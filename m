Return-Path: <stable+bounces-237801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F/XNFoi3mk1ngkAu9opvQ
	(envelope-from <stable+bounces-237801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:17:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682C3F93C1
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5383064CFB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14B3D9DC5;
	Tue, 14 Apr 2026 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOAikDc+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449833B2FD1
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165403; cv=none; b=JQ6idyCkBmAvc6vi1whGhsIvN4U6mh83oKBCtB+z7bn3R4z/UaFVq6Aiq1W29Ettv7gLbTSwW61pmiKLsgim28JBIPnFU4RmZzKPuWrXHR5eupEnOPTGunXy2hI1JCixQlBrwFE7Wiyo11KXHUYqOjHiEK0g7s/Ar2IoUtuyBJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165403; c=relaxed/simple;
	bh=PxcMkxKwR0QjBXMQ7BoJDuxGHFoSakkgwUWJVqBw0ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1P3Gw1TSvp6F5+uoqk/mvkQ+wLEXgQeODadjpOlUF0WGSAoMXIgI3cbtQoqQRsooI1FYlnwnPbl2bUowoDCNlAohEKylWPPhimy7Uhg9KVEcUrvIqANhK/SqamOStD2H/nE83n03IOWj9HGERRGBGXjSDZ/EKUFQoI9V1Z6T3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOAikDc+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfc5941028so803484785a.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776165401; x=1776770201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1esxknwxAu1HK9DsqSzVwMwdkh7HafK/RQh7O/qJj8=;
        b=WOAikDc+KtVNbrtn80jUqGlPfURXkyn650Yeo5942oxLg22+NBO2SJYoZbPtCrX97e
         Y4QvLEmbxjIQevBv6yEGMthxrbvkuffO8GhWFHHjiT8mYR2u3nPe7vw+tzRO1Xqzi/61
         4hy/V/WMa2zZr9E/311bx7Nm/56PT/tX4nUjbopY/HqICLIrSmZe4CrHg29/1/MXSrSj
         cdHbWxeoMBCKqk5kT2Fak2xjZDLCcbaTK/KafDaKvdLJsUscJtWpwHZn9WLqxvysSfv4
         wB3nPjKeUBQxadBj08Et4Zetp5Hce77aw3Eurg7vtXA7bhXjaEDmp+nxtlop1T+UB4Cv
         yCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776165401; x=1776770201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1esxknwxAu1HK9DsqSzVwMwdkh7HafK/RQh7O/qJj8=;
        b=YanuyuXPpMjUZBb/YfHdJc2UGhacVkta9T4Q96VbUvEOikQgKqwfhhjoyVR42ltYsU
         whWwNmX/MuZWLNQ/XH60WsDeqiE/wdIjp33nqESzKcJphPW+OdMLvdMoaznl8d3+PkFl
         UMwfBBxsBWFj7vF0qgxAZn9rzlHsfyke+Dd+N5q3foc07k1cgo1FsCggKGQFsnOB/+Cg
         /8H19EAq7kRFukLS0VH1WA00m94+48NXdLo4Rq3ErifGHNtiluGyjTcnwqzEWvx9czsL
         nZiYdvcIUHYKRp763qq6jSiuOWv1lUvsJ25IrALtK/dvyj17tccviFcAQukRef/rWwdG
         +s0A==
X-Forwarded-Encrypted: i=1; AFNElJ9fa8l2LWNwwyVtkW78W0blOBejky1eQudZZnHGlvdp/fkupMR8n4SHfIJJo7QvJksut+9DnPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0DTnq5xJik3IenINBjAYDkVmRr/fdnW5geiyZ0GCQssYuc6s
	YNgBUxLNGmh8pWiBj524nJ8+7DBbIS8lTq/tOQ+4UVVK+IMBXRvBw9Yy
X-Gm-Gg: AeBDiet3TbcEDuUIB7H+RK12xRfYUfTbiaq4GxYi21pVcNZmL4pzhxbFZ9LfERrxhvH
	cWZ9R+nJAG1kj+SVKngbAKVaQ7jwzY2QZEP0s3Kt7BSRFhUkE/pRn7+2ZWnp2XmW0m+Gdg8bIB2
	V+21GzkVteg9DWWC6d26POHOsXbkmGexXzB8or/fVD+Ko+gbTYhtrZYDJ7ey9PRLtmqri5GgtbQ
	ODYyR8eWPcs5OHZE1hDMqNgL1x/1Ml2EMEZKZ2HspYUBRUNMs6BlLqvSvu7ukXa8dnR3sLJOXV0
	j7z3GFJJeF1etdBoCGZQV0+Har+7GdywNiKupcqjCyxu8h4QydPrnZjV3dRFgCCEthEa5W3rpzq
	kAkXGm5mKFKDC1H3U1SLa0Jgn33Pa4vk5Oil8wjwsgHl/kjx95uBJvuoy8beC/gFtQCJiOOzGY1
	1yAJwp94Rx6/04MyEBSsep8q0PJia/Rdu/rroLOHl94LeQZAcF6gZB6p++wyinCt0YPpufz6vYe
	dSdxl6NvSDi56L5vdxG
X-Received: by 2002:a05:620a:2949:b0:8cf:d3a9:60ea with SMTP id af79cd13be357-8ddce2c9fbcmr2505935285a.26.1776165401195;
        Tue, 14 Apr 2026 04:16:41 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84cb0474sm120225296d6.40.2026.04.14.04.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:16:40 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Jason Gunthorpe" <jgg@ziepe.ca>,
	"Leon Romanovsky" <leon@kernel.org>
Cc: "Zhu Yanjun" <yanjun.zhu@linux.dev>,
	"hkbinbin" <hkbinbinbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH v2] RDMA/rxe: Reject unknown opcodes before ICRC processing
Date: Tue, 14 Apr 2026 07:15:55 -0400
Message-ID: <20260414111555.3386793-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-237801-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 3682C3F93C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Even after applying commit 7244491dab34 ("RDMA/rxe: Validate pad and ICRC
before payload_size() in rxe_rcv"), a single unauthenticated UDP packet
can still trigger panic.  That patch handled payload_size() underflow
only for valid opcodes with short packets, not for packets carrying an
unknown opcode.  The unknown-opcode OOB read described below
predates that commit and reaches back to the initial Soft RoCE driver.

The check added there reads

    pkt->paylen < header_size(pkt) + bth_pad(pkt) + RXE_ICRC_SIZE

where header_size(pkt) expands to rxe_opcode[pkt->opcode].length.  The
rxe_opcode[] array has 256 entries but is only populated for defined IB
opcodes; any other entry (for example opcode 0xff) is zero-initialized,
so length == 0 and the check degenerates to

    pkt->paylen < 0 + bth_pad(pkt) + RXE_ICRC_SIZE

which does not constrain pkt->paylen enough.  rxe_icrc_hdr() then
computes

    rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES

which underflows when length == 0 and passes a huge value to
rxe_crc32(), causing an out-of-bounds read of the skb payload.

Reproduced on v7.0-rc7 with that fix applied, QEMU/KVM with
CONFIG_RDMA_RXE=y and CONFIG_KASAN=y, after

    rdma link add rxe0 type rxe netdev eth0

A single 48-byte UDP packet to port 4791 with BTH opcode=0xff and
QPN=IB_MULTICAST_QPN triggers:

    BUG: KASAN: slab-out-of-bounds in crc32_le+0x115/0x170
    Read of size 1 at addr ...
    The buggy address is located 0 bytes to the right of
     allocated 704-byte region
    Call Trace:
     crc32_le+0x115/0x170
     rxe_icrc_hdr.isra.0+0x226/0x300
     rxe_icrc_check+0x13f/0x3a0
     rxe_rcv+0x6e1/0x16e0
     rxe_udp_encap_recv+0x20a/0x320
     udp_queue_rcv_one_skb+0x7ed/0x12c0

Subsequent packets with the same shape fault on unmapped memory and
panic the kernel.  The trigger requires only module load and
"rdma link add"; no QP, no connection, and no authentication.

Fix this by rejecting packets whose opcode has no rxe_opcode[] entry,
detected via the zero mask or zero length, before any length
arithmetic runs.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
v2: also check rxe_opcode[].length per Zhu Yanjun; "||" rather than
    "&&" so the guard tracks the actual underflow in rxe_icrc_hdr().

v1 was sent privately to security@kernel.org.

 drivers/infiniband/sw/rxe/rxe_recv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index f79214738c2b..2d5e701ff961 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -330,6 +330,17 @@ void rxe_rcv(struct sk_buff *skb)
 	pkt->qp = NULL;
 	pkt->mask |= rxe_opcode[pkt->opcode].mask;
 
+	/*
+	 * Unknown opcodes have a zero-initialized rxe_opcode[] entry, so
+	 * both mask and length are 0.  Reject them before any length math:
+	 * rxe_icrc_hdr() would otherwise compute length - RXE_BTH_BYTES
+	 * and pass the underflowed value to rxe_crc32(), producing an
+	 * out-of-bounds read.
+	 */
+	if (unlikely(!rxe_opcode[pkt->opcode].mask ||
+		     !rxe_opcode[pkt->opcode].length))
+		goto drop;
+
 	if (unlikely(pkt->paylen < header_size(pkt) + bth_pad(pkt) +
 		       RXE_ICRC_SIZE))
 		goto drop;
-- 
2.53.0


