Return-Path: <stable+bounces-273516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c7E8HBDfU2oIfwMAu9opvQ
	(envelope-from <stable+bounces-273516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 20:38:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A2F745A56
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 20:38:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=SFG7KXJq;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273516-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273516-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CD603003620
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C623B27E9;
	Sun, 12 Jul 2026 18:38:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAE2F532F;
	Sun, 12 Jul 2026 18:38:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783881485; cv=pass; b=ugYSdfy/YtvlVeZgSnSPGK5SkEMP/uQLNr7nJGaUEpzsdIWgBf2hBi2mi4EcHIl0cM8hva5pwkR3qAKiT3Y34c3B2pcmK4loQ6xI+J3kKT56CzjdKBh3CXLHwe02ConfXfABYLedNDTvPHk+ufQv7AwJvejg/SyL0jJTvuXNsmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783881485; c=relaxed/simple;
	bh=lQ/iHNm6s1AoaaXVaFlISU78dFYq/QWF11TXBNqayoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIv7WhAEDkYoSF0BgMZeKKnm/6XWWMmFUHAF096VAHv3/8NvIKyjVQEcQNFH95ULwQPB6Trpb804MetdoPm84qPElv94ssEXIV8j7zmGy8wRadNLVswdX1DD1cNsPMDP27xNoj1boTWxRKrdlWy6B72YiZKNk5S9nxuTsng468o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=SFG7KXJq; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1783881465; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZY/0s3gfC3DTXrdqqQxxmyvjbwYQlY/TLce2+O1navfromjWcVM4MbFI7SEGyLbcS+OVRiwN0FrZ6qXVSYXVR7KB5AA6i45GoOx8kVmHanv6JIkFhVNWu72IraJQhwO7Bj5YVj/9iJWcuN7gLxjy6eRvRtNmz419TwOI0hRjW+c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783881465; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AfuDLYhZuyEhsh0ZD2c1HoKY5yxT51SVPoxqz9SOCA4=; 
	b=VEFfBX8uCPL8MA8yxaxr/t0p44hzT+cshzpxgguIOZvEXUpfllRAN5PX7/Z0bFWbOfxlgECikXZIlTgVnKQ3mjpRUFj1GSlns2bnwAhUSamI1Tf8khLWvNmtVVC3c0UVsdQgrPvns/6bCeHP76twEk39/5wqb9HCoKm6Il/nUs8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783881465;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AfuDLYhZuyEhsh0ZD2c1HoKY5yxT51SVPoxqz9SOCA4=;
	b=SFG7KXJqkpGyGjxdgxu8n7Iv7TmG0S+YR3k1e9FEVEzUz9r4rDXKx6eHOX7i4dRB
	1Quqq/g2QO7mVCMIQ14ndGzLjPsrcB168Ok2gNPQvv8BjbqCbSkKn+lz95HfYJi+RSU
	mfayO8T0UMyE+mNAOj1T9aeBmKshkM6kJVLY9RPI=
Received: by mx.zoho.eu with SMTPS id 1783881463576303.5017438322558;
	Sun, 12 Jul 2026 20:37:43 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	dlemoal@kernel.org
Cc: bvanassche@acm.org,
	shinichiro.kawasaki@wdc.com,
	damien.lemoal@opensource.wdc.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] scsi: scsi_debug: fix REPORT ZONES alloc_len underflow OOB write
Date: Sun, 12 Jul 2026 20:37:39 +0200
Message-ID: <20260712183739.83915-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260710055755.53830-1-security@auditcode.ai>
References: <20260710055755.53830-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273516-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:dlemoal@kernel.org,m:bvanassche@acm.org,m:shinichiro.kawasaki@wdc.com,m:damien.lemoal@opensource.wdc.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[security@auditcode.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@auditcode.ai,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,auditcode.ai:from_mime,auditcode.ai:email,auditcode.ai:mid,auditcode.ai:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2A2F745A56

resp_report_zones() sizes the reply buffer from the CDB allocation
length. The v3 fix rounds alloc_len up with ALIGN() before deriving the
descriptor count:

	rep_max_zones = (ALIGN((u64)alloc_len, RZONES_DESC_HD) -
			 RZONES_DESC_HD) >> ilog2(RZONES_DESC_HD);
	arr_len = (u64)RZONES_DESC_HD * (rep_max_zones + 1);

For alloc_len in 0xFFFFFFC1..0xFFFFFFFF, ALIGN() rounds up to
0x100000000, so arr_len is 4 GB. On 32-bit, kzalloc()'s size_t is
32-bit and truncates 0x100000000 to 0; kzalloc(0) returns
ZERO_SIZE_PTR, which passes the !arr check, and desc = arr + 64 is then
dereferenced in the loop -> out-of-bounds write / panic.

Clamp rep_max_zones to devip->nr_zones. The loop already stops at
sdebug_capacity (after nr_zones zones), so a report can never hold more
than nr_zones descriptors; the clamp does not change the report, it
only bounds arr_len to (nr_zones + 1) * RZONES_DESC_HD, a real device
property that can never reach 0x100000000.

Fixes: 7db0e0c8190a ("scsi: scsi_debug: Fix buffer size of REPORT ZONES command")
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
v4: clamp rep_max_zones to the device zone count (devip->nr_zones) so arr_len
cannot reach 0x100000000 and be truncated by kzalloc()'s 32-bit size_t on
32-bit platforms (which returns ZERO_SIZE_PTR and bypasses the NULL check),
as reported by sashiko-bot / Bart Van Assche on v3. This restores a bound
that pre-dated the loop refactor: the original REPORT ZONES code already
capped rep_max_zones at the device zone count. The clamp is additive and does
not change any report (the loop already stops at sdebug_capacity), so it only
bounds the allocation. Dropped Damien's v3 Reviewed-by since v4 adds a
functional line he has not reviewed; his ALIGN sizing is otherwise unchanged.
v3: https://lore.kernel.org/linux-scsi/20260710055755.53830-1-security@auditcode.ai/
 drivers/scsi/scsi_debug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 9d1c9c41d0f9..643051332132 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5890,6 +5890,7 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	u32 alloc_len, rep_opts, rep_len;
 	bool partial;
 	u64 lba, zs_lba;
+	u64 arr_len;
 	u8 *arr = NULL, *desc;
 	u8 *cmd = scp->cmnd;
 	struct sdeb_zone_state *zsp = NULL;
@@ -5911,9 +5912,12 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 		return check_condition_result;
 	}
 
-	rep_max_zones = (alloc_len - 64) >> ilog2(RZONES_DESC_HD);
+	rep_max_zones = (ALIGN((u64)alloc_len, RZONES_DESC_HD) - RZONES_DESC_HD) >>
+			ilog2(RZONES_DESC_HD);
+	rep_max_zones = min_t(unsigned int, rep_max_zones, devip->nr_zones);
+	arr_len = (u64)RZONES_DESC_HD * (rep_max_zones + 1);
 
-	arr = kzalloc(alloc_len, GFP_ATOMIC | __GFP_NOWARN);
+	arr = kzalloc(arr_len, GFP_ATOMIC | __GFP_NOWARN);
 	if (!arr) {
 		mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC,
 				INSUFF_RES_ASCQ);
-- 
2.50.1 (Apple Git-155)


