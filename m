Return-Path: <stable+bounces-34471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5E893F7D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED23D1C20D64
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BB747A79;
	Mon,  1 Apr 2024 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GNh86Iar"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23D47A57;
	Mon,  1 Apr 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988234; cv=none; b=K6kGNheJpuyumsa0L3sok7Ql5bt2WgWo1ZQvYOyF5nXT6JbqmQa4R1E2Pbg/XBH/fh7Y3/1U1rN3BPvlz9YFJWWu1Ch73DgK+4VIxCwYXWVorm4QwdGFqZPjWQEBt1LoNjnPvX05QtVuwBrIMH1YMfwfWBhjeQADqhRVuLWtvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988234; c=relaxed/simple;
	bh=oOSX2HZOG5GQNlF00JeCIeUXLpuQs6uhcjXGtvLeYa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8/ZRAFTe1HE5ViWxbhPDoHEyDjsmaCFYuPM2nbYhSOgO0IWR28/M1VTbDoJZPEl3fWkBdfcnq2V4HnZXkoEcc1loN5Crt82/iBcNO8BCl4LZ8TLO4GTtFb4L0tMR0m7nEcbLmwxElovrvp/h8Tdn8U4MhwA3V+oXi59+a4Az/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GNh86Iar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B10C433C7;
	Mon,  1 Apr 2024 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988233;
	bh=oOSX2HZOG5GQNlF00JeCIeUXLpuQs6uhcjXGtvLeYa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNh86Iar4p6wLTaq4G0Np/cXkYB50YuLI/WO/NwA9V5xyVTucmZCmA2kM9coA88pX
	 SG3pAzpcCCe0fOQJdFE34zHUmzMn0xetsg3TFhxRGDydxg7NdlSiB+rHs9OSw0/Ir+
	 2giMIMyRzQy/YsM6oSP4stfonMUYlZfjVyletYL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 123/432] slimbus: core: Remove usage of the deprecated ida_simple_xx() API
Date: Mon,  1 Apr 2024 17:41:50 +0200
Message-ID: <20240401152556.789643293@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 89ffa4cccec54467446f141a79b9e36893079fb8 ]

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. So change this change allows one more
device. Previously address 0xFE was never used.

Fixes: 46a2bb5a7f7e ("slimbus: core: Add slim controllers support")
Cc: Stable@vger.kernel.org
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20240224114137.85781-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index d43873bb5fe6d..01cbd46219810 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -436,8 +436,8 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
 		if (ret < 0)
 			goto err;
 	} else if (report_present) {
-		ret = ida_simple_get(&ctrl->laddr_ida,
-				     0, SLIM_LA_MANAGER - 1, GFP_KERNEL);
+		ret = ida_alloc_max(&ctrl->laddr_ida,
+				    SLIM_LA_MANAGER - 1, GFP_KERNEL);
 		if (ret < 0)
 			goto err;
 
-- 
2.43.0




