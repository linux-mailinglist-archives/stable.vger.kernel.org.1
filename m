Return-Path: <stable+bounces-173223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88993B35C8A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9327362DE8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E13321456;
	Tue, 26 Aug 2025 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DVd5bhnU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC882BF001;
	Tue, 26 Aug 2025 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207688; cv=none; b=eoQxcmduTA0Ev7FruZJU8zOyz7kDn8ukvf5D2QraBxOfxOlxcXfs9+SITX6bAfmDbtQe4ZBMrcitlWpeHnRf+7impJHiTkKDTk95IJbmJMCMgQBkppq+ImKMKyu+ydXOlXx1YO+KQg24VblTyvtSM8U1oZ/03L1tno10F8ksvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207688; c=relaxed/simple;
	bh=I9AOLVPKk5/kBIArW8E1MBMRfE1aiUAIarOe3OlJZJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URTcPQRpznDMZ1e7Vb/28ySBWF3nGWeIfXBbCTB4RVMMiEx9c92pwYSzcn7OvOUV2NbrxIf3u1k8liaSBn5JDBhdmdjqllDeKfEpZjO6qknU9HV/bX1Yf9s6U2ENMydNnUI/Bhg1Fvcvk7uK9O7haWJyZDJ+T4GQABh6P8t6LEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DVd5bhnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB9DC4CEF1;
	Tue, 26 Aug 2025 11:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207688;
	bh=I9AOLVPKk5/kBIArW8E1MBMRfE1aiUAIarOe3OlJZJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVd5bhnUAGfUcz7x4ZpYtKv5+KN30wXyXyKChKk50HVj+8J/R5intXr2RUMRV/WXM
	 d1cM1JOfjtNr9ZT1ICKxjZliPgpkGuzM/BC7BKJLSvLhZYWZ+1bZUbODbS2S0fM1Ev
	 Ng6yUQxQoJZZCiO1zCki7GzyKMojOMm5oG42t9sQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.16 278/457] soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()
Date: Tue, 26 Aug 2025 13:09:22 +0200
Message-ID: <20250826110944.250667129@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 9f35ab0e53ccbea57bb9cbad8065e0406d516195 upstream.

This function is supposed to return true for valid headers and false for
invalid.  In a couple places it returns -EINVAL instead which means the
invalid headers are counted as true.  Change it to return false.

Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/db57c01c-bdcc-4a0f-95db-b0f2784ea91f@sabinyo.mountain
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/mdt_loader.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -33,14 +33,14 @@ static bool mdt_header_valid(const struc
 		return false;
 
 	if (ehdr->e_phentsize != sizeof(struct elf32_phdr))
-		return -EINVAL;
+		return false;
 
 	phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
 	if (phend > fw->size)
 		return false;
 
 	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
-		return -EINVAL;
+		return false;
 
 	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
 	if (shend > fw->size)



