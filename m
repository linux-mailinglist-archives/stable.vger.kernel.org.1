Return-Path: <stable+bounces-142815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF5DAAF566
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 10:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC673A7B76
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D54221FAF;
	Thu,  8 May 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8SGxtd3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BEC21D5AF
	for <stable@vger.kernel.org>; Thu,  8 May 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692355; cv=none; b=V872++RqKJxJAHEeyDNYgAfgHU1Tdsla2e2tIr2UhnSAmGPZZco/Av/TwBK/N0R2FI4Qm84Gr0MSSHV3PTwi1FunxMJtirk8Ya5vSDGiT7dwfbjyKM487XAL1MhkFj73wzD4SfalzhNGZhImTVKKLUhy6iUWzSWnkZJe1FbV+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692355; c=relaxed/simple;
	bh=2xNax2J4+nAASCdA1MqY9GPbWKMDyOOiS1aYTzdLIB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QpN84xgL594TPqlbwTl14CDrcJFOjegcGc3t8P3E3QqbtwNfNUwGlPRbLgvMC/Ln1CeEEOWXNH2RDUFLqYxt1gB+uOAevlLN3xtPd9BEqx6SRfDTtR+82K0BHUiHfC/h0UY5IuNPX+pdQ7k3k5u3IYGFkMqQpBG8801bem/dnik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8SGxtd3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746692353; x=1778228353;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2xNax2J4+nAASCdA1MqY9GPbWKMDyOOiS1aYTzdLIB8=;
  b=H8SGxtd3gtaXHKzTh67XZP6hpoZ0WrIQWtBEUsQgi5RYPAkpgZVuGPm9
   v5M5nD8dwnWgBxoplDD1NdOFEuXtUnhenyGoKOKWt0K8fqvpn5nlKu/1I
   r70f6NhAaqwO/sMu2oSiTwZPPMR5sOM1a+jI3eNRhRXC9JX1r0UGOWJ6i
   x9Wlbdy3TCOOGGQHMQpXJX7C5hC6s/E27pZ3hf5QRWq841CA+itd0+nd9
   Ikkjnz2CplqFE88rEhSh+//2uSjZb+hPTQgtiZpx22wFrCag+bnCeBBkS
   PN765cSt4T3LYnFYXKh7BZ01UN5sdv2I15dQR0XqewkqC7DgZB6KTCocT
   Q==;
X-CSE-ConnectionGUID: 2Ja1TK+FShCvDlGIZ/zugQ==
X-CSE-MsgGUID: uOmUuE19Qee1prH1DazcKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="47562080"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="47562080"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:19:12 -0700
X-CSE-ConnectionGUID: YoUYGevsSkWBR1THiPiWhA==
X-CSE-MsgGUID: psdPB6TVRiijWwhiBcengQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="159534086"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:19:11 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, mario.limonciello@amd.com,
 harry.wentland@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/dp: Fix Write_Status_Update_Request AUX request format
In-Reply-To: <20250427095053.875064-1-Wayne.Lin@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250427095053.875064-1-Wayne.Lin@amd.com>
Date: Thu, 08 May 2025 11:19:08 +0300
Message-ID: <877c2rv7k3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 27 Apr 2025, Wayne Lin <Wayne.Lin@amd.com> wrote:
> +			/*
> +			 * When I2C write firstly get defer and get ack after
> +			 * retries by wirte_status_update, we have to return
> +			 * all data bytes get transferred instead of 0.
> +			 */

My brain gives me syntax and parse error here. ;)

BR,
Jani.

-- 
Jani Nikula, Intel

