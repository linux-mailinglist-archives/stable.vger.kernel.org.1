Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394177614B7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjGYLWH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjGYLWD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45713199C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8893361600
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FFEC433C8;
        Tue, 25 Jul 2023 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284121;
        bh=bVMgwzBJUMyGtbdEfx/DoLkxXR8Qv5xHKfmOrU59HqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PT+A6hFeMrsskJIXmQGM42/I7FhfPhyQLGKvCjqwoXQXroeU8hXgkzYW/SQfRx8LF
         xuPNN18AT6SU46d2DYBkQjWk+/GQ3imC5WbKuVOj0ZW4Lp7x6+TiHduwl52uNNP+Bz
         UNQSN60txTwvyR6FRC01V5JFzc3PwgnMnETNPnMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nico Boehr <nrb@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 242/509] KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
Date:   Tue, 25 Jul 2023 12:43:01 +0200
Message-ID: <20230725104604.840146415@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nico Boehr <nrb@linux.ibm.com>

[ Upstream commit 285cff4c0454340a4dc53f46e67f2cb1c293bd74 ]

The KVM_S390_GET_CMMA_BITS ioctl may return incorrect values when userspace
specifies a start_gfn outside of memslots.

This can occur when a VM has multiple memslots with a hole in between:

+-----+----------+--------+--------+
| ... | Slot N-1 | <hole> | Slot N |
+-----+----------+--------+--------+
      ^          ^        ^        ^
      |          |        |        |
GFN   A          A+B      |        |
                          A+B+C    |
			           A+B+C+D

When userspace specifies a GFN in [A+B, A+B+C), it would expect to get the
CMMA values of the first dirty page in Slot N. However, userspace may get a
start_gfn of A+B+C+D with a count of 0, hence completely skipping over any
dirty pages in slot N.

The error is in kvm_s390_next_dirty_cmma(), which assumes
gfn_to_memslot_approx() will return the memslot _below_ the specified GFN
when the specified GFN lies outside a memslot. In reality it may return
either the memslot below or above the specified GFN.

When a memslot above the specified GFN is returned this happens:

- ofs is calculated, but since the memslot's base_gfn is larger than the
  specified cur_gfn, ofs will underflow to a huge number.
- ofs is passed to find_next_bit(). Since ofs will exceed the memslot's
  number of pages, the number of pages in the memslot is returned,
  completely skipping over all bits in the memslot userspace would be
  interested in.

Fix this by resetting ofs to zero when a memslot _above_ cur_gfn is
returned (cur_gfn < ms->base_gfn).

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: afdad61615cc ("KVM: s390: Fix storage attributes migration with memory slots")
Message-Id: <20230324145424.293889-2-nrb@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/kvm-s390.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7ffc73ba220fb..7a326d03087ab 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2005,6 +2005,10 @@ static unsigned long kvm_s390_next_dirty_cmma(struct kvm_memslots *slots,
 		ms = slots->memslots + slotidx;
 		ofs = 0;
 	}
+
+	if (cur_gfn < ms->base_gfn)
+		ofs = 0;
+
 	ofs = find_next_bit(kvm_second_dirty_bitmap(ms), ms->npages, ofs);
 	while ((slotidx > 0) && (ofs >= ms->npages)) {
 		slotidx--;
-- 
2.39.2



