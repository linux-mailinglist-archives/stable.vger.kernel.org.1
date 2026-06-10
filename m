Return-Path: <stable+bounces-262410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HwlLIEvSKGqRKQMAu9opvQ
	(envelope-from <stable+bounces-262410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 04:56:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFF1665840
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 04:56:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=BVeB97sS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262410-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262410-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89A1F302DF97
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 02:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9D33344A;
	Wed, 10 Jun 2026 02:56:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2994309F09;
	Wed, 10 Jun 2026 02:55:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060161; cv=none; b=kkUQPX9RJst7seuIpxTKDA84wuoAiXlZshbUxhar61c41V2d0YY5FhowlVTtnNlfwimf5o6cB6iLXTwqopnwq5gzwPehippTT3Kha2DzVV1d7pWKONzjKjgoTvWWWwrdUWDatHSA77x+/UZjnZae2ajauMjktHntSj970OuxbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060161; c=relaxed/simple;
	bh=k8bCoUpQPz3kiTGDkZN6riGwl+G6opCb2J3B2RnZxEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pc0FHITpC6ysnzZZ+NSrSmOLLdC46IObz2nnQgdCCXhF4PNcgXcyhREdZ0iIRubrZDt7ZIaD6TvB3J8Za/s8owDlioVXPV8gQGx/ZgiV+cX4gkFdPZSKjVfg03icA9wHTCZLAor7aHlffS2MWDYKYRAnmaXL6C5wRkP0MD+JU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BVeB97sS; arc=none smtp.client-ip=45.254.49.198
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41c381d5a;
	Wed, 10 Jun 2026 10:50:38 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: lyude@redhat.com
Cc: dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	ttabi@nvidia.com,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2] nouveau/firmware: fix memory leak on BL load failure
Date: Wed, 10 Jun 2026 10:50:37 +0800
Message-Id: <20260610025037.4115412-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eaf7062b703a2kunmc6eba4c6156930
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGB1KVh5PTBofS09PTEgfH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=BVeB97sStw69DKNXFQtYXpsIiiNTJ/xuDGVaXutLyIwGvGDWzjd81LpZ1siCwco3Lhx0d4CXRrnVANOKJZNkK799vsoxQTDDp1MBK6yEWj2OnJx4nrMqQa1+xw1xn5H+41sL0uDQ4K3WA9zOXryl89EdxTLCmhS9KJSCjJ/p/Wc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=0pJPLwBr4j7fuUn4mvVSS8dg+sLUYiki6rsJq47kVB0=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262410-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lyude@redhat.com,m:dakr@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:nouveau@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:ttabi@nvidia.com,m:dawei.feng@seu.edu.cn,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,seu.edu.cn,nvidia.com];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBFF1665840

If loading the HS bootloader blob fails, nvkm_falcon_fw_ctor_hs() returns
immediately. This skips the common cleanup path and leaks the firmware
state allocated by nvkm_falcon_fw_ctor() and nvkm_falcon_fw_sign().

Fix this by routing the load failure to the 'done' label so
nvkm_falcon_fw_dtor() can properly clean up the partially initialized
state. Keep the original image firmware in 'blob' until the common
cleanup path, and use a separate 'blob_bl' pointer for the bootloader
firmware so it can be released immediately after the bootloader data has
been copied.

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
Changes in v2:
- Use a separate bootloader firmware pointer instead of reusing 'blob'.
- Keep the original image firmware release in the common cleanup path.

 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
index 4e8b3f1c7e25..063469ee462f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
@@ -277,19 +277,20 @@ nvkm_falcon_fw_ctor_hs(const struct nvkm_falcon_fw_func *func, const char *name,
 	fw->dmem_sign = loc - lhdr->data_dma_base;
 
 	if (bl) {
-		nvkm_firmware_put(blob);
+		const struct firmware *blob_bl;
 
-		ret = nvkm_firmware_load_name(subdev, bl, "", ver, &blob);
+		ret = nvkm_firmware_load_name(subdev, bl, "", ver, &blob_bl);
 		if (ret)
-			return ret;
+			goto done;
 
-		hdr = nvfw_bin_hdr(subdev, blob->data);
-		desc = nvfw_bl_desc(subdev, blob->data + hdr->header_offset);
+		hdr = nvfw_bin_hdr(subdev, blob_bl->data);
+		desc = nvfw_bl_desc(subdev, blob_bl->data + hdr->header_offset);
 
 		fw->boot_addr = desc->start_tag << 8;
 		fw->boot_size = desc->code_size;
-		fw->boot = kmemdup(blob->data + hdr->data_offset + desc->code_off,
+		fw->boot = kmemdup(blob_bl->data + hdr->data_offset + desc->code_off,
 				   fw->boot_size, GFP_KERNEL);
+		nvkm_firmware_put(blob_bl);
 		if (!fw->boot)
 			ret = -ENOMEM;
 	} else {
-- 
2.34.1

