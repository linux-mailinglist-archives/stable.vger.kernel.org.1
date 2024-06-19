Return-Path: <stable+bounces-53860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87CB90EB8A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A38286A24
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4F14A4E2;
	Wed, 19 Jun 2024 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CW53Lf1u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A5146590
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801887; cv=none; b=vGcqvpNh6+9mvwwoEJ8z+J/Q3og6VcYEieiz5XUFOmqc7YULAfzdiLpZ3IPsC5Z1YgMsV2W141yGU/S7hqNJm8xHedNnATZ14rHgQeH91oCK6kHyzroJFYMZfI7a6WlizFr6Ug507yzGfsbcfHfqoRyTZxM6AAYCiRuG8nbOoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801887; c=relaxed/simple;
	bh=HW3CNf4DL2oRuR0s7iYbNLA7/rHWu4DQp1ou2n9hvMo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jMGb+eQoQw03izZiSwLF7EJikHQhsu/NOq+58U3enx1H6/fzU/xsvnbxSL3QXLG0Ss1HPP1cKO+eQtoOr7VKEAF3IChst4oO9Fx4hsm7xwB7fTPrDEh6f+1N3m0ShzGGrdNafxOdp152A/h/87rfzqqHX+ugb1AcwI6BrzdChZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CW53Lf1u; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718801886; x=1750337886;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=HW3CNf4DL2oRuR0s7iYbNLA7/rHWu4DQp1ou2n9hvMo=;
  b=CW53Lf1uLkQpSQ9SwmZfgdWsR8nM//L/Eafn4Hp6c3DQ7uJgTyhybFSm
   y7zIBvotDO64SihlfneF2H1v0Lbs/DH3g2+Ln6XvGNUy6akt4JBa4S2vQ
   c2CxuwQmWbEu8+olJiBX5w8nmq9XgljewBRBrzZW0mozxyXdVYYXlnYKE
   02J8cH/B2S2foeAOBL9dTmRcffgYGlm4BpnvJ0XjdJFLwDb1KMgLkNBKe
   sotaKCTOBeXRtBIXbO34CTLS/xN+H6P6WnNIi+4PPpy0b9DDD4hhjOJv+
   Nhjiev0tGPuSHe/aLFobbHvgs3WA4ihT2JMp3WRAgr1vpUK0GucveFPql
   A==;
X-CSE-ConnectionGUID: I/d7A8zuRDWgNIZ0vyj3AQ==
X-CSE-MsgGUID: k9AbVyfWQFmY8rWm7Nj+bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="19558996"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="19558996"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 05:58:05 -0700
X-CSE-ConnectionGUID: l/iCYzhDTBO76Ywg9Gq2cA==
X-CSE-MsgGUID: e78MO9iWRmGvKDm7JPcMVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="46856624"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Jun 2024 05:58:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJusz-0006bC-1t;
	Wed, 19 Jun 2024 12:58:01 +0000
Date: Wed, 19 Jun 2024 20:57:10 +0800
From: kernel test robot <lkp@intel.com>
To: yangge1116@126.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mm/page_alloc: add one PCP list for THP
Message-ID: <ZnLVphyq95in72jq@6715f18d4702>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718801672-30152-1-git-send-email-yangge1116@126.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mm/page_alloc: add one PCP list for THP
Link: https://lore.kernel.org/stable/1718801672-30152-1-git-send-email-yangge1116%40126.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




