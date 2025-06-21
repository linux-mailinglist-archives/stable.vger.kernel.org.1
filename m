Return-Path: <stable+bounces-155223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB783AE2827
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241D33B5D12
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C71DF974;
	Sat, 21 Jun 2025 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEGREGXS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A051940A2
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495937; cv=none; b=UtjvRCFSFCcD/uTAbXdli52pabGtUk6OQ8X9wZz4jeqKpF/2qkLRzd0iTN5HiZuO2tXXYhZYbytHMu1OWFq1jPoI+IECnei3UL1CS1EjFvavu1s+aT39E7poa5IFpS9d81NOu19n+ZreUHG3wzSn31xzUa7b1FR22RuDwt8q1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495937; c=relaxed/simple;
	bh=5BG0irfcakxtadyCFek/uEjWcCpoT0a+6MoC/HqSp9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmPHmEiTqLvc4GCWDeUglNIinaT+wB9eH2JAsKaMI6CPwmEPMgz9vHsxmzdS283JIfT+jYQJA559qcJ4jWpyySOFAFE0hBlHthJZF+8s7bmvd9jtSTT5y2a0RTKjcHJOeH0D8P8NCCdeYMkf+1TAUvXkDna80svCrrBLmO+r9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEGREGXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6B8C4CEE7;
	Sat, 21 Jun 2025 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495936;
	bh=5BG0irfcakxtadyCFek/uEjWcCpoT0a+6MoC/HqSp9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEGREGXSzhu0m9fg9LuMXqCwB4q4QfZ/IbfkvxgUt+OKFx8AWvotFEgEZjSrc/N7s
	 Vov1kC5NoVZ3pjH4V7C244Uvbk48SmvcoNXxxcx93Pl+Rs6X6hMX6f7UXrjToq4aA7
	 uCCKZnY+PUICvQ0YfwxGBelv+OMyy+SWspYT70o6LS6TJILi1N98MtAT4XP6mev6PF
	 N6MuvTbjMK4SyLoaB59ef3IBXIQYGOYO3TPjsDX5gU7A5kJyHIOo2kdcymiqWIicK0
	 RM0e4BT+8x9AsFlLpJFDOylZmDvqIYT3GRJP5M2b34ceKGqEi7UGE+vvm9OCl9MR4N
	 3//9qGDWfoOcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sean@geanix.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] iio: accel: fxls8962af: Fix temperature calculation
Date: Sat, 21 Jun 2025 04:52:15 -0400
Message-Id: <20250621031849-bad50516bc0d32e2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250620102136.222541-1-sean@geanix.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 16038474e3a0263572f36326ef85057aaf341814

Status in newer kernel trees:
6.15.y | Present (different SHA1: b0df531da1ef)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  16038474e3a02 ! 1:  8e583bd0770f6 iio: accel: fxls8962af: Fix temperature calculation
    @@ Commit message
         Signed-off-by: Sean Nyekjaer <sean@geanix.com>
         Link: https://patch.msgid.link/20250505-fxls-v4-1-a38652e21738@geanix.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit 16038474e3a0263572f36326ef85057aaf341814)
     
      ## drivers/iio/accel/fxls8962af-core.c ##
     @@
    + #include <linux/pm_runtime.h>
      #include <linux/regulator/consumer.h>
      #include <linux/regmap.h>
    - #include <linux/types.h>
     +#include <linux/units.h>
      
      #include <linux/iio/buffer.h>
    - #include <linux/iio/events.h>
    + #include <linux/iio/iio.h>
     @@ drivers/iio/accel/fxls8962af-core.c: static int fxls8962af_read_raw(struct iio_dev *indio_dev,
      		*val = FXLS8962AF_TEMP_CENTER_VAL;
      		return IIO_VAL_INT;
    @@ drivers/iio/accel/fxls8962af-core.c: static int fxls8962af_read_raw(struct iio_d
      	case IIO_CHAN_INFO_SAMP_FREQ:
      		return fxls8962af_read_samp_freq(data, val, val2);
      	default:
    -@@ drivers/iio/accel/fxls8962af-core.c: static const struct iio_event_spec fxls8962af_event[] = {
    +@@ drivers/iio/accel/fxls8962af-core.c: static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
      	.type = IIO_TEMP, \
      	.address = FXLS8962AF_TEMP_OUT, \
      	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

