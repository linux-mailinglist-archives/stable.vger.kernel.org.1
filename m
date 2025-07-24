Return-Path: <stable+bounces-164640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACAEB10FA3
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B2B1C2087B
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6242EB5C9;
	Thu, 24 Jul 2025 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOYzk0un"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D222EB5C4
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374427; cv=none; b=eShBQkxLz1EazqzzA95aWki6RAYvd74DMv5PKYV/LAjDt/KEiGocLxjImh7sj5v5n4qYS0oVuEIWrGTqqG1Pi4ycSt3xeHGtPCRNMHjhB4Xy+WE8aJU8iPeoaDqbm3JVO9j+rQxkBIGmGLM9OcGA+td5/eLZ6R2OAvhwYZUw340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374427; c=relaxed/simple;
	bh=gOSOhp2aHn4QnMocfEjY/TPzbqnCSZw3r1trnn4HRo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlDQ37FaQ+5tHj5aJxchJcohpnfcsx7C8bjwtUB4rwbiFpQPUw8q4iFzXFkJFhCtfALowmGRR1fvSOON5+0fdxZ0Ymzv10LrlkB+KIcymYuoAhQFSi2S8QQhijX0L15yv/8rhDEYt4bhfDgTL8ZRG5m/9IZaLiKWm7dTqZraImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOYzk0un; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78457C4CEEF;
	Thu, 24 Jul 2025 16:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753374427;
	bh=gOSOhp2aHn4QnMocfEjY/TPzbqnCSZw3r1trnn4HRo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOYzk0un1rUyse2SSotrVBgJqiWSnRKBYwvjcUy8zAaWu1Yt6d3SRHthsdx1xPWSu
	 CbjTBvVfFFjFf5JVLnHsZbrTYzvxSlpDHfXWv3myfOI8Cu01w0azZ5ilJyP6JivUFd
	 X1RLKFb05V40jMn9au21BFYQlEBqITt68SmEykQ3BJNosyM0On7EtqQww4NpldgUjJ
	 j3nSPjPDTTAX/4uRAQUnS5DQslLw442DRhmm7uE6f0cr4kiiM4da4fTcwGj5kH3zQd
	 LtUSW2KKpJlnKHB3E86RU9t/s1GHpby1xtIZzoH5TqYPqK80cag+OfbmA7v54G9obk
	 VvTKhbsZmACfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: hid-sensor-prox: Restore lost scale assignments
Date: Thu, 24 Jul 2025 12:27:03 -0400
Message-Id: <20250724162703.1368510-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025051230-unfold-exonerate-3e6d@gregkh>
References: <2025051230-unfold-exonerate-3e6d@gregkh>
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


