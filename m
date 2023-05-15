Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBEA70396E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbjEORm1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244584AbjEORmH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD891B749
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C524762E24
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69495C433D2;
        Mon, 15 May 2023 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172378;
        bh=NMPDj9gNR+q6iJhbchjz6/v5vcYV0OtYGL4SFGnlObg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQB3E+cdhzYuuBFsnZTW6x/2mRvYT5y5s+ZT/V4pjKUyAyJ5Zt5cr7ygHEQvcnoYj
         w3qicLk/WUfBgPYw0DbxYtzKrYtseyLmqO/ndAhgZ6vY7OPi5e3ofpMXmlg3HNLobp
         v2ua9hf4wjAkD7JDXY3KJW+lMhZTG3kSfa04ebws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Uros Bizjak <ubizjak@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 105/381] x86/apic: Fix atomic update of offset in reserve_eilvt_offset()
Date:   Mon, 15 May 2023 18:25:56 +0200
Message-Id: <20230515161741.548385592@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Uros Bizjak <ubizjak@gmail.com>

[ Upstream commit f96fb2df3eb31ede1b34b0521560967310267750 ]

The detection of atomic update failure in reserve_eilvt_offset() is
not correct. The value returned by atomic_cmpxchg() should be compared
to the old value from the location to be updated.

If these two are the same, then atomic update succeeded and
"eilvt_offsets[offset]" location is updated to "new" in an atomic way.

Otherwise, the atomic update failed and it should be retried with the
value from "eilvt_offsets[offset]" - exactly what atomic_try_cmpxchg()
does in a correct and more optimal way.

Fixes: a68c439b1966c ("apic, x86: Check if EILVT APIC registers are available (AMD only)")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230227160917.107820-1-ubizjak@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 1c96f2425eafd..25eb69f26e039 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -410,10 +410,9 @@ static unsigned int reserve_eilvt_offset(int offset, unsigned int new)
 		if (vector && !eilvt_entry_is_changeable(vector, new))
 			/* may not change if vectors are different */
 			return rsvd;
-		rsvd = atomic_cmpxchg(&eilvt_offsets[offset], rsvd, new);
-	} while (rsvd != new);
+	} while (!atomic_try_cmpxchg(&eilvt_offsets[offset], &rsvd, new));
 
-	rsvd &= ~APIC_EILVT_MASKED;
+	rsvd = new & ~APIC_EILVT_MASKED;
 	if (rsvd && rsvd != vector)
 		pr_info("LVT offset %d assigned for vector 0x%02x\n",
 			offset, rsvd);
-- 
2.39.2



