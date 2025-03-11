Return-Path: <stable+bounces-123601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD6A5C682
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480073BA45E
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2539025F7A7;
	Tue, 11 Mar 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dnabxw6E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73C25F7B0
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706424; cv=none; b=hZ7DoXwvbrmmYoztCxCRju14tVsM/8Cyd95luBdUNqt0db1VmQ0HQtoTORM/W1cfaW9U6DdqwtfOmRSJaJ5W8uvdhsTmtJMD4P6SS1fdxrOlDxrUa2b5DkdgIFDDuYwheTVdSycIyDcZcrPa9d6huh1hwfNSUwbbM2Lu+8CWGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706424; c=relaxed/simple;
	bh=xRjIih1Spyxz0wKNTHphFJaztHIt/IrumX1ZTK75y38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AKo1gYR9ug0UuYkDskbhPRgrJH4KTw4qf7VgybzrjpwcEoNqdBB/w0o+dPqJwkmwO3AZML3Oaldv8+HFflX0oewHlOjXjme2eztGukQUsm6uYFs5+yqcUd28w+ZyeGTNJBwTqxoqhADINZgyMyZNOJVP+i4MeSPG3J9vw/Ii1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dnabxw6E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741706423; x=1773242423;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=xRjIih1Spyxz0wKNTHphFJaztHIt/IrumX1ZTK75y38=;
  b=Dnabxw6EW5w+KayygqACBomFTHskVJwqWHZpE9R+G45ifWxmtpgr+XpW
   aa9eSmHX6/kYPntbzB+tnTCFs+x34DoHZSvWmYF7HaGeM/oB2ObSemNTO
   nNbIBtile4ae2xRy94/2Dd3HQPOZ1j7PXR05/OFX3JzIJy5kGTTQMPtOm
   kLOJegQK8C8qWOxEEZjZtVRwEwONCP1dI+QtjJ8bQ/VaY0k+E4k3AKjtI
   TI38ioqdwAtidYF91DsrW0NPhr+9dT412vmJ2ERsaeK3YFnOOxoIE/Qov
   lbFESmALlREqiL2u629ISTRoBM0guajX6SjKOrxID9yPj4wLQ4V1VrPEF
   Q==;
X-CSE-ConnectionGUID: pHWC2CfrQMiu8zrXhdM+sg==
X-CSE-MsgGUID: 4FXbc62ZQJq1mqGNHivliw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53743746"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="53743746"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:20:22 -0700
X-CSE-ConnectionGUID: mmrdXqLVT6er9Epe//cJ5g==
X-CSE-MsgGUID: l4kOcfeKQMqYxKjliLusoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="157556808"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Mar 2025 08:20:21 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts1P1-00071A-18;
	Tue, 11 Mar 2025 15:20:19 +0000
Date: Tue, 11 Mar 2025 23:19:21 +0800
From: kernel test robot <lkp@intel.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] fpga: bridge: incorrect set to clear
 freeze_illegal_request register
Message-ID: <Z9BUeSAqxZU_aabC@59514bb59f20>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311151601.12264-1-tanmay.kathpalia@altera.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] fpga: bridge: incorrect set to clear freeze_illegal_request register
Link: https://lore.kernel.org/stable/20250311151601.12264-1-tanmay.kathpalia%40altera.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




