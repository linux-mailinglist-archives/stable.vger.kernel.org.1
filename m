Return-Path: <stable+bounces-156564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C2AE5018
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF243ADB41
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A99A1F582A;
	Mon, 23 Jun 2025 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zTBL1G4x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D91E521E;
	Mon, 23 Jun 2025 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713722; cv=none; b=c9FNKYI7YlKATZaG6zZqPxw602a4ZkYOLUnI+uSMrV5yo8+Ej7J7HrEn3xwdJg6m1eslqCvyStDOdiZ2FCoTZiL8Nkng0Tt1DR0ktUBYaRd8IYzB5VcE6diFsWxXQkmWDbnwiWnkqulvNSdztrxMQrWL+cVuM8GHr1KjxqG40LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713722; c=relaxed/simple;
	bh=N8d2yAYXFVmlslXEuHfsFEhBpsTJFvIAPslhc9cP2+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOe00Rwuj2UBK+GlsKBgcXrBPKyeG8Ts5OTfwzia5wauRV1iBNWPaqZOJOWc82bmJgbaP7q9TKVE3nzDcspdM+fYRB0D8ZcSqrAbxBmDVVMPGeqQ7kOiQ++ld1WFuEDtiaGrx3vU3DcHk8OOMVtLvRijDbsMS55t6fha9HipHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zTBL1G4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72892C4CEEA;
	Mon, 23 Jun 2025 21:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713721;
	bh=N8d2yAYXFVmlslXEuHfsFEhBpsTJFvIAPslhc9cP2+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zTBL1G4xwmDjvV0cEVuoDpJYis45ZuPwgD61RSsKkkkhSHFpSDq67s18+pILcbc3l
	 sRKLTB26JE1QE0mKQ4BIaMItgXYAGClcM5UDCZpciOyxIPa2XFWkcwz+5XIq/kx8gz
	 B5SpG27O2LO2TJjvoxa57rN9M5xMqKCEsZfA9tHk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.6 086/290] mtd: nand: sunxi: Add randomizer configuration before randomizer enable
Date: Mon, 23 Jun 2025 15:05:47 +0200
Message-ID: <20250623130629.569489725@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit 4a5a99bc79cdc4be63933653682b0261a67a0c9f upstream.

In sunxi_nfc_hw_ecc_read_chunk(), the sunxi_nfc_randomizer_enable() is
called without the config of randomizer. A proper implementation can be
found in sunxi_nfc_hw_ecc_read_chunks_dma().

Add sunxi_nfc_randomizer_config() before the start of randomization.

Fixes: 4be4e03efc7f ("mtd: nand: sunxi: add randomizer support")
Cc: stable@vger.kernel.org # v4.6
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/sunxi_nand.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -817,6 +817,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(s
 	if (ret)
 		return ret;
 
+	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);



