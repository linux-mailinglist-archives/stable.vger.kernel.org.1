Return-Path: <stable+bounces-75679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF2973F5B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D891F27E0D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA21ABEDF;
	Tue, 10 Sep 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEKm0G9X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1351ABED5;
	Tue, 10 Sep 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988952; cv=none; b=sEQhfu92V4aslSBLJg/E9sMeYHcDs0Uq9H4GsEtCl82ofcv7d4ZkvT5LGD23TDoLoqcpQqsQGGj5MMdgCBbBJJgN0IRf1eEsRGFMsGcjMQlQXayfsmicn8eDr3rWK3OHBzluFqS7LMXJygpEtaEBP35TQQ02gESRzVFRS40A4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988952; c=relaxed/simple;
	bh=iMGgSxIC3F1XzM8wiBcUZYnqVIyuNBVNIdMKabXag9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAg5h/BJoSahLy4MxVODTZtyxrM/MvIfaJesEgPihk4jSiPUqm1HCqXDqfDfCB0MkmD9Bd+vFUtHE6iXhD27+JOvG0RogGz00692AdhoLuCQt+ncT1dXMnNdpVJ16ATxT58z6wzMIrWrZ2qynUTF9EYGXAC7TmhkRoVsmaf/KNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEKm0G9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF28C4CECE;
	Tue, 10 Sep 2024 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988952;
	bh=iMGgSxIC3F1XzM8wiBcUZYnqVIyuNBVNIdMKabXag9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEKm0G9XAije4hXwxFfft32HFGo2xU2y/pHBlbiyuQUXcRdk6C1I4h8MqVK+Xwvlw
	 UpCJRDXI0LWq0BwIUOCWEY2Cy6XIH9PUjt0xDIMMEXA1tfDvqR/9C9N4vQwxQqwVax
	 8ntJ2ghgRqQDbdNjb5GjzJm7D1dvnFeM6G+c2L/ycgqyqaAGzzAZ8sJkGdZ6Z8DUbk
	 PeAoSMMEvHYCeJiTVsJ7hUnQoWEJDdHcWddYoScuhYUQnt7LEEUlPpe0mNREjngPdc
	 h0grX+3thatB76fC0wDT7mxDqUlAdIe4/8+V+LYtogK+20IIU9db/CdKxmB9A5QQgr
	 u7a4mjZ7kr/Tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 07/18] ASoC: fix module autoloading
Date: Tue, 10 Sep 2024 13:21:52 -0400
Message-ID: <20240910172214.2415568-7-sashal@kernel.org>
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

[ Upstream commit 6ba20539ac6b12ea757b3bfe11adf8de1672d7b8 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240826084924.368387-5-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/chv3-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/chv3-codec.c b/sound/soc/codecs/chv3-codec.c
index ab99effa6874..40020500b1fe 100644
--- a/sound/soc/codecs/chv3-codec.c
+++ b/sound/soc/codecs/chv3-codec.c
@@ -26,6 +26,7 @@ static const struct of_device_id chv3_codec_of_match[] = {
 	{ .compatible = "google,chv3-codec", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, chv3_codec_of_match);
 
 static struct platform_driver chv3_codec_platform_driver = {
 	.driver = {
-- 
2.43.0


