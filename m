Return-Path: <stable+bounces-260610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4VZdMjIxImq6TgEAu9opvQ
	(envelope-from <stable+bounces-260610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 04:15:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A776449F1
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 04:15:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=G4y7xzCU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260610-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260610-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE3F9300D747
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 02:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50FE3E5A19;
	Fri,  5 Jun 2026 02:15:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75B3BB102;
	Fri,  5 Jun 2026 02:14:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625704; cv=none; b=cA8oM5uwd92ovYY8q+4agLwBFOj+KYbPM7aFb0i+HLG2daAXuYcqalZQ7uca5r8BZPbxcFD4AwJXCLhs7Te0SYdVkXFeYVISFmF/HDhs4Ue/W8K+iflNA50Hw/+FB4izO0EoFsSkDvpgB/gXz/G2KySd7s9DwxC+2+CR8O98OqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625704; c=relaxed/simple;
	bh=0bQEGTXCr8ZVAYQLiYVu1g1Jrg9OroAMlRskoctL2zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PJdpYfjH2E3cvYFv+izCDlcSxe/v8Wvr7/Z4hGIHg1qUNy9cn1oeShkn9QvhqowjZTMkGBZaeAkcwsn1GmLSWXIz578MU72RGIdL5EO3vn+6nhewC35UbWVijlvQ1ICe//IVeM9A6Um7muwlLSC621W1yAF80Xy56pE9pXy3Wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=G4y7xzCU; arc=none smtp.client-ip=101.71.155.101
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 412814aef;
	Fri, 5 Jun 2026 10:09:26 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: lyude@redhat.com
Cc: dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	namcao@linutronix.de,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Date: Fri,  5 Jun 2026 10:07:52 +0800
Message-Id: <20260605020752.1707562-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e958adbad03a2kunme8b1df4229401
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR0fVktOGB0aSR9MQ08eSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=G4y7xzCU87m6TM2r9nqttfnEpiwLXLmAUtmfJsKWNCxv2FIyJYSir3x5/iUP8pSqaa+aY9iIgL912ZjwsfFULxFMchyYUkPUhw90xVpfeHcY96zWxdGiTejHAeKcF2alBT9G+d7lUCcQrHWK3tFhXb3f3tp28LoWBKB7MIkwVtQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=9hPQlir0LYpa42uuWLi8uH8JCnnafnPqkGo+wT4cuCU=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260610-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:lyude@redhat.com,m:dakr@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:namcao@linutronix.de,m:dri-devel@lists.freedesktop.org,m:nouveau@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:dawei.feng@seu.edu.cn,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,linutronix.de,lists.freedesktop.org,vger.kernel.org,seu.edu.cn];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,seu.edu.cn:mid,seu.edu.cn:dkim,seu.edu.cn:from_mime,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99A776449F1

If loading the HS bootloader blob fails, nvkm_falcon_fw_ctor_hs() returns
immediately. This skips the common cleanup path and leaks the firmware
state allocated by nvkm_falcon_fw_ctor() and nvkm_falcon_fw_sign().

Fix this by routing the load failure to the 'done' label so
nvkm_falcon_fw_dtor() can properly clean up the partially initialized
state. Also clear the original 'blob' pointer after releasing it so the
final nvkm_firmware_put() remains balanced after a failed bootloader
reload.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
v7.1-rc6.

An x86_64 allyesconfig build showed no new warnings. As we do not have a
supported NVIDIA GPU with the required firmware to test this path, no
runtime testing was able to be performed.

Fixes: 2541626cfb79 ("drm/nouveau/acr: use common falcon HS FW code for ACR FWs")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
index 4e8b3f1c7e25..71f55c5b0837 100644
--- a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
@@ -278,10 +278,11 @@ nvkm_falcon_fw_ctor_hs(const struct nvkm_falcon_fw_func *func, const char *name,
 
 	if (bl) {
 		nvkm_firmware_put(blob);
+		blob = NULL;
 
 		ret = nvkm_firmware_load_name(subdev, bl, "", ver, &blob);
 		if (ret)
-			return ret;
+			goto done;
 
 		hdr = nvfw_bin_hdr(subdev, blob->data);
 		desc = nvfw_bl_desc(subdev, blob->data + hdr->header_offset);
-- 
2.34.1


