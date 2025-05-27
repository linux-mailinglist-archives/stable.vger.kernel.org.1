Return-Path: <stable+bounces-146812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807CBAC54B9
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19587A3AB5
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B9A86347;
	Tue, 27 May 2025 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q3EXcbHJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737D280034;
	Tue, 27 May 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365383; cv=none; b=d9D9QcZWJ2ARK/elrTE0Vmuh9SmNS2Fgf0WsaZJO0aMZnl41WJYww3vjTPk20Jhx2+gG6pkmFtxg9a1/X6kGOSdNjSRcAWQ4dZ7LVB0NNtvhB9B9Pzgrdsuje7vnq7v9N7CTEyKsNt32dQ7ozyU5XzvdOj5rZvniYeBI+sb6L7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365383; c=relaxed/simple;
	bh=YZtIhGFa5a5yMeuIqR6zk9KF3FzLfRB7eOV4XzfELjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqzLbt7848bJB8Dzv1wiSBp0iPO536JC7tnzZ2C7heq4rYq3joUJnLT9KqvSUmd6fJ9khUaKCgaY/4yKZ8xZEVW3wnh9sJhG9wWbm6hfr9I4pDFFMJW1D8OmnskOFpno5ylzUAcXRWWSEvY3IItoo9M7ACa9lHzfqgR6GCLEm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q3EXcbHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B9C4AF09;
	Tue, 27 May 2025 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365383;
	bh=YZtIhGFa5a5yMeuIqR6zk9KF3FzLfRB7eOV4XzfELjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3EXcbHJNt3olkD8M1USv4iZ7O0EJSagjE0oe138ym3uR6o/cF23Tir+TGEf8IIVY
	 IAymZunU3ijp3HtdwP7OYIOnc4oL6KHjQpvd0txWUpzf5sR9ylyaDb18yKr+2iNUkT
	 IJllg0UPPIQQJyEahcmXY2s8uhyJUXFasmYVZ1l4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hector Martin <marcan@marcan.st>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 359/626] ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG
Date: Tue, 27 May 2025 18:24:12 +0200
Message-ID: <20250527162459.600931473@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

From: Hector Martin <marcan@marcan.st>

[ Upstream commit d64c4c3d1c578f98d70db1c5e2535b47adce9d07 ]

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2764-v1-4-dbab892a69b5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 58315eab492a1..bc0a73fc7ab41 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -634,6 +634,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_TDM_CFG2, 0x0a },
 	{ TAS2764_TDM_CFG3, 0x10 },
 	{ TAS2764_TDM_CFG5, 0x42 },
+	{ TAS2764_INT_CLK_CFG, 0x19 },
 };
 
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
-- 
2.39.5




