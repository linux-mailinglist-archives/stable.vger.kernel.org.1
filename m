Return-Path: <stable+bounces-134639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39000A93C2D
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B84463E11
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3EA21ABC5;
	Fri, 18 Apr 2025 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="MzOuMP79"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-2.centrum.cz (gmmr-2.centrum.cz [46.255.227.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277072192E0;
	Fri, 18 Apr 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998412; cv=none; b=lU7C6gzGAsw1CzB6zQ/eIPTcp/Su7Q5fS+J5uWSw2ie1MvHeNoyaK+EyboLvGpiGWSJr5YuweIYyqW2Y72xUrJGe3KLW8XQwHYtFu9WYLtcc2Ea9eF0SfzNDJNqvSyEm2TMCYnIQ9E0G/Jtj0gvqDga5Yb/XShs9WVJ8igljtpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998412; c=relaxed/simple;
	bh=NTba5+T2jbj0mEB4THNhG57knCQYzKfkCkfqx+GHIpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/R+ZS7Giel8tlC/o4MGLkTRE/30Evp5b0ccEdP/GsHaBT7LDi1iC+2Lj6pLEbfOzQWGT4kickiIOf04lRHn3l2Q3x8dKHAKMb5EaDjfsw8F4nLJctzEeRA6pIXo3kfcrTKRDJ+nGdypGLNEztKilv928YcWn42tO1Hf2fh3yeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=MzOuMP79; arc=none smtp.client-ip=46.255.227.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-2.centrum.cz (localhost [127.0.0.1])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 8D8C620391ED;
	Fri, 18 Apr 2025 19:46:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1744998400; bh=Fams/ed1xNpzAsw/jGMqibP9F1wAGloYnaaO7rvT+cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MzOuMP79q7ot+0fQO79l6couOBK6gUlSV1eYPsQ8iBp1Vhwl7Pu1aCr1JHQkOWiLu
	 PCQ31ZMOHJ0YjoG5L53BcqEdXK5Vsaxia01eSqJrJ7F8Gi1aYCO66or4oRebDPjfoB
	 ZXEcy/eed9yjEj3ckycpCFdmxs5ycjzP9UFD2KI8=
Received: from antispam36.centrum.cz (antispam36.cent [10.30.208.36])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 8B97C2018543;
	Fri, 18 Apr 2025 19:46:40 +0200 (CEST)
X-CSE-ConnectionGUID: 6MKn1wl6QE6NIr05uuVkyw==
X-CSE-MsgGUID: 9DvAAV3uTVOa7LvWaPFbvg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2FIAABDjwJo/0vj/y5aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFACYFKAoM/gWSEVZFxA4okiAWBIIxHDwEBAQEBAQEBA?=
 =?us-ascii?q?Qk7CQQBAQMEOIRIAossJzgTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQYBAQEBA?=
 =?us-ascii?q?QEGBgECgR2FNUYNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQIBI?=
 =?us-ascii?q?w8BRgULCw0BCgICJgICVgYTgwIBgi8BAw4jFAaxJXqBMhoCZYNsQdhDAkkFV?=
 =?us-ascii?q?WOBJAaBGy4BiE8BhWyEd0KCDYQ/PoJKFwSFOYJpBIItgReTYYJ0ixNSexwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSlDA4EPI04FMB2BeoNyhTaCEYFcAwMiAYMVdRyEb4RULU+DM?=
 =?us-ascii?q?4IDPR1AAwttPTcUGwaZDIQQYAEHQRYCIIEtDZcxsAyDHIEJhE6HS5VKM5dwA?=
 =?us-ascii?q?5JkLphQjA2BeZsvgX6BbAwHMyIwgyISAT8Zlz29cHYCATkCBwEKAQEDCYI7i?=
 =?us-ascii?q?26Bc4FLAQE?=
IronPort-PHdr: A9a23:FtRVwhwzQdPXS8fXCzKqzFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xaZva0m1gSTAtqTwskHotSVmpioYXYH75eFvSJKW713fDhBpOMo2icNO4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTezf79+N
 gm6oRneusUIj4ZuNKQ8xxnUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElR
 rFGDzooLn446tTzuRfMVQWA6WIQX3sZnBRVGwTK4w30UZn3sivhq+pywzKaMtHsTbA1Qjut8
 aFmQwL1hSgdNj459GbXitFsjK9evRmsqQBzz5LSbYqIL/d1YL/Tcs0GSmpARsZRVjJOAoWgb
 4sUEuENOf9Uo5Thq1cSqBezAxSnCuHyxT9SnnL406003fo/HA/b3wIgEd0Bv2jJo9v6NqgfS
 vy1warSwDnfc/9axTXw5Y7VeR4hu/GMWrdwfNLLx0YxCwPFlEibpoP/MDOTyOENsHWQ4u16W
 uK1iG4osQRxrSK1xso3kIbJmoYVxUrf9Slj3Ik0JMS1RUhmatGrDJVerTuVN5dqQsw8WWFov
 j43xLIJt5C0fyUG1pcqyh7bZvGDfYWE/BLuWuaVLDp4i3xpZa6yihWz/EauxeDxV8e53VlWo
 yZYjtTBtHMA2hzN58WBV/Bz8ECh2TOV2ADS7OFJOUM0mrTBK54n3LEwkoAfsUPZHi/5nkj9k
 ayYdl089+Wn6unreKvqq5+cOoNulA3yLKYjlta9DOk4KgQDUGmW9f6i2LDt50H1XbpHguAsn
 qTYrZzXI9kQqLSjDA9PyIkj7g6yDzKh0NsFg3YKNElFeBebj4jxPFHOPez4Ae+/g1uylDdrw
 OjLPrLkApnUNXjDlavhfa5g50JB0gY80c5Q55RICrEbPfLzX1X9u8DZDxMhMgy0xfjoCMll2
 44RWG+DGLGVPaPSvFOS+O4jPeuBaJUXtTv9M/Ql4uThjX49mV8TZ6mp2p4XZWiiEfR8IEWWe
 3/sjc0bEWoRpAU+UOjqh0eZUTJJe3mzXrow5isnB4K+EYfDWoetjaSa0yejBZBZfGRGClGSH
 nfudIiIQeoDZzyKLs97jjMETaShS5Mm1Ry2rA/11aZnIfTO+iwZrp/j1d515+PJlR4o6DN7E
 d6S3HyXQ2FzhGMISCc63Lpjrkxl1leDza94juRcFdxO+/NJVRw3NZ3CwOxgDdD9RAbBcs2OS
 Fa8TdWqGSsxQc4pw98Sf0Z9HM2vjx/A0ierGLIVlKKEBIYy8q3C23j9PcF9y2zJ1KU5lVkpX
 tNPNXG6hq547wXTG4HJk0GWlquxcaQc3SjN9HqfzWqUu0FYVg9wUKrfUX8CeETatc756V/aT
 7+yFbQnNRNMxtOYJatUdNLll1VGS+3lONTFfW2xnXy9BRKJxrOKcYrrdH8R3CTbCEgYjQ8T+
 WyKOhQ5Bieku27eFiBhFUrzY0Pw9ulzsHa7Tk4yzwGFaE1szKC19QAIivycUfwTwqgItzsmq
 zVxBFq9xc7ZC8Kcpwp9e6VRedE94Fhd1WLerAx9JYetL7t/hl4FbQt7pV/h1xJyCtYIrc9/j
 m4n1gV/L+q3ylRabHvM35/qPabMAnLv5x3pYKnTjALwytGTr58C9O5wlVzlHwLhQkM48Hxi2
 sN92meY746MBxhEAsG5aVo+6xUv/+KSWSI6/Y6BkCQ0acGJ
IronPort-Data: A9a23:uHBYm6mC+svg57QI9pO2U1Lo5gwGJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJJCGGEbvaJZjD2fNAnb460pkIOu8KHndQ2S1RqriBkFltH+JHPbTi7wuYcHM8wwunrFh8PA
 xA2M4GYRCwMZiaB4Erra/658CQUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dga++2k
 Y20+pC31GONgWYubzpIsvLb9nuDgdyr0N8mlg1jDRx0lACG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaPVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 ONl7sXsFFhzbsUgr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAG4oTRbamObo+Z/lbMh23pk+MffoLZxK7xmMzRmBZRonaZ/GBr7P+ccBhXE7i8ZSB+vbI
 cELAdZtREieJUcSZxFNUs14w7rAanrXKlW0rHqcv6k+5mHJ5AVt1LH2dtHHEjCPbZwMwhnJ+
 j+dpgwVBDlLGMK24ATe706SoeaQuT3EUbo8HqO3o6sCbFq7gzZ75ActfVGjifC9i0O4C5RTJ
 iQ84icyoLIg3E2tQMP0UxCxrDiDpBF0c95ND+oS6wyXzKfQpQGDCQAsXm4fQN8rrsk7QXotz
 FDht8/mASxHtLyTVG6H8bGVvXW+NEA9IWYcaGkERA0e7t/LpIA1kwKJT9B/HarzhdrwcRn1w
 jaFqwAkirkThNJN3KK+lXjFjCirvYPhVRMu60PcWWfNxgd4YpO1Io+l817W6d5eI4uDCFqMp
 n4Jn46Z9u9mJYqRnSaJTc0TE7yzofWIKjvRhRhoBZZJ3zS18laxbJxX+nd1I0IBDyofUWO3J
 hWO5EULvsAVYybCgbJLXr9dwv8ClcDIfekJnNiOBjaSSvCdrDO6wRw=
IronPort-HdrOrdr: A9a23:vivyGaHm3/W3gYP8pLqE5ceALOsnbusQ8zAXPo5KJiC9Vvbo8v
 xG+85rsSMc6QxhOk3I9urrBEDtex7hHNtOkO4s1NSZLWrbUQmTTb2KhLGKq1bd8m/FltK1vp
 0PT0ERMrHNMWQ=
X-Talos-CUID: 9a23:UuPkWmMDLtLTTu5DBgxE8hcLHp4cXyP77W2IflKlN2V4V+jA
X-Talos-MUID: =?us-ascii?q?9a23=3Ah2T1ig9OGm67VDtB1LqFfomQf5ZE/Y2HNhsQras?=
 =?us-ascii?q?hspagKxN5AxmXkjviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,222,1739833200"; 
   d="scan'208";a="114794531"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam36.centrum.cz with ESMTP; 18 Apr 2025 19:46:40 +0200
Received: from arkam (46-23-141-61.static.podluzi.net [46.23.141.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id E3CBD100AE11B;
	Fri, 18 Apr 2025 19:46:39 +0200 (CEST)
Date: Fri, 18 Apr 2025 19:46:38 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: fix _pgd_alloc() for Xen PV mode
Message-ID: <2025418174638-aAKP_lnKYqenWy7u-arkamar@atlas.cz>
References: <20250417144808.22589-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417144808.22589-1-jgross@suse.com>

On Thu, Apr 17, 2025 at 04:48:08PM +0200, Juergen Gross wrote:
> Recently _pgd_alloc() was switched from using __get_free_pages() to
> pagetable_alloc_noprof(), which might return a compound page in case
> the allocation order is larger than 0.
> 
> On x86 this will be the case if CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
> is set, even if PTI has been disabled at runtime.
> 
> When running as a Xen PV guest (this will always disable PTI), using
> a compound page for a PGD will result in VM_BUG_ON_PGFLAGS being
> triggered when the Xen code tries to pin the PGD.

> Fix the Xen issue together with the not needed 8k allocation for a
> PGD with PTI disabled by using a variable holding the PGD allocation
> order in case CONFIG_MITIGATION_PAGE_TABLE_ISOLATION is set.
> 
> Reported-by: Petr Vaněk <arkamar@atlas.cz>
> Fixes: a9b3c355c2e6 ("asm-generic: pgalloc: provide generic __pgd_{alloc,free}")
> Cc: stable@vger.kernel.org
> Signed-off-by: Juergen Gross <jgross@suse.com>

I have runtime tested this patch, and it fixes the reported issue. The
following trailers can be appended to the commit message (as per [1]):

Closes: https://lore.kernel.org/lkml/202541612720-Z_-deOZTOztMXHBh-arkamar@atlas.cz/
Tested-by: Petr Vaněk <arkamar@atlas.cz>

Cheers,
Petr

[1] https://docs.kernel.org/process/5.Posting.html#patch-formatting-and-changelogs

