Return-Path: <stable+bounces-55161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B391916183
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6342861E2
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED1B1474B8;
	Tue, 25 Jun 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tc/NBH7M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B345038;
	Tue, 25 Jun 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305123; cv=none; b=Itasc2rfBa4o59Kb/Wk+QekN4yMlqo94Ls3vXa0Ds6Hnosg0Qwu5i3p1ifJYCdfsPmDKy6dAeIoV4zaqsileOW3vTzeaIE8McbhHUzknYGMYCH7c/you0PyoS6+jXp4pO2WGhfTpxvQ7jP7WJXHHDS84z6bN8XHILy7rrMkaIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305123; c=relaxed/simple;
	bh=mj1NnDHMlm+CMxrJ5SMFcXe/X9knYSfeszcPN6HgYhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWPVHdoO/fEP0KJOX78Pb/zv0RkJwHf9pN6eJ7P6LPL1eFcpOZ74Fs1kOuly3Fxa4BdMsWJEUAxEKiLI9g1Z/cL+e1sWb9Etp8nakYQA3BfqjRBEb830hDrVHxW/bM2mJj2xk+4Kc4xV5Hr9Q3JZ1CVLC7aYo/E4UKm7QKEIm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tc/NBH7M; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719305122; x=1750841122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mj1NnDHMlm+CMxrJ5SMFcXe/X9knYSfeszcPN6HgYhY=;
  b=Tc/NBH7MZfEZLK8i+6+wdGr2/4u1NWw8c7IjhZB3CniFgsuWbzX3spQd
   Z4nJ2cT/mYt17vIhGMclf4C9/2zHlMAMzu3Y1UcKrFzd+u+k3Mp9tuhbi
   Rnw7GC3xCT886WnFB3YAn/qJm7NTVRWnHX/eC360BqAnldF1l0h0YkGNZ
   iO9bR13FNRKIDW2CrQFuLYTWGo9GawczzdNRuyphVpfbGXDWF4uVCjChe
   vf3mqOmTQV/AsfpeLqWQyXxZwfcU9+FbAFIZ9voRGL8Df+vxXURYl6XAQ
   0RqzqyDC8taQ4w8ZGKJFBH3/XmQ8Ka6lnU9eQSCHr1qVCDFjvEaPzQ+Tv
   g==;
X-CSE-ConnectionGUID: KefOEmrWT02qV2dY3l+SHQ==
X-CSE-MsgGUID: OBEj+FEFQiO9E/5qKt+ERw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33764658"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="33764658"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:45:21 -0700
X-CSE-ConnectionGUID: Q9+y8qckTQeEaohFZcpPng==
X-CSE-MsgGUID: PIFM/bOSTtW4gaN6GRZ+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43561242"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:45:19 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id EC8AF11FA94;
	Tue, 25 Jun 2024 11:45:16 +0300 (EEST)
Date: Tue, 25 Jun 2024 08:45:16 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: tomas.winkler@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH v4 1/5] mei: vsc: Enhance IVSC chipset stability during
 warm reboot
Message-ID: <ZnqDnDisvzc9FTyH@kekkonen.localdomain>
References: <20240625081047.4178494-1-wentong.wu@intel.com>
 <20240625081047.4178494-2-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625081047.4178494-2-wentong.wu@intel.com>

On Tue, Jun 25, 2024 at 04:10:43PM +0800, Wentong Wu wrote:
> During system shutdown, incorporate reset logic to ensure the IVSC
> chipset remains in a valid state. This adjustment guarantees that
> the IVSC chipset operates in a known state following a warm reboot.
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8+
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

