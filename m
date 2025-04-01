Return-Path: <stable+bounces-127320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5890FA779A0
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 13:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2003AD4D2
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F961F8BBC;
	Tue,  1 Apr 2025 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4dZaDjJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE61FA26C;
	Tue,  1 Apr 2025 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743507330; cv=none; b=tROK96N5LbfXoaPo92MWw5ba6odQg0lT7sWyvS1hHY3sJZEKRXFB9mauzGJts9B36pWqssz+r6CBsJBn23OWxEcsjMJsCLFjxjvQ12FRIwVIH4pf/eueHjYIR+IIiRlD+dVzKuoHHzt/Up2nmAEXV7lsGpyAPsXeXGUydcUgfKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743507330; c=relaxed/simple;
	bh=OhNeptbAimAxwxg3/oj50OR59tc+7qzE/FdhfTTVrsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n4W7+u9JQ5qOFrTE8bEWuOH/EBhXhhsGZ4Lp7TwUOGuTM2GWUBiCVMuo6ETP1S/s0t9BDtwbktzyXAGng/zoxkvTyVIC4vLWm3q3O3/utOJf5NgV9cyNJzwZKLHvh2tXtWnBoOQBH8qFHtxIHZvDNk2oO+SXEFIKL6oqVKQJCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4dZaDjJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743507329; x=1775043329;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=OhNeptbAimAxwxg3/oj50OR59tc+7qzE/FdhfTTVrsI=;
  b=R4dZaDjJZVJn9gLLYkbECbqSNd7ahEbTMSZGj4m4VFBUDNIH6CdVzg7d
   5evP2ZvKlAlyvL7kvUmctKLDK2ODG/pUlGdXdS12QIqtj37YL1Dq11kQ1
   /285+utHNyvW4r5xbMocDHLoqxmvOvoTf8Kw/qkHy3RgxDQve/2MhOLEv
   +sD3QheQcuws3k17CYbCHrbezNgR+mHO7L82rQt9eaTOMJN69LrS22ZB3
   faVDGE1WVTnPg0meFSvS8B54StT9816su3I4vHl6rVQ5qJRE/Uk2CtQrq
   Rcd0YN8rYCNRMs4KaUMoG0LJla6/40/w4gTkT9c5AXFpmGJpgwjRlB+F2
   w==;
X-CSE-ConnectionGUID: f591Krf5SDyVz39YZJtmzw==
X-CSE-MsgGUID: 0cYNaiYaRACYCh1HuWgoQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="48616233"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="48616233"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 04:35:28 -0700
X-CSE-ConnectionGUID: nB1mp2o5TmGhgoO4oKmoSg==
X-CSE-MsgGUID: eGJ4PKoLRGS3Vq79pdTn8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126120335"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 04:35:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hmh@hmh.eng.br, hdegoede@redhat.com, 
 Seyediman Seyedarab <imandevel@gmail.com>
Cc: ibm-acpi-devel@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Seyediman Seyedarab <ImanDevel@gmail.com>, 
 Vlastimil Holer <vlastimil.holer@gmail.com>, stable@vger.kernel.org, 
 Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>, 
 Kurt Borja <kuurtb@gmail.com>, 
 Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
In-Reply-To: <20250324152442.106113-1-ImanDevel@gmail.com>
References: <20250324152442.106113-1-ImanDevel@gmail.com>
Subject: Re: [PATCH v3] platform/x86: thinkpad_acpi: disable ACPI fan
 access for T495* and E560
Message-Id: <174350731915.2494.4458891330469738526.b4-ty@linux.intel.com>
Date: Tue, 01 Apr 2025 14:35:19 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 24 Mar 2025 11:24:42 -0400, Seyediman Seyedarab wrote:

> T495, T495s, and E560 laptops have the FANG+FANW ACPI methods (therefore
> fang_handle and fanw_handle are not NULL) but they do not actually work,
> which results in a "No such device or address" error. The DSDT table code
> for the FANG+FANW methods doesn't seem to do anything special regarding
> the fan being secondary. Fan access and control is restored after forcing
> the legacy non-ACPI fan control method by setting both fang_handle and
> fanw_handle to NULL. The bug was introduced in commit 57d0557dfa49
> ("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support"),
> which added a new fan control method via the FANG+FANW ACPI methods.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: thinkpad_acpi: disable ACPI fan access for T495* and E560
      commit: 2b9f84e7dc863afd63357b867cea246aeedda036

--
 i.


