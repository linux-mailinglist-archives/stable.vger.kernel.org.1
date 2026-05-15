Return-Path: <stable+bounces-247717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJxELNgLB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:04:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5054754F064
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7E9F3046125
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97E2480DDB;
	Fri, 15 May 2026 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ofACj4MP"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656C480DCC
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846251; cv=none; b=Yoz1VflqoP4cOzx0NJ0Z15T+ahAqksxpqkJp+THT89xEgx5Exnm+gSF2I6jhFMurwJjdR3ibngyJT7/0tUtETl5ooixmFKIku1OY8VBbUnKdO1KcCfSL8zN/kpTmQijk0JAvuaWJX9ECXuajpH1blavG+qdMo41/qZTmGg1Ii38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846251; c=relaxed/simple;
	bh=nx0J1QX5oaXOCykQ07CxVUiQY0PaY0fsVt6IsOUPFtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqIPiIyYFa1j+ru0E49Q9QRqrN8TqIfwnjE1SRCYd0KincCKK5YFd/oAbu7HenjklKDjtVROX1e3HRdmyaDqrectJr4sXlOmqbpwxRkWsQ/oWYPE2jAUEf3k+TcUsoeyMKBr166TQrVmQnlnJilDZNKGZq+vBIEcX7Lw6TBC9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ofACj4MP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 881421A35E7
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:57:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 570D3606FD;
	Fri, 15 May 2026 11:57:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E60D911AF8C5C;
	Fri, 15 May 2026 13:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778846242; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KWr11r2W+5gIUvnQAWZ5dbd+eVz+6vXjcvqbFYT0Wo8=;
	b=ofACj4MP9e5VeMy9iJzUnpG5d6Tf84OcahQPR0FHmY7vM3EybAu/Rx/HgQhDclz85voYYa
	v5U4+EWWtgUuDNmvvXvXTzhTQa58FiJ7dvNT0iKRG3mE3ZGnxTm3rX9uK+nxBFPxj5kjGL
	AzJd6ASCHjq1MvsTZ00F5+/yUCtNiXda2i8UyEzQcTpH+j+ymTCL3deSRAuhUzb/Was1Cb
	rwVbBC9+mLNN46ciglKmLKl4ahGxIUNUQP60MlLqHVZSaXnzozB4u4gO2Qqdpflt1zuY27
	g8VJ0org0rqmcMUjMTyronMSPaaeqLwZqVP0lEi3btrjDqs7eyTlm6mzv+IfYQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 15 May 2026 13:56:57 +0200
Subject: [PATCH v2 2/2] nvmem: layouts: Make the fixed-layout driver
 optional
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-mathieu-nvmem-fixed-layout-v2-2-8ac215dd4016@bootlin.com>
References: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com>
In-Reply-To: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778846239; l=1950;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=nx0J1QX5oaXOCykQ07CxVUiQY0PaY0fsVt6IsOUPFtQ=;
 b=vJ8C0JgVunY0CqA0AwqdsO34bPgkxulBxzU4qZ0fttgd7pZ8kkaTfi0FWAdTqP3VwKjjofYw5
 e9IqAPHjU/KASTN4gm4lr9P9jcz+Xznsph3o/XxzrbGRh3zODLorPSs
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 5054754F064
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247717-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.dubois-briand@bootlin.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The fixed-layout support is now managed by a separate driver, so we can
make this support optional. This aligns with the approach taken for
other layout drivers.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/nvmem/core.c           | 1 +
 drivers/nvmem/layouts/Kconfig  | 8 ++++++++
 drivers/nvmem/layouts/Makefile | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0ec4924c4bda..594180d4b889 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -834,6 +834,7 @@ int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvmem_add_cells_from_dt);
 
 static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
 {
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 5e586dfebe47..f823d56210a3 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -8,6 +8,14 @@ if NVMEM_LAYOUTS
 
 menu "Layout Types"
 
+config NVMEM_LAYOUT_FIXED_LAYOUT
+	tristate "Fixed layout support"
+	help
+	  Say Y here to enable support for NVMEM fixed layout, which provides a
+	  way to describe memory cells with fixed offsets and sizes.
+
+	  If unsure, say N.
+
 config NVMEM_LAYOUT_SL28_VPD
 	tristate "Kontron sl28 VPD layout support"
 	select CRC8
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index dd6c6c70b1a9..9da790a9dde9 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -3,7 +3,7 @@
 # Makefile for nvmem layouts.
 #
 
-obj-$(CONFIG_NVMEM_LAYOUTS) += fixed-layout.o
+obj-$(CONFIG_NVMEM_LAYOUT_FIXED_LAYOUT) += fixed-layout.o
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
 obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o

-- 
2.47.3


