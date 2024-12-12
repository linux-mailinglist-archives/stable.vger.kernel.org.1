Return-Path: <stable+bounces-102234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FDF9EF0E9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4349F29DCC2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619FB226523;
	Thu, 12 Dec 2024 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dd7DvdE3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD84F218;
	Thu, 12 Dec 2024 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020484; cv=none; b=MFUp3Z30yrYPsLfZdI4+zItbXQs0iiOKsCOPEqwKJzUSqFJpwWtZ0YRXhNRw4k0hnp/58ce9usOQbT+VWySnDzbDw8XvWqs+qpOm19TOhy6pjHY0k0cvdWtgFn3i21d3PHSSBGbSZwdIBYCEOxVGBRFZwG9DTyyndYTwO9a9f2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020484; c=relaxed/simple;
	bh=f/kSdKQDWID50WIv6ppIrPkjbkFK2rsef4Qk1Hl18Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebwglmAIvar9jUDOAq/KAIA1rpv7UMluhW654Jcm0Bashz93QmwT007OQTOz1stG8Yy1BjMOPbnu/qu3R6JRUMFoizM64Ioh3mcXpmOgZVED+Agaki6trtWaSZzXKo8VNcHjGJ+kvGNd4Vs1kbTuBynnbF4fRq6MqeKK7Hzg/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dd7DvdE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F301C4CECE;
	Thu, 12 Dec 2024 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020484;
	bh=f/kSdKQDWID50WIv6ppIrPkjbkFK2rsef4Qk1Hl18Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dd7DvdE3v92zlPqM8jDqSQ7nWDJUkP7iB8SLvAN3U8O+fINJXpmsLrmYSO/I99kaX
	 BvmgrtBsV7c9MtOvU848V+vkEQSqqp6BI1G4pKSRCs55Ff7F5NRch7N10H9YQTqPps
	 EzcVIEJ72ZxOz/oIZCj5LRMl+lmnJyhI7AeQZwhc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zicheng Qu <quzicheng@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 478/772] ad7780: fix division by zero in ad7780_write_raw()
Date: Thu, 12 Dec 2024 15:57:03 +0100
Message-ID: <20241212144409.681884273@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zicheng Qu <quzicheng@huawei.com>

commit c174b53e95adf2eece2afc56cd9798374919f99a upstream.

In the ad7780_write_raw() , val2 can be zero, which might lead to a
division by zero error in DIV_ROUND_CLOSEST(). The ad7780_write_raw()
is based on iio_info's write_raw. While val is explicitly declared that
can be zero (in read mode), val2 is not specified to be non-zero.

Fixes: 9085daa4abcc ("staging: iio: ad7780: add gain & filter gpio support")
Cc: stable@vger.kernel.org
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Link: https://patch.msgid.link/20241028142027.1032332-1-quzicheng@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7780.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -152,7 +152,7 @@ static int ad7780_write_raw(struct iio_d
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
-		if (val != 0)
+		if (val != 0 || val2 == 0)
 			return -EINVAL;
 
 		vref = st->int_vref_mv * 1000000LL;



