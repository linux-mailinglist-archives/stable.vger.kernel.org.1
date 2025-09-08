Return-Path: <stable+bounces-178849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68984B483B1
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 07:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FCC57A12BA
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0BA1BC41;
	Mon,  8 Sep 2025 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHYWqqKg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1EB1B0437
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309996; cv=none; b=DWaxLAk9/oMKvpzla9f4+s6z0NGFWPR/LAhZvAwP7vkOdLWUpXTlDtV1uL2j7Sg/viOSNZr/r6wZS/ISrT9w93j5wXfgPzwXgAHt2M0pWeDheIplOe0nnHrH0DCHAyZMBX8yulqaiwf8rYTYKvOybtJmUOE5M9bHCtJdhrIR1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309996; c=relaxed/simple;
	bh=9UirNUjPJtdVex0c3sdBlSNioP2vpZReRtQYL3XxdMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JLv8xjqL4hnQqx/0yjMuQ9eaY0Nh6tzkUcYCKS4EwHaL33anaWdFc3qYLMRcWbwi8Ote7NBPNrYIZpGpNGxToKmjs4K+Brynl6JzyNKxNBNL9VGdEOj3N7grg5uiPZDqo9YBURkq3j8mF2ab/esWeEQwOGNxkMSLFhtq5hQQDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHYWqqKg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757309994; x=1788845994;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=9UirNUjPJtdVex0c3sdBlSNioP2vpZReRtQYL3XxdMI=;
  b=eHYWqqKgLvyWDAukeR9X+EHf57vyxsY6vHAy5gaTCL83HRUQYjHyYV7Y
   b6QYduP1xepuJ1aWqTLfXdAXDnEHV/qywD0S4+0I2AOSmgu7LTtacfI1h
   ZgYRA2oKzPXa4DgWGLjZ0oM4ukYigbhWtSyQZqezW+8VQw2GjDoFJYRGm
   MHkKUHNebZe4uZEuL9/Xm9TXu3L+Ew15V7Fl3c4qRbd3LVDO+55IbnhJA
   u1qedFQMvtZh0hNchCpDUNHzuh4ljLOdwKlqzaHrBS7JSI4P+4kPx4aRC
   ZwakXh/xOucpqHVgYacpG+BGXeTLZA0anAA7n/xjc3qL/5VwwN2JFj1oK
   A==;
X-CSE-ConnectionGUID: C/OmDQ58To+PsAIO9UO0wQ==
X-CSE-MsgGUID: WYZqnhVkQqixBHcydFVQOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="70657151"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="70657151"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 22:39:54 -0700
X-CSE-ConnectionGUID: zNJFz7BKR7K7i0gzIF2AYw==
X-CSE-MsgGUID: P5xnksVCRJim3KsPyRPo9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="172815477"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Sep 2025 22:39:53 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvUbW-0003XP-20;
	Mon, 08 Sep 2025 05:39:50 +0000
Date: Mon, 8 Sep 2025 13:39:16 +0800
From: kernel test robot <lkp@intel.com>
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 3/3] ASoC: qcom: sc8280xp: Enable DAI format
 configuration for MI2S interfaces
Message-ID: <aL5sBHUqOcdItTqG@af736d05e5f8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908053631.70978-4-mohammad.rafi.shaik@oss.qualcomm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v4 3/3] ASoC: qcom: sc8280xp: Enable DAI format configuration for MI2S interfaces
Link: https://lore.kernel.org/stable/20250908053631.70978-4-mohammad.rafi.shaik%40oss.qualcomm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




