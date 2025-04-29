Return-Path: <stable+bounces-138963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F73BAA3D20
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D423B1881D46
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99428032D;
	Tue, 29 Apr 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0IT/e+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8E274FE8;
	Tue, 29 Apr 2025 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970620; cv=none; b=m0S9mP6dxPkKfKzBuiLs4aQb1BH3G8NqKNkyFBdSdWtEzvM7AigUHGjFzuOdIjtXZoskxa2LwafpLng9Pe5dFVXo20hSw7sq/0aZPn9V31o5RKUf98BTTFkm0zyt0dC4OUz/KmqEw1QcyYa4Hkp/TEfWbEcnAOI+9b4qJOwsq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970620; c=relaxed/simple;
	bh=6N+9fP+CW7lhN19iz9KPcmJsUXKjoiVupQ+fXp5A/Is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlUKWzEZS7fpJD4ZdHn8KEuyQWswnkDRnImMS4xTTKbGNdezp4O+vmp/Uya72B/u8YoH0JlCWTJc4yJkwxqZnWlJ7Af+yqXiaJkHi9kAE5J9zBnH9BB5IrW5kNcfiaIQ8Il6Ojzh3eX6iEcdZMDxQsW6ry0S/BDd63g++zPZLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0IT/e+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F66FC4CEEE;
	Tue, 29 Apr 2025 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970620;
	bh=6N+9fP+CW7lhN19iz9KPcmJsUXKjoiVupQ+fXp5A/Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0IT/e+2geXdtmAwhRe9nauLgfvraDYu06cnFXVfAmajUiERX76YTrSTjDEuP0L9O
	 KtCOFNtPX2YOhwRlWYevvJe+eIqqc5qPaG16IcylkVBQ8dxhw1t6d+P5+fZzGdWVaa
	 c26p2KWVLFqvWqNXpKDOiOOmXJGQt2MKHr6QvGUg4HMHt5DazlqW963EVqSNtcU3gp
	 tTWOci7C7Ug1KTGi3ImW9P4Xii5DPYYGyUo/YDjPd1Mzgq36/r15wJzbw/mIQajOoH
	 009OVXeJVJTxL9Y7RwvH34STmyygb8GFWeMLwAa9WY40cdqoY7vW3/X6DiaOacvFqb
	 GCBWxm5deSVjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	srini@kernel.org
Subject: [PATCH AUTOSEL 6.14 07/39] nvmem: core: update raw_len if the bit reading is required
Date: Tue, 29 Apr 2025 19:49:34 -0400
Message-Id: <20250429235006.536648-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 6786484223d5705bf7f919c1e5055d478ebeec32 ]

If NVMEM cell uses bit offset or specifies bit truncation, update
raw_len manually (following the cell->bytes update), ensuring that the
NVMEM access is still word-aligned.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20250411112251.68002-11-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7b8c85f9e035c..e206efc29a004 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -594,9 +594,11 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->nbits = info->nbits;
 	cell->np = info->np;
 
-	if (cell->nbits)
+	if (cell->nbits) {
 		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
 					   BITS_PER_BYTE);
+		cell->raw_len = ALIGN(cell->bytes, nvmem->word_size);
+	}
 
 	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
 		dev_err(&nvmem->dev,
-- 
2.39.5


