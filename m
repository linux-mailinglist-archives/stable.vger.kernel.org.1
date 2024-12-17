Return-Path: <stable+bounces-105032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740119F55A4
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C367D176CAD
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB51F7568;
	Tue, 17 Dec 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/+kpfm+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFA1F8902
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458314; cv=none; b=ileVGs2WLAo5CxhdTpq9YfeADPHsn33AhBR07764AvLRptrlaDffSr0HJou9tFj3E+mRv39qKgO2a+0SjgaLLqgtF3TbW4OijhR7t4Rqv7qbcQ7UtHJ9Ufzdf/ipuK0oESrXWJPyeZBuYwQW717vLdqCScxrkWwKIdxfr232ueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458314; c=relaxed/simple;
	bh=mS6Ki+BRL7H8sAwN9At5mj6UFheQBZ4TC3FNI75AG9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK0M4Euf5QzOSz+n89cLRWlThQuF87HKuQ5yUuxTranfwJuSgTx2XC1Ft+NPtZgmi9qCbTrE0k3XDRGSwXJiAWO9fsQJrB79y0Y0x3fc5BV5qPDEFuT2F/LP/d3UJqsN+KAjpOu1xVBly6DEMB+PwFs/G564dQkFkv1v6JharSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/+kpfm+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734458313; x=1765994313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mS6Ki+BRL7H8sAwN9At5mj6UFheQBZ4TC3FNI75AG9I=;
  b=D/+kpfm+W9bOkYNRaxQjj5knYlwJiSaU9+WDFXLODKnJGb93lHusCvzm
   jGFIRdZIyXyvBDQ12ns7LH7sfZ2f70NqWEkS0A1BKIhuAdLXiL2ZYRgao
   MdgVfvThx7m2GwIv5A2kPP71B3AXCaFZBeE9pMHgem1WjbPNscWFsYDj1
   D85ktosgnXMm803+ok8Ho3ZLUDjcPAe6wUNjETKO3Hqb/GDhm+WYpfPYd
   8B+/Co22Eq/4KmOCk9up6UAL0h/8R15/mNXvebzmF456uN7S4zgwRJAzn
   hxrbHHVaLS8yorNLv+LAh8pipg6pfMsdJwEH2sSpFPY8aM61/48o7ErwX
   w==;
X-CSE-ConnectionGUID: 66A5pjHNTWKTBgw6SWF4Hw==
X-CSE-MsgGUID: RZzia8Z2T1CFIp68Kpv6wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34805599"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34805599"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 09:58:32 -0800
X-CSE-ConnectionGUID: Filkew7lQqC6LT6ciK2K2w==
X-CSE-MsgGUID: iHcI7jgbT6KTR86TdYaYqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="128416996"
Received: from carterle-desk.ger.corp.intel.com (HELO intel.com) ([10.245.246.58])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 09:58:30 -0800
Date: Tue, 17 Dec 2024 18:58:26 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Jiang Jiasheng <jiashengjiangcool@outlook.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] drm/i915: Fix memory leak by correcting
 cache object name in" failed to apply to 5.10-stable tree
Message-ID: <Z2G7wrn4rKdjRk3o@ashyti-mobl2.lan>
References: <2024121517-deserve-wharf-c2d0@gregkh>
 <Z2ArIdUSYWZofqt-@ashyti-mobl2.lan>
 <BYAPR05MB6406014F80159A032E3D7A74AD3B2@BYAPR05MB6406.namprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR05MB6406014F80159A032E3D7A74AD3B2@BYAPR05MB6406.namprd05.prod.outlook.com>

Hi Jiasheng,

> Yes. I have submitted the patch for 5.10 to stable@vger.kernel.org.

Thank you!

Andi

