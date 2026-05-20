Return-Path: <stable+bounces-253367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKmKKBgHDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:10:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDBE597DD0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3777D324462D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91643FC5C9;
	Wed, 20 May 2026 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3HYJyk5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F32701C4;
	Wed, 20 May 2026 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303538; cv=none; b=XRUAvRA7r8baIvOIiH/I09tw2S6LPD6vrpA4Ag/CGaJwn8dovxlr5Idjaz/jWvvRKVjcWO8eyURc0Vq5C/3Df8qHYHYruk+HJV2zaoD/+1Tstjr3mssbvix/qpaFvlCzWiG3b2ysxwuE6BvFr1dXVUWHD5NHmK1+4iOHCZw+WGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303538; c=relaxed/simple;
	bh=tQ2CvlZD5E4G/EoOu8BkHnDUHVLY01kjEqytn+FSuns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmreU9yv4a2jTlvmyry3CQRjY/N5pR05puGfbT5E6AnySJnxu5LOkqMSgVX0lLFhXYAMQ7VRoZ52iC4XvKKM9mKLvfCvxvKKvBTcuO9fblRsHBo+NB9yOez+VYe3tYa3SEAF7zEm82OoPkQ1ckojd0qi5JQskjyUfDusTBKzfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3HYJyk5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779303536; x=1810839536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tQ2CvlZD5E4G/EoOu8BkHnDUHVLY01kjEqytn+FSuns=;
  b=C3HYJyk5dFAc9JhyKoKizc2jNJtGx7EbUguzC1w8k12vNu0TIuz7WiSN
   uO5BYrCRn5QFsxa77yB/cYVFebtzHR/V92qz+1T//1HcMp1kb8df64ZZP
   16JQbeJHwrjXmlQyRrkjDVPkYVi7x/J6yIOIbBbCZvnmIO2+IDW9h8gfk
   1NdORTciKRxIMtoR5y7qKZwRVVIWhvWYc9wHHU6tjuDODmkZLPGehiZO8
   710EuOJ1ggprxZFg/J6Cjsjb7woR1HHAplC4GcpJ7Wl8ang+eoyzulhgP
   cHHfOADuC8DklEzSJsc06K0rvRVR/scCcedHOAMgbDrZiqXOAv62JDOpk
   g==;
X-CSE-ConnectionGUID: VcLrXReVQ4+h+H7nXwotiA==
X-CSE-MsgGUID: wShn7LAdS42JWRWl/JqqSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80332753"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80332753"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:58:55 -0700
X-CSE-ConnectionGUID: 96T3v6E8Td+OA/16PJLZpg==
X-CSE-MsgGUID: fJPfPjFAScC0AyDkCDgYUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="245266532"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 20 May 2026 11:58:54 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPm7l-000000003jh-4AQk;
	Wed, 20 May 2026 18:58:38 +0000
Date: Thu, 21 May 2026 02:57:04 +0800
From: kernel test robot <lkp@intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: keyspan: fix missing indat transfer sanity
 check
Message-ID: <202605210249.xpCIgp3t-lkp@intel.com>
References: <20260520101230.657426-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520101230.657426-1-johan@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253367-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,01.org:url]
X-Rspamd-Queue-Id: 1DDBE597DD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johan,

kernel test robot noticed the following build errors:

[auto build test ERROR on johan-usb-serial/usb-next]
[also build test ERROR on usb/usb-testing usb/usb-next usb/usb-linus tty/tty-testing tty/tty-next tty/tty-linus linus/master v7.1-rc4 next-20260520]
[cannot apply to johan-usb-serial/usb-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johan-Hovold/USB-serial-keyspan-fix-missing-indat-transfer-sanity-check/20260520-181924
base:   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git usb-next
patch link:    https://lore.kernel.org/r/20260520101230.657426-1-johan%40kernel.org
patch subject: [PATCH] USB: serial: keyspan: fix missing indat transfer sanity check
config: arm-randconfig-002-20260520 (https://download.01.org/0day-ci/archive/20260521/202605210249.xpCIgp3t-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260521/202605210249.xpCIgp3t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605210249.xpCIgp3t-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/serial/keyspan.c:1189:25: error: incompatible pointer types passing 'struct usb_device **' to parameter of type 'const struct device *' [-Wincompatible-pointer-types]
    1189 |                         dev_warn_ratelimited(&serial->dev, "malformed indat packet\n");
         |                                              ^~~~~~~~~~~~
   include/linux/dev_printk.h:227:34: note: expanded from macro 'dev_warn_ratelimited'
     227 |         dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
         |                                         ^~~
   include/linux/dev_printk.h:215:13: note: expanded from macro 'dev_level_ratelimited'
     215 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
         |                           ^~~
   include/linux/dev_printk.h:156:49: note: expanded from macro 'dev_warn'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~
   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/dev_printk.h:52:37: note: passing argument to parameter 'dev' here
      52 | void _dev_warn(const struct device *dev, const char *fmt, ...);
         |                                     ^
   1 error generated.


vim +1189 drivers/usb/serial/keyspan.c

  1166	
  1167	static void usa49wg_indat_callback(struct urb *urb)
  1168	{
  1169		int			i, len, x, err;
  1170		struct usb_serial	*serial;
  1171		struct usb_serial_port	*port;
  1172		unsigned char 		*data = urb->transfer_buffer;
  1173		int status = urb->status;
  1174	
  1175		serial = urb->context;
  1176	
  1177		if (status) {
  1178			dev_dbg(&urb->dev->dev, "%s - nonzero status: %d\n",
  1179					__func__, status);
  1180			return;
  1181		}
  1182	
  1183		/* inbound data is in the form P#, len, status, data */
  1184		i = 0;
  1185		len = 0;
  1186	
  1187		while (i < urb->actual_length) {
  1188			if (urb->actual_length - i < 3) {
> 1189				dev_warn_ratelimited(&serial->dev, "malformed indat packet\n");
  1190				break;
  1191			}
  1192	
  1193			/* Check port number from message */
  1194			if (data[i] >= serial->num_ports) {
  1195				dev_dbg(&urb->dev->dev, "%s - Unexpected port number %d\n",
  1196					__func__, data[i]);
  1197				return;
  1198			}
  1199			port = serial->port[data[i++]];
  1200			len = data[i++];
  1201	
  1202			/* 0x80 bit is error flag */
  1203			if ((data[i] & 0x80) == 0) {
  1204				/* no error on any byte */
  1205				i++;
  1206				for (x = 1; x < len && i < urb->actual_length; ++x)
  1207					tty_insert_flip_char(&port->port,
  1208							data[i++], 0);
  1209			} else {
  1210				/*
  1211				 * some bytes had errors, every byte has status
  1212				 */
  1213				for (x = 0; x + 1 < len &&
  1214					    i + 1 < urb->actual_length; x += 2) {
  1215					int stat = data[i];
  1216					int flag = TTY_NORMAL;
  1217	
  1218					if (stat & RXERROR_OVERRUN) {
  1219						tty_insert_flip_char(&port->port, 0,
  1220									TTY_OVERRUN);
  1221					}
  1222					/* XXX should handle break (0x10) */
  1223					if (stat & RXERROR_PARITY)
  1224						flag = TTY_PARITY;
  1225					else if (stat & RXERROR_FRAMING)
  1226						flag = TTY_FRAME;
  1227	
  1228					tty_insert_flip_char(&port->port, data[i+1],
  1229							     flag);
  1230					i += 2;
  1231				}
  1232			}
  1233			tty_flip_buffer_push(&port->port);
  1234		}
  1235	
  1236		/* Resubmit urb so we continue receiving */
  1237		err = usb_submit_urb(urb, GFP_ATOMIC);
  1238		if (err != 0)
  1239			dev_dbg(&urb->dev->dev, "%s - resubmit read urb failed. (%d)\n", __func__, err);
  1240	}
  1241	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

