Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF92703B7B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbjEOSDb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242121AbjEOSDF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93801CBAF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898C563013
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812BFC4339E;
        Mon, 15 May 2023 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173640;
        bh=mQ1t5VLd0xJHD2IqjCdEww5tQDzeEt7GoCxU48umE8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbXolN4t4Ecn2OX62HCTh2UHkWA9ntE6p55kiPHXDHvqJM+BkYUSDlM2pZh3Askag
         iK5iJ8P3lEV8fkbQwLb7LJfoJ65+6ng13JVIkNI2PghUY+oigG7TcoKtn+nSSGH0I3
         8zUidTYZass741U+8/wTTS+XNKaD4GdX2zIUyJ9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Lynch <nathanl@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 159/282] powerpc/rtas: use memmove for potentially overlapping buffer copy
Date:   Mon, 15 May 2023 18:28:57 +0200
Message-Id: <20230515161726.982076571@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit 271208ee5e335cb1ad280d22784940daf7ddf820 ]

Using memcpy() isn't safe when buf is identical to rtas_err_buf, which
can happen during boot before slab is up. Full context which may not
be obvious from the diff:

	if (altbuf) {
		buf = altbuf;
	} else {
		buf = rtas_err_buf;
		if (slab_is_available())
			buf = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
	}
	if (buf)
		memcpy(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);

This was found by inspection and I'm not aware of it causing problems
in practice. It appears to have been introduced by commit
033ef338b6e0 ("powerpc: Merge rtas.c into arch/powerpc/kernel"); the
old ppc64 version of this code did not have this problem.

Use memmove() instead.

Fixes: 033ef338b6e0 ("powerpc: Merge rtas.c into arch/powerpc/kernel")
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230220-rtas-queue-for-6-4-v1-2-010e4416f13f@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/rtas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index ee810df7d522d..0793579f2bb9b 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -398,7 +398,7 @@ static char *__fetch_rtas_last_error(char *altbuf)
 				buf = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
 		}
 		if (buf)
-			memcpy(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+			memmove(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);
 	}
 
 	return buf;
-- 
2.39.2



