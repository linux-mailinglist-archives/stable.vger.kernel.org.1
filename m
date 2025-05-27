Return-Path: <stable+bounces-147676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8CAC58B3
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A944A0162
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2C27A131;
	Tue, 27 May 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K6kgKo76"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D01FB3;
	Tue, 27 May 2025 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368084; cv=none; b=AGBJSGL9Ywq6tx7kYazGUh7aeRJdbmu3LytD1izrOUvTMzI4i+JJ2R5abh0zASa6APjkN8B4ZSlctjvHuCPaoDDNmhqYQcgyqD8LEx5TSMzap4vpnbXo94CCMlMA6BCdy68e8NM5SqDX0OHBbuSbb+7NhdJIM0TFDcyk7Bsq21k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368084; c=relaxed/simple;
	bh=uqqUMf1Hj25Z9Eb5HRZBtA5M7Qu9LIoq7/2cGF+e+uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZR47nd94Yl1S8LomN5jtqo/bzHWQ13YEXqjimEl75sjO2l8GlaQttZGuuguVdGCSC8jLOWF2AuRsy+jaAGX3G+rBSa1F4nLRN9OQcj+an9brk8yuKBq2TS92hpGz/mH4a8i9CHlWZ22+aiZfoyMbjumySfDK99yQasyr0DXfos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K6kgKo76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EECAC4CEE9;
	Tue, 27 May 2025 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368084;
	bh=uqqUMf1Hj25Z9Eb5HRZBtA5M7Qu9LIoq7/2cGF+e+uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6kgKo76xdXGD10+v1UQ5+oZGLmWI62gewtI36t5/bKEIrFFxiL2B5PWmR5mDfXe9
	 nAP34LoLz8k04ih7CQA7q1LUPcH1TaiI26OGualiJMEcDU+nxrRD61W0MpbTqTJppy
	 KeuKvksDqagxfUoHQXTf7v1YZqGE94nsz5Tti10w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 576/783] net/mana: fix warning in the writer of client oob
Date: Tue, 27 May 2025 18:26:13 +0200
Message-ID: <20250527162536.602369478@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Taranov <kotaranov@microsoft.com>

[ Upstream commit 5ec7e1c86c441c46a374577bccd9488abea30037 ]

Do not warn on missing pad_data when oob is in sgl.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Link: https://patch.msgid.link/1737394039-28772-9-git-send-email-kotaranov@linux.microsoft.com
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 638ef64d639f3..f412e17b0d505 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1047,7 +1047,7 @@ static u32 mana_gd_write_client_oob(const struct gdma_wqe_request *wqe_req,
 	header->inline_oob_size_div4 = client_oob_size / sizeof(u32);
 
 	if (oob_in_sgl) {
-		WARN_ON_ONCE(!pad_data || wqe_req->num_sge < 2);
+		WARN_ON_ONCE(wqe_req->num_sge < 2);
 
 		header->client_oob_in_sgl = 1;
 
-- 
2.39.5




