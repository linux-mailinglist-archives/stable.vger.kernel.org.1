Return-Path: <stable+bounces-223689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBqnNi3prmlRKAIAu9opvQ
	(envelope-from <stable+bounces-223689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:37:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5859023BD07
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B332C30729DC
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE13D7D7F;
	Mon,  9 Mar 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="XQS6+1DF"
X-Original-To: stable@vger.kernel.org
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6FC3D5229;
	Mon,  9 Mar 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069865; cv=none; b=WND6vBMdd0Odd2xCyv8VsEnx4XGr3waHpBoWufER11oxPIcOkzUtW39PFrpYSPH+OxVhYfphYxPvhFPi2ihxQGbLidjbysKtOs73emXzJ9oRFVTJSvjRTNBB2Q9wuc9hNz5YXDNFgPUazy3L/uSB67a+pwM7v8foyhWX3zz7p7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069865; c=relaxed/simple;
	bh=oXjAn/frMEepxVkPh4OGIzVy+5lq+FiyZyDdSC/VmC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=RzAnGk3/n5JE63LV59ge8gpqjWV9ALiqRTx5M1N6enPDnjrsx8FJo4ulIYBtA2Yu5RuE3pwybv4Y3NQ4U+pBLVQZOQR9agN//DblSf1XUGsXPZerrIqGbv41QD6+Vv7gO08DFa9BsEb3s3IFUQiGwqi5XbWhqzFipqq728dPzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=XQS6+1DF; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6296QwPF4109588;
	Mon, 9 Mar 2026 15:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=dk201812; bh=Aj4Z112A+l8JwYyMToVVYm9
	DQ9T6e9MfPk1hwZSFXS0=; b=XQS6+1DFyaDuir2kCvXSmPkZoAvLlEjVKs9lnyk
	cPEh6U6L7lrVP+r/78tk0QXtp1u6iAg3Fp5CEtQjnVHjDCiJXOjU0Lx4OZszBdty
	tC+EpVThhtEAnhnFFeraoR1y/XLPGfkQBxppa4y4/Hwpx0uhjTMXuvloaGHoIIQE
	cdp3qB3T5QKUXBvBgdsuymugGn0rHFnQVdae74IWxjUwHNusdD0ZE3JmO+4uRdbT
	OL4uBC/PrxLQ9T8JRb+G1aE/MnLIviPpc33kf93E5jHzzKe+qD+MhT7IY1lgGqDD
	Ue+k8ZANTHb7wo12qGw1dr6799HbfHfy+FogOhujBWApD1A==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4crb5thjrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 15:24:13 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.8.171) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 15:24:11 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
Date: Mon, 9 Mar 2026 15:23:48 +0000
Subject: [PATCH] drm/imagination: Fix deadlock in soft reset sequence
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAAPmrmkC/x2MSQqAMAwAvyI5G6gNuH1FPEibai5WGhGh9O8Wj
 wMzk0E5CSvMTYbEj6jEs0LXNuCO7dwZxVcGa2xvyEwY5EWN4cbEyjeOgayjYSRPHmp0Ja7GP1z
 WUj74xUCNYAAAAA==
X-Change-ID: 20260309-fix-soft-reset-8f32c3783d3d
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        Brajesh Gupta <brajesh.gupta@imgtec.com>,
        "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Alessio Belle <alessio.belle@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773069851; l=1481;
 i=alessio.belle@imgtec.com; s=20251208; h=from:subject:message-id;
 bh=oXjAn/frMEepxVkPh4OGIzVy+5lq+FiyZyDdSC/VmC0=;
 b=4sgUkNMjtGNG2WtaU3PEDkX9NgOL7wAfyB8aDWHlZzroC8B2s9UBz2PaMYIJUEnVKyqWsmKLw
 md5aGMs2HrHCSNVOTRiegzWwf877o7LC2cugvMgnYhxMIeGiFzwWn74
X-Developer-Key: i=alessio.belle@imgtec.com; a=ed25519;
 pk=2Vtuk+GKBRjwMqIHpKk+Gx6zl7cgtq0joszcOc0zF4g=
X-Proofpoint-ORIG-GUID: TVBurlFqrxhG_zc3r0SHg3lx7lbIi4k5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzOSBTYWx0ZWRfX4jUcNPPgPEPc
 Sa7eggDdeHKuD6L6HLWisSPdndYMFoO5rAcNdjCt+cBq8k0M4FBKxRFE/l0gqxC+vfd63Ixn1kB
 y0jcd7AFh7Ytys56wwKu3KJJGJYzxt+YoeeTcv9Xf/13fjN5kfD37zWPxBTkEqnov8NkMu5TKbh
 2QI8jrGzRtpsGCaMrC3qrIsSPh6YUwr13LK1GGlix40y8nCaiP/J7k9GytSBLFKzzN7Cm+c6FID
 vxWmPlxq8dzzk7QJwhoONIUc6Si1oK4sVQ4ouJS6ZoyQtrTpUKJef2zYh085iiewbgrs/bVdOa/
 BYo8E295lBa6t/NDomakW9LldBD0bt2QAZ6Fx27ljwQQXNelrTSp3tXUbNpzoxx+ecryC1/upzw
 7QzbGDK+CgWLye+kEalwqyDA1F3pQ9ikTsPjxmG1hYKWzFmCXpcjFjzq/8ZCAfufaTdbwKo1iTd
 IYpzH4MnVoVBzIRtU4w==
X-Authority-Analysis: v=2.4 cv=VN7QXtPX c=1 sm=1 tr=0 ts=69aee61d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Rd4DrVCMV_EA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=3oOJLAxtiLN628aBsBcA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: TVBurlFqrxhG_zc3r0SHg3lx7lbIi4k5
X-Rspamd-Queue-Id: 5859023BD07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[imgtec.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[imgtec.com:s=dk201812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223689-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[imgtec.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.belle@imgtec.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.931];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,imgtec.com:dkim,imgtec.com:email,imgtec.com:mid]
X-Rspamd-Action: no action

The soft reset sequence is currently executed from the threaded IRQ
handler, hence it cannot call disable_irq() which internally waits
for IRQ handlers, i.e. itself, to complete.

Use disable_irq_nosync() during a soft reset instead.

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Cc: stable@vger.kernel.org
Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_power.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index 7a8765c0c1ed..046cce76498a 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -510,7 +510,16 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 	}
 
 	/* Disable IRQs for the duration of the reset. */
-	disable_irq(pvr_dev->irq);
+	if (hard_reset) {
+		disable_irq(pvr_dev->irq);
+	} else {
+		/*
+		 * Soft reset is triggered as a response to a FW command to the Host and is
+		 * processed from the threaded IRQ handler. This code cannot (nor needs to)
+		 * wait for any IRQ processing to complete.
+		 */
+		disable_irq_nosync(pvr_dev->irq);
+	}
 
 	do {
 		if (hard_reset) {

---
base-commit: d2e20c8951e4bb5f4a828aed39813599980353b6
change-id: 20260309-fix-soft-reset-8f32c3783d3d

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>


