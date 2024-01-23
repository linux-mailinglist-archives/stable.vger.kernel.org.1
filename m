Return-Path: <stable+bounces-13124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C217837A98
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2660F290345
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08BE12F5BE;
	Tue, 23 Jan 2024 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JWE4UO0c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFB12F5A7;
	Tue, 23 Jan 2024 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969012; cv=none; b=C2XVPhKl8Fik8WAKKKu7a5nEMCtsQNkgz5Zo7ilTQjKt2kW6KKJkiHDPG/F5sD/ury95dDF6SsbZaZ2cP5fUvcyKxyjQycFyjXpGc5MLOz05rx/d9JQ9OuVoVdSKxC99wt2n7DywE98tN/aREcHZqZs/ZbZ47nmzOPXtIX//Bng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969012; c=relaxed/simple;
	bh=kPuCv+LOjYkhPHnYkfafAS4/uXMC3iR+Tko4G2OyRz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMPSySyhBDKAlNTlBceuD9huxr5PAohstPZCKbTsFTLfQ1a99V/l1wyhPF+fk1UUeNqvEvi52CpcLDWbV1TYEWxGxaN7TA1IMeOhswR2AA89OdQKWp3i8Jb4idzvFf1FluOP9Izxtxz4fgw8kEhpFAUd9kLALpng0drEgasC5Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JWE4UO0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57049C43399;
	Tue, 23 Jan 2024 00:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969012;
	bh=kPuCv+LOjYkhPHnYkfafAS4/uXMC3iR+Tko4G2OyRz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWE4UO0cXicQjEN/JyVNf2AUqGZwPGtQCENc8PkbZrNGgirh0F6z3fM2HHWydxIU2
	 15H1Vly5OAJsRl7FwibjjLIkMSSrYoCsOfSWuUJ2Zfp6OUQ7/KK8ye5L3NR1YXzzIi
	 IVX6T5UHFMi/vOXHPKq52H559CVv3F/M95P09tVc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Su Hui <suhui@nfschina.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 135/194] clk: si5341: fix an error code problem in si5341_output_clk_set_rate
Date: Mon, 22 Jan 2024 15:57:45 -0800
Message-ID: <20240122235725.018100361@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 5607068ae5ab02c3ac9cabc6859d36e98004c341 ]

regmap_bulk_write() return zero or negative error code, return the value
of regmap_bulk_write() rather than '0'.

Fixes: 3044a860fd09 ("clk: Add Si5341/Si5340 driver")
Acked-by: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20231101031633.996124-1-suhui@nfschina.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-si5341.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 07ef9995b3cb..31504e52a67c 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -732,10 +732,8 @@ static int si5341_output_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	r[0] = r_div ? (r_div & 0xff) : 1;
 	r[1] = (r_div >> 8) & 0xff;
 	r[2] = (r_div >> 16) & 0xff;
-	err = regmap_bulk_write(output->data->regmap,
+	return regmap_bulk_write(output->data->regmap,
 			SI5341_OUT_R_REG(output), r, 3);
-
-	return 0;
 }
 
 static int si5341_output_reparent(struct clk_si5341_output *output, u8 index)
-- 
2.43.0




