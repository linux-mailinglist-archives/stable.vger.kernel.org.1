Return-Path: <stable+bounces-192502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F02C35A14
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 13:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2531D462995
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F2314B6E;
	Wed,  5 Nov 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GR9KTWIJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74A314D01;
	Wed,  5 Nov 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345470; cv=none; b=OQTTswiaqlLq7489OugvZhS2XlUStekXi4P+J7yfAgOKhrtE1AVThRUUzUpa4VQvQPZAErj2Zklf9rF0lAZT2/QjO2mPeYEMy5W66RjihBQ9LZUrrpcpLnYQctLs5WG7dlS0NZUX+VaI3baL6aM1g3eDnl9xPLQK+kqcT0KB7uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345470; c=relaxed/simple;
	bh=FrsBppbRUg1uqMKzbphvbtVwaExS+He7dxzOXm1SlDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qL+wEI4XfFjqVdahG180dgD8jrVtBKzUk52naEK0yPCQ+/bkQueLe6HEEy3cziXlCaxoWFVHkgg4236eq49jh5PwIux+193ByvclcqpDgru7cipywoPVR2i334Z/JRnaivp+ktav7GzBgWmfCbREpE3sTtSxcoucFcV4hef0uSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GR9KTWIJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762345469; x=1793881469;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=FrsBppbRUg1uqMKzbphvbtVwaExS+He7dxzOXm1SlDc=;
  b=GR9KTWIJgkySq0V+4m08FJmE2lb1Wdr16bBbup2rvgP1r8QKhvN8Gz5u
   cEXrSAWvEdxImgMEmJEt30OMtykOBXJnp8wnAoUFyLiYH49OFT0QeBRKA
   XchQlbeKNoVXUcF+ro3gs4VKCcXmVR2YON1JzZp/NJ24b+CFpDnFcQgp6
   aN76fkhksFZDuPET+jLpWSfrxd+tXbrET1x6+LIklP8UWav3Y5/0TYTtJ
   hXMDOqzNwbfZ6lVBOeBt1IfSoa2SJRRaZGauWwZ0nzLlB/qJm9dcJm4Fy
   qP1cbRGHLW/PvJj2fgm57tfo7smci5jVS4lZQE1N3H8sdptmqtMYYz2oY
   A==;
X-CSE-ConnectionGUID: 0tN4tKP8TvK1IKXxnAhR+g==
X-CSE-MsgGUID: YbWpceR9SLezDTgKaGQR7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68110115"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="68110115"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:24:28 -0800
X-CSE-ConnectionGUID: j+UqIEGXQt+wXdQWL113AQ==
X-CSE-MsgGUID: DoUhTZ8AStKQekXMrF9tOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186693105"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:24:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Cihan Ozakca <cozakca@outlook.com>, 
 stable@vger.kernel.org
In-Reply-To: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
References: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
Subject: Re: [PATCH 0/5] platform/x86: alienware-wmi-wmax: Add AWCC support
 for most models
Message-Id: <176234545988.15175.7415064699001825905.b4-ty@linux.intel.com>
Date: Wed, 05 Nov 2025 14:24:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 03 Nov 2025 14:01:43 -0500, Kurt Borja wrote:

> This patchset adds support for almost all models listed as supported by
> the AWCC windows tool.
> 
> This is important because the "old" interface, which this driver
> defaults, is supported by very few and old models, while most Dell
> gaming laptops support the newer AWCC interface.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] platform/x86: alienware-wmi-wmax: Fix "Alienware m16 R1 AMD" quirk order
      commit: 6da381e2cd4ccf2df4bc1d37bf5a2843745e68d9
[2/5] platform/x86: alienware-wmi-wmax: Drop redundant DMI entries
      commit: 757dbe844903b53bbd32ab2ad6b0bcd76afab8a0
[3/5] platform/x86: alienware-wmi-wmax: Add support for the whole "M" family
      commit: 1931748058c5ef9c9dfad50483bb99cc645cbcb5
[4/5] platform/x86: alienware-wmi-wmax: Add support for the whole "X" family
      commit: 157a1f2d93d2e0416af386d67d1a3953796d0941
[5/5] platform/x86: alienware-wmi-wmax: Add support for the whole "G" family
      commit: 4f29ef0b522988fe41e2a080ce861b4deb1d976c

--
 i.


