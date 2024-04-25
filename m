Return-Path: <stable+bounces-41438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F6B8B24EF
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 17:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7C0B20F05
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD514AD15;
	Thu, 25 Apr 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9RIv4Z+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED961494DB
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058466; cv=none; b=G6n4tzyItzFh5VxNZwuaOi9DWiO0nfrpjr9MG+/p3NUxGt4M/oBcDEnPcbY8z7sazm5R7MSjD6nmCVWpv/TRKeSq5lJ/YQHTtKFuaWEnMvbKLGrDFuCTbOeCMrkm5o4rEIzhkdqp9feeyDiTVjKK1E2I67x+qaAYUmgJULgoy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058466; c=relaxed/simple;
	bh=JloY/B/gDmMJyEDYcyExOhbAHwiS5rnHujtDvj33j9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a4uwJDTQlY5hPfDzRDFuG5TJ2phLp7V+hc29NhkvBQFv5F6jjKAtA4nHOhnUlmWwJpDKq92XEQ//bZarHRw8HX3xpgTFkc6xJL7MqXf+zUJ8Ptk1xIBlKqCBg7WdczZn1CuhohuUCFkYehKW5Ow5K1aWLR5xFFur4PWT+gPHn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9RIv4Z+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714058464; x=1745594464;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=JloY/B/gDmMJyEDYcyExOhbAHwiS5rnHujtDvj33j9o=;
  b=F9RIv4Z+PAjAGkMrGBxVcUiGLC65lWylIdXudxnP/cmKiLDfVlq0deSG
   GSrbSpIRDZa5UHgSYfrDOlfVUrqYNaz+2bc1EuPi34euwxCc5PQ0gR206
   1o7n3d5Bqq4bQeshZNZOGtRs74xXL9OIGPVfRE3MjER5xg/SxLr8qoB/B
   kxQ157ZoU9OIxm0pfA72wzxO/GccDn3bTe//qoJVwn37YEDtfRCpaBLNe
   7ZUhiDUgWnJUcJwmHlyowAhBGp5v/8l8fsAOA/NNgIzEtUG6VYAAZX13d
   asneX5Oi1/977j77XGBqIK8Yejp8DmugeED5WZkeXgeb/phI42amWY9Rv
   A==;
X-CSE-ConnectionGUID: 6Kc5ngeyQhOELkPIYhhwCQ==
X-CSE-MsgGUID: VQqtYMQMRXmhUgnMFql5Uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9873246"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9873246"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 08:21:04 -0700
X-CSE-ConnectionGUID: X6UyI1WISRyz6cqVj9zc4g==
X-CSE-MsgGUID: hTtEuiVNSLK+qhSgQik2WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29567185"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Apr 2024 08:21:03 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s00uC-0002Uu-0r;
	Thu, 25 Apr 2024 15:21:00 +0000
Date: Thu, 25 Apr 2024 23:20:55 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Wulff <Chris.Wulff@biamp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] usb: gadget: u_audio: Fix race condition use of
 controls after free during gadget unbind.
Message-ID: <Zip016sIIls1j7aK@c8dd4cee2bb9>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR17MB5419C2BF44D400E4E620C1ADE1172@CO1PR17MB5419.namprd17.prod.outlook.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] usb: gadget: u_audio: Fix race condition use of controls after free during gadget unbind.
Link: https://lore.kernel.org/stable/CO1PR17MB5419C2BF44D400E4E620C1ADE1172%40CO1PR17MB5419.namprd17.prod.outlook.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




