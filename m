Return-Path: <stable+bounces-135264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC6FA988B6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 13:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A28444AA7
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 11:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662A270552;
	Wed, 23 Apr 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXVAtWHj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C33426C383;
	Wed, 23 Apr 2025 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408310; cv=none; b=hYWDcJ7FcNPns+0SxsktZA5NagduRfUSrbf2ypVHTR+024pLyVFiGgtad7ypmi8Z2VuJFqKgrdq0wGhL3TcuK/Wp8+WvfMdvGhVn8Cr0uyx9E3ZIHCm/GlCshks2Ut02oXjulfWFYF0ldAGatDBXz7moQF82jgiRPI0pcpm8rx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408310; c=relaxed/simple;
	bh=S8f7WjEySvpwK0W8HzaMP7km4uM1lyMcyHeEmcNn584=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iEO2hgAcVX0dcNPkGRbJsE8ez0poejtcDHh+BcmUV7r1Z+C11aiXQfKlbK49D9KJ4mIiyLCB9ZEGmSLtEVI9teuo2xZLCtLtSr6n02cpkBsHRPZAjYfhDJk1yLr1k5VMXg964EBivUMHmT5NyuJEoJJ3ufu2XV3bGA5DioKawlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXVAtWHj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745408308; x=1776944308;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=S8f7WjEySvpwK0W8HzaMP7km4uM1lyMcyHeEmcNn584=;
  b=QXVAtWHjr2INEjjZMaHxFvkq/Crm3nWOUBsh15lFhNBhEc+Dp4E0P54w
   OgDlmIU/wX8MrMyrgVWtJgqoFGTAg7RGoIj2FFv2MZJgW+0fnmKjrI4eH
   gZq5ha66pXXagcF+2jh/X9V9Zc31YYjhAv6k5hrjgu+9jf3dUbrKXHXBc
   bCqk6LbCSJikb+9q1b9zJfkJsT1HoldSxqA5IIb+yaucyHS06EwsMnA7i
   qHDi1wu5erELjGdaB5yeWiClbsSZ5R/btxoVqf9QEjojwnXQMbpC8JrHr
   6lSD7z+Y85NcgPN9Qd+JKbAf0yaOLbJvU0hC+1z/ppDWHjvtq2Gel7JLR
   g==;
X-CSE-ConnectionGUID: reM3VyzqRFCiGxbP5Oac9A==
X-CSE-MsgGUID: f+lyIdljQRyd8Seybcc4jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57652711"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57652711"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 04:38:28 -0700
X-CSE-ConnectionGUID: 7j8AkHztTFaZTxtdYzw3uQ==
X-CSE-MsgGUID: PjkcNOeRSjSr1UE4Uv7M4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132212773"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.36])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 04:38:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Romain THERY <romain.thery@ik.me>
In-Reply-To: <20250419-m15-r7-v1-1-18c6eaa27e25@gmail.com>
References: <20250419-m15-r7-v1-1-18c6eaa27e25@gmail.com>
Subject: Re: [PATCH] platform/x86: alienware-wmi-wmax: Add support for
 Alienware m15 R7
Message-Id: <174540830099.2601.11725407315378984520.b4-ty@linux.intel.com>
Date: Wed, 23 Apr 2025 14:38:20 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 19 Apr 2025 12:45:29 -0300, Kurt Borja wrote:

> Extend thermal control support to Alienware m15 R7.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: alienware-wmi-wmax: Add support for Alienware m15 R7
      commit: 246f9bb62016c423972ea7f2335a8e0ed3521cde

--
 i.


