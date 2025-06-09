Return-Path: <stable+bounces-151999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 099B3AD1958
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 09:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CC41888158
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E149528135B;
	Mon,  9 Jun 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJvsuDv+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB1280CC8;
	Mon,  9 Jun 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455570; cv=none; b=IGcEHvFOpzAbnW0vJu2y3ZOdVTcL1adqT2zraTM6tytSFScAvfkoSQrUlDuBJqRDWBdY8SkCPDt25AW1ZDAzIgJxPvNCEju7tYl9tKsP9ZnlHj6mmv4fBsKx4gUvhomf93zqLa+c1Hty+vklaJvLR7YgkDnBskR6OZ51go5WL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455570; c=relaxed/simple;
	bh=yKCAkkocVMt/xboYQMnhpHPN9tMeGfAsSRDt/ILHQck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jxWegE4GIod0EkoETUy8trTl2pDNSgRauXbVdL6oE0qZocHXh1kQ5CmEDKZe7OqR4IKNaf+tUFv961vbeVn/LxKjRU9K9SpGsojpi28CuKzC+a0jPpS34DzIkb7BzPBzfv9ohMohAbZ78h74GNLfgVM8jhsiTIN3kJf2UKvOekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJvsuDv+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749455569; x=1780991569;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=yKCAkkocVMt/xboYQMnhpHPN9tMeGfAsSRDt/ILHQck=;
  b=ZJvsuDv+n0iX/la1OgJJ9F07qS4rEbqSwIxS0QnzHgVYwmr2iMcNiC7V
   OMMnB+x/tt/YgK5pgdRvGCwdoW6mjb13tfMHSdB9A8HVsYkOBM5S7GnoC
   l2K2BtHxRShzZ7vShTUb4+vxbKl7GtHE3aqsGgqYzu9/NRgu32tF9+5hT
   u/F4IqO5IR43ndZikhVn126/llbuyCQO2Lh/TjwLzqMo3OYzjWvIifBEY
   D4zx2I1sNZlVo4LmxK9GCzGH70zGo5YaMdxXbm6k2qKtkjKMwBVlVUsV7
   0RBz2nlW+53IDpYI8ikrNZ23wW4dbqv0/7/WSQiQvhShdysVlvuhvHmop
   g==;
X-CSE-ConnectionGUID: 7CzIDpUmS26y0feYIRvQWA==
X-CSE-MsgGUID: X9UMpu7PQ7ureCT7oEAZkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51669318"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="51669318"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 00:52:48 -0700
X-CSE-ConnectionGUID: 9UEr8cbtRgCpkXuidtIhDg==
X-CSE-MsgGUID: /k59eJkjT0ikEAo76bjBGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="147374787"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 00:52:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
In-Reply-To: <20250606205300.2384494-1-srinivas.pandruvada@linux.intel.com>
References: <20250606205300.2384494-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Fail module load when
 plat_info is NULL
Message-Id: <174945556062.2685.13696640320236584390.b4-ty@linux.intel.com>
Date: Mon, 09 Jun 2025 10:52:40 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 06 Jun 2025 13:53:00 -0700, Srinivas Pandruvada wrote:

> Address a Smatch static checker warning regarding an unchecked
> dereference in the function call:
> set_cdie_id(i, cluster_info, plat_info)
> when plat_info is NULL.
> 
> Instead of addressing this one case, in general if plat_info is NULL
> then it can cause other issues. For example in a two package system it
> will give warning for duplicate sysfs entry as package ID will be always
> zero for both packages when creating string for attribute group name.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel-uncore-freq: Fail module load when plat_info is NULL
      commit: 685f88c72a0c4d12d3bd2ff50286938f14486f85

--
 i.


