Return-Path: <stable+bounces-241989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCXeCz7m8mmvvQEAu9opvQ
	(envelope-from <stable+bounces-241989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:18:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957849D941
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A03D301CC74
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 05:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D9363C74;
	Thu, 30 Apr 2026 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA+uGxfk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3CB1FF1B5
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 05:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777526330; cv=pass; b=MW2Hbh/BH0IcyqmxIlJoSqqR/AefSgS9CTgr66Y6MPQ3Qw1UQgOiAYvZNuHZv+OQyibvLzfBJoj+De66aU3dWsazr/eyuHEQudLnA9Xxh7I2Wn85rEnsv0vnWfIgBwFjumMkw8GdBCDVvZVJo0lfqb0uoiP9XX1ved8isvnwgHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777526330; c=relaxed/simple;
	bh=P1sfo+Q5kI12SwY4byNjcRdmuNM0osuq3r/DXEeSUyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNiCQv5irEhkpWbcV5+pv9pSIkmULGxRnsba2XflITcjG5WXn2BLwx2mjaV7On4ovlo6HVFdnZPI7QfEjm1DNEVx7XQJpyVtHPTGct5qIr7FaX90AZ3BLCNrFZYIMXtjvoUnZkIBxpptyfAoFYjKR+KIGLW8V/T97iRN1F82RDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA+uGxfk; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6563f83ae9fso562911d50.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 22:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777526328; cv=none;
        d=google.com; s=arc-20240605;
        b=M3c4fVEbpoy4fpAwK4r8vI002ePHNRV2hdGFgURNOv+09OecZQd/Vddq0VIJIny+Nb
         MBHelN6BsApOLlQrabNGdczNdMH+HrhsSN5umfZvpNSh+YV6ALGxrm+oIRdn45zV4Xye
         qU0s4MMKpyR7smMSYveEHYydsd9s71pPuJ3drXBRJeREcQYc0j3rhvn3NAgW4zbeIUjQ
         Juk6KDtq2mWsf1pJOdiuoUoOInouzpYqdjpBmoU/rDLwpqTuBCLiDKjE7wNHO54ghazv
         4646zr7NJATdK1ilMucK7Mmuf/Uv0burl/vGdgkBTXLrwK005h8vvZ3cHftUlxINfmgx
         DJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ai9guCpibXPXFjFZdk1+jpyO2wT0iDbSyZIBVstbTwg=;
        fh=avvqiD3Vy8Mqed2lGALpoMO/rZ6RyozHHElRLjq9Ub8=;
        b=JltKe+v3KdGacafvv4xbsyxmUJXX/Ib1hqGWXouTppWqcfxtvEHr0MxM24Qoq0HZcH
         Ba73wgmvb/LCtFhxjuSdMULqo2nVe7YStMu9G1L3sdwix1AD3Y5W8Olj2OVW7rfmfn87
         9maallhGujnjrS/528c6W48zxHqnmlegPkB14NU2IThiS5F1KVYfvoqJG5GknHkfoVV5
         PmI4R5A5l0QZhPLxbkPDW2HrT77Ds0DhQfJUP8PbWf4FAK1sj/G28B7ZTHsn8n9qWO3V
         GjuE1xoF0SafBkmcvwHegpFvG7ahDppzYpV4w9rehmQhIQo9by4qfr3GgBREzpxyyAcW
         t/8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777526328; x=1778131128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai9guCpibXPXFjFZdk1+jpyO2wT0iDbSyZIBVstbTwg=;
        b=WA+uGxfkaskFZUvpshPlUrTgUt1fvm5kaSkgkkdK+vb6r5OWaEFEXjm6ibiMAcz/S+
         h+Ubm5b2R6f1uXQy7psfHNhw72i2c4pwwWozuvaIq/b0bAPjNlfRkxzLx0I2UulfSRaW
         9/1AS9DPW2r+ExS1bu49Vbly3WL4DOwVTJojb1wVM0GsCyK8T6Q+sdHlrrcl0FM9NPn5
         AT9/HPz9OoDJ6EJX1v9Ll1EC19ryBoqk1fxD+FGbN4rJT5G+b5a5mG24RcT9yuFKx5Sz
         Fs/yXv+X+ZGtHyACXFCfeV93o2dYYnLGL30uN+bRZqOv+XRnVgoXxDFrLGH9FYcXB83o
         DTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777526328; x=1778131128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai9guCpibXPXFjFZdk1+jpyO2wT0iDbSyZIBVstbTwg=;
        b=sdliBSDZhjoWY/Dt4eOMDPRQy3Zpxg5kK9x1j/ZQpHzSUhIvIGGRHEAL4cB6dkdhxo
         /vfyf0w+YQS3hn69cgcDA3m0Z1CWqxqMw0R8x8kXCDU1Nfj9SbVCiGwLQKBDc2OEbOzg
         eddXF/JZmTlu2cj9mD//KyqFpxynXJyX+9JSxl6yhhDarBuYtOG/bkxiyMNZRWVZviDV
         LvVp1u0dCQYdghe/ZMhHwW1bT8e7Hw0qv0K+W030tRkmfkcgPekvDJ1UyKSrqDik7jBc
         uMrEl/UwA+MrDxaKQOAty1O55H13vmx/G6Na2ceyieK+utdABn+j3V+bdMhcZRtt4bo3
         /kLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8g79rtXgP0ywTHM3ywEOPZnoff5fv8sFhqADHlVCJYO5JRKem3YF17NNPCD0GldUVe44Uofb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6v7LaOKg8IeM9JwZPJ153H07Y7Nuwra779yDCipCQ0mfNalh
	0PEEXp8YD+hkFfTyLz5GiPsjNy57RmZP5Bm6ei3uke45uMFcc6aeB4oyoNmPUH3Z9wNj1tN9LvX
	M7jjtW6ckeXndrnsXNN8AfrSaRR5NvHs=
X-Gm-Gg: AeBDievfq1LPTBBQuItKEW5RDVn8mWNQxpOFq2vaSmkhaXq+bfwhF0lM3cam/UjUV5r
	jBoeMC+oO14EUP8qaMMqWfsFyvAv1c8EgPNcv/qUsREWGAL9f2ejZ6q9QHgmtYbPq8Kz1dWW653
	2t/7UK3T8qD8Df/ASZrnbrEt++hwpe8XbxxiEOErnIs6M37p3N1Xj8K2oMA2wkut/0Iqj6VoKv0
	fCn5z1wNrviA9I7B9R/ALCYA9Y4FCN/ZrGTciFd7UCL1qtsnM+RGIVWdbg/1ietptWTZgiWM0Wy
	2ZPtCa50PxyA6g3PpZA=
X-Received: by 2002:a53:ca02:0:b0:650:2257:e085 with SMTP id
 956f58d0204a3-65c18ddff59mr682510d50.30.1777526328567; Wed, 29 Apr 2026
 22:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415193455.3869807-1-lgs201920130244@gmail.com> <202604300638.5ysk7jy1-lkp@intel.com>
In-Reply-To: <202604300638.5ysk7jy1-lkp@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 30 Apr 2026 13:18:39 +0800
X-Gm-Features: AVHnY4KTWVjqmwRu5uzb2FBcih9ICZ6wwRPGHbQW1XPPHW286ml2iZ9APHrv-3Y
Message-ID: <CANUHTR90BbRGDwpK398AAW5V_ZqoCcuWbmuwk7P2-HuZE3M5uQ@mail.gmail.com>
Subject: Re: [PATCH] x86/rtc: fix failed fallback RTC device registration handling
To: kernel test robot <lkp@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9957849D941
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241989-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url,mail.gmail.com:mid,git-scm.com:url]

Hi,

Please drop this patch.

On Thu, 30 Apr 2026 at 06:41, kernel test robot <lkp@intel.com> wrote:
>
> Hi Guangshuo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on tip/master]
> [also build test ERROR on linus/master v7.1-rc1 next-20260429]
> [cannot apply to tip/auto-latest tip/x86/core bp/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/x86-rtc-fix-failed-fallback-RTC-device-registration-handling/20260416-130623
> base:   tip/master
> patch link:    https://lore.kernel.org/r/20260415193455.3869807-1-lgs201920130244%40gmail.com
> patch subject: [PATCH] x86/rtc: fix failed fallback RTC device registration handling
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20260430/202604300638.5ysk7jy1-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300638.5ysk7jy1-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604300638.5ysk7jy1-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    arch/x86/kernel/rtc.c: In function 'add_rtc_cmos':
> >> arch/x86/kernel/rtc.c:142:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
>      142 |         ret = platform_device_register(&rtc_device);
>          |         ^~~
>          |         net
>    arch/x86/kernel/rtc.c:142:9: note: each undeclared identifier is reported only once for each function it appears in
>
>
> vim +142 arch/x86/kernel/rtc.c
>
>    133
>    134  static __init int add_rtc_cmos(void)
>    135  {
>    136          if (cmos_rtc_platform_device_present)
>    137                  return 0;
>    138
>    139          if (!x86_platform.legacy.rtc)
>    140                  return -ENODEV;
>    141
>  > 142          ret = platform_device_register(&rtc_device);
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

After re-checking the code, rtc_device is a static platform_device and it
does not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback warning.

The build failure reported by the kernel test robot is only due to the
missing ret declaration, but the patch itself is not correct because of
the static platform_device lifetime issue.

Sorry for the noise.

Thanks,
Guangshuo

