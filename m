Return-Path: <stable+bounces-97888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F86E9E2B98
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F371EB33BDE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2111F76D1;
	Tue,  3 Dec 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zObTingD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581BD1E766E;
	Tue,  3 Dec 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242076; cv=none; b=egabaEvk1gVutf4YhhezAeFhln37QpZ46278wiBf4ZefLm1M/Ep3W3RGk3qsNCOYj3dvg0SLfkI+pDnQfndcFfWwa30G9ZFJgSdW+fhDOrx6qHsa6s1RXvlRHzKovRPKr2P1WJXToBN3bUfXvZbRLIshz3ZRW13OV5vpNjEW/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242076; c=relaxed/simple;
	bh=Qyih0H2DS+4c+68XfnaWewQr+7K7Ssydk+tWRJ5DZi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOwSfnI8yNuOX0Y3dDmYgYJGcAAc1nlqoLCZfHv4NGyi3CNgXkuNdsSUYqp7BLYdJjyNtJ6o9p3NLCKik8GjbWAXZRv9gpxXauSXvgwdC+VdwAByIm24Snv0AfyKypohL3hhm4bFwhduU25nFBGi2+mnJAImdWskB0YxE6ZmxeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zObTingD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6833CC4CECF;
	Tue,  3 Dec 2024 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242075;
	bh=Qyih0H2DS+4c+68XfnaWewQr+7K7Ssydk+tWRJ5DZi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zObTingDNv8840dEhmGlydvWdEpzU+6u6XRthD/lJZB1XUCsLc709VraxV4S0FISJ
	 yW3PlbjVZ3dlDE341kOPSp8MUI2TXulN58nmxATJ9DaPubwt0hEYeDKXMvvYy6iv6I
	 sEkbFClo9brKaILM48WnMpYC0puOhN560NhE8c1o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 600/826] iio: adc: ad4000: fix reading unsigned data
Date: Tue,  3 Dec 2024 15:45:27 +0100
Message-ID: <20241203144807.162680908@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit 62dd96ac9cdf2814f41cfc55ecaf22a28aad6ccb ]

Fix reading unsigned data from the AD4000 ADC via the _raw sysfs
attribute by ensuring that *val is set before returning from
ad4000_single_conversion(). This was not being set in any code path
and was causing the attribute to return a random value.

Fixes: 938fd562b974 ("iio: adc: Add support for AD4000")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20241030-iio-adc-ad4000-fix-reading-unsigned-data-v1-1-2e28dd75fe29@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad4000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 6ea4912450849..fc9c9807f89d2 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -344,6 +344,8 @@ static int ad4000_single_conversion(struct iio_dev *indio_dev,
 
 	if (chan->scan_type.sign == 's')
 		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+	else
+		*val = sample;
 
 	return IIO_VAL_INT;
 }
-- 
2.43.0




