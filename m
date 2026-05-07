Return-Path: <stable+bounces-244577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG94HY2j/Gn2SAAAu9opvQ
	(envelope-from <stable+bounces-244577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:37:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDAF4EA4DD
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC5F303E2CC
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5D3FBEDE;
	Thu,  7 May 2026 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiMsEF8L"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564803F7883
	for <stable@vger.kernel.org>; Thu,  7 May 2026 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164401; cv=none; b=sQ1ZMaSHihSDihF1zxxZUplzN1JQR7iH2PSERl4Ni4BhBIpYMbezi2q1UpvEQ7Z6+2W2V7jsYYBdX8i5GAusUlVFMHThDepp31nSt6OzzlMxQmqMstHd/HBEkiNBvFAOqPnpg14eeFCr1UnSaH2p3J3HaCwNkFOHfhjDTIVUuGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164401; c=relaxed/simple;
	bh=/n+7llmepQAvJ5J8m7gmaT9JZWY/jvh+7hnDojvXqTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iL29zI+MalwKRmMoH1OzB3IuASatCYOzuECZFg6ikpa4gOd8PRGqfsYYdAHBS74ae9pWdz/X8ulCIeP7Nzy30Zh9COra9mcfrfvW1FFEA1CHLlBi54c7kXlJ5YgP+sgL2pwGnwo0B41SmdzeVPTIkrr58HiC5aCwEzL+t00o3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiMsEF8L; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-902deb2412fso96762885a.3
        for <stable@vger.kernel.org>; Thu, 07 May 2026 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778164398; x=1778769198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kzcSdsCpo5Y3mn41POdySZcZFAGaT53MIAxz0TRGE0=;
        b=qiMsEF8L1E88iiuA5BvbiIgz8FiS+bFiAP4TF+bxCN5utzEYD0M4/OpGHvpMsOBo8u
         OEspr1NQCQoVplh+6Uw3fcKghu/ULNj1DOtozo+9PCHS2UQLdWexGIuVRUr5d7LrYGal
         a/mCmXVfsyUKkrX9w3jSFZeqHwWWzVfDwkAU8kJarTboXO7xiAwus5W0XbFAFZiD9vaC
         JykfBYLaV7fSg1EyG4LKkh9KjXl1Zw21ClOeOTBeywStGjjerJLQwi/J16xnxdvghj2M
         vr7AXA5JQ178AqePauHy9qFLiQm09boHMTdvQ+/cJn/byeCkCwD5RJ752SgEqIw6vd3m
         /ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164398; x=1778769198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kzcSdsCpo5Y3mn41POdySZcZFAGaT53MIAxz0TRGE0=;
        b=WMzebsAEFzD7fZ1at3ob0Epopo8HizOqFX2CD2X3M36bcAKe+FW5NPDhTQqbqZDjWH
         Td3zsap5vXdISSTZ6lBoGUz6Vsiwu/fI61t0LH5QayJK9rAg/l2LjO+/ZMc1olhl8g01
         CJRk528WHa4V3sGvLn2skguHPKyKYU6cD9tdLDwhLakEjsggBc7sy2MCbeEaf+ThAYRl
         yNctBz96Fovg/sC2qgG7Hfa06NVvF7IlWUN27DXwBq1x7xug6KQkUp7monWgUQ4ZAwip
         GnS+1KTJNKfN0pAvXFdYuKw+kqXDy2iV+mncTuy2QoDzGho1e7Y3mp1J8o/xFifnKHJH
         J10A==
X-Forwarded-Encrypted: i=1; AFNElJ/DCIV9G7SmiObFJYxwZZE0wRu2qdnTvxIkLthhQOdEoSW2D2yFXDVcFfliU+vkgA+PZSNWspw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjrXIq6jRjwrvqetKa54mNc9cm9Z4z1daWcq8CauanChtFzGQf
	Mf6yLMPcK5Wf2H/1tUmfo7QlJVTw8Swvqg3JWPq+tRSoX1QZGltJbCF7
X-Gm-Gg: AeBDievWk9l4NwQ4QkE/405JMp3zFKEcEXKxmDEVTalStar5c5B4gDZNiLjbYZOvA+2
	SDwyM/gKUy7dRvfi0BKdy2P9lDJ29jfUy1XWqx6L1bNUR5MhUp97prcZ8XpHRs8YILUv05cgxkG
	CR0U3qYy4Gx8E4a3Xw8e59nXXU4Z6MHDCiOBWXzryzfVhJtl92sUzebZCS8lznbcO1kQZ8F0lHX
	plcVxBEqujUHafij7kOM5a2Xcr7o4suL3cVyZsEghIejSnAnZ7LB4MHF9bSntED04ySY4fd9nDc
	hQPqn77Qkg3LRAFWwGoEweGml1hva48mrVege85wilDYvKiphiak1BXcWJf7UHuRg2ae9zCgi6k
	SQ1bQZVU+xNBDQivOyeYV90O43uPuuW7gQB6GH9SSy7H05gJeXuu8C4TREYtg7Ad+x6qgzJmEnP
	d+kISd1/LNjVUIa2yyPwAJ9EnGZR3wFKD+C6DRyt3h1LJUszMGJNm1FAfS5MYEMHMvZDpBRzs0z
	BnEVN4QJiwoAF2bNTsN9io++Q==
X-Received: by 2002:a05:622a:59ce:b0:50f:bd51:f1d2 with SMTP id d75a77b69052e-514621d1bfdmr103573311cf.50.1778164397873;
        Thu, 07 May 2026 07:33:17 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b80a4dsm175420501cf.24.2026.05.07.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:33:17 -0700 (PDT)
From: "Jeremy Erazo (Devel Group)" <mendozayt13@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jeremy Erazo (Devel Group)" <mendozayt13@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: target: iscsi: validate ECDB AHS length
Date: Thu,  7 May 2026 14:25:59 +0000
Message-ID: <20260507142559.2373177-1-mendozayt13@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CEDAF4EA4DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244577-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mendozayt13@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

iscsit_setup_scsi_cmd() processes the Extended-CDB Additional Header
Segment (AHS) of a SCSI Command PDU without bounding AHSLength,
despite the long-standing "FIXME; Add checks for AdditionalHeaderSegment"
comment a few lines above in the same function.

A SCSI Command PDU sent after iSCSI Login with hlength=1,
ahstype=ISCSI_AHSTYPE_CDB and ahslength=0 reaches:

    cdb = kmalloc(0 + 15, GFP_KERNEL);             /* 15-byte alloc  */
    memcpy(cdb, hdr->cdb, ISCSI_CDB_SIZE);         /* 16 -> 15       */
    memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb,
           be16_to_cpu(ecdb_ahdr->ahslength) - 1); /* (size_t)-1     */

On CONFIG_FORTIFY_SOURCE=y kernels the first memcpy is rejected by
__fortify_panic() because the declared destination size is 15:

    memcpy: detected buffer overflow: 16 byte write of buffer size 15
    kernel BUG at lib/string_helpers.c:1044!
    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
    RIP: 0010:__fortify_panic+0xd/0xf
    Call Trace:
     iscsit_setup_scsi_cmd.cold+0x8c/0x224
     iscsit_get_rx_pdu+0x9ec/0x1740
     iscsi_target_rx_thread+0xf7/0x1f0
     kthread+0x1b4/0x200
    Kernel panic - not syncing: Fatal exception

On kernels without CONFIG_FORTIFY_SOURCE the first memcpy fits in the
kmalloc-16 slab object and execution reaches the second memcpy whose
size argument has wrapped to (size_t)-1.

Reproduced on Linux 7.0 with a malformed Command PDU sent after a
completed iSCSI Login.  The trigger is reachable post-Login by any
initiator that successfully logged in (anonymous on demo-mode targets,
authenticated on CHAP-protected targets).  No claim of RCE, LPE or
controlled write is made.

Validate, before any dereference and any allocation:

  - the AHS area received from the socket holds at least the 4-byte
    iscsi_ecdb_ahdr header,
  - AHSLength is at least 1 (RFC 7143 §10.2.2.3 minimum for the ECDB
    AHS, which carries one reserved byte),
  - the declared AHSLength does not exceed the AHS bytes that were
    actually received.

Reported-by: Jeremy Erazo (trexnegr0) <mendozayt13@gmail.com>
Signed-off-by: Jeremy Erazo (Devel Group) <mendozayt13@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/target/iscsi/iscsi_target.c | 33 +++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index e80449f6c..de291eb6f 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1100,6 +1100,16 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 	cdb = hdr->cdb;
 
 	if (hdr->hlength) {
+		u16 ahslen;
+		unsigned int ahs_area_bytes = hdr->hlength * 4;
+
+		/* The AHS area must hold at least the iscsi_ecdb_ahdr
+		 * header before any of its fields may be dereferenced.
+		 */
+		if (ahs_area_bytes < sizeof(struct iscsi_ecdb_ahdr))
+			return iscsit_add_reject_cmd(cmd,
+				ISCSI_REASON_PROTOCOL_ERROR, buf);
+
 		ecdb_ahdr = (struct iscsi_ecdb_ahdr *) (hdr + 1);
 		if (ecdb_ahdr->ahstype != ISCSI_AHSTYPE_CDB) {
 			pr_err("Additional Header Segment type %d not supported!\n",
@@ -1108,14 +1118,29 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 				ISCSI_REASON_CMD_NOT_SUPPORTED, buf);
 		}
 
-		cdb = kmalloc(be16_to_cpu(ecdb_ahdr->ahslength) + 15,
-			      GFP_KERNEL);
+		/* Per RFC 7143 §10.2.2.3 AHSLength counts the bytes of
+		 * the AHS that follow the AHSType/AHSLength fields; for
+		 * the ECDB AHS it includes one reserved byte, so the
+		 * smallest legal value is 1.  Rejecting 0 prevents the
+		 * "ahslen - 1" memcpy size below from underflowing to
+		 * (size_t)-1, and ensures the kmalloc(ahslen + 15) below
+		 * is at least ISCSI_CDB_SIZE (16) so the first memcpy
+		 * does not overflow.  Also reject any AHSLength larger
+		 * than the AHS bytes that actually reached us.
+		 */
+		ahslen = be16_to_cpu(ecdb_ahdr->ahslength);
+		if (ahslen < 1 ||
+		    ahslen - 1 > ahs_area_bytes -
+				 offsetof(struct iscsi_ecdb_ahdr, ecdb))
+			return iscsit_add_reject_cmd(cmd,
+				ISCSI_REASON_PROTOCOL_ERROR, buf);
+
+		cdb = kmalloc(ahslen + 15, GFP_KERNEL);
 		if (cdb == NULL)
 			return iscsit_add_reject_cmd(cmd,
 				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
 		memcpy(cdb, hdr->cdb, ISCSI_CDB_SIZE);
-		memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb,
-		       be16_to_cpu(ecdb_ahdr->ahslength) - 1);
+		memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb, ahslen - 1);
 	}
 
 	data_direction = (hdr->flags & ISCSI_FLAG_CMD_WRITE) ? DMA_TO_DEVICE :

base-commit: a293ec25d59dd96309058c70df5a4dd0f889a1e4
-- 
2.53.0


