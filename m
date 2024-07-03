Return-Path: <stable+bounces-57498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0701F925CB9
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31FC1F21588
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7410318C333;
	Wed,  3 Jul 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+s5yi2T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7E1891DC;
	Wed,  3 Jul 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005064; cv=none; b=jMtStDnv2xL0SochuP63ZzQmtByZbq+4zaWi5b8BUy5V3P6b3iPe6Ccr2mjBVQHB8TKuEMt4dcpweieGNJjYoB+wi7LQh4ICBh21VcFUpjqwBN8FlY7+916hFnfVdyrcvEYc6cn9qgeMajzp5n9GnVtK278HJpYN0fMUILF0BOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005064; c=relaxed/simple;
	bh=hSGzjuz4bOLAvHGQwUzEqATyWL1/H09yrIfloVKf3Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck5xXnu1I+IIQUtNTqv33LmQGkRlDNKd098whfd2frcS79P4cIGoQ/otslzc9tm0WJaMb74iEts/DPvEPe2qvHl6QVBhwklSCOse9jKdqm9NnPSmSVtuW54/nTsfx4kKHcLjlECLCMJVjCokAYw3ai3d5CnflAzw0y0mAcFw+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+s5yi2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4807EC2BD10;
	Wed,  3 Jul 2024 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005063;
	bh=hSGzjuz4bOLAvHGQwUzEqATyWL1/H09yrIfloVKf3Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+s5yi2TjraxvBmjMw/KnLDwMy8x//CvQloE3Rpf+F7IUWD6i/2AMn62fnsjqfEP8
	 VEiVu8g20wR1b33xQFPxmJ5aq2CeI+GKnkSkt6JHXqyrdJ08vIqzY2T9ekBNSfxEUz
	 6p2zEelX95cv/qlA/7wnf7fXulxHSriqB/CIgXek=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fernando Yang <hagisf@usp.br>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10 248/290] iio: adc: ad7266: Fix variable checking bug
Date: Wed,  3 Jul 2024 12:40:29 +0200
Message-ID: <20240703102913.518440706@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Yang <hagisf@usp.br>

commit a2b86132955268b2a1703082fbc2d4832fc001b8 upstream.

The ret variable was not checked after iio_device_release_direct_mode(),
which could possibly cause errors

Fixes: c70df20e3159 ("iio: adc: ad7266: claim direct mode during sensor read")
Signed-off-by: Fernando Yang <hagisf@usp.br>
Link: https://lore.kernel.org/r/20240603180757.8560-1-hagisf@usp.br
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7266.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -157,6 +157,8 @@ static int ad7266_read_raw(struct iio_de
 		ret = ad7266_read_single(st, val, chan->address);
 		iio_device_release_direct_mode(indio_dev);
 
+		if (ret < 0)
+			return ret;
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
 			*val = sign_extend32(*val, 11);



