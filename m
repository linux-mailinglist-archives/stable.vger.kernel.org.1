Return-Path: <stable+bounces-232547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEojE6gFzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:34:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A281B36EEF3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FA94332D309
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C32932D0CF;
	Tue, 31 Mar 2026 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQaENH7g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E43290DC;
	Tue, 31 Mar 2026 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977081; cv=none; b=BjI34i7MOi2GyRD4ioxQ/4mPd7Fd/tymKc0dGzQ7x/n0rQ9j6hbtt8c1wy6TtKtyGGL2OKFZV5S/6RKibilNMAxkurx2Sgan82/vosEcw0Vq62IEUqTWW6xmB7kfLecXH3CBXqOEjl7nEBgfOxDYzrGMvr9Pfli4qOsCt1wInrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977081; c=relaxed/simple;
	bh=GtvqYs/cKyskZarliVyoZyk6Lrz0zh2hjMq/BgJEN6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9RsXCXaTq4l833gq2jIxCaMgyqrNf6z6dzXDpamrwmoK/2u2Ts7T6lOq1AdW+WeW8qk2kHsoRx1fTdSwTJePIoUSDCFS4mRfjJeNIlNykxQbea45PWy5aHYBh1JC2iwZJaezC6DvXoRmIRvBbsY9jAbvDfxW3GAipfDrf2kWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQaENH7g; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774977079; x=1806513079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GtvqYs/cKyskZarliVyoZyk6Lrz0zh2hjMq/BgJEN6A=;
  b=UQaENH7gsNZumb7iGYgFmnsrTv/IKdrOiRsnS+LMv/7YgMKNMPw5PxE8
   6xD15nGVouNUBIrpZ3lR82HY1ZE8IUfvEEPygKlvI8AnKeQ9VF9dNrWtj
   ZvgSWrcAap+1h93VrBMdlfd4N9SK5rxg1K64jN6TN8djJbdul9dUr0UEw
   f9ShYqYMIYR1K3Ny7xyq3zdUAEXyqVvnRQw1WuFdjx97J2Xt1wwuWcUaF
   F8er1tiwID3sPYdPkMPQ4IvrUdh+Osny8GD+doCzx3aNN/CijNRGouLv3
   B84j0bPTkNJ34rBAuW0+3gcVpiR+W/DOL/DOjkoLjrb/8ficK3ldNaRDs
   w==;
X-CSE-ConnectionGUID: TUK9PemkTx+ry5CzHixBWA==
X-CSE-MsgGUID: T7VAPoKMSOOxf9Rgc1bqlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="101452498"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="101452498"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 10:11:18 -0700
X-CSE-ConnectionGUID: r2xYqhAfS3+du50J680yKw==
X-CSE-MsgGUID: gPOK64SeQbOM5PtqQpcDlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221563716"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 31 Mar 2026 10:11:16 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7ccT-000000003bB-2W3u;
	Tue, 31 Mar 2026 17:11:13 +0000
Date: Wed, 1 Apr 2026 01:10:55 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?iso-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Subject: Re: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
Message-ID: <202604010125.AvkWBYKI-lkp@intel.com>
References: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.ozlabs.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-232547-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,sipsolutions.net,suse.com,perex.cz];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: A281B36EEF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cássio,

kernel test robot noticed the following build errors:

[auto build test ERROR on 46a6512f4a74dd7b18d9a455669c226843fc49ce]

url:    https://github.com/intel-lab-lkp/linux/commits/C-ssio-Gabriel/ALSA-aoa-i2sbus-clear-stale-prepared-state/20260331-113724
base:   46a6512f4a74dd7b18d9a455669c226843fc49ce
patch link:    https://lore.kernel.org/r/20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e%40gmail.com
patch subject: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260401/202604010125.AvkWBYKI-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010125.AvkWBYKI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604010125.AvkWBYKI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/aoa/soundbus/i2sbus/pcm.c:760:25: error: initialization of 'int (*)(struct snd_pcm_substream *, struct snd_pcm_hw_params *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *)' [-Wincompatible-pointer-types]
     760 |         .hw_params =    i2sbus_playback_hw_params,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/aoa/soundbus/i2sbus/pcm.c:760:25: note: (near initialization for 'i2sbus_playback_ops.hw_params')
   sound/aoa/soundbus/i2sbus/pcm.c:313:12: note: 'i2sbus_playback_hw_params' declared here
     313 | static int i2sbus_playback_hw_params(struct snd_pcm_substream *substream)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/aoa/soundbus/i2sbus/pcm.c:829:25: error: initialization of 'int (*)(struct snd_pcm_substream *, struct snd_pcm_hw_params *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *)' [-Wincompatible-pointer-types]
     829 |         .hw_params =    i2sbus_record_hw_params,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   sound/aoa/soundbus/i2sbus/pcm.c:829:25: note: (near initialization for 'i2sbus_record_ops.hw_params')
   sound/aoa/soundbus/i2sbus/pcm.c:323:12: note: 'i2sbus_record_hw_params' declared here
     323 | static int i2sbus_record_hw_params(struct snd_pcm_substream *substream)
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +760 sound/aoa/soundbus/i2sbus/pcm.c

   756	
   757	static const struct snd_pcm_ops i2sbus_playback_ops = {
   758		.open =		i2sbus_playback_open,
   759		.close =	i2sbus_playback_close,
 > 760		.hw_params =	i2sbus_playback_hw_params,
   761		.hw_free =	i2sbus_playback_hw_free,
   762		.prepare =	i2sbus_playback_prepare,
   763		.trigger =	i2sbus_playback_trigger,
   764		.pointer =	i2sbus_playback_pointer,
   765	};
   766	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

