Return-Path: <stable+bounces-230656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN0hI8qHxmlALQUAu9opvQ
	(envelope-from <stable+bounces-230656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:36:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07D345550
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BD6A30810A4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70873F54B4;
	Fri, 27 Mar 2026 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdS6VlxT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BFE3F54A2;
	Fri, 27 Mar 2026 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617421; cv=none; b=a9FoLFtxWdTuHhEFC6C3BTCZApOOgqH59K5vZmbsZElSEqOLQfoKKsEycXS6mmMS/YfMG+sfxcWrzyNmhbFO5sTeroYvNppe2iywKqq5QAgXNBEsKALm2kSkkHszAl97XglTcecfozJoVERo5T/88wCmyatPQeHuy8h/0H971qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617421; c=relaxed/simple;
	bh=l2Wb0oVTIQsMM3NmSvpjN/9r9uGPXLRKEcydauBmvWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li6GBWi/92ClzLQu55Z14wPcITBw2ICx1ExgMBOGoRu1jI9EyxCBVhJkg01/vCQmOoZCZNWUEyaahj2hsoct/efuJHRWkK3zmY/CT7l6K7Uem9DaZq8s3a+LAgyE/aj0TJEhG/c1RnPGRJyHXSTrBOmGCcBwQQyNU5yjtjDiyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdS6VlxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BCFC2BC9E;
	Fri, 27 Mar 2026 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774617421;
	bh=l2Wb0oVTIQsMM3NmSvpjN/9r9uGPXLRKEcydauBmvWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdS6VlxTCrypQUM5yZNL5J3p6W/DNiFD1Q3qeJkMuspiCucvTNSIPEcGGCGwjaNip
	 n8kfuoMeY+W8zlsVmK8xz0TDAVsKN2uWWMI2UkwCGRKy+wNloW0QCsjRvhmygVFelX
	 W9HqoErP9v4uHTQun3EXJORKqkKHfy+/Jx5DIw1fNlnKwOCLIefBxfrndVEDRpmbRX
	 sJCOhWUpdBfmYN23KVStDMKphvsxU6loJHTXaQsuCQ0aKh82REhKcmSLUrt9VhVVFE
	 UNIoEcpjirEg6dBC3pktXYDjgOyMM0SF64yFVe5qgZ28SLpj+nuNU1qqzR3tWX/XHf
	 bkXfaBBqhYVZw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ivan Vera <ivanverasantos@gmail.com>,
	stable@vger.kernel.org,
	Harish Ediga <harish.ediga@amd.com>,
	Harsh Jain <h.jain@amd.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/2] nvmem: zynqmp_nvmem: Fix buffer size in DMA and memcpy
Date: Fri, 27 Mar 2026 13:16:45 +0000
Message-ID: <20260327131645.3025781-3-srini@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327131645.3025781-1-srini@kernel.org>
References: <20260327131645.3025781-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,amd.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-230656-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srini@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C07D345550
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ivan Vera <ivanverasantos@gmail.com>

Buffer size used in dma allocation and memcpy is wrong.
It can lead to undersized DMA buffer access and possible
memory corruption. use correct buffer size in dma_alloc_coherent
and memcpy.

Fixes: 737c0c8d07b5 ("nvmem: zynqmp_nvmem: Add support to access efuse")
Cc: stable@vger.kernel.org
Signed-off-by: Ivan Vera <ivanverasantos@gmail.com>
Signed-off-by: Harish Ediga <harish.ediga@amd.com>
Signed-off-by: Harsh Jain <h.jain@amd.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/zynqmp_nvmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 7da717d6c7fa..d297ff150dc0 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -66,7 +66,7 @@ static int zynqmp_efuse_access(void *context, unsigned int offset,
 	dma_addr_t dma_buf;
 	size_t words = bytes / WORD_INBYTES;
 	int ret;
-	int value;
+	unsigned int value;
 	char *data;
 
 	if (bytes % WORD_INBYTES != 0) {
@@ -80,7 +80,7 @@ static int zynqmp_efuse_access(void *context, unsigned int offset,
 	}
 
 	if (pufflag == 1 && flag == EFUSE_WRITE) {
-		memcpy(&value, val, bytes);
+		memcpy(&value, val, sizeof(value));
 		if ((offset == EFUSE_PUF_START_OFFSET ||
 		     offset == EFUSE_PUF_MID_OFFSET) &&
 		    value & P_USER_0_64_UPPER_MASK) {
@@ -100,7 +100,7 @@ static int zynqmp_efuse_access(void *context, unsigned int offset,
 	if (!efuse)
 		return -ENOMEM;
 
-	data = dma_alloc_coherent(dev, sizeof(bytes),
+	data = dma_alloc_coherent(dev, bytes,
 				  &dma_buf, GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
@@ -134,7 +134,7 @@ static int zynqmp_efuse_access(void *context, unsigned int offset,
 	if (flag == EFUSE_READ)
 		memcpy(val, data, bytes);
 efuse_access_err:
-	dma_free_coherent(dev, sizeof(bytes),
+	dma_free_coherent(dev, bytes,
 			  data, dma_buf);
 efuse_data_fail:
 	dma_free_coherent(dev, sizeof(struct xilinx_efuse),
-- 
2.47.3


