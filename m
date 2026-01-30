Return-Path: <stable+bounces-212913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN4ECRIcfWlQQQIAu9opvQ
	(envelope-from <stable+bounces-212913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 22:01:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87976BEA25
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 22:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 701343048089
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 20:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883137F8CF;
	Fri, 30 Jan 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWZLZ+Rl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1C38170E;
	Fri, 30 Jan 2026 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806777; cv=none; b=gvijehLMTrIJupzdlrFI40kWC1tExJ5jKxF7hMh5OpFdWNh4qSKRbDJViVNdWYNLqGq7BdzDkPjzdqoP6PFftN4DP4ZluW7dhPDUYO1T5Ebti+FQc/GIysluA0FBJbjhGdUyqdwC36sbjRlCGoc3L2hfN2mrG0VByfxmumbYAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806777; c=relaxed/simple;
	bh=baKThfj+uFC29r614dW5AycogE14elKtuMG3Rd0W1m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkIbjXIwgwzF1GacQhET9LEll0e5iIUYG6zOpxWTjbTk8trdGi5drWR2c7ZT4J000Gz62GeO/KL/jlSvdqoa38ClDYurkQDneop8vjN80i45Re9o17GWMM1znAb0n2fkLAwB6kEG7WHOXUelmvIWO5AVERR+uYqJmWi3UZ/cCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWZLZ+Rl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769806776; x=1801342776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=baKThfj+uFC29r614dW5AycogE14elKtuMG3Rd0W1m4=;
  b=iWZLZ+RlipdUq9IvwVd3rhkrTECBGL9+VG1Du/37aFdXsA+iWVJ5aJ8v
   Wsw+XGsmhoo9Dy7jO8QmDkDfKR6SAZD1qYuKaL7RdN/5n/omuaf5cgLH/
   n+Yd//qsQRg4vMCnlK3zoDF9S8LkZGz3J4KWq/ww6qfFNX5Xsa3rk0who
   GNTzLmRCuZAEn9j9/tCstJi6eeRDJ+dOIGAGf/pe5bQ5smRVHDoj7+PDT
   3yjIV93E6rupjCfM9HowEA49ghixAvWOnK4+tVwml+aSBnLjiV4CmyEA+
   7ZXMiUG1/qXRW7VK/s//Uu/XQ4GUy5e6MSIPkZe0QoCTbl5VoHjLrasni
   w==;
X-CSE-ConnectionGUID: O6T1n+FER8iV9TWhFpu3HA==
X-CSE-MsgGUID: sYZmVKxcSHebMTT1ss9R8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="88636591"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="88636591"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 12:59:35 -0800
X-CSE-ConnectionGUID: TOvX5lamQxKe+vP8xRY4yQ==
X-CSE-MsgGUID: MGpvkZjGTruQ+cPX22T0Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="209351537"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jan 2026 12:59:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlvaS-00000000dMG-3LNm;
	Fri, 30 Jan 2026 20:59:28 +0000
Date: Sat, 31 Jan 2026 04:59:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	Tim Kryger <tim.kryger@linaro.org>,
	Matt Porter <matt.porter@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Markus Mayer <markus.mayer@linaro.org>,
	Jamie Iles <jamie@jamieiles.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 7/7] serial: 8250_dw: Ensure BUSY is deasserted
Message-ID: <202601310404.Rdq0kVXE-lkp@intel.com>
References: <20260130132857.13124-8-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130132857.13124-8-ilpo.jarvinen@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212913-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,linaro.org,jamieiles.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 87976BEA25
X-Rspamd-Action: no action

Hi Ilpo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Ilpo-J-rvinen/serial-8250-Protect-LCR-write-in-shutdown/20260130-213314
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20260130132857.13124-8-ilpo.jarvinen%40linux.intel.com
patch subject: [PATCH v3 7/7] serial: 8250_dw: Ensure BUSY is deasserted
config: parisc-randconfig-001-20260131 (https://download.01.org/0day-ci/archive/20260131/202601310404.Rdq0kVXE-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260131/202601310404.Rdq0kVXE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601310404.Rdq0kVXE-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_dw.c: In function 'dw8250_check_lcr':
>> drivers/tty/serial/8250/8250_dw.c:267:1: error: label at end of compound statement
    write_err:
    ^~~~~~~~~


vim +267 drivers/tty/serial/8250/8250_dw.c

   234	
   235	/*
   236	 * This function is being called as part of the uart_port::serial_out()
   237	 * routine. Hence, special care must be taken when serial_port_out() or
   238	 * serial_out() against the modified registers here, i.e. LCR (d->in_idle is
   239	 * used to break recursion loop).
   240	 */
   241	static void dw8250_check_lcr(struct uart_port *p, unsigned int offset, u32 value)
   242	{
   243		struct dw8250_data *d = to_dw8250_data(p->private_data);
   244		u32 lcr;
   245		int ret;
   246	
   247		if (offset != UART_LCR || d->uart_16550_compatible)
   248			return;
   249	
   250		lcr = serial_port_in(p, UART_LCR);
   251	
   252		/* Make sure LCR write wasn't ignored */
   253		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
   254			return;
   255	
   256		if (d->in_idle)
   257			goto write_err;
   258	
   259		ret = dw8250_idle_enter(p);
   260		if (ret < 0)
   261			goto write_err;
   262	
   263		serial_port_out(p, UART_LCR, value);
   264		dw8250_idle_exit(p);
   265		return;
   266	
 > 267	write_err:
   268		/*
   269		 * FIXME: this deadlocks if port->lock is already held
   270		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
   271		 */
   272	}
   273	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

