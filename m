Return-Path: <stable+bounces-180364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C26B7F1D8
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2D31C80210
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127FB319601;
	Wed, 17 Sep 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ujzoEL8B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413C19F115;
	Wed, 17 Sep 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114228; cv=none; b=DstNVxbZmpJ9v+ZclMrT3fGEgaC+gYhcN8KU1kA+CQZv9lfhNZO85RdVMCKyuUzMVceaygfPqZKJOAyxPV0rs854gf7SOtC+sVYcESo8ReHd4fwI8Rjds4MtRe276KrVjNfvzJZMbEbDzT2v0qiNyEi3Ez9WxxArAoKkDkdRun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114228; c=relaxed/simple;
	bh=8MkgdAQ8bYjv4NqXmfdMq7bo++Lfa3s9+WTSMg/963c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nihj2sF84bkxyBi+c/uicI3RFLut+Ym7i7xISBJKXCzYF0sZqrv4mx7Pzst+l7F1T3PtULvdl6aC3gJkUnjf8Ek2jlA04UjDL0hF9aHP28zkUmNfXlKONxWDhGOTX7vkcqppKDkziA28C5g/aoutRjHCcLHDOewbhHR/3srJijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ujzoEL8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4575C4CEFA;
	Wed, 17 Sep 2025 13:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758114228;
	bh=8MkgdAQ8bYjv4NqXmfdMq7bo++Lfa3s9+WTSMg/963c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujzoEL8BuC6KdAK+4heD8o8yTPgb0WhF6xkujoljjwyOh/zevDjUeUCRCmFcX0t7c
	 xKzliiJ9sFT7HWqr3IeUtQSlc4CPdP2HZIspxTdWrk6A2wnX+fw7fVR64XGB20HzTy
	 S6JWIhiD5fvthISfKFVhWDTrciMuVUMu0x+kMHcs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Val Packett <val@packett.cool>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Yongqin Liu <yongqin.liu@linaro.org>
Subject: [PATCH 6.1 78/78] soc: qcom: mdt_loader: Deal with zero e_shentsize
Date: Wed, 17 Sep 2025 14:35:39 +0200
Message-ID: <20250917123331.491149370@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
References: <20250917123329.576087662@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

commit 25daf9af0ac1bf12490b723b5efaf8dcc85980bc upstream.

Firmware that doesn't provide section headers leave both e_shentsize and
e_shnum 0, which obvious isn't compatible with the newly introduced
stricter checks.

Make the section-related checks conditional on either of these values
being non-zero.

Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
Reported-by: Val Packett <val@packett.cool>
Closes: https://lore.kernel.org/all/ece307c3-7d65-440f-babd-88cf9705b908@packett.cool/
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Closes: https://lore.kernel.org/all/aec9cd03-6fc2-4dc8-b937-8b7cf7bf4128@linaro.org/
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Fixes: 9f35ab0e53cc ("soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()")
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250730-mdt-loader-shentsize-zero-v1-1-04f43186229c@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Cc: Yongqin Liu <yongqin.liu@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/mdt_loader.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -38,12 +38,14 @@ static bool mdt_header_valid(const struc
 	if (phend > fw->size)
 		return false;
 
-	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
-		return false;
+	if (ehdr->e_shentsize || ehdr->e_shnum) {
+		if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+			return false;
 
-	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
-	if (shend > fw->size)
-		return false;
+		shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
+		if (shend > fw->size)
+			return false;
+	}
 
 	return true;
 }



