Return-Path: <stable+bounces-172682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B30B32CD9
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 03:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CDD2039AF
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 01:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD661922C4;
	Sun, 24 Aug 2025 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaUXrjyB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157533E7
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755998977; cv=none; b=C2DRpg4jn8cDootg8ldc/kQjL3hzB1PYtN7iPu69RnZUb4+K+nglZOSjwpUS4NTMUA5Ekg+9fLX+KrTZvbe1c0WCQ7Xa0Ry64emLpRtm4R0+C7SiPELKhG/KWrb/uQkzqVRu6s6Kv4XMiGxWGblvwbezdsELSjKFTDXfW/aYCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755998977; c=relaxed/simple;
	bh=0S9aZPYhjZR2u2+ivHqHjZstFGD+zeoXtVXVRz9+vMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpfKyBzOnbcrNhYaUm+EkTYAje0HYUbjOTNuYKXuPHDGyFg2LOJImdKDMIQ02joSxGB6kMZLSXNKbgo0fQZmreHqyqsgGy5Gm03PM4QeDZHGN+8HAE6Yl1G33Ah7793rWnUgRYl1QiXNJ0euziFPyt94sIiZ07kDFk5YSpUG6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaUXrjyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D233DC116B1;
	Sun, 24 Aug 2025 01:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755998975;
	bh=0S9aZPYhjZR2u2+ivHqHjZstFGD+zeoXtVXVRz9+vMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaUXrjyBRHNkFBf/HDLF0ELZnmILzbiCpneMuSd8FQ6IFZWJCUd+O191FaOXDNZEX
	 M4q2U4pj0HRN/aO6vnyrmyXKDpudLPzCGcJRTOqO2/5H8d7YRsR1KLxKoJ1d9hR75/
	 /sAK89GoLHmW7VlsqivfAgP4MKfmTbLNaLrmtDQYs7jc5ro1p/z9zmjnYRmEKtspiH
	 ZGHngSc1z7HHiuGOFgUISQ0dz49rHIVz0c9/TTVwTkEQUvGdmiXv3x+eejgeSB15OC
	 E/tnfWREeHPcrdxwBqigKGHyJdugb3GWebxQihTVvNLdTXRTCrckCFQRD3QWBVaQoF
	 u2XlWbKjZn0Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iio: light: as73211: Ensure buffer holes are zeroed
Date: Sat, 23 Aug 2025 21:29:32 -0400
Message-ID: <20250824012932.2578686-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824012932.2578686-1-sashal@kernel.org>
References: <2025082316-antennae-resurrect-e01a@gregkh>
 <20250824012932.2578686-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 433b99e922943efdfd62b9a8e3ad1604838181f2 ]

Given that the buffer is copied to a kfifo that ultimately user space
can read, ensure we zero it.

Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://patch.msgid.link/20250802164436.515988-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/as73211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 37fffce35dd1..36f6f2eb53b2 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -643,7 +643,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct {
 		__le16 chan[4];
 		aligned_s64 ts;
-	} scan;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);
-- 
2.50.1


