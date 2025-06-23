Return-Path: <stable+bounces-156980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F1DAE51F4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F437A3F94
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B7B2222A9;
	Mon, 23 Jun 2025 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OiPaRxzU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5421D3DD;
	Mon, 23 Jun 2025 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714741; cv=none; b=tXlZfeQ6bPnwyXW/5qnokZ4sF3DeCCIwbUB3j6H+V6BtuORerOXYUyEmKdPPXvkKbR3+r3YAVCiXOB2gZDV0PH6X8g2lNtVhAT4ikpjYx8kYd0CqwLrOGyscLmWBXTEql/bWmdqK0UUpgUMuKprErPJsi5wTxtq/TWLP7dFAQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714741; c=relaxed/simple;
	bh=YcKoEJKnBWDcMr6eBij6HxOuNbf+KlHx5Cz5DkhMZcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKbNUbGJCIv9wXRpFCgThqnFJvDEiVFMys4ZK3XAUgTI3kXRBgabFK5JeoKaO7+Mhva1eo2J7MU6MTHHoehVq+lmEyKbqGz94Hps+vhKPjjkbZ0G+zWQYxLDWPH66ObIwScZ7uehSf3bhNh2VOYvc7tp2u/g0hDPsdRKDK0pme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OiPaRxzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45003C4CEEA;
	Mon, 23 Jun 2025 21:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714740;
	bh=YcKoEJKnBWDcMr6eBij6HxOuNbf+KlHx5Cz5DkhMZcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OiPaRxzUkKhIAH0bJ7keaPqvBCJ5mVPhnDt0mmqSz2SD1MhJhHX3hU8YCpDdjJqPj
	 YfRdkEfMRw/PIEGd7kjnpPeCQ8l/DhfnMySjeVLmHF0vvKoX5q8ZNSMMrlYfltqxoI
	 RhSx45O4TY9sVHWg8oHy0/5AiYden64iMgTjUNl4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lakshmi Sowjanya D <quic_laksd@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.12 127/414] mtd: rawnand: qcom: Fix read len for onfi param page
Date: Mon, 23 Jun 2025 15:04:24 +0200
Message-ID: <20250623130645.237070764@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Md Sadre Alam <quic_mdalam@quicinc.com>

commit e6031b11544b44966ba020c867fe438bccd3bdfa upstream.

The minimum size to fetch the data from device to QPIC buffer
is 512-bytes. If size is less than 512-bytes the data will not be
protected by ECC as per QPIC standard. So while reading onfi parameter
page from NAND device set nandc->buf_count = 512.

Cc: stable@vger.kernel.org
Fixes: 89550beb098e ("mtd: rawnand: qcom: Implement exec_op()")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2917,7 +2917,7 @@ static int qcom_param_page_type_exec(str
 		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
 	}
 
-	nandc->buf_count = len;
+	nandc->buf_count = 512;
 	memset(nandc->data_buffer, 0xff, nandc->buf_count);
 
 	config_nand_single_cw_page_read(chip, false, 0);



