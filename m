Return-Path: <stable+bounces-238098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOxNDxVy32mFTAAAu9opvQ
	(envelope-from <stable+bounces-238098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:10:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC34039A4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB6D730469A9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AFE36494C;
	Wed, 15 Apr 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqcd++Kc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F41DDC37;
	Wed, 15 Apr 2026 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251402; cv=none; b=sHB8LTsJyduQHuhnBEQMLuF9047pXT0zie/kHwXJ1hqpN5F6NyoFSJFZPc4MyTzbEUIIEoqBpwSStVPNRNylu2tP7DjgZCAWAqRBpqBQt1ubFowi36lBeV74kwqqtq/h2nWQo70XP8IzzSO/hOymyt58xA9fOFcYevXus0X9U4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251402; c=relaxed/simple;
	bh=zYISl4YymA6/eZuqTpBh/rfh+fOUzsz13rpCC8OY6V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy43weZoV6g5AxrEk44Ww2BTcKMDeYO/gUKbXQ9WJIicojXnd3esT3w9BA9709FTXs0e+SaOrJ6JYyHycyWPuSfkoBhGPopD/GxF5nHL/Jp/26P5LA68/PDkcSZfHsj6wa3xB66JPfwNVSE79y2crYHTG/uQampEHWs6m2AVGbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqcd++Kc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776251401; x=1807787401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zYISl4YymA6/eZuqTpBh/rfh+fOUzsz13rpCC8OY6V8=;
  b=hqcd++KcA7zhwP5ztzfeHt6lzZmdwWZwx/ebRVMKkvkk1u/7tRI81Jcn
   FaV7SODX4CWFyp4XqNh8t25MqYu773HWQ7+8vu4RemWd/ehdQNszWx7JR
   lW8IlxqCVZC7tyI2DHgrMq/TK7drK944TqOxQfFCI5uMqs+wClW5FFvxa
   AMTNPX6T2Dw5gCfPjNcbs/YOfkaHzXD8s8E9zFgBrLO5zMExOEkmXx8Ll
   18ZS1Na69H5EwlrexO1pYLwRmwsgeOX9Biip9KAl7Lp9GxEOssjer67qq
   KBhojTKPEW9HLG/Uhjr2dvuH6Bx1BWMCXM9m+RfUER2IrunNpsfwglT3t
   g==;
X-CSE-ConnectionGUID: ZX6wt3OPQjK63f9ZD0VUmw==
X-CSE-MsgGUID: L36afjqwQ5OWp/+NkZTLLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="76256665"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76256665"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 04:10:00 -0700
X-CSE-ConnectionGUID: QrNsoN+gSWKbOlpE4G79ZA==
X-CSE-MsgGUID: lD75H1XmRnuQeEwDr7YlWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234425047"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 04:09:57 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCy82-000000000QT-3cBT;
	Wed, 15 Apr 2026 11:09:54 +0000
Date: Wed, 15 Apr 2026 19:09:45 +0800
From: kernel test robot <lkp@intel.com>
To: Pavitra Jha <jhapavitra98@gmail.com>, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, w@1wt.eu,
	chandrashekar.devegowda@intel.com, linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: Re: [PATCH v2] net: wwan: t7xx: validate port_count against message
 length in t7xx_port_enum_msg_handler
Message-ID: <202604151900.1tnLdQi7-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,1wt.eu,intel.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238098-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7EC34039A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Pavitra,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v7.0 next-20260414]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavitra-Jha/net-wwan-t7xx-validate-port_count-against-message-length-in-t7xx_port_enum_msg_handler/20260415-014321
base:   net/main
patch link:    https://lore.kernel.org/r/20260414153201.1633720-1-jhapavitra98%40gmail.com
patch subject: [PATCH v2] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
config: loongarch-randconfig-002-20260415 (https://download.01.org/0day-ci/archive/20260415/202604151900.1tnLdQi7-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604151900.1tnLdQi7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604151900.1tnLdQi7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c:127 function parameter 'msg_len' not described in 't7xx_port_enum_msg_handler'
>> Warning: drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c:127 function parameter 'msg_len' not described in 't7xx_port_enum_msg_handler'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

