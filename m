Return-Path: <stable+bounces-155220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C46AE2820
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEBF17CF0D
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7951E5713;
	Sat, 21 Jun 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhUdnSqn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F481940A2
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495926; cv=none; b=c5q9/gIl4+VzgLaqiWETNUZlA/OoGi3XNmDDmZNJ5CDVwObb4InpMQ8s/Oq0hzwpel8FI3cI21E5Txjt3I+oA44yCRjTFlgEZTOI7GW2kbzIgczElsFVIHkTvE+pmEKBeG5unCPcvtiTH/Ji0UObWUPk7CP29x3yZGq/JYf1K24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495926; c=relaxed/simple;
	bh=0U2bKd8J3pgH4U8Ig78nrD9sapMUia6DTcey2FPdaS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+LjbqAYIR2fgmFsKiGu9qzPZAmJE1uimNPmSIfRLgBFrxZsXzA12g2ZWxl2BXEXhGDUtmFBj1kaj9CPyjl7LMs+/3yamO7IWIhC0fgJ0KvlvL9tWiYH0HRER5PRaPUDrPLgrsPPOqcE6pl+3HCATYMro5qk+ldaavNbm+tUYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhUdnSqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED0BC4CEE7;
	Sat, 21 Jun 2025 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495925;
	bh=0U2bKd8J3pgH4U8Ig78nrD9sapMUia6DTcey2FPdaS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhUdnSqn9pSudXTZzu5tTzUHumK8ZcqJkttcq4D7mbWG31oIem14GEIBN8Zhg0iTj
	 pjCmkogUP73bZ+4NqeAzMPL7L93pSxcULchsZzlFhS15Ai1RE2M6yy93bVYeuaDUWZ
	 UytEHMDVsBFiIQ+2RYY3a2Sj1QH/0NcnzzPyd5lPfOoXelRkiJSifYAh26NRRNq/wA
	 UNZcVrN5FRkaD26WsqoYcL4UgDKaQ8/sxphM4pmPFPlLaOhZuuzij9JobhRtpVbMWG
	 yrG6cosVnRzxegqMZ34ey14wzrmvNB4iQW4ySUuas0bO+lCv0Foq51nlsbUcf9YJxF
	 C378eZ8eRdxog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sean@geanix.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] iio: accel: fxls8962af: Fix temperature calculation
Date: Sat, 21 Jun 2025 04:52:03 -0400
Message-Id: <20250621034357-217a82afb9daed71@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250620102408.536990-1-sean@geanix.com>
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

Note: The patch differs from the upstream commit:
---
1:  16038474e3a02 ! 1:  46805b31deced iio: accel: fxls8962af: Fix temperature calculation
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

