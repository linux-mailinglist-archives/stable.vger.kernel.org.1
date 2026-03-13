Return-Path: <stable+bounces-225370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Hj3A5BLtGk4kAAAu9opvQ
	(envelope-from <stable+bounces-225370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:38:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E93288326
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03F973008268
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304713CB2F8;
	Fri, 13 Mar 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZKyS8zm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164643C7E14;
	Fri, 13 Mar 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423499; cv=none; b=lWDHUWrCK7tjSqGkqu8stbWcE5HP0jQQGJUSewIJPekJBQVnPhHas0hDcKoDZciX7Ub48h4a1pbDKrYlKa5YUi4cREg+xuCE5UxB4zttfF7/EucNlCq2RNhAIcu93I9LWIdPkQsMfbhA2stRK3rBmT7wVQDPsZT4rOnV5D1dXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423499; c=relaxed/simple;
	bh=XTcmNKxQOYv/ODEIJ+6aq3vYnvqwEosHnYKM0NBNPyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEVbfZrzacv3MxOzTgH1zPQAahbjdanUtLKTYrXpDW979sq9wyxhfmMedec3cq5COxKEyQjwplCdSDozQYtMGNVdFIr+sXboqL66B8xBqvH4CUudp8BNawxMMDH7GJnMzfMQqJqO8El6rU8mgMok+SiutxTIfnTicqmvDP14pLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZKyS8zm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773423498; x=1804959498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XTcmNKxQOYv/ODEIJ+6aq3vYnvqwEosHnYKM0NBNPyI=;
  b=DZKyS8zmY+Dq+uXNSFtiwzg8v29uAfzMjfCeEBNqMy4VRxfSdw5BoNza
   py+S+L66gdMlmTG+n1f4PJtArk7KSyeas4F+cgIPmd7wkA68HknmwGfeT
   YNPHJqI89WJ/TNNCulnCUhuzBnFMiejWBNKO+7rElbu50kcWBdB1+6YaU
   ko1j85czMpVNdr8nodMBmAXpjpIzwD7CGknB4HrncL+wtUacCmDofX7s4
   SCoiKQz976kVaMafvoJRbsXk6DDGWm95E8ajys64151LUudpQOxVolj9b
   R7O+2NW61SC3rXG9ZmldGW+H+b5OEg3vurM0TgQ70cLo956PBYBg3Yssc
   Q==;
X-CSE-ConnectionGUID: NSxr0kdJSFaVV0Ott95PbA==
X-CSE-MsgGUID: qG0WWof4SVWFErtuAygwCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74415617"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74415617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:38:17 -0700
X-CSE-ConnectionGUID: rT0sjaKIQ1eKnBrBuuknew==
X-CSE-MsgGUID: CHraJtiFTNKoW/DwMKNSbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="226218180"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 13 Mar 2026 10:38:15 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w16Si-000000003gh-125h;
	Fri, 13 Mar 2026 17:38:12 +0000
Date: Fri, 13 Mar 2026 18:37:45 +0100
From: kernel test robot <lkp@intel.com>
To: Nathan Rebello <nathan.c.rebello@gmail.com>, gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
	heikki.krogerus@linux.intel.com, kyungtae.kim@dartmouth.edu,
	stable@vger.kernel.org, Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: Re: [PATCH v4] usb: typec: ucsi: validate connector number in
 ucsi_notify_common()
Message-ID: <202603131813.ofOSyCrk-lkp@intel.com>
References: <20260312211503.1915-1-nathan.c.rebello@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312211503.1915-1-nathan.c.rebello@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.intel.com,dartmouth.edu,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225370-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: A0E93288326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Nathan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v7.0-rc3 next-20260313]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nathan-Rebello/usb-typec-ucsi-validate-connector-number-in-ucsi_notify_common/20260313-200729
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20260312211503.1915-1-nathan.c.rebello%40gmail.com
patch subject: [PATCH v4] usb: typec: ucsi: validate connector number in ucsi_notify_common()
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260313/202603131813.ofOSyCrk-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260313/202603131813.ofOSyCrk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603131813.ofOSyCrk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/usb/typec/ucsi/ucsi.c:11:
   drivers/usb/typec/ucsi/ucsi.c: In function 'ucsi_notify_common':
>> drivers/usb/typec/ucsi/ucsi.c:50:44: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
      50 |                         dev_err(ucsi->dev, "bogus connector number in CCI: %u\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/usb/typec/ucsi/ucsi.c:50:25: note: in expansion of macro 'dev_err'
      50 |                         dev_err(ucsi->dev, "bogus connector number in CCI: %u\n",
         |                         ^~~~~~~
   drivers/usb/typec/ucsi/ucsi.c:50:77: note: format string is defined here
      50 |                         dev_err(ucsi->dev, "bogus connector number in CCI: %u\n",
         |                                                                            ~^
         |                                                                             |
         |                                                                             unsigned int
         |                                                                            %lu


vim +50 drivers/usb/typec/ucsi/ucsi.c

    39	
    40	void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
    41	{
    42		/* Ignore bogus data in CCI if busy indicator is set. */
    43		if (cci & UCSI_CCI_BUSY)
    44			return;
    45	
    46		if (UCSI_CCI_CONNECTOR(cci)) {
    47			if (UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
    48				ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
    49			else
  > 50				dev_err(ucsi->dev, "bogus connector number in CCI: %u\n",
    51					UCSI_CCI_CONNECTOR(cci));
    52		}
    53	
    54		if (cci & UCSI_CCI_ACK_COMPLETE &&
    55		    test_and_clear_bit(ACK_PENDING, &ucsi->flags))
    56			complete(&ucsi->complete);
    57	
    58		if (cci & UCSI_CCI_COMMAND_COMPLETE &&
    59		    test_and_clear_bit(COMMAND_PENDING, &ucsi->flags))
    60			complete(&ucsi->complete);
    61	}
    62	EXPORT_SYMBOL_GPL(ucsi_notify_common);
    63	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

