Return-Path: <stable+bounces-238132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPKWENiV32leWQAAu9opvQ
	(envelope-from <stable+bounces-238132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:42:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5F3404F40
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A0C931148D3
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0659C2222D0;
	Wed, 15 Apr 2026 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CH2Yq5fs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6633F378;
	Wed, 15 Apr 2026 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260303; cv=none; b=Td2AJpZulapfEaAB4tSqOZgh9UTvDD6zIHcphaDXtmuvIZcn6gxNbELbs4vuyNjaCDImKrJax/4LK/cUehFgJ4KUVjkaNQcfWZO+q94rPYu+ogp3wI/w7BAPt2NOhIfFzehpB2gspWc8ajtaXYWMfoZWs/VoQiVQjXUL39Hhcuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260303; c=relaxed/simple;
	bh=bZqt6vLbbY7wV9vBAY98g6ZXIP63PameKJz0SxWrAgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpxcgi81Ranpq8UfmwcGEtmN6bmSKjPRjcbpWTkPxRv6X6nVzeVpcbX0+rvvQJtAbiQaHy23tK3PbYAzcwlTs3wJF59zfempf8r+bG1wfqjwKX6iQT6/+31sZQTyglO+YCZgy5aVOnU4ZcpHuqCA2A5AmEUtBEx4KU+kHJijX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CH2Yq5fs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776260302; x=1807796302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bZqt6vLbbY7wV9vBAY98g6ZXIP63PameKJz0SxWrAgE=;
  b=CH2Yq5fsUJgqAQPn8f85HRgtahDvOd267S7cyImXNI9EDQNciOdmcfBw
   EkagcSnZDImaB77joJw66BlGb9srssHvDx9ckASd7CjCjI8NNwNjRSBtk
   kVvC8wfIaGg4w3P8jvtgZVa/779JEltQYcAJ4cTTil4z00CGHM7TrEjPD
   hMuXoONiYZny4XnROK6Z7XyzND7FpK7ksL1+7cwMl6u0Tk7hJkbJXnMpr
   EessYY7i14GyB9WxF1AJ/S56qojdABpONU+gmAJKyTQnpSCqKfqfRDBEQ
   LH0c3ifTRteRVugb4XTfuArTkRw9i3rDgiSk6VURFy212y7mHakaFRvvb
   Q==;
X-CSE-ConnectionGUID: Hh/xPqGRS/iEPQyfvchGIg==
X-CSE-MsgGUID: yYuoigTnSpqQQHI1+xzU7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88615723"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88615723"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 06:38:22 -0700
X-CSE-ConnectionGUID: rK1wKLmkSD+RjgV8lrGs2A==
X-CSE-MsgGUID: /u+gW7pHSaqh7UMzNKJWwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235367890"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 15 Apr 2026 06:38:20 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wD0Rd-000000000kz-2PTm;
	Wed, 15 Apr 2026 13:38:17 +0000
Date: Wed, 15 Apr 2026 15:37:31 +0200
From: kernel test robot <lkp@intel.com>
To: Pavitra Jha <jhapavitra98@gmail.com>, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, w@1wt.eu,
	chandrashekar.devegowda@intel.com, linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: Re: [PATCH v2] net: wwan: t7xx: validate port_count against message
 length in t7xx_port_enum_msg_handler
Message-ID: <202604151531.ClMVCCxv-lkp@intel.com>
References: <20260414153201.1633720-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414153201.1633720-1-jhapavitra98@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,1wt.eu,intel.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238132-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC5F3404F40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Pavitra,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v7.0 next-20260415]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavitra-Jha/net-wwan-t7xx-validate-port_count-against-message-length-in-t7xx_port_enum_msg_handler/20260415-014321
base:   net/main
patch link:    https://lore.kernel.org/r/20260414153201.1633720-1-jhapavitra98%40gmail.com
patch subject: [PATCH v2] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260415/202604151531.ClMVCCxv-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604151531.ClMVCCxv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604151531.ClMVCCxv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c:127 function parameter 'msg_len' not described in 't7xx_port_enum_msg_handler'
>> Warning: drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c:127 function parameter 'msg_len' not described in 't7xx_port_enum_msg_handler'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

