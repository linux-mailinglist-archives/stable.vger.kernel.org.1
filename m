Return-Path: <stable+bounces-14608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C919838194
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037491F21D03
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0353D69;
	Tue, 23 Jan 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aV+XIltU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29BC37C;
	Tue, 23 Jan 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972178; cv=none; b=GSqV7F9BFgutdnjHTHF1ixAlwrbskB3eKpFQxsosYLesyx/bq91MbVOHfxbVSmmOqzpL125vqbTkpZ3idNJ6UN3xkv2SIUB0ObW3xoojhUIzferajRFlMe/ZcbByV3kpLrjZXmTHoMtJyxFpI8rIwemxx/GwaZy3mFMRk/OTzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972178; c=relaxed/simple;
	bh=bXciTJwCOEQUKDYL2JZ4myI4iH8PTq1X/6VqmpZwJQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRw2f26imx2GlWMcm6823VVNa/l6B8izXRKJVQE8zuvoSdNJ3rlaSWv7WKI80Q4XfHll2eBVH+Ikp07J0M+p9VSmX7uoy49MqmvhGbZE8mrIWtnIQRcOTpWj48KKeW9F7ueIPCOHMC8MT/bxBumSH8U+Qwiv/An+BLMqoueRUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aV+XIltU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97678C433C7;
	Tue, 23 Jan 2024 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972178;
	bh=bXciTJwCOEQUKDYL2JZ4myI4iH8PTq1X/6VqmpZwJQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aV+XIltUCraTirrA5EgmlcN60D7qC3nU2svIF6FCc69quX/RsBHQU6kX6zjJTplO1
	 6iI18lm6gQtu+6uYHEt74mQSvEoj11OZ6QokinsCEYPlLCmxOTyJYHZlmW5Cl3QeO6
	 MP0dM7nsfkXAY8DRVflJOBMNv5iwl2wf65pI462o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 103/374] pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()
Date: Mon, 22 Jan 2024 15:55:59 -0800
Message-ID: <20240122235748.190005644@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit 86222a8fc16ec517de8da2604d904c9df3a08e5d ]

In persistent_ram_init_ecc(), on 64-bit arches DIV_ROUND_UP() will return
64-bit value since persistent_ram_zone::buffer_size has type size_t which
is derived from the 64-bit *unsigned long*, while the ecc_blocks variable
this value gets assigned to has (always 32-bit) *int* type.  Even if that
value fits into *int* type, an overflow is still possible when calculating
the size_t typed ecc_total variable further below since there's no cast to
any 64-bit type before multiplication.  Declaring the ecc_blocks variable
as *size_t* should fix this mess...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Fixes: 9cc05ad97c57 ("staging: android: persistent_ram: refactor ecc support")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20231105202936.25694-1-s.shtylyov@omp.ru
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index ccdb71c3dc51..ec321722384d 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -190,7 +190,7 @@ static int persistent_ram_init_ecc(struct persistent_ram_zone *prz,
 {
 	int numerr;
 	struct persistent_ram_buffer *buffer = prz->buffer;
-	int ecc_blocks;
+	size_t ecc_blocks;
 	size_t ecc_total;
 
 	if (!ecc_info || !ecc_info->ecc_size)
-- 
2.43.0




