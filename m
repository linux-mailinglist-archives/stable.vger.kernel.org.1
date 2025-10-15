Return-Path: <stable+bounces-185803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0D4BDE356
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B43CD4FE472
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 11:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68201F4191;
	Wed, 15 Oct 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Td+6CVGp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691F1CD15
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526441; cv=none; b=D0CFJyiXvhcZypSCngSVkjRa4bYepZciJf7t39hDm42Z2QuxUSBXiSPEjbZP5r6IfGmR9duZa23PV2Gw2uhRK2I/pgADEI5Wc8CLTYEUET0hfPAaRTZxE6JF3QMv1z6YGTg8x0wU9DcpOM17ZCzqDJsHNooxuoIMXlTQJEwOvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526441; c=relaxed/simple;
	bh=Y5nFKTxbbVkj56KLZ71XtvPF6VV9QcTORMl084Qpxc8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mNN7w3yk1yavoge8g3QDKc6OdV/oUx+PqBGuHuFtX20oRT6ekyMdSL3F1HTCaPm4bxFzMX4iW4fTdozj+4va122GJ11C/AYkulXMZqJ7XV5zUiyr1BMUn5y/4YQSQqiC7OnANMArPqUh771Ru5oViWcjOGGyCmMUoGNaOX7WbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Td+6CVGp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760526439; x=1792062439;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Y5nFKTxbbVkj56KLZ71XtvPF6VV9QcTORMl084Qpxc8=;
  b=Td+6CVGpnRO6XzyN9psBP5IzdhbtFEeOaFQ/9YByEwrq8IRFXB5Uyi/3
   tdwAxyoHU2QhAxiGKxuNFJeel1Rty2B8+N2lgm9cGnsxNomrwCWo6Wwqs
   1b3PQePx9Fovt4td22p4p2P17kn0xNcaZoIVmo9UQBOG0D/LUPyEOJVIp
   8MJL9Zge2ZU8IWP012Hec1iBdIilZBmoc8GisXfPTTRKb9/yn1htqe35l
   WS2JOORnbrxnGBzF/S1TkAuF1xRuI4xmPxUaF84munISArcSnDP1ri3+v
   oC9isQ9Feo4Se/QlX1E4DUvUfsjErd2RlJI28wRkdq7lT88lklz5kxv7S
   w==;
X-CSE-ConnectionGUID: TdvQig4dQ8eHl9TaESqH7A==
X-CSE-MsgGUID: fj5oiJSWTLuMdM0+3IxgYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62793415"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="62793415"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 04:07:19 -0700
X-CSE-ConnectionGUID: ULJ+Eco1RMK2yzfFawHZFQ==
X-CSE-MsgGUID: NssRSdjoQxW9asBI0qr5Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="213089120"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2025 04:07:17 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8zLf-0003l5-2E;
	Wed, 15 Oct 2025 11:07:15 +0000
Date: Wed, 15 Oct 2025 19:06:31 +0800
From: kernel test robot <lkp@intel.com>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] firmware: stratix10-svc: fix bug in saving
 controller data
Message-ID: <aO-AN5Eq_ZqAAXJx@87a0c2f242e8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4c4906e48979514e0e365b7785988e79db640b9.1760521142.git.khairul.anuar.romli@altera.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/1] firmware: stratix10-svc: fix bug in saving controller data
Link: https://lore.kernel.org/stable/a4c4906e48979514e0e365b7785988e79db640b9.1760521142.git.khairul.anuar.romli%40altera.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




