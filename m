Return-Path: <stable+bounces-164622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E539B10E5E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E1E1CE7B8A
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3212E9742;
	Thu, 24 Jul 2025 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAMwykim"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20E2E972D
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369974; cv=none; b=LsNHH20DFPT7QWHMfWjLBttv5dITrQ7h6CEmnIzLbgitskQ2P9mwZL5C/HjfC7eFu2pDHIjoadHtXdM8bsb4sJyvMPthV0WU3wv0le3/6Q8AjysXuYvzH5DgParEDlmELPG8Mw4uC7gECyKUaguV0susL7xxN4mAJJnbJm5BLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369974; c=relaxed/simple;
	bh=jRnaDm8N8qcOFjoE0TgyrvKQQqqryo7MKzkm7vN44OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZG65bFJuOML2aYQNUVDAGGWj4zlJWHGvyTDlhzqM3cFzy6chMUDMP91sAYXLcDqksfU1WloUkgX9a8ITgbxYuoxNzjio1EFrphFjB5ZFmk7YMubG0HwBln9Gw4cvQw8P8io7VsrF6kubtDGhxpPSUooGHPYPfc9lcoBw7kvs10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAMwykim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D71C4CEED;
	Thu, 24 Jul 2025 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753369974;
	bh=jRnaDm8N8qcOFjoE0TgyrvKQQqqryo7MKzkm7vN44OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAMwykimozUqsj578mRPT41UkgIwY0e00q6CKhcJ5OtR3OvSrehl1y1g8FNkaX15g
	 s1qN0WJnN0Ma9aC8seS3Z4ATIAn87EeXQtgWVitI80gURHmkWj2956guzhQtEoPBIo
	 +XiOfs7rhlMwvFlarhJV3UKiiDQyS4O1bD6NGgesctT96OUei4ShxQn+SR2h4PAhdY
	 YnMtx4t1j/tSNBf0m6/k0fVz8JC/xsRqqawFyxCq0053lcxv20YApjI9/QHTP0fszs
	 YAVnoegs25sqvbkzcLmGwTwNFAzryFbN0rVMM/0/9SSeeiJxqD7f1JywD2Q80hutR9
	 yHotG+/EuvJoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: hid-sensor-prox: Restore lost scale assignments
Date: Thu, 24 Jul 2025 11:12:50 -0400
Message-Id: <20250724151250.1363220-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025051228-tactile-preppy-668b@gregkh>
References: <2025051228-tactile-preppy-668b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Lixu <lixu.zhang@intel.com>

[ Upstream commit 83ded7cfaccccd2f4041769c313b58b4c9e265ad ]

The variables `scale_pre_decml`, `scale_post_decml`, and `scale_precision`
were assigned in commit d68c592e02f6 ("iio: hid-sensor-prox: Fix scale not
correct issue"), but due to a merge conflict in
commit 9c15db92a8e5 ("Merge tag 'iio-for-5.13a' of
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next"),
these assignments were lost.

Add back lost assignments and replace `st->prox_attr` with
`st->prox_attr[0]` because commit 596ef5cf654b ("iio: hid-sensor-prox: Add
support for more channels") changed `prox_attr` to an array.

Cc: stable@vger.kernel.org # 5.13+
Fixes: 9c15db92a8e5 ("Merge tag 'iio-for-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20250331055022.1149736-2-lixu.zhang@intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ changed st->prox_attr[0] array access to st->prox_attr single struct member ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/hid-sensor-prox.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 26c481d2998c1..a54e3c87cee31 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -227,6 +227,11 @@ static int prox_parse_report(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
 			st->prox_attr.report_id);
 
+	st->scale_precision = hid_sensor_format_scale(hsdev->usage,
+						      &st->prox_attr,
+						      &st->scale_pre_decml,
+						      &st->scale_post_decml);
+
 	return ret;
 }
 
-- 
2.39.5


