Return-Path: <stable+bounces-114390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED64A2D600
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7529B3A89EA
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD7C246339;
	Sat,  8 Feb 2025 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBjqx9Lz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17A2451E6;
	Sat,  8 Feb 2025 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739016654; cv=none; b=TQLlmkOnluHApQSqaX5BPmKrqzIXj9hUoX1zG+QN4rfIpy56iT28JGA7hp148l3xuCQSmXKB0pylkjzYut0yp397OMjlzww/ZDWOAi8NEuydcnjxUYs9lJ/ZZDzDLK4H8PBmHwv57zi7RPDFqP1lKdZyeYDxqQddpbH9rYH78Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739016654; c=relaxed/simple;
	bh=Y4cah178pVm/TyCjnR2BxWLPSd7RUgpqPRJ2KklwCB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dlz+mqOfHt0MAna1oWePfGznsIvKz5pVxkn6cGsm5HZrwwo8wxdch372+b2COTyJs3bUjbIEByQm3VlEsYq26C58lD6V4NqIJ7YvRNH+DMHbeYZ5xhZJ7JQqTbbm7xOHLGTRpvqBZ3bQd2G32JpymziObJwYIyoc3Z6hfpjnU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBjqx9Lz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739016652; x=1770552652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y4cah178pVm/TyCjnR2BxWLPSd7RUgpqPRJ2KklwCB0=;
  b=OBjqx9Lz7WtO1nhtHw4Eox+ibossr1MrffEcFG/605cWlVqv2nm5v52/
   9H3cw1Lm3ale8+3agfp3kuUhlMVLe7cEoeCAlr3BSkp7SI/tlGlJnfrJj
   X4H0bEgDYd9sBE39egVIX00oYfuR9i/vrtAW4QbLCtg2OMw53z0ak9o23
   8wgOoMGPEjUtUwy0stv3dnxi+in7dMfqP/p07Zy+AsKaz38aFAeQaNPsH
   BtO7WxybGQc+OfySPXRRYe3gKOuYajLrkLobHnHAMUd1lC+lhqnOQ9V0C
   QB+Su5KDIpmj0nxhFiEchVNb8IAUnDlp+KhdU+xOonhPf9BJsFxuuYbsR
   A==;
X-CSE-ConnectionGUID: RPPS7triR1yzYKxNo245iw==
X-CSE-MsgGUID: YbNh1tkzRl+GtVF4Gp2r7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="57070806"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; 
   d="scan'208";a="57070806"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 04:10:52 -0800
X-CSE-ConnectionGUID: UKX7WyT1R12FPhdDM3c1XQ==
X-CSE-MsgGUID: YDExt5IHSWi50POe66I1Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; 
   d="scan'208";a="116770919"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Feb 2025 04:10:50 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgjfa-000zw7-35;
	Sat, 08 Feb 2025 12:10:46 +0000
Date: Sat, 8 Feb 2025 20:10:02 +0800
From: kernel test robot <lkp@intel.com>
To: Jill Donahue <jilliandonahue58@gmail.com>, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Jill Donahue <jilliandonahue58@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] f_midi_complete to call tasklet_hi_schedule
Message-ID: <202502081928.T2cRhulq-lkp@intel.com>
References: <20250207203441.945196-1-jilliandonahue58@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207203441.945196-1-jilliandonahue58@gmail.com>

Hi Jill,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.14-rc1 next-20250207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jill-Donahue/f_midi_complete-to-call-tasklet_hi_schedule/20250208-043845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20250207203441.945196-1-jilliandonahue58%40gmail.com
patch subject: [PATCH v3] f_midi_complete to call tasklet_hi_schedule
config: i386-buildonly-randconfig-003-20250208 (https://download.01.org/0day-ci/archive/20250208/202502081928.T2cRhulq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250208/202502081928.T2cRhulq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502081928.T2cRhulq-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/gadget/function/f_midi.c: In function 'f_midi_complete':
>> drivers/usb/gadget/function/f_midi.c:286:50: error: 'struct f_midi' has no member named 'tasklet'
     286 |                         tasklet_hi_schedule(&midi->tasklet);
         |                                                  ^~


vim +286 drivers/usb/gadget/function/f_midi.c

   269	
   270	static void
   271	f_midi_complete(struct usb_ep *ep, struct usb_request *req)
   272	{
   273		struct f_midi *midi = ep->driver_data;
   274		struct usb_composite_dev *cdev = midi->func.config->cdev;
   275		int status = req->status;
   276	
   277		switch (status) {
   278		case 0:			 /* normal completion */
   279			if (ep == midi->out_ep) {
   280				/* We received stuff. req is queued again, below */
   281				f_midi_handle_out_data(ep, req);
   282			} else if (ep == midi->in_ep) {
   283				/* Our transmit completed. See if there's more to go.
   284				 * f_midi_transmit eats req, don't queue it again. */
   285				req->length = 0;
 > 286				tasklet_hi_schedule(&midi->tasklet);
   287				return;
   288			}
   289			break;
   290	
   291		/* this endpoint is normally active while we're configured */
   292		case -ECONNABORTED:	/* hardware forced ep reset */
   293		case -ECONNRESET:	/* request dequeued */
   294		case -ESHUTDOWN:	/* disconnect from host */
   295			VDBG(cdev, "%s gone (%d), %d/%d\n", ep->name, status,
   296					req->actual, req->length);
   297			if (ep == midi->out_ep) {
   298				f_midi_handle_out_data(ep, req);
   299				/* We don't need to free IN requests because it's handled
   300				 * by the midi->in_req_fifo. */
   301				free_ep_req(ep, req);
   302			}
   303			return;
   304	
   305		case -EOVERFLOW:	/* buffer overrun on read means that
   306					 * we didn't provide a big enough buffer.
   307					 */
   308		default:
   309			DBG(cdev, "%s complete --> %d, %d/%d\n", ep->name,
   310					status, req->actual, req->length);
   311			break;
   312		case -EREMOTEIO:	/* short read */
   313			break;
   314		}
   315	
   316		status = usb_ep_queue(ep, req, GFP_ATOMIC);
   317		if (status) {
   318			ERROR(cdev, "kill %s:  resubmit %d bytes --> %d\n",
   319					ep->name, req->length, status);
   320			usb_ep_set_halt(ep);
   321			/* FIXME recover later ... somehow */
   322		}
   323	}
   324	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

