Return-Path: <stable+bounces-197698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 949A5C96A51
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 11:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8A9E4E183F
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 10:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA05303A00;
	Mon,  1 Dec 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URNLc2K0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B40302CB4;
	Mon,  1 Dec 2025 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584898; cv=none; b=GpSMqu2aPI2thZ5372yXC/yjw3NNUj32kxlg/4ezEDgmzs4NCbRuBpI1jeXY88g17PsrS3p94rkd3OzRIDrXwG1KLE3kZct1b7MnUk60ET5PcHmUzMN7nsjh5i5raGR6iJYX/eADjpV28SFpqa1OwySUZmLo5HJX1b9XRf2dl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584898; c=relaxed/simple;
	bh=kT5X//GhJjikAD5RWnXukswO6wYtIaZuTzepa00csFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kVktEVo0SRXsxeTmRukI1Sx1axupaXMDeYRvQ+XaAvZUzTIiF31s2/oU3WYdMzC6eqKafJsHxIvZxrXH4Ry8kd+v4B/r1lulYyiRkl4eJm3G92q+D05zO2FcCdVAdWuhq0EanZ4jM79HL7NRUzAXHAVFBJuNQZSlMXUfwaDzD70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URNLc2K0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764584897; x=1796120897;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=kT5X//GhJjikAD5RWnXukswO6wYtIaZuTzepa00csFE=;
  b=URNLc2K0KRXwLEqjG5LR5UNl/b6YQUbWGzmb5a2bTOlyzH352q3izuxI
   0j1WjTVWDgWLEQzzGHyxEKZFrJJftWPgbTpPvudHzocEg3yoScnGc3OKG
   4dAnu6ws89zMMMVw67Oa6T5Hzz3c5GNcereRnVx8E23LNu5RiJBJTgvFJ
   8rO9SSmb5iTHDyQ4aa0hkjfu4V3OoLts0tQGZN+pysPmzCAlFgh3vsTCa
   REvh9wFXOH105lePzKH/H9o9KYNMMECWOt+Ejp0kE/tJH0PYhe9S28138
   Aa1nMLvE/fUs1EXEEReOHTAENCXbbVj6qjw7zyWXzxYfxEVXBqAPrnDsC
   w==;
X-CSE-ConnectionGUID: H9qkspNbTlW330GOSPKX4w==
X-CSE-MsgGUID: +/oADK6TTz2EO7fVtzfE1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="66407643"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="66407643"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 02:28:16 -0800
X-CSE-ConnectionGUID: yoelmp2nSrqj2bvrnYXCPg==
X-CSE-MsgGUID: /co980COSBClJxfn2twXRg==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 02:28:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, david.e.box@linux.intel.com, 
 yongxin.liu@windriver.com
Cc: linux-kernel@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20251128102437.3412891-2-yongxin.liu@windriver.com>
References: <20251128102437.3412891-2-yongxin.liu@windriver.com>
Subject: Re: [PATCH v4] platform/x86: intel_pmc_ipc: fix ACPI buffer memory
 leak
Message-Id: <176458488785.9246.12086096381340723589.b4-ty@linux.intel.com>
Date: Mon, 01 Dec 2025 12:28:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 28 Nov 2025 18:24:38 +0800, yongxin.liu@windriver.com wrote:

> The intel_pmc_ipc() function uses ACPI_ALLOCATE_BUFFER to allocate memory
> for the ACPI evaluation result but never frees it, causing a 192-byte
> memory leak on each call.
> 
> This leak is triggered during network interface initialization when the
> stmmac driver calls intel_mac_finish() -> intel_pmc_ipc().
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: intel_pmc_ipc: fix ACPI buffer memory leak
      commit: 611cf41ef6ac8301d23daadd8e78b013db0c5071

--
 i.


