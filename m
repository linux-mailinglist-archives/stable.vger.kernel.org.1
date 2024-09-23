Return-Path: <stable+bounces-76937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3B397F195
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 22:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D556281DC9
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687821A08A3;
	Mon, 23 Sep 2024 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhwpZ3WV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C836126;
	Mon, 23 Sep 2024 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122548; cv=none; b=Px8mDFsTxGUZ4dWPdsrurkW9yKZSIXoq5mamHgKLM8RCNKh7IqydVdbdf5xfY9HALxAmW0xvrbcEpNZBZhtCGU+1bXwcGDGwVK/v35Cl/Uyy2vYdL7KpWp7/ebZu6m4+t8T1r0iowbFNRZ8tmlTK4Yhm9ZNm3AKxLUvG8T26P9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122548; c=relaxed/simple;
	bh=wNpFDbj7PPOA+nXw14Q42Hk1QSaBxdvFRbuXkuNfBjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzD7h+dix9+BavYHrZwJjmqXwOZbQAa3UTR/QHl7A71MIqvbRJ9j2KXvPAhyapXE/EfVl1YOkZESsjX9h+/i/lOCWU5y0i5tjhgkaGTijXRHdjXTTPE5RbXhrFp9e3MpAJvWozj3wZtg5znGVjBWCj9wQuYflKx4mtAs47dnrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhwpZ3WV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727122546; x=1758658546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wNpFDbj7PPOA+nXw14Q42Hk1QSaBxdvFRbuXkuNfBjI=;
  b=ZhwpZ3WVUm9yDxhNbzt0scmaZVE7+OkOpPdq10dR2BiuJleDG9wSJx7n
   HsWw9G3W11K9fJ502cUX7vMxcX2rH+vSpOrNBWM2Qg0daaAr4fqtG75YY
   P2Cgsnw78guWKieETsxnoC5lk8z25Y175m7kndk4eqxiOcuv6sHcIMvBU
   9VnATyxyznnYlm+f2KQG5lEfFByN+uKipJLfA68PRbQ/vxzhWg+t1TFr5
   u87Z9V9EyDnLmWJy8XlUbGOAvDqKoeK9qTkCJ+Z61z+qTlDdqJdfVth99
   3NtaejloH9P7nvzzrMNpo6Y89dBcm6h+WaAvcuKvMWOci7qUH98vI2+e5
   g==;
X-CSE-ConnectionGUID: OyLislo1ShudBb/upXXUOQ==
X-CSE-MsgGUID: o2mrKTnFQOu5qDZFP2Hlqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26282284"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="26282284"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 13:15:46 -0700
X-CSE-ConnectionGUID: ixLLyd4cQxiDz4dSSrcPAg==
X-CSE-MsgGUID: IdpIgqqcQAqalR2buqrdiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="76103494"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 Sep 2024 13:15:43 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sspTA-000HZm-2m;
	Mon, 23 Sep 2024 20:15:40 +0000
Date: Tue, 24 Sep 2024 04:15:15 +0800
From: kernel test robot <lkp@intel.com>
To: Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] usb: yurex: make waiting on yurex_write interruptible
Message-ID: <202409240433.Bl9ay4Ua-lkp@intel.com>
References: <20240923141649.148563-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923141649.148563-1-oneukum@suse.com>

Hi Oliver,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.11 next-20240923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oliver-Neukum/usb-yurex-make-waiting-on-yurex_write-interruptible/20240923-221833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240923141649.148563-1-oneukum%40suse.com
patch subject: [PATCH] usb: yurex: make waiting on yurex_write interruptible
config: x86_64-buildonly-randconfig-004-20240924 (https://download.01.org/0day-ci/archive/20240924/202409240433.Bl9ay4Ua-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240433.Bl9ay4Ua-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240433.Bl9ay4Ua-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/misc/yurex.c:444:6: warning: variable 'retval' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     444 |         if (count == 0)
         |             ^~~~~~~~~~
   drivers/usb/misc/yurex.c:524:9: note: uninitialized use occurs here
     524 |         return retval;
         |                ^~~~~~
   drivers/usb/misc/yurex.c:444:2: note: remove the 'if' if its condition is always false
     444 |         if (count == 0)
         |         ^~~~~~~~~~~~~~~
     445 |                 goto error;
         |                 ~~~~~~~~~~
   drivers/usb/misc/yurex.c:433:24: note: initialize the variable 'retval' to silence this warning
     433 |         int i, set = 0, retval;
         |                               ^
         |                                = 0
   1 warning generated.


vim +444 drivers/usb/misc/yurex.c

6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  428  
1cc373c654acde Sudip Mukherjee     2014-10-10  429  static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
1cc373c654acde Sudip Mukherjee     2014-10-10  430  			   size_t count, loff_t *ppos)
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  431  {
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  432  	struct usb_yurex *dev;
e9cac1c1ecfe84 Oliver Neukum       2024-09-23  433  	int i, set = 0, retval;
7e10f14ebface4 Ben Hutchings       2018-08-15  434  	char buffer[16 + 1];
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  435  	char *data = buffer;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  436  	unsigned long long c, c2 = 0;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  437  	signed long timeout = 0;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  438  	DEFINE_WAIT(wait);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  439  
7e10f14ebface4 Ben Hutchings       2018-08-15  440  	count = min(sizeof(buffer) - 1, count);
113ad911ad4a1c Arjun Sreedharan    2014-08-19  441  	dev = file->private_data;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  442  
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  443  	/* verify that we actually have some data to write */
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29 @444  	if (count == 0)
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  445  		goto error;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  446  
e9cac1c1ecfe84 Oliver Neukum       2024-09-23  447  	retval = mutex_lock_interruptible(&dev->io_mutex);
e9cac1c1ecfe84 Oliver Neukum       2024-09-23  448  	if (retval < 0)
e9cac1c1ecfe84 Oliver Neukum       2024-09-23  449  		return -EINTR;
e9cac1c1ecfe84 Oliver Neukum       2024-09-23  450  
aafb00a977cf7d Johan Hovold        2019-10-09  451  	if (dev->disconnected) {		/* already disconnected */
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  452  		mutex_unlock(&dev->io_mutex);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  453  		retval = -ENODEV;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  454  		goto error;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  455  	}
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  456  
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  457  	if (copy_from_user(buffer, user_buffer, count)) {
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  458  		mutex_unlock(&dev->io_mutex);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  459  		retval = -EFAULT;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  460  		goto error;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  461  	}
7e10f14ebface4 Ben Hutchings       2018-08-15  462  	buffer[count] = 0;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  463  	memset(dev->cntl_buffer, CMD_PADDING, YUREX_BUF_SIZE);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  464  
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  465  	switch (buffer[0]) {
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  466  	case CMD_ANIMATE:
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  467  	case CMD_LED:
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  468  		dev->cntl_buffer[0] = buffer[0];
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  469  		dev->cntl_buffer[1] = buffer[1];
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  470  		dev->cntl_buffer[2] = CMD_EOF;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  471  		break;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  472  	case CMD_READ:
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  473  	case CMD_VERSION:
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  474  		dev->cntl_buffer[0] = buffer[0];
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  475  		dev->cntl_buffer[1] = 0x00;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  476  		dev->cntl_buffer[2] = CMD_EOF;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  477  		break;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  478  	case CMD_SET:
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  479  		data++;
0d9b6d49fe39bd Gustavo A. R. Silva 2020-07-07  480  		fallthrough;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  481  	case '0' ... '9':
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  482  		set = 1;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  483  		c = c2 = simple_strtoull(data, NULL, 0);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  484  		dev->cntl_buffer[0] = CMD_SET;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  485  		for (i = 1; i < 6; i++) {
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  486  			dev->cntl_buffer[i] = (c>>32) & 0xff;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  487  			c <<= 8;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  488  		}
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  489  		buffer[6] = CMD_EOF;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  490  		break;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  491  	default:
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  492  		mutex_unlock(&dev->io_mutex);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  493  		return -EINVAL;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  494  	}
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  495  
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  496  	/* send the data as the control msg */
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  497  	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);
aadd6472d904c3 Greg Kroah-Hartman  2012-05-01  498  	dev_dbg(&dev->interface->dev, "%s - submit %c\n", __func__,
aadd6472d904c3 Greg Kroah-Hartman  2012-05-01  499  		dev->cntl_buffer[0]);
f176ede3a3bde5 Alan Stern          2020-08-10  500  	retval = usb_submit_urb(dev->cntl_urb, GFP_ATOMIC);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  501  	if (retval >= 0)
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  502  		timeout = schedule_timeout(YUREX_WRITE_TIMEOUT);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  503  	finish_wait(&dev->waitq, &wait);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  504  
372c93131998c0 Johan Hovold        2020-12-14  505  	/* make sure URB is idle after timeout or (spurious) CMD_ACK */
372c93131998c0 Johan Hovold        2020-12-14  506  	usb_kill_urb(dev->cntl_urb);
372c93131998c0 Johan Hovold        2020-12-14  507  
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  508  	mutex_unlock(&dev->io_mutex);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  509  
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  510  	if (retval < 0) {
45714104b9e85f Greg Kroah-Hartman  2012-04-20  511  		dev_err(&dev->interface->dev,
45714104b9e85f Greg Kroah-Hartman  2012-04-20  512  			"%s - failed to send bulk msg, error %d\n",
45714104b9e85f Greg Kroah-Hartman  2012-04-20  513  			__func__, retval);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  514  		goto error;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  515  	}
93907620b30860 Oliver Neukum       2024-09-12  516  	if (set && timeout) {
93907620b30860 Oliver Neukum       2024-09-12  517  		spin_lock_irq(&dev->lock);
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  518  		dev->bbu = c2;
93907620b30860 Oliver Neukum       2024-09-12  519  		spin_unlock_irq(&dev->lock);
93907620b30860 Oliver Neukum       2024-09-12  520  	}
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  521  	return timeout ? count : -EIO;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  522  
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  523  error:
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  524  	return retval;
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  525  }
6bc235a2e24a5e Tomoki Sekiyama     2010-09-29  526  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

