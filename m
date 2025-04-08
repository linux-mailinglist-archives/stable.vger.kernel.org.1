Return-Path: <stable+bounces-129964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7AAA80281
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF0F4470DB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4C25FA13;
	Tue,  8 Apr 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DgH+GgnD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8922192F2;
	Tue,  8 Apr 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112450; cv=none; b=bY5bJqYAv+B5fR3ExvQ/cQ60d7BKFQlUFzaZE94wOs4kaAv5v3+bghrc/P6wWJIT7GVzFbK0ierTn7o5nOzkWE95Oi5XhoMd5cGQxR5TaVNgkYX6d4M1OqfgV/J+Q4w4DVMUyYvXIHsg+UR0PNLlt9pFxYFBAmv/RyODSGzy8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112450; c=relaxed/simple;
	bh=hSrJxNeDD9Hf25xSPQ6r8ZayGtr4H5eiUIPE0vXZGPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPp3z9Dg8h4u7SMGt1d/qpiN9gOgKaXgeMyfaw3Jnxs1CRfuSWwARHUuQpjpiLBBQK5+URgG5X3CzwqEwH3WQ/4XTc+YEIu3x3RLiNlRqaOjoYVhencXyAG/Fe1QwIqGpn5kKDueXqKN6f5HtN/wMR48XyH7TiXFUYaJTY/TWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DgH+GgnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95354C4CEE5;
	Tue,  8 Apr 2025 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112450;
	bh=hSrJxNeDD9Hf25xSPQ6r8ZayGtr4H5eiUIPE0vXZGPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DgH+GgnDRpMPxFsuFzJZR2ufaaOsNYBBUMenp1EQdZ0/0iz19+ZrfvZv5hJc++bIZ
	 +zBJD0YLJH2p4IcKlYlosaHC8FMLFmNip/0xK6viw+e0P7LY3tf9VfHxIIZPOB4jkR
	 W4W12uk5wCjAg4wuqXIpmN3xRcYy+4DMShO5H7z4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 072/279] i2c: ali1535: Fix an error handling path in ali1535_probe()
Date: Tue,  8 Apr 2025 12:47:35 +0200
Message-ID: <20250408104828.285168358@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 9b5463f349d019a261f1e80803447efca3126151 ]

If i2c_add_adapter() fails, the request_region() call in ali1535_setup()
must be undone by a corresponding release_region() call, as done in the
remove function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/0daf63d7a2ce74c02e2664ba805bbfadab7d25e5.1741031571.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-ali1535.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index ee83c4581bce0..cd2c8afebe798 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -490,6 +490,8 @@ MODULE_DEVICE_TABLE(pci, ali1535_ids);
 
 static int ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int ret;
+
 	if (ali1535_setup(dev)) {
 		dev_warn(&dev->dev,
 			"ALI1535 not detected, module not inserted.\n");
@@ -501,7 +503,15 @@ static int ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
 		"SMBus ALI1535 adapter at %04x", ali1535_offset);
-	return i2c_add_adapter(&ali1535_adapter);
+	ret = i2c_add_adapter(&ali1535_adapter);
+	if (ret)
+		goto release_region;
+
+	return 0;
+
+release_region:
+	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
+	return ret;
 }
 
 static void ali1535_remove(struct pci_dev *dev)
-- 
2.39.5




