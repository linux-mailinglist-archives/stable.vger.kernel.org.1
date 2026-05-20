Return-Path: <stable+bounces-251845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOjEED8fDmpd6QUAu9opvQ
	(envelope-from <stable+bounces-251845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:53:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A921959A422
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E90E3328134F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1DD3F1AC7;
	Wed, 20 May 2026 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DA99Mr0a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C83EE1FA;
	Wed, 20 May 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299038; cv=none; b=uFi3NvD6RYuv6sn+jTp80HLJkLuKfM6xHd6o+Mln4gNqpmorDs+1FlzQRn/aqxFCEkNv2yCw6m/hjk7tugKdS0IU0eBUOMfA8Q7z++McMaeiceT950OziEAX7tdMRBu0Tj49I7ZQszegmiViTNx0QOFiBXlJswdmnzu6qGiRz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299038; c=relaxed/simple;
	bh=HmbzItfoBNw9pRHaQ4Z+zDtSvsx6AuIEaW7Ov5R+vFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLN4hHYVo0JLOrSgMnw9Btqj2GLzivCs+xE+4wJ+Qwb2sseoAKBjkpTZs2+hOO5SWAo6vaL2mcplFndN7+QQwBVv6fGC+m9BJDuCedhyuuPGK2z4C++Z6RVRYki5vg4H7xFHxTTZU3BJOBmqyAFFKa/KvLhtpbcKmHggDWK5HY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DA99Mr0a; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779299037; x=1810835037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HmbzItfoBNw9pRHaQ4Z+zDtSvsx6AuIEaW7Ov5R+vFs=;
  b=DA99Mr0av5ZAisYcOEaFv5QrJBKpMzJbVNoNLEN77+4Rydylwg2wGV4o
   LP17rZ+tdzRhUQ/82meqfG0Fb50EZEtlaEY0HGCFPZeiavtdTRyvPDOiF
   /kj70j40egz/1On0Z3q2K9RtUiZ3EG59Yk37pKsTOlJdH0RlryCUEz11w
   KCYdbNvhc+5tCET4bTMSWanvw21tlNdgNB5ytNp28GXomcKnxTawxnHrv
   m91CXYbz/LCav80CUrVKpYOmX+P8LkMWPsM1NiK+/wxKjhSZLEafyriIK
   /G0mmdProDpbSAWVoQkXYaQDlQf6Gauuokoij+BeWOrOetSqf8jqafXJ5
   A==;
X-CSE-ConnectionGUID: mV6aRw06QSe+l7/GxjVgnw==
X-CSE-MsgGUID: IiUVJVs6TySnXTxeEmxgcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90784892"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="90784892"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 10:43:57 -0700
X-CSE-ConnectionGUID: 0RuTxDY6T6C4TrX8UPnXYw==
X-CSE-MsgGUID: vAvB2vGvQe+79Z8PTXhRJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="264063058"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 20 May 2026 10:43:54 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPkx3-000000003d7-2eTq;
	Wed, 20 May 2026 17:43:33 +0000
Date: Thu, 21 May 2026 01:42:32 +0800
From: kernel test robot <lkp@intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: keyspan: fix missing indat transfer sanity
 check
Message-ID: <202605210121.M2IibKiB-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251845-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: A921959A422
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
config: i386-buildonly-randconfig-006-20260520 (https://download.01.org/0day-ci/archive/20260521/202605210121.M2IibKiB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260521/202605210121.M2IibKiB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605210121.M2IibKiB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/serial/keyspan.c:1189:25: error: incompatible pointer types passing 'struct usb_device **' to parameter of type 'const struct device *' [-Werror,-Wincompatible-pointer-types]
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
   include/linux/dev_printk.h:89:37: note: passing argument to parameter 'dev' here
      89 | void _dev_warn(const struct device *dev, const char *fmt, ...)
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

