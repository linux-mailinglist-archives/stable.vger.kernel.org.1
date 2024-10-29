Return-Path: <stable+bounces-89235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287959B5177
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 18:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBD81C22E2C
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4B31E048A;
	Tue, 29 Oct 2024 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLJLCihj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9A1DC739;
	Tue, 29 Oct 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224708; cv=none; b=pLJCf6tuMswnRkzb3/ILohzkMmazG21UpQdQ2fL4O4RKwHLltJlNtTGBwMAb0QMEhDE8morsfo/CdFXw4lb4h+4WNKP+hzxZh1ydM6mFzW18H3cIan0tG03RawIEuWJGjx3KMjMlCeKvXP3McGlvQq/94c5RPbszM+R61w3WjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224708; c=relaxed/simple;
	bh=7aaGphVstemt+LrVYO8eRhyN+SIXqmyHmB8xIhK98Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emjeSrCNtcqqMTV+/Rzf4a+B6FADX5GxFc37wzZmsGSvCN66iiODC/KUjT9NZ1xmLt8qSpkoIC9vE9zoGYa+W3ZxFpLLjaQmMCo5UHcxq37UIRIYYUYJLVAexLerlR+qhnROaQUW/IhUHZ7LBbNao7GWsAt+Lgi9Jd2Fs4RlPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLJLCihj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730224705; x=1761760705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7aaGphVstemt+LrVYO8eRhyN+SIXqmyHmB8xIhK98Ho=;
  b=kLJLCihjHS8ePjj6TSDqc69xWQYDXqH93lqT6+ztdQxAts2vPSGTJhzD
   0+Fb3bjeXOowlKjmdEhHK3LyTI2+uiDqT4SIP8r1mYsa3ClMRxlAff2pJ
   kerJfseNYpb1zqJnqwCr1JKceb7JREJLiq2bTWihqME+J51rSogEP01NO
   dxf8I1IaMWFR2N6lET0/sxbrp8b27XhbWhhSag/wdD8Vvn+J8ZO8RKXbD
   NHDeu6a6VCZRJBuZSTfZFcVX33G1Y8OQIunMV+TkF/GbXRvkQFT9aWwKj
   KBzacXMBbxh88guOdlYswQ9yvMUVZFEeb3sXEqFjxdNsgGcywH31stRK3
   A==;
X-CSE-ConnectionGUID: tCPrBOloS66kwyRsF85hFw==
X-CSE-MsgGUID: OWiJ2MrXQzSF22xng3PITQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40985310"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40985310"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:58:25 -0700
X-CSE-ConnectionGUID: PKc316V0TH6oGzyT5au3Vw==
X-CSE-MsgGUID: DT6jGl/DQxyIZ+oWVUrmTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82147331"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2024 10:58:19 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5qTx-000dxg-0l;
	Tue, 29 Oct 2024 17:58:17 +0000
Date: Wed, 30 Oct 2024 01:57:29 +0800
From: kernel test robot <lkp@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Murphy <dmurphy@ti.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net] net: phy: dp83869: fix status reporting for
 1000base-x autonegotiation
Message-ID: <202410300125.K125vk3f-lkp@intel.com>
References: <20241029-dp83869-1000base-x-v1-1-fcafe360bd98@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-dp83869-1000base-x-v1-1-fcafe360bd98@bootlin.com>

Hi Romain,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 94c11e852955b2eef5c4f0b36cfeae7dcf11a759]

url:    https://github.com/intel-lab-lkp/linux/commits/Romain-Gantois/net-phy-dp83869-fix-status-reporting-for-1000base-x-autonegotiation/20241029-173146
base:   94c11e852955b2eef5c4f0b36cfeae7dcf11a759
patch link:    https://lore.kernel.org/r/20241029-dp83869-1000base-x-v1-1-fcafe360bd98%40bootlin.com
patch subject: [PATCH net] net: phy: dp83869: fix status reporting for 1000base-x autonegotiation
config: arm-randconfig-004-20241029 (https://download.01.org/0day-ci/archive/20241030/202410300125.K125vk3f-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241030/202410300125.K125vk3f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410300125.K125vk3f-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/dp83869.c:197:3: warning: variable 'adv' is uninitialized when used here [-Wuninitialized]
                   adv |= DP83869_BP_FULL_DUPLEX;
                   ^~~
   drivers/net/phy/dp83869.c:174:9: note: initialize the variable 'adv' to silence this warning
           u32 adv;
                  ^
                   = 0
   1 warning generated.


vim +/adv +197 drivers/net/phy/dp83869.c

   168	
   169	static int dp83869_config_aneg(struct phy_device *phydev)
   170	{
   171		struct dp83869_private *dp83869 = phydev->priv;
   172		unsigned long *advertising;
   173		int err, changed = false;
   174		u32 adv;
   175	
   176		if (dp83869->mode != DP83869_RGMII_1000_BASE)
   177			return genphy_config_aneg(phydev);
   178	
   179		/* Forcing speed or duplex isn't supported in 1000base-x mode */
   180		if (phydev->autoneg != AUTONEG_ENABLE)
   181			return 0;
   182	
   183		/* In fiber modes, register locations 0xc0... get mapped to offset 0.
   184		 * Unfortunately, the fiber-specific autonegotiation advertisement
   185		 * register at address 0xc04 does not have the same bit layout as the
   186		 * corresponding standard MII_ADVERTISE register. Thus, functions such
   187		 * as genphy_config_advert() will write the advertisement register
   188		 * incorrectly.
   189		 */
   190		advertising = phydev->advertising;
   191	
   192		/* Only allow advertising what this PHY supports */
   193		linkmode_and(advertising, advertising,
   194			     phydev->supported);
   195	
   196		if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, advertising))
 > 197			adv |= DP83869_BP_FULL_DUPLEX;
   198		if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertising))
   199			adv |= DP83869_BP_PAUSE;
   200		if (linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertising))
   201			adv |= DP83869_BP_ASYMMETRIC_PAUSE;
   202	
   203		err = phy_modify_changed(phydev, DP83869_FX_ANADV,
   204					 DP83869_BP_FULL_DUPLEX | DP83869_BP_PAUSE |
   205					 DP83869_BP_ASYMMETRIC_PAUSE,
   206					 adv);
   207	
   208		if (err < 0)
   209			return err;
   210		else if (err)
   211			changed = true;
   212	
   213		return genphy_check_and_restart_aneg(phydev, changed);
   214	}
   215	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

