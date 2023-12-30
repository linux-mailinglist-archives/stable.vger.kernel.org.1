Return-Path: <stable+bounces-8828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FF820512
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FC11C20EC7
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A079DE;
	Sat, 30 Dec 2023 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n6bGSYZ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10E79DC;
	Sat, 30 Dec 2023 12:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4266FC433C8;
	Sat, 30 Dec 2023 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937867;
	bh=RqaqHwmtyWEDuYMBpFSYZ1QMrmdOdNL/FiDIgq206k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6bGSYZ0uvaC3N5lwcuIiHd9KK0ADH/JLhXsr4Aems/cvmu+P3pZY2KJjDIK1lAdY
	 nw5BcWLxTOU/4pDFbg+0OKBt8s4b6H58YqKSZ5UV566KAazqPFEB4NzRwbOMLE9Byc
	 +CwR3bzm6WZ8RDcSdbZ+wmhMs3i7rTWODSasq/QU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6 094/156] iio: tmag5273: fix temperature offset
Date: Sat, 30 Dec 2023 11:59:08 +0000
Message-ID: <20231230115815.432279624@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco@wolfvision.net>

commit 3b8157ec4573e304a29b7bced627e144dbc3dfdb upstream.

The current offset has the scale already applied to it. The ABI
documentation defines the offset parameter as "offset to be added
to <type>[Y]_raw prior to scaling by <type>[Y]_scale in order to
obtain value in the <type> units as specified in <type>[Y]_raw
documentation"

The right value is obtained at 0 degrees Celsius by the formula provided
in the datasheet:

T = Tsens_t0 + (Tadc_t - Tadc_t0) / Tadc_res

where:
T = 0 degrees Celsius
Tsens_t0 (reference temperature) = 25 degrees Celsius
Tadc_t0 (16-bit format for Tsens_t0) = 17508
Tadc_res = 60.1 LSB/degree Celsius

The resulting offset is 16005.5, which has been truncated to 16005 to
provide an integer value with a precision loss smaller than the 1-LSB
measurement precision.

Fix the offset to apply its value prior to scaling.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
Link: https://lore.kernel.org/r/9879beec-05fc-4fc6-af62-d771e238954e@wolfvision.net
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/magnetometer/tmag5273.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -356,7 +356,7 @@ static int tmag5273_read_raw(struct iio_
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val = -266314;
+			*val = -16005;
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;



