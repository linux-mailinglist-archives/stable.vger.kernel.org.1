Return-Path: <stable+bounces-95096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D3F9D7646
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD86B3F76D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26A1DF26F;
	Sun, 24 Nov 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffSOKV6m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43D1DE3C5;
	Sun, 24 Nov 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456009; cv=none; b=UzZq10eQHfv7FZfH9ERb6YGK/yTQdwp9PsESCoir1LAheAqAuc+V2WW7PIMwNcyW2/HHsYWRktdmblaqwRaxspbRU0OlNuc6vCwqJGJU3ng96uOS1ObRCJNODVptiCD3cItUvr1Fo7RX3h1Hw8fKfLwgUA5QkY6oLVL6IZZ59GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456009; c=relaxed/simple;
	bh=x35rkTtAI/wf+hgtlmnnwxeSK/5ftIU16nfiqXXk2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzelC2jtMqfT7FRBahgxhDGuSFIM1ZWG3Zn+JrIHn6s2SFdVORwwI1DNw7jkPXfHhH/fSo34SQQFA/1a23HmK/wa+v/koXBdc33VaHYykCLR4Caefvpw+okk/AhE0+dNvCJbt9kZsNhvoMaaMITlNNFAqoYkZhCA6cgu5fA5QmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffSOKV6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610D6C4CECC;
	Sun, 24 Nov 2024 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456008;
	bh=x35rkTtAI/wf+hgtlmnnwxeSK/5ftIU16nfiqXXk2gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffSOKV6ma0bn1Rg2/6J6vAxWLAbT8UQCJeLB3taZhZUJV/4jqnhGrCX+EzFV/dFGh
	 w+9qhG36pUT9N2nSNNhfhhVAcdRGrsQbX04LQt+mUUXc+cfDEExCxGB3yJzHf+BTMP
	 ElZxjE21lfNQVVi2EitOwz8jJqbpvqiyjgfe1ZrzchAmmbLGnBiBIm/eP78FMCQORh
	 oSAa9VMz6MLZHEPFdwQ1VEASvEFFaIc3u57FKSHLSO3bNqwu/lGKT/p3ly0zk7VqCM
	 GoN0dc80ohdh0qXp/QF2St2TXOqmXYDBbsGn7F7lNIG7nNCShMXukybyYCfzztDe1s
	 GNZwn/LJlzDLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	andrzej.hajda@intel.com,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 06/61] drm/bridge: it6505: Enable module autoloading
Date: Sun, 24 Nov 2024 08:44:41 -0500
Message-ID: <20241124134637.3346391-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 1e2ab24cd708b1c864ff983ee1504c0a409d2f8e ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240902113320.903147-2-liaochen4@huawei.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 4ad527fe04f27..dbf9a2eadf6d2 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3501,6 +3501,7 @@ static const struct of_device_id it6505_of_match[] = {
 	{ .compatible = "ite,it6505" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, it6505_of_match);
 
 static struct i2c_driver it6505_i2c_driver = {
 	.driver = {
-- 
2.43.0


