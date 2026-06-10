Return-Path: <stable+bounces-262473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i1yOCr1OKWpKUgMAu9opvQ
	(envelope-from <stable+bounces-262473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 13:47:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8E2668EFE
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 13:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ClyjEuJp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262473-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262473-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 937F93263733
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84881402422;
	Wed, 10 Jun 2026 11:41:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB93D7D69;
	Wed, 10 Jun 2026 11:41:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091684; cv=none; b=CxwXwmqv0w82N4Bu/dUuzUd6ACLQWaLplUidyKJtjsB7F+D7Qc6zBhUZVmZb2o0/zOmu6taAesxaApxrAe6DW1uy3epItngZ6dR5GiqodKhFvq7Pkg2v2ju2DcyEiAVqqvAp2RMnBVt+KahP0t6q1yfnJE1pzZk0w4nk9Z16XtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091684; c=relaxed/simple;
	bh=YUZnH9iXq0Pl87kTiU9IWLwmwffmNGTynFm+HmKTlRY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ewYu4nzZ8OrnQ4Middet11vhuaUCtzOuqO/FGi4e9j4gu/ce/y6vKqSDWhKSGn1EedKfKBytXl+QI7afMGXTCT09sBb80cpYo8H116mU7jSETns/uQx6RgBj1XgrONEBTuOOVoXkOvz+dvnteZEgbOyDcJbKE6mMyX61pdLjRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClyjEuJp; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781091682; x=1812627682;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YUZnH9iXq0Pl87kTiU9IWLwmwffmNGTynFm+HmKTlRY=;
  b=ClyjEuJp/Ev0Re15EII0IUVgl0zxiMjsB0mis/1eLZaYAW7v9FHxGCPB
   hgsI/xHB1WyaWwTsdoPTps21tXD9XK4ngTF+NcGqjtIGzZz5yOTnNhvE6
   ROVJ+eOQKhWi+AxwQCXIFMfW4AlTNCTvEdVRC9SxPugsFY6CuBT+OsKBE
   FLVK4Q7mlJcFv5zG4Zv1rVs4FhoasX0Vbp/U8IbM7cwUhUMA3+8RDKDRl
   sYiPHfpBtbufBee69HSCu8SLkyHemi02Nb1SIU4/7g8W+IhHHmqAJoVhu
   2pktP3zF5Y5nWLKIS6kr52OpxV7Ze5VdTrCCj10jfHNaqv6mQgcwIXj2c
   A==;
X-CSE-ConnectionGUID: 8OqtE/hRRU6oWSUk1nkYVw==
X-CSE-MsgGUID: 1Zz2fNHYT2+nhPdcb+4AZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81924275"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81924275"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 04:41:21 -0700
X-CSE-ConnectionGUID: tFJiYj0STv+g0NQhxFUyQQ==
X-CSE-MsgGUID: 3omx3dyUTwGLa0smXA1bPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="243685061"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.18])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 04:41:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 10 Jun 2026 14:41:14 +0300 (EEST)
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
cc: mjg59@srcf.ucam.org, pali@kernel.org, Hans de Goede <hansg@kernel.org>, 
    dvhart@infradead.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: dell-laptop: fix missing cleanups in
 init error path
In-Reply-To: <20260609081419.1995169-1-lihaoxiang@isrc.iscas.ac.cn>
Message-ID: <adce8429-e437-48a1-6520-2b95973411eb@linux.intel.com>
References: <20260609081419.1995169-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
	TAGGED_FROM(0.00)[bounces-262473-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lihaoxiang@isrc.iscas.ac.cn,m:mjg59@srcf.ucam.org,m:pali@kernel.org,m:hansg@kernel.org,m:dvhart@infradead.org,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,linux.intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD8E2668EFE

On Tue, 9 Jun 2026, Haoxiang Li wrote:

> dell_init() initializes several resources after dell_setup_rfkill(),
> including the optional touchpad LED, keyboard backlight LED, battery
> hook, debugfs directory and dell-laptop notifier.
> 
> If a later LED or backlight registration fails, the error path only
> tears down the battery hook and rfkill resources. This leaves the
> notifier, debugfs directory, keyboard backlight LED and optional
> touchpad LED registered after dell_init() returns an error.
> 
> Add the missing cleanup calls before tearing down rfkill.
> 
> Fixes: 9c656b07997f ("platform/x86: dell-*: Call new led hw_changed API on kbd brightness change")

I've included also these:

Fixes: 037accfa14b2 ("dell-laptop: Add debugfs support")
Fixes: 2d8b90be4f1c ("dell-laptop: support Synaptics/Alps touchpad led")
Fixes: 6cff8d60aa0a ("platform: x86: dell-laptop: Add support for keyboard backlight")

Applied this change to my local the review-ilpo-next branch (it will 
eventually appear in the public one if there are no problems).

--
 i.

> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
> Changes in v2:
>  - Fix all missing cleanups in dell_init()'s error path.
>  - Add Fixes tags.
>  - Modify the commit title and message.
> ---
>  drivers/platform/x86/dell/dell-laptop.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 57748c3ea24f..053f40572bf6 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -2551,7 +2551,12 @@ static int __init dell_init(void)
>  	if (mute_led_registered)
>  		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
> +	dell_laptop_unregister_notifier(&dell_laptop_notifier);
> +	debugfs_remove_recursive(dell_laptop_dir);
>  	dell_battery_exit();
> +	kbd_led_exit();
> +	if (quirks && quirks->touchpad_led)
> +		touchpad_led_exit();
>  	dell_cleanup_rfkill();
>  fail_rfkill:
>  	platform_device_del(platform_device);
> 

