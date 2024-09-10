Return-Path: <stable+bounces-75676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA51973F54
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D69828CD3A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6F1AB51E;
	Tue, 10 Sep 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkbsCnCn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D301AB510;
	Tue, 10 Sep 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988945; cv=none; b=CYBRP9Q3hFfBlHifonJ2d1IRf+PdAoFqZZbV2loj7+7ETer0bBctIibWMjlaoyiA83x8mCSmqt43KwPHL/eQph4Isr+wrGqaoATq+zIYzvQNLRXUl62G1kYF/lPSWHc8+YxhegsjG6wVeHQ0hMZFJTcoSkX2A7wk8GLGAtHfAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988945; c=relaxed/simple;
	bh=raDMnFp+N3hv/o1TlM4If1mKOgWKbnER8dzm/gLbS94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP6CPep36j6SkhVaddaS6c+fBqGBXhj2C7z8eizCwNFIirxco43hlmXO6VqhatuGgCBG2Po9u4oqbjrGABh43YbKERdAdZEh5SE6tN+PbOTLL2BFR7Obj+vnfhatmkdMxOfEW1B0emTmrGGVaBX9Pm3ZKgWovptVfR+8LBUaZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkbsCnCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504E9C4CECD;
	Tue, 10 Sep 2024 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988945;
	bh=raDMnFp+N3hv/o1TlM4If1mKOgWKbnER8dzm/gLbS94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkbsCnCnOOgcoVS5n4mh17bqTb81wl12VfwZVaMafckxjn/didbdOeMZ+pQ47nivj
	 J8UKcD+1SEqvwOwOPdyqXFGcmCpFOjLuhtdCK0bRdIaiamtvRqgZOZ5CXGgv57Q7/C
	 HiuMHyQZMIWeGnlqLfYdUP4/fNWUd18vxXm5spbaJmz+D/UpC6cvbjMFvEOqSIlMZE
	 7LcunHFHXyd6tFZ0oZMvZu7nQmSMmGrorLB5jh2IcT6u0ZRYcEglB5Yuh8fQZaP8qE
	 XjHK7FE//aZ1ghukCnCrd365Xi1JuI6MeZYpXCJFLhOrmytpgIrf3xUVB05LTmoO74
	 QXhtOV8391XoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	robh@kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 04/18] ASoC: intel: fix module autoloading
Date: Tue, 10 Sep 2024 13:21:49 -0400
Message-ID: <20240910172214.2415568-4-sashal@kernel.org>
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

[ Upstream commit ae61a3391088d29aa8605c9f2db84295ab993a49 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240826084924.368387-2-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/keembay/kmb_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/keembay/kmb_platform.c b/sound/soc/intel/keembay/kmb_platform.c
index 37ea2e1d2e92..aa5de167e790 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -814,6 +814,7 @@ static const struct of_device_id kmb_plat_of_match[] = {
 	{ .compatible = "intel,keembay-tdm", .data = &intel_kmb_tdm_dai},
 	{}
 };
+MODULE_DEVICE_TABLE(of, kmb_plat_of_match);
 
 static int kmb_plat_dai_probe(struct platform_device *pdev)
 {
-- 
2.43.0


