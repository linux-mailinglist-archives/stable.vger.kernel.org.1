Return-Path: <stable+bounces-89598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B0E9BAC9E
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 07:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FB5281FE8
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 06:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522B418C90E;
	Mon,  4 Nov 2024 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eb0o2JvU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DDB175D56;
	Mon,  4 Nov 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702222; cv=none; b=pltBlyvb59P1I/NLjp8OefYT5xJ9Fy6ZK6LZXZt7e1rUJJb3ptHGWMw4ckoQg4LnKNGeXGAbRamni1WsYdAi2mqtdOEFs9Fvh1/qNpl/staEC3sA9h4DTRsAyb9EANFu1uDC4BgmjC/3h8W5e2fJqMkkbsf4eC4OgL6PXOKS5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702222; c=relaxed/simple;
	bh=qKh/unJNmYHVD6p6LEuueFoUbyCLveUwKE8TAZ2UYjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b26++bRJGQ2bwbFR/UG9mlG9WrFJvvy1M5fMlsy0ULDuoJGKJtV1+ouUChdmnQqMYsxw7wUl4KI/KMvUYpJMeDuFq+bFIPPjSeORkeuG7d+8v9IpkkmlY7jCqQ2rJGnB9r78wuiWVv6GOpLdp8kekH6QhXQLOxSj2E+hy8xfJjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eb0o2JvU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730702221; x=1762238221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qKh/unJNmYHVD6p6LEuueFoUbyCLveUwKE8TAZ2UYjw=;
  b=Eb0o2JvUybvCtEHLaNz6Ev7hQGPEXjRIgKx28pJ7AAm05LjoXPyBBXoL
   IpQ6WDVBy0K771SNHpbgyCrXegYAkTCobqtdNDpYTkNlSfub6oNXcgrp0
   9lS4Q84JqlgqwxmfM6JhbhrXAuhk2BtwCv0BwQFGRE0NsypJGrXmH0dY0
   B+dfHUJHBiIvG6Fl3R6Ok/xz7oobgCnyaFXLfTMz0sWACOjtm4hqf79D7
   VOqQXtizynLzpwCF8II7389rHKIWSBMtHdDNf0IQiaCzE5vofkwVdjQGF
   QfPVssR2BP4qasRfNtX1/vLTbCiyVs7V6o9Ope4gsrNu0nhq3rbfbqMWA
   Q==;
X-CSE-ConnectionGUID: HuOIxzK5Q+S/tZcJJWKDZw==
X-CSE-MsgGUID: Hr2zP0ckRcKkyZop90wU5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="41776458"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="41776458"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 22:37:01 -0800
X-CSE-ConnectionGUID: l1ZEc6tKRAqoXQOx3Z8CKA==
X-CSE-MsgGUID: gugQqAFPSwufZvmi1+xJhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83901304"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 03 Nov 2024 22:36:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id E37F91C8; Mon, 04 Nov 2024 08:36:56 +0200 (EET)
Date: Mon, 4 Nov 2024 08:36:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rick <rick@581238.xyz>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Sanath.S@amd.com,
	christian@heusel.eu, fabian@fstab.de, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
Message-ID: <20241104063656.GZ275077@black.fi.intel.com>
References: <96560f8e-ab9f-4036-9b4d-6ff327de5382@amd.com>
 <22415e85-9397-42db-9030-43fc5f1c7b35@581238.xyz>
 <20241022161055.GE275077@black.fi.intel.com>
 <7f14476b-8084-4c43-81ec-e31ae3f7a3c6@581238.xyz>
 <20241023061001.GF275077@black.fi.intel.com>
 <4848c9fe-877f-4d73-84d6-e2249bb49840@581238.xyz>
 <20241028081813.GN275077@black.fi.intel.com>
 <2c27683e-aca8-48d0-9c63-f0771c6a7107@581238.xyz>
 <20241030090625.GS275077@black.fi.intel.com>
 <70d8b6b2-04b4-48a6-964d-a957b2766617@581238.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70d8b6b2-04b4-48a6-964d-a957b2766617@581238.xyz>

Hi Rick,

On Fri, Nov 01, 2024 at 01:57:50PM +0100, Rick wrote:
> I compiled 6.12.0-rc5-00181-g6c52d4da1c74-dirty resulting in docking station
> not working.
> 
> Then I compiled 6.12.0-rc5-00181-g6c52d4da1c74-dirty without commit
> c6ca1ac9f472 (reverted), and now the docking station works correctly (as in
> screen output + USBs + Ethernet)
> 
> So it seems c6ca1ac9f472 is causing issues for my setup.

Okay, thanks for testing!

It indeed looks like there is no any kind of link issues anymore with
that one reverted. So my suspect is that we are taking too long before
we enumerate the device router which makes it to reset the link.

Can you try the below patch too on top of v6.12-rcX (without the revert)
and see if that still keeps it working? This one cuts down the delay to
1ms which I'm hoping is sufficient for the device. Can you share
dmesg+trace from that test as well?

diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index c6dcc23e8c16..1b740d7fc7da 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -48,7 +48,7 @@ enum usb4_ba_index {
 
 /* Delays in us used with usb4_port_wait_for_bit() */
 #define USB4_PORT_DELAY			50
-#define USB4_PORT_SB_DELAY		5000
+#define USB4_PORT_SB_DELAY		1000
 
 static int usb4_native_switch_op(struct tb_switch *sw, u16 opcode,
 				 u32 *metadata, u8 *status,

