Return-Path: <stable+bounces-164642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B687B10FAF
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55413B781E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83AE2EBDD7;
	Thu, 24 Jul 2025 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy10n4+X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717DD2EBDC8
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374808; cv=none; b=CIKfOpsyC/KGi7F/obhQ1d5dungE0S14Q0YZpn3Cf4sWV+H030NZbioEghQ+ElmNc54/AEWvQJX3vEbJnRMlTJSZ83F9wPusgAl2/B95CQgx3MUuNE7d1M1/AmPATworz+St08WtTrkFrI43BmdhN257TSN0GCQoI1Wm7+xrZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374808; c=relaxed/simple;
	bh=gOSOhp2aHn4QnMocfEjY/TPzbqnCSZw3r1trnn4HRo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+zP/IAYttsxSNNCNjiEFHJU186ytfdKnC++GklNOBWHRY+V5r2/W9qhhvcGm3VHN3DPVW1Xk8r2ItZqUKTJBJsbgb0y8xvhceEMqigxF5/UNvvKvkhSYWXwjw99S+VySwwxIasRYBgHtwrAl0J0zRf+BX9HBdHDT/CErVj4Vuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy10n4+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A0EC4CEED;
	Thu, 24 Jul 2025 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753374808;
	bh=gOSOhp2aHn4QnMocfEjY/TPzbqnCSZw3r1trnn4HRo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yy10n4+X2WTjJlMm6k5QpQIpeY0yC4AfSUeCLirPdu7Vqde5b7ykNqEBjzkSHfEcT
	 Y8fFesMp0AM2uvREZTngKLDUGRCmCYFl5Jw77ghAWNqv3KlQrxf2/5ObP5kYl570Fr
	 B/t8e/MzeICIfWYv9L9+5AWC6BnujbOCqRDwq/5K69ToFsloFauehjjBfq6Fkmf5RC
	 fBZJ7rR/I4hyryKw6ZAIsHDpmuSrf8TBvqgEWSk+0dGCwVuZ8LWxjXaI30Kkwi2xy9
	 dRYZMg5kCMNzWSKU2c4Buc7VFyWPCaLBWCizRDmX7+eMCgxyokqFHm8sbFWCdi45Fp
	 iiQt+dMTCZpwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: hid-sensor-prox: Restore lost scale assignments
Date: Thu, 24 Jul 2025 12:33:24 -0400
Message-Id: <20250724163324.1369864-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025051230-facility-envision-71f1@gregkh>
References: <2025051230-facility-envision-71f1@gregkh>
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
index f10fa2abfe725..02d289095c541 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -222,6 +222,11 @@ static int prox_parse_report(struct platform_device *pdev,
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


