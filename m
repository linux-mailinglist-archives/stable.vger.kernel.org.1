Return-Path: <stable+bounces-164630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F2B10ED6
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7291C28464
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2482E92BA;
	Thu, 24 Jul 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCaQqruh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07721D584
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371408; cv=none; b=Lj1vJ95ejJRg9FAP4d6im+Tn7cmy6+96dctwm3WE7GEFskka9Y0WGYCLlaMFEBdXcO1ZiHccFXDtoeNTPngShrzzG8gfAsopadGYEVvZ9f6jsxIEOduMFSgiGRKOLuL2YruqfaANl6ACDE3YnB7PUbkRZQD4OXHYWPsJUkrMrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371408; c=relaxed/simple;
	bh=Dqyy2ej2K/cWWRE6erBhtfqgXtz6OEv833lO1YUj0d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4LRX6x3mkMidie+6qS2cNJJBmmfrS5tFQW0HUvnNUgJqCMT78ZXr4f0T8fuoY4BrcOfF5l8usziAhV2xGXUulJ9tmnaIR9XvYQRVh7+OOHYALxyJwW9cfxHrF/4Wn3AeanVBwZf7rdxgyeruf38awsKSb7qAanyZLxEtc3JfnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCaQqruh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF37FC4CEED;
	Thu, 24 Jul 2025 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753371407;
	bh=Dqyy2ej2K/cWWRE6erBhtfqgXtz6OEv833lO1YUj0d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCaQqruhyvGiIE8q4xIGeJjvN+WEv8noFFHoxgcX2WC/kClOrPVCVQvuQl/aNxfmX
	 Yu3h6tDaqsiewmqa6r0y5e5nCRIr/Ifygu0B6sLF4EALTOThEa2Drd2bLbDuqZ6yMY
	 fuLmxsfgksD6UMJioNkb+2DNSnbefvyW/qWxygYRz7HF58UPzXjeb/24sZV664zgJr
	 wNjReImKtwtbVZYaMuECESNU3VyWtIgqsxVLIwPWzXci55zw+eLEExQMRDNTV7t45D
	 HGTr+b+5gcVVTD9MdgaTQJoovIndTuDfy5U3Pb3PSCkDZ1v7K7iAn8iHTVLIH2O2/j
	 cbGnjSiNwj/VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: hid-sensor-prox: Restore lost scale assignments
Date: Thu, 24 Jul 2025 11:36:37 -0400
Message-Id: <20250724153637.1367298-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025051229-viewable-moonlight-630a@gregkh>
References: <2025051229-viewable-moonlight-630a@gregkh>
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
index a47591e1bad9d..97746404007be 100644
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


