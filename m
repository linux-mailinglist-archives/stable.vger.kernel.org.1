Return-Path: <stable+bounces-184719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3AEBD417D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A11D234ED31
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8348C3126C4;
	Mon, 13 Oct 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htJcGqaF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592DC30BF72;
	Mon, 13 Oct 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368241; cv=none; b=VAA6ZPQs/HC4NE2LhnyIPRZKb2I0azeISU3z4F3pmPjdBKrJshMFpKxC5hcMlHtgrGbbW4FscdXMOZjjXlDeLQppaW9Ld+1Ttq94xCDOnmjeSYhfaYrlahMH+OQJKWmay3NtvJs4AY1FapS8VA8Rc7KWhjTWgDtiNcrKYqw9wQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368241; c=relaxed/simple;
	bh=T6rkmZPK9y6R+KhcrUPhsT9aMA6EbLewStHqcb00su4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iCjpJtMrgHPQl7qi6/dRY0uigiLOG8sOX+zcaX78inMw6mdJUNGNP/eY6ybxYVHZl1Lv4x2B0TnpVB+P4zG6LaJnGrC6Ogj/E0isJ/t8AYCcHrioniqFU5l7hdYepF2fnRSYNGhOk85VmFevpArpogf7XYa1com5RSvoCqEKa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htJcGqaF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760368239; x=1791904239;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=T6rkmZPK9y6R+KhcrUPhsT9aMA6EbLewStHqcb00su4=;
  b=htJcGqaFMHiVnQ2jZmkoSS6Bf56c3j01bILEJ2ZAvbTOhIxuVJCaxcEA
   b61TzDuC7HtSxIFsbFvBHeaL+uVCpAEMLlPR/Q98bitoKV/VcddZXwAcU
   +1HXltSJOdkxqn+fr5y+WuKXuQYOWrhyFV4bhWZ3H3G7j4qinceM2bK+s
   yygb53j2/UmY5a4+qArtWTSBfw9Mve2a/EZiYwyW/dVrYwM6PArvw/xc2
   XBKgoWHTb0w4eqKjgStIZOgLQOFETK0K7XYKK7e4M3yyxe2tjLD//sFpS
   oJxR9RZHPcAKj1m3cHlMVrKXsNK0YtbpFd3zqYiloRYMAdluG2LsTngsP
   w==;
X-CSE-ConnectionGUID: 8YOEVFqaRdiFcGXNCO4J8w==
X-CSE-MsgGUID: MnFvRrpkRDyU/Sz7OKtt3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62546045"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="62546045"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 08:10:38 -0700
X-CSE-ConnectionGUID: KsL7c0fbTSmlIFJzzkaLcQ==
X-CSE-MsgGUID: ctslHxUvSiOYZyiW2PB8rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="186915218"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.77])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 08:10:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Gal Hammer <galhammer@gmail.com>
In-Reply-To: <20251013-sleep-fix-v2-1-1ad8bdb79585@gmail.com>
References: <20251013-sleep-fix-v2-1-1ad8bdb79585@gmail.com>
Subject: Re: [PATCH v2] platform/x86: alienware-wmi-wmax: Fix null pointer
 derefence in sleep handlers
Message-Id: <176036823039.2473.15648931584117338012.b4-ty@linux.intel.com>
Date: Mon, 13 Oct 2025 18:10:30 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 13 Oct 2025 00:26:26 -0500, Kurt Borja wrote:

> Initialize `awcc` with empty quirks to avoid a null pointer dereference
> in sleep handlers for devices without the AWCC interface.
> 
> This also allows some code simplification in alienware_wmax_wmi_init().
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: alienware-wmi-wmax: Fix null pointer derefence in sleep handlers
      commit: 5ae9382ac3c56d044ed065d0ba6d8c42139a8f98

--
 i.


