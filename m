Return-Path: <stable+bounces-74074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86B2972169
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 19:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204CE1C237CB
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03AE17ADEB;
	Mon,  9 Sep 2024 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgFoZgQu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA6F43AA1;
	Mon,  9 Sep 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904500; cv=none; b=qkEKfJpSC9HR6y+BZyqy54F7AARIwli3bzLUZH9tNOvORlio6chl3jrH98HtRuzWAL2a6zrzSX/O4fXM7Amun7X7Q0trywfJOpzimlkFut0v+EkCiabK7n19Z9+HJJYIdXLLfcxH+fE7I3OBgofBZSSJm6IsCLMYps/qDXpZpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904500; c=relaxed/simple;
	bh=B+6nPZlcTimswUoAomVeNialyu4KqNTg5gLHycOAFxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B0aZxNkgH/6O6cf445UKU7yL6A31E8x6jiLtve0cHZDd66uT3Ao4KpG0klebl0Jm8QhBHBiQeIqigth4I98EjMvMc1hyzYpSpdNh+7ck9/3xzX7wbN8+iGQ8bUW4qgPD2ekUMSclik5WI64i6ZN1l5luSG0VEs7WZiK7TQuE+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgFoZgQu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725904499; x=1757440499;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=B+6nPZlcTimswUoAomVeNialyu4KqNTg5gLHycOAFxw=;
  b=CgFoZgQu8HFnYu1wIescQefiLs/pb0gtp34I/4mjSuOVoiPiTSekQaiG
   94Ji9sU5Txr4Dq88fECmq+As1qC5Mm0ju3xCybacC87vgyfKRdiVHV0nE
   KSnREIeFrzJyaRRvgfIiqIHVtRgS/WIQRjvwWxUELFIVdC0DgKCywqusP
   /EmLF7s7okaLHwxqEzkhKV6dEm+I/eGpjXSY9Y95E32pS9xvFlNLheEmT
   G3gTT22ZlLZ6EzVaKoHDFCj/3PLCVb3oPEJExkRy9E09mkrCPkhs3zCq2
   YLrQAmGS8Ym6JJTZoflcKoL+ArZXxQe12FbFKvwcq1MxOrZQsre5G8TOf
   w==;
X-CSE-ConnectionGUID: u3LfkfB0RumOQA/F/Ah7UA==
X-CSE-MsgGUID: vHlhlP9FRWCN+yXXDigAdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="50028295"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="50028295"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 10:54:58 -0700
X-CSE-ConnectionGUID: uMkhaP+/TcyFS9ccyBl4HA==
X-CSE-MsgGUID: q3yNs7ZnQs+I83et4Gpy7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="71530730"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.60])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 10:54:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andy Shevchenko <andy@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: James Harmison <jharmison@redhat.com>, 
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20240909113227.254470-1-hdegoede@redhat.com>
References: <20240909113227.254470-1-hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/3] platform/x86: panasonic-laptop: Fix SINF array
 out of bounds accesses
Message-Id: <172590448046.2114.11735502570640542626.b4-ty@linux.intel.com>
Date: Mon, 09 Sep 2024 20:54:40 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 09 Sep 2024 13:32:25 +0200, Hans de Goede wrote:

> The panasonic laptop code in various places uses the SINF array with index
> values of 0 - SINF_CUR_BRIGHT(0x0d) without checking that the SINF array
> is big enough.
> 
> Not all panasonic laptops have this many SINF array entries, for example
> the Toughbook CF-18 model only has 10 SINF array entries. So it only
> supports the AC+DC brightness entries and mute.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86: panasonic-laptop: Fix SINF array out of bounds accesses
      commit: f52e98d16e9bd7dd2b3aef8e38db5cbc9899d6a4
[2/3] platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf array
      commit: 33297cef3101d950cec0033a0dce0a2d2bd59999
[3/3] platform/x86: panasonic-laptop: Add support for programmable buttons
      (no commit info)

--
 i.


