Return-Path: <stable+bounces-268878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JbEoMIJxPmrTGAkAu9opvQ
	(envelope-from <stable+bounces-268878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:33:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF536CD05C
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:33:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=NorX4JAl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268878-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268878-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB8CA301F4A6
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446653F23C4;
	Fri, 26 Jun 2026 12:32:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2F26B973;
	Fri, 26 Jun 2026 12:32:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477169; cv=none; b=ToH/nraFFgR6+3D+aT35Y+haBGGrnRsZyhzAXJ0rwrksZw5EMqg/ccv1FNx7+F+UmZuJKxtUVwrcKg/stNKdyJ4EJC/OeOzVaSCayvqUX6m3cNKBN8GOzrOw+08aRjTN3SIDRc4tlG8lKCadSjFAjMBGHF2upUA0Oms+NeAHxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477169; c=relaxed/simple;
	bh=KcZgACwtmX+SVYeSnRzH9eljl4Ne8+uOz5GEYaGLwJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHCp0HJPg4NLNFOPHNJKsUMutFR6iw+vvZ7PfdJBu7GRoI4KEeUXKLVCOe/Faql3d9GXsLKGLt/2G/XLu1a/altsM1U7kMYoQKMLpE9l3ySYJ1h2yb2Ngozzb+dn3ir4SziC+6VtUVImGm0ex+ZSZSTe6u45ru4dErDIr5LyS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NorX4JAl; arc=none smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782477168; x=1814013168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KcZgACwtmX+SVYeSnRzH9eljl4Ne8+uOz5GEYaGLwJY=;
  b=NorX4JAlF7OboufltQJA7Eo5Dg1SuKScBbrs9aA5IzMIndlQ5vhgdkPV
   Qe+yBVVmV88k/4s8JfNZEuXr3BDQrsyQz6pOwMQf67cLxROiar9x4y58r
   JiBRCdbgVuGD/6ee8+rDu4GJ30gdlOHWv4tvr7wLHe7/5VEuxxHks3NVf
   APU/cY5jMHPna1qsuK6eo12Pi4/So/YJ6myYI0FoBKm/bhFwRUFgSBUL6
   LKnuKwmaY1j0AIjdyuTO4Jt8NRJY3Ci9aDudX3DSH/s1h2PvvkQvSGjOV
   BxnDU7oE35f7oZ0zrlqLuDHaAHkPKA3s3C6BPSAB8JLJn2PWPdzlS4BoR
   w==;
X-CSE-ConnectionGUID: VB0rk8g6QAqjdRbtStzTCw==
X-CSE-MsgGUID: 5bxxXJKnRka9coxpx6j1hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94417418"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="94417418"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:32:47 -0700
X-CSE-ConnectionGUID: d63zfJFfQVeB/pl+AWWgSQ==
X-CSE-MsgGUID: H6vs7KUrSeahz+oWRGy/Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247948579"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:32:43 -0700
Date: Fri, 26 Jun 2026 15:32:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>, Kees Cook <kees@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Timur Tabi <ttabi@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Mel Henning <mhenning@darkrefraction.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 2/2] drm/nouveau/gsp/r570: Never enter Gcoff state
Message-ID: <aj5xaeHusBhWhDK1@ashevche-desk.local>
References: <20260625231252.89684-1-lyude@redhat.com>
 <20260625231252.89684-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625231252.89684-3-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268878-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lyude@redhat.com,m:dri-devel@lists.freedesktop.org,m:nouveau@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:airlied@redhat.com,m:kees@kernel.org,m:dakr@kernel.org,m:ttabi@nvidia.com,m:bskeggs@nvidia.com,m:mhenning@darkrefraction.com,m:maarten.lankhorst@linux.intel.com,m:simona@ffwll.ch,m:airlied@gmail.com,m:tzimmermann@suse.de,m:mripard@kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,redhat.com,kernel.org,nvidia.com,darkrefraction.com,linux.intel.com,ffwll.ch,gmail.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ashevche-desk.local:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DF536CD05C

On Thu, Jun 25, 2026 at 07:10:55PM -0400, Lyude Paul wrote:
> It turns out that the only reason our previous fixes looked like they
> worked for this was because we would occasionally set the Gcoff state to 0
> in the normal S3 path, which fixed suspend/resume on desktops - but not on
> machines using runtime suspend.
> 
> The proper fix is to just never set this flag. Our current guess for the
> reasoning behind this is that Gcoff likely coincides with GC6, and not
> literally power off.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 firmware")
> Cc: <stable@vger.kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: Ben Skeggs <bskeggs@nvidia.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mel Henning <mhenning@darkrefraction.com>
> Cc: <stable@vger.kernel.org> # v6.19+
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Same comment here.

-- 
With Best Regards,
Andy Shevchenko



