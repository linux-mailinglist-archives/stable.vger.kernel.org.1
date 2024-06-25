Return-Path: <stable+bounces-55162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D5916187
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B241C2350E
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834C148FFA;
	Tue, 25 Jun 2024 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/9T1h6/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F91494A8;
	Tue, 25 Jun 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305131; cv=none; b=QnfWuN/0seBKfXfAhc6UDVF9oK9QvORjjai2mL7P9rufzEObynBsRmOZWzU7zD0uvTojOSfEjvNFsDnE8n9FbWYWXKnw+WHlbg7gdEkRmb9SpxEmH3zL6RrqclCfOGC4ZV8EuJWhogAcGMq3Yg7slrFditPt132bj09ptFPL9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305131; c=relaxed/simple;
	bh=PJ7qoNLMxD6KqwQ/QfoSzJR6/VgUz2vUymrfl28BKA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXO4jdVamwG98sm1ujRx/k7urv2KKCDIth+WPhsty295k+op+tLHWNksocL+22bZfgNH2vZSlW7KtDgPHXIM+LozB/CdySKrqrrYNJh6la0De6RfZhW+PQqCCrQ4RevRA+fx0Xx38jgkXdZjvrlNT3N2CjD3Da/ivPHg81ZeKdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/9T1h6/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719305130; x=1750841130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJ7qoNLMxD6KqwQ/QfoSzJR6/VgUz2vUymrfl28BKA4=;
  b=B/9T1h6/elhG3s7akUi+DsYIaib/Wt4WnBD5chOTockWR/E/A+mDR56i
   KJ6sh9YQCAU1ePhE6fKSyRGFMHTNkBhcPObViZut5EJiqTBXzJEsQQrk5
   oyi51O24jhMye0ZR8lxlv5M7mVL7kUK70YbzJlpkusliK3TPtM7Y4x8gr
   D5Cp6w9NTPjfjfipZVOIuE3iYJz64UJFs3va4DDK/rNLgCsV6GKVfTJsr
   VgNrb2dTCxzkR934zuz5l6RqR4nS8YFXKrEgv3hJ0j9WYSD5E+jUiS1gd
   E0CAsQbkhyclcD/MKFRKsPYrOTDxp/uHafaozR/6v4uaPvJD4fQME37du
   A==;
X-CSE-ConnectionGUID: PCL7iFyjQvGbGHADRajcaw==
X-CSE-MsgGUID: Qj3ECzJiSbqCtT1SOk+/Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33764667"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="33764667"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:45:29 -0700
X-CSE-ConnectionGUID: 39XEKaElSqq2h04uUxmuyQ==
X-CSE-MsgGUID: UBWWRTAXRY2ps2byQW9eZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43561256"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:45:27 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B04D911FA94;
	Tue, 25 Jun 2024 11:45:25 +0300 (EEST)
Date: Tue, 25 Jun 2024 08:45:25 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: tomas.winkler@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH v4 2/5] mei: vsc: Prevent timeout error with added delay
 post-firmware download
Message-ID: <ZnqDpRA_LzkAxdCS@kekkonen.localdomain>
References: <20240625081047.4178494-1-wentong.wu@intel.com>
 <20240625081047.4178494-3-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625081047.4178494-3-wentong.wu@intel.com>

On Tue, Jun 25, 2024 at 04:10:44PM +0800, Wentong Wu wrote:
> After completing the firmware download, the firmware requires some
> time to become functional. This change introduces additional sleep
> time before the first read operation to prevent a confusing timeout
> error in vsc_tp_xfer().
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8+
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

