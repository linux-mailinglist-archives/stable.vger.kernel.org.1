Return-Path: <stable+bounces-72857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4472196A8A1
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FA01C23467
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E61D223D;
	Tue,  3 Sep 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXNcIJ0E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B471D2236;
	Tue,  3 Sep 2024 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396127; cv=none; b=TjOjXE7yoEP9GvliQNLzBo3nRJHq0OkVLcMx8vlPkkqUn2wZ8rSi+ISeqpzkMFwguq4Od36GdBHZ7v0zecsdZ2hlAEmO2Cfbzcn+iUCd+aNpwxXcMWWDX6nvEktNrIn+xZKsB2+XrVUhBfWmG4B59dcz/+AHwjvUz+5J7iuPzvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396127; c=relaxed/simple;
	bh=w6fSv6FthRP/2c3MZzantN4l5vf2SRduU7qrhe5/nlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjxN60ePzK2aAFV2n8ykZ9oFK2hpC36yqtTlrFkh7CsxR774+gZLYKvubIIGwggtrUYQcPUdcmWXLcrFaqBSzykhn9IlWgcJYTBC04PwVD2KtWzlGOMFjZcdDy3udZ7ZIw7wAo1tZlXF/nYInGO3J29hRcM89XcjkcwdMGNZ8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXNcIJ0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7751FC4CEC8;
	Tue,  3 Sep 2024 20:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396126;
	bh=w6fSv6FthRP/2c3MZzantN4l5vf2SRduU7qrhe5/nlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXNcIJ0ESShKMjo/rxHr4lhT8PeLY48sqX723AfZx6XWk63iUsW8Iji4eAq7lP+Wh
	 rfkzy5wpps495+qRhrQS+wFwLo2nQQCUS6M4ZtxaY90DGlvME4J/wJYA1YeQs2bAm1
	 QRAoZpbkKRB96pksZI45VPKGxg4igNrXrDNRYblt2dPv7ViSqHfeB0U0ErAoId/Qxd
	 anVmPzZaZImBlJrpFQvvEwY+dafQQhGy/DAC9QDXEMol4USg2oYJ30EiWL2M3685dQ
	 Z8rBk2q2wYfObmh+/tn/0sTnPiTlCcWovHX7RFJPYhHs0bioThHhU9WrFRdL1/XjzR
	 pwOm0u+5TT86Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hongbo Li <lihongbo22@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 03/22] ASoC: allow module autoloading for table db1200_pids
Date: Tue,  3 Sep 2024 15:21:50 -0400
Message-ID: <20240903192243.1107016-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

[ Upstream commit 0e9fdab1e8df490354562187cdbb8dec643eae2c ]

Add MODULE_DEVICE_TABLE(), so modules could be properly
autoloaded based on the alias from platform_device_id table.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Link: https://patch.msgid.link/20240821061955.2273782-2-lihongbo22@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/au1x/db1200.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 83a75a38705b4..81abe2e184024 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -44,6 +44,7 @@ static const struct platform_device_id db1200_pids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(platform, db1200_pids);
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
-- 
2.43.0


