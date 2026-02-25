Return-Path: <stable+bounces-219269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLG0KtOenmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB97192D87
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73BDB314029E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C92D23A4;
	Wed, 25 Feb 2026 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QpznKevk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136542C17A0;
	Wed, 25 Feb 2026 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002605; cv=none; b=kubgRlhk/f5UVR/VLO4d2He6aAcGrrleNBb1ilZ/LWHb5XfRchdJEpPnUKfc+lCKdxLD73iFfdaHOZOLPX/TMcvNCUtj9UVnMRz4iH0rqdY9eDZxAnQoR7h2iGVGvCpsgiyExdiaLXR8JbCO2Oa88vXm/xZiTKXj3drFzaEI+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002605; c=relaxed/simple;
	bh=qXZv+eoiZ+E5EDWqcLbxcPsVhMxSrBjteYoey8f1eBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8Ko4arLAzJkwD8W4ofnM9tP17WvKY3b+LBVdSueKsEqJ5FwF6Lb2iA5N48ZRWD48mjQJyYUUJpR6Y8a14WYUxawaH2cAfj/907By6jbr5s9Yg7xFqODjxaee94WtyA8VChmETeepDdluicDYTQmicinkz+u2iH/DN4Ds7Wnwqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QpznKevk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C01C19422;
	Wed, 25 Feb 2026 06:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002605;
	bh=qXZv+eoiZ+E5EDWqcLbxcPsVhMxSrBjteYoey8f1eBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpznKevkQ9zOy7Ajr8haIK0Y8w6lZHEZ26Dp0F2eXLLOV4bWDiTnD+rYOM6pGDYuZ
	 SjtY6Ueh15oMgw6XyPbtfs3Za2pL+Wl7TiEMog7khyhDy4JMOE5W1+xvJQtQ+cWh4G
	 Md2GeHRvIZHmXac5X5GWEIhrtOje40vObcsx1nqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Koskovich <akoskovich@pm.me>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 354/641] power: reset: nvmem-reboot-mode: respect cell size for nvmem_cell_write
Date: Tue, 24 Feb 2026 17:21:20 -0800
Message-ID: <20260225012357.215162751@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219269-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DB97192D87
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Koskovich <AKoskovich@pm.me>

[ Upstream commit 36b05629226413836cfbb3fbe6689cd188bca156 ]

Some platforms expose reboot mode cells that are smaller than an
unsigned int, in which cases lead to write failures. Read the cell
first to determine actual size and only write the number of bytes the
cell can hold.

Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
Link: https://patch.msgid.link/20251214191529.2470580-1-akoskovich@pm.me
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/reset/nvmem-reboot-mode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc48..d260715fccf67 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -10,6 +10,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
 #include <linux/reboot-mode.h>
+#include <linux/slab.h>
 
 struct nvmem_reboot_mode {
 	struct reboot_mode_driver reboot;
@@ -19,12 +20,22 @@ struct nvmem_reboot_mode {
 static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 				    unsigned int magic)
 {
-	int ret;
 	struct nvmem_reboot_mode *nvmem_rbm;
+	size_t buf_len;
+	void *buf;
+	int ret;
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	buf = nvmem_cell_read(nvmem_rbm->cell, &buf_len);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+	kfree(buf);
+
+	if (buf_len > sizeof(magic))
+		return -EINVAL;
+
+	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, buf_len);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
-- 
2.51.0




