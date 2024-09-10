Return-Path: <stable+bounces-75677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0907E973F57
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48021F27831
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF21AB535;
	Tue, 10 Sep 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsO/RL6O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90761AB52B;
	Tue, 10 Sep 2024 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988947; cv=none; b=Ws6eyA27fjgstOB15aVNuv4+0b9D0DC/06DYVGdB5lbMINQXRhqycbp+UuWKUwbpKkPMyYGxhkCW4xSOpJvcJFAwHXtn0tg5KTl7FD9jcmIQZQaYAwVPhn0g4oUR+ym99pFSGyGjTCABfyLbMX9tUONB6CLoMho3j7y+E1HPyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988947; c=relaxed/simple;
	bh=82MapHR5wb5BF6hn0KKiM1uIKRu/vTCh5scMiJ49uLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fidijl2vmJLe+kz892FaXqzJVS+EOnX1xdYPoJgYncRX25uewAg8tTVyM7LeY0b7yzPhGGhuVdKIJ54EzbSy0CUevawJHhV/Mb9Kh9Ol5dZSJz1xnzaIpgL/You+ZKGiqes40W/lmm6RbcWzhDbG8D+BhGmT2wx0SyqPdaod3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsO/RL6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651E6C4CEC4;
	Tue, 10 Sep 2024 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988947;
	bh=82MapHR5wb5BF6hn0KKiM1uIKRu/vTCh5scMiJ49uLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsO/RL6OHzuG5cz1bxX/r+Gwz6WPp/A/Li6+UuglMra8+UD05fm/SFlZ39z2WNb54
	 xrJG5K+JLAGkow/LM4RuaOZasi4zmWp4Ztkoq+9XNaFj/KRP6JFAWJfYNQWO3GCGDT
	 qyqndjJBMwwAg4/+YUeVArg30nlyvO7CFJV29ASy8T2BaZRTk7p6IRibFHSw/MEAmJ
	 kgrc4nFduJNnwyvxNxPpV9ok/oZz0XCFcPNj/NhdCalm54AMYxkkXIraMfaATcLVHV
	 kSrpRVqIihBhnjKA/R+1AX7xoEjj/o934yt9HsKV1c03NGV66SounGK7wIpil/5K/J
	 CuQVim6rNzlPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 05/18] ASoC: google: fix module autoloading
Date: Tue, 10 Sep 2024 13:21:50 -0400
Message-ID: <20240910172214.2415568-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172214.2415568-1-sashal@kernel.org>
References: <20240910172214.2415568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.9
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 8e1bb4a41aa78d6105e59186af3dcd545fc66e70 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240826084924.368387-3-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/google/chv3-i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/google/chv3-i2s.c b/sound/soc/google/chv3-i2s.c
index 08e558f24af8..0ff24653d49f 100644
--- a/sound/soc/google/chv3-i2s.c
+++ b/sound/soc/google/chv3-i2s.c
@@ -322,6 +322,7 @@ static const struct of_device_id chv3_i2s_of_match[] = {
 	{ .compatible = "google,chv3-i2s" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, chv3_i2s_of_match);
 
 static struct platform_driver chv3_i2s_driver = {
 	.probe = chv3_i2s_probe,
-- 
2.43.0


