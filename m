Return-Path: <stable+bounces-203243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 899A0CD7721
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 00:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F580301CE96
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 23:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E333314A0;
	Mon, 22 Dec 2025 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzVQctZc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC033064E;
	Mon, 22 Dec 2025 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766445307; cv=none; b=hnXKOnwJRRAeWZQ8nL8TuVRsqcxxn2OGt3OHHIP/I/jV8cP7GlFC9iWTr2HYgdV9+06MVPKTQiq8EofCatpMRnVoqK3oR1EwvJekVJlOEkiEbpJjDRinfT/E4OvVml1VEqf3JIFNhPRNq6V4lLjYanY6BBGXBD4bB1zBH5lagHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766445307; c=relaxed/simple;
	bh=2HVNOkYDGFzNpOGHd6rID/vvWRVJgkD781Ei3tklPD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJL6iPzeeiTmjxXdPJXdeLQ5lTq+hVwmAzUhKTdT//apotw4RAaPEr56XN8e4UmQgn6CwzMaO+1YaVh6mhq3iZ6TiV3d6K9DLiqImZSY9/WIK11PjcNgXkZDRAMxQIqU5nD2KgdN63I8NRRv2Q7F4TyYoMAKJWmxN4VzEXKLiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzVQctZc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766445307; x=1797981307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2HVNOkYDGFzNpOGHd6rID/vvWRVJgkD781Ei3tklPD8=;
  b=DzVQctZc0z+nnx57gUvlhLMqLbxR+ulGBAktFCM3ujUjWl8BpPZ1eigg
   QQciIS5wxPfcDjXo8qXsnOmXVMETCFElZ6s8/fIsib/pWx2CDveupVrNS
   YhAaluFgZcUte1NlgK/ijGXRKGgk4gor0V4krjGvv2ZiCStGt5gE//ODC
   nraHBtsMR9gw11pnOHzcgvS0wA0wRSl6Xv9XaflT3anECLp+Bd8US7fJU
   Rn0ifoXuTQnWVDSaLHm1/wHXABzG8ggQ1wKFAWQK1ARBGsU7WJxk/B+Mx
   XAa4JGKklPgRi2bcu+bYjGm5oUedkfnPX2yP19jF74eXdViZt7MsZqfFQ
   w==;
X-CSE-ConnectionGUID: ScGJdJsfTZShq05h/5En9w==
X-CSE-MsgGUID: 2P0re1VCSOuajOEzbBJzpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68344694"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="68344694"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 15:14:14 -0800
X-CSE-ConnectionGUID: 3YMoto4RRCezSvSLMHSV2Q==
X-CSE-MsgGUID: QV6jfENsRZSo44h4Yz9Nxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="199404464"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 22 Dec 2025 15:14:12 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXp6G-000000001Cl-0byD;
	Mon, 22 Dec 2025 23:14:01 +0000
Date: Tue, 23 Dec 2025 07:13:00 +0800
From: kernel test robot <lkp@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, mporter@kernel.crashing.org,
	alex.bou9@gmail.com, akpm@linux-foundation.org,
	dan.carpenter@linaro.org, linux@treblig.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] rapidio: fix a resource leak when rio_add_device() fails
Message-ID: <202512230711.jyQOu79S-lkp@intel.com>
References: <20251221120538.947670-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221120538.947670-1-lihaoxiang@isrc.iscas.ac.cn>

Hi Haoxiang,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoxiang-Li/rapidio-fix-a-resource-leak-when-rio_add_device-fails/20251221-201559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251221120538.947670-1-lihaoxiang%40isrc.iscas.ac.cn
patch subject: [PATCH] rapidio: fix a resource leak when rio_add_device() fails
config: x86_64-buildonly-randconfig-003-20251223 (https://download.01.org/0day-ci/archive/20251223/202512230711.jyQOu79S-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512230711.jyQOu79S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230711.jyQOu79S-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/rapidio/devices/rio_mport_cdev.c: In function 'rio_mport_add_riodev':
>> drivers/rapidio/devices/rio_mport_cdev.c:1792:30: error: 'net' undeclared (first use in this function)
    1792 |                 rio_free_net(net);
         |                              ^~~
   drivers/rapidio/devices/rio_mport_cdev.c:1792:30: note: each undeclared identifier is reported only once for each function it appears in


vim +/net +1792 drivers/rapidio/devices/rio_mport_cdev.c

  1648	
  1649	
  1650	/*
  1651	 * rio_mport_add_riodev - creates a kernel RIO device object
  1652	 *
  1653	 * Allocates a RIO device data structure and initializes required fields based
  1654	 * on device's configuration space contents.
  1655	 * If the device has switch capabilities, then a switch specific portion is
  1656	 * allocated and configured.
  1657	 */
  1658	static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
  1659					   void __user *arg)
  1660	{
  1661		struct mport_dev *md = priv->md;
  1662		struct rio_rdev_info dev_info;
  1663		struct rio_dev *rdev;
  1664		struct rio_switch *rswitch = NULL;
  1665		struct rio_mport *mport;
  1666		struct device *dev;
  1667		size_t size;
  1668		u32 rval;
  1669		u32 swpinfo = 0;
  1670		u16 destid;
  1671		u8 hopcount;
  1672		int err;
  1673	
  1674		if (copy_from_user(&dev_info, arg, sizeof(dev_info)))
  1675			return -EFAULT;
  1676		dev_info.name[sizeof(dev_info.name) - 1] = '\0';
  1677	
  1678		rmcd_debug(RDEV, "name:%s ct:0x%x did:0x%x hc:0x%x", dev_info.name,
  1679			   dev_info.comptag, dev_info.destid, dev_info.hopcount);
  1680	
  1681		dev = bus_find_device_by_name(&rio_bus_type, NULL, dev_info.name);
  1682		if (dev) {
  1683			rmcd_debug(RDEV, "device %s already exists", dev_info.name);
  1684			put_device(dev);
  1685			return -EEXIST;
  1686		}
  1687	
  1688		size = sizeof(*rdev);
  1689		mport = md->mport;
  1690		destid = dev_info.destid;
  1691		hopcount = dev_info.hopcount;
  1692	
  1693		if (rio_mport_read_config_32(mport, destid, hopcount,
  1694					     RIO_PEF_CAR, &rval))
  1695			return -EIO;
  1696	
  1697		if (rval & RIO_PEF_SWITCH) {
  1698			rio_mport_read_config_32(mport, destid, hopcount,
  1699						 RIO_SWP_INFO_CAR, &swpinfo);
  1700			size += struct_size(rswitch, nextdev, RIO_GET_TOTAL_PORTS(swpinfo));
  1701		}
  1702	
  1703		rdev = kzalloc(size, GFP_KERNEL);
  1704		if (rdev == NULL)
  1705			return -ENOMEM;
  1706	
  1707		if (mport->net == NULL) {
  1708			struct rio_net *net;
  1709	
  1710			net = rio_alloc_net(mport);
  1711			if (!net) {
  1712				err = -ENOMEM;
  1713				rmcd_debug(RDEV, "failed to allocate net object");
  1714				goto cleanup;
  1715			}
  1716	
  1717			net->id = mport->id;
  1718			net->hport = mport;
  1719			dev_set_name(&net->dev, "rnet_%d", net->id);
  1720			net->dev.parent = &mport->dev;
  1721			net->dev.release = rio_release_net;
  1722			err = rio_add_net(net);
  1723			if (err) {
  1724				rmcd_debug(RDEV, "failed to register net, err=%d", err);
  1725				put_device(&net->dev);
  1726				mport->net = NULL;
  1727				goto cleanup;
  1728			}
  1729		}
  1730	
  1731		rdev->net = mport->net;
  1732		rdev->pef = rval;
  1733		rdev->swpinfo = swpinfo;
  1734		rio_mport_read_config_32(mport, destid, hopcount,
  1735					 RIO_DEV_ID_CAR, &rval);
  1736		rdev->did = rval >> 16;
  1737		rdev->vid = rval & 0xffff;
  1738		rio_mport_read_config_32(mport, destid, hopcount, RIO_DEV_INFO_CAR,
  1739					 &rdev->device_rev);
  1740		rio_mport_read_config_32(mport, destid, hopcount, RIO_ASM_ID_CAR,
  1741					 &rval);
  1742		rdev->asm_did = rval >> 16;
  1743		rdev->asm_vid = rval & 0xffff;
  1744		rio_mport_read_config_32(mport, destid, hopcount, RIO_ASM_INFO_CAR,
  1745					 &rval);
  1746		rdev->asm_rev = rval >> 16;
  1747	
  1748		if (rdev->pef & RIO_PEF_EXT_FEATURES) {
  1749			rdev->efptr = rval & 0xffff;
  1750			rdev->phys_efptr = rio_mport_get_physefb(mport, 0, destid,
  1751							hopcount, &rdev->phys_rmap);
  1752	
  1753			rdev->em_efptr = rio_mport_get_feature(mport, 0, destid,
  1754							hopcount, RIO_EFB_ERR_MGMNT);
  1755		}
  1756	
  1757		rio_mport_read_config_32(mport, destid, hopcount, RIO_SRC_OPS_CAR,
  1758					 &rdev->src_ops);
  1759		rio_mport_read_config_32(mport, destid, hopcount, RIO_DST_OPS_CAR,
  1760					 &rdev->dst_ops);
  1761	
  1762		rdev->comp_tag = dev_info.comptag;
  1763		rdev->destid = destid;
  1764		/* hopcount is stored as specified by a caller, regardles of EP or SW */
  1765		rdev->hopcount = hopcount;
  1766	
  1767		if (rdev->pef & RIO_PEF_SWITCH) {
  1768			rswitch = rdev->rswitch;
  1769			rswitch->route_table = NULL;
  1770		}
  1771	
  1772		if (strlen(dev_info.name))
  1773			dev_set_name(&rdev->dev, "%s", dev_info.name);
  1774		else if (rdev->pef & RIO_PEF_SWITCH)
  1775			dev_set_name(&rdev->dev, "%02x:s:%04x", mport->id,
  1776				     rdev->comp_tag & RIO_CTAG_UDEVID);
  1777		else
  1778			dev_set_name(&rdev->dev, "%02x:e:%04x", mport->id,
  1779				     rdev->comp_tag & RIO_CTAG_UDEVID);
  1780	
  1781		INIT_LIST_HEAD(&rdev->net_list);
  1782		rdev->dev.parent = &mport->net->dev;
  1783		rio_attach_device(rdev);
  1784		rdev->dev.release = rio_release_dev;
  1785	
  1786		if (rdev->dst_ops & RIO_DST_OPS_DOORBELL)
  1787			rio_init_dbell_res(&rdev->riores[RIO_DOORBELL_RESOURCE],
  1788					   0, 0xffff);
  1789		err = rio_add_device(rdev);
  1790		if (err) {
  1791			put_device(&rdev->dev);
> 1792			rio_free_net(net);
  1793			return err;
  1794		}
  1795	
  1796		rio_dev_get(rdev);
  1797	
  1798		return 0;
  1799	cleanup:
  1800		kfree(rdev);
  1801		return err;
  1802	}
  1803	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

