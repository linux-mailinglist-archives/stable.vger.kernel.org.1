Return-Path: <stable+bounces-241932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMQlG3JW8mkTpwEAu9opvQ
	(envelope-from <stable+bounces-241932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:05:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE534997C9
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1D063012BF0
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80FE3CA4A0;
	Wed, 29 Apr 2026 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2QUmowe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18B33BBCF;
	Wed, 29 Apr 2026 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489488; cv=none; b=VML/3t13zRHjQDMyE2IFtuzlkIGRB01X2uqFxPHXYJsI6Vv3PV0703HMmrG9R+dvFsG3h15qFKwgpQUEXAyTzLSzAoS06Qk89+d3+NZdDKh0Q97k/JWI0mmuYWO1EN+1DQupxB6VTT1sWYmUeCCRwJrlQjMWigdsr/UiBxyxBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489488; c=relaxed/simple;
	bh=tsidYZBHseBKOISqltd/eKHnliZi9ZyEiXutHjbxvS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkTLWW763P4XR+YJH/HAfEb5DjGL5gYdjt2jzQDbVyuyYtoIsxm/ajRWtMTAi8Cb/nTJWgGf6ikJTUB8SzARmcJjAGVKp2uM1rLTUKvBsTvkZ/60nZDIq/RJ4oqK32tl0m3Fy1OFZakz3RzjCDISTtEENwma6bjIlD6aUk3KXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2QUmowe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777489486; x=1809025486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tsidYZBHseBKOISqltd/eKHnliZi9ZyEiXutHjbxvS0=;
  b=k2QUmowePQJYtexxH//yyHi8DUMMJF/dHdT01a7gK0DIdqkmM9J6XjC9
   /iEjVdMSCyxW1JuaCyD11ST3CIxh1i84mJP9oqkSNirrhao/LxUKVWsQr
   Pp9yH6vTlhLsxUrJzJ4++H7zaKuOdG1QWQR1d0FbPF/cJOc/XVsXdkAas
   By3cZv6YUQ30kng1fi0CACMzc9h4tIGVs3++8b9T4mpSTUzvD1eSj5hh5
   23G0vts2pj4jxs1rkLxkrIe/9QwRUZM0+57vISpXPz9niCerdbuupHQ4c
   5PbKIRsxo7augUoimnjisWGZb7Fmin2JuJZyCPz7vbH6vcYwjP4enTKSI
   w==;
X-CSE-ConnectionGUID: FKplU8sxRHqu6WHnnvie4w==
X-CSE-MsgGUID: QgzhidDERliLWJd6opGLCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78536921"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78536921"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:04:45 -0700
X-CSE-ConnectionGUID: wUoF0Hs8Tr2pd2NJYUbiCg==
X-CSE-MsgGUID: 1aNgzHMcQSSPenipv5Uycg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="272481706"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 Apr 2026 12:04:42 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIAD7-00000000BRA-48UD;
	Wed, 29 Apr 2026 19:04:37 +0000
Date: Thu, 30 Apr 2026 03:04:13 +0800
From: kernel test robot <lkp@intel.com>
To: Evgenii Burenchev <evg28bur@yandex.ru>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, Evgenii Burenchev <evg28bur@yandex.ru>,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/radeon/rs780: prevent division by zero in refresh
 rate calculation
Message-ID: <202604300247.Gzeia1bh-lkp@intel.com>
References: <20260428190318.34413-1-evg28bur@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428190318.34413-1-evg28bur@yandex.ru>
X-Rspamd-Queue-Id: 5AE534997C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241932-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,yandex.ru,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru,vger.kernel.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]

Hi Evgenii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.1-rc1 next-20260428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evgenii-Burenchev/drm-radeon-rs780-prevent-division-by-zero-in-refresh-rate-calculation/20260429-055830
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260428190318.34413-1-evg28bur%40yandex.ru
patch subject: [PATCH] drm/radeon/rs780: prevent division by zero in refresh rate calculation
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20260430/202604300247.Gzeia1bh-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300247.Gzeia1bh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300247.Gzeia1bh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/radeon/rs780_dpm.c: In function 'rs780_get_pm_mode_parameters':
>> drivers/gpu/drm/radeon/rs780_dpm.c:66:25: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
      66 |                         if (crtc->mode.htotal && crtc->mode.vtotal)
         |                         ^~
   drivers/gpu/drm/radeon/rs780_dpm.c:68:33: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
      68 |                                 if (pi->refresh_rate == 0)
         |                                 ^~


vim +/if +66 drivers/gpu/drm/radeon/rs780_dpm.c

9d67006e6ebc6c Alex Deucher      2013-04-12  48  
9d67006e6ebc6c Alex Deucher      2013-04-12  49  static void rs780_get_pm_mode_parameters(struct radeon_device *rdev)
9d67006e6ebc6c Alex Deucher      2013-04-12  50  {
9d67006e6ebc6c Alex Deucher      2013-04-12  51  	struct igp_power_info *pi = rs780_get_pi(rdev);
9d67006e6ebc6c Alex Deucher      2013-04-12  52  	struct radeon_mode_info *minfo = &rdev->mode_info;
9d67006e6ebc6c Alex Deucher      2013-04-12  53  	struct drm_crtc *crtc;
9d67006e6ebc6c Alex Deucher      2013-04-12  54  	struct radeon_crtc *radeon_crtc;
9d67006e6ebc6c Alex Deucher      2013-04-12  55  	int i;
9d67006e6ebc6c Alex Deucher      2013-04-12  56  
9d67006e6ebc6c Alex Deucher      2013-04-12  57  	/* defaults */
9d67006e6ebc6c Alex Deucher      2013-04-12  58  	pi->crtc_id = 0;
9d67006e6ebc6c Alex Deucher      2013-04-12  59  	pi->refresh_rate = 60;
9d67006e6ebc6c Alex Deucher      2013-04-12  60  
9d67006e6ebc6c Alex Deucher      2013-04-12  61  	for (i = 0; i < rdev->num_crtc; i++) {
9d67006e6ebc6c Alex Deucher      2013-04-12  62  		crtc = (struct drm_crtc *)minfo->crtcs[i];
9d67006e6ebc6c Alex Deucher      2013-04-12  63  		if (crtc && crtc->enabled) {
9d67006e6ebc6c Alex Deucher      2013-04-12  64  			radeon_crtc = to_radeon_crtc(crtc);
9d67006e6ebc6c Alex Deucher      2013-04-12  65  			pi->crtc_id = radeon_crtc->crtc_id;
9d67006e6ebc6c Alex Deucher      2013-04-12 @66  			if (crtc->mode.htotal && crtc->mode.vtotal)
c3eaa088277709 Alex Deucher      2013-09-13  67  				pi->refresh_rate = drm_mode_vrefresh(&crtc->mode);
0d99a77de43b3f Evgenii Burenchev 2026-04-28  68  				if (pi->refresh_rate == 0)
0d99a77de43b3f Evgenii Burenchev 2026-04-28  69  					pi->refresh_rate = 60;
9d67006e6ebc6c Alex Deucher      2013-04-12  70  			break;
9d67006e6ebc6c Alex Deucher      2013-04-12  71  		}
9d67006e6ebc6c Alex Deucher      2013-04-12  72  	}
9d67006e6ebc6c Alex Deucher      2013-04-12  73  }
9d67006e6ebc6c Alex Deucher      2013-04-12  74  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

