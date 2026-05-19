Return-Path: <stable+bounces-249497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6It2LnUnDGrvXQUAu9opvQ
	(envelope-from <stable+bounces-249497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:03:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6438257AD50
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB8B2301A7DB
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61DF3EF0BC;
	Tue, 19 May 2026 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Bk7QOhWP"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA953E4C83;
	Tue, 19 May 2026 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180959; cv=none; b=f7N1MEKTpzucfrjGvklXMst9SAFEt9LLVUZzt5A/TmsI9aK9msZu2JvLuE5Y11pSTC8PjKOdDaSVBxwHXBRuvyrGTHDYIHgGhaNKyONOGef+/4b58UoO6HJ4WXVk5B50l99+tdU6Tpsk/9wRNGkage1TQiWYYx8MUcBTdrNbiVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180959; c=relaxed/simple;
	bh=ftwpKvo7Rp8BJXbKoIeNCthLPgJyanvKkG1cCqMbZrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyapmoFRI741U1CQi6CppV06Le9VT67h1IS3VTsHkhQEkpi/zAfSo9osDpw7MB7QO3wtR9z+ayR52LYQALiGe4vwVXs30m6RTytoyKzyQVuuWjpjFvaBYPnG1Fe792leLpCMELlceJgzQMq2Wh9udH++Hd7S0URBd6ZFkVJF9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Bk7QOhWP; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gKT6C6JjZz66cd;
	Tue, 19 May 2026 10:55:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779180947;
	bh=ftwpKvo7Rp8BJXbKoIeNCthLPgJyanvKkG1cCqMbZrc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bk7QOhWPhgRRz7KJEtAd7+0uPaXPHzCEfZO++UCFwxc0nSf8I/rfQxU4Ag9itMfa4
	 FziggAWTPNkzi/ut5RkSVCNr8jsHUtihQXlQohvCUh1Mq58EFH9oZA6S+YwgcNT/R7
	 EJyHVf09JTxKpKQkFLg9Txuq18jypCBGSIk+c72VJmmb10bRigVf9zxqi78ls9b7O1
	 xz4e6br19ti047z/0U6phzJ73//UyN9aMxkrC2Z0vkQzcPA8QGf6Fr5CzJ3Lpi9p4i
	 73e7uA6y5gK32EY2gQnb40CX7CdRECqMzeZ4kCY5AXU6MjCTsANs7AI3QRkNU5IkNq
	 IB5Bfh3hcp9TA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gKT6C5YgDz4y0B;
	Tue, 19 May 2026 10:55:47 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gKT6B4wgcz8sh8;
	Tue, 19 May 2026 10:55:46 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id E33E361877;
	Tue, 19 May 2026 10:55:45 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4bba4c5a-debb-4844-a032-986f761a74af@leemhuis.info>
Date: Tue, 19 May 2026 10:55:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Nick <nick@kousu.ca>, regressions@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, todd.e.brandt@linux.intel.com,
 xi.pardee@linux.intel.com, platform-driver-x86@vger.kernel.org,
 stable@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
References: <E2OXET.4X5GTP37VTNC3@kousu.ca>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <E2OXET.4X5GTP37VTNC3@kousu.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177918094642.1165543.11562446347433548455@mxe9fb.netcup.net>
X-NC-CID: epF3U4eHTZik8NUEwaCRXLV7fuMp3N41BuBYajb/kcgPFQePtdQ=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kousu.ca,lists.linux.dev,vger.kernel.org,linux.intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-249497-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gist.githubusercontent.com:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6438257AD50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[CCing Azael, just in case]

On 5/12/26 18:49, Nick wrote:
> My Toshiba Tecra X40 laptop's function keys no longer send events.

Rafael, have you seen that this regression seems to be caused by a
change of yours? Namely 57c31e6d620f13 ("ACPI: scan: Use
acpi_setup_gpe_for_wake() for buttons") [v7.0-rc1]

No complains, just wondering, as it was easy to miss. Ciao, Thorsten

> Specifically the mute ("KEY_MUTE"), lock ("KEY_COFFEE"), "power plan"
> ("KEY_BATTERY"), sleep ("KEY_SLEEP"), mic mute (for some reason this
> reads as "KEY_SUSPEND"), screen switch ("KEY_SWITCHVIDEOMODE"),
> brightness ("KEY_BRIGHTNESSDOWN" and "KEY_BRIGHTNESSUP"), and rfkill
> ("KEY_WLAN") hotkeys -- these are the Fn-shifted versions of Esc, F1,
> F2, F3, F4, F5, F6, F7 and F8 -- keys no longer work. Neither does the
> lid-switch.
> 
> Fn+F9, Fn+10, Fn+F11 and Fn+12 still work; those show up on /dev/input/
> event3 like the rest of my keyboard, but the hotkeys show up on /dev/
> input/event6.
> 
> I'm on ArchLinux. My keys worked on v6.19.14, I first noticed them
> broken on v7.0.2.
> 
> I bisected mainline and found the break is: "ACPI: scan: Use
> acpi_setup_gpe_for_wake() for buttons"  <https://lore.kernel.org/
> all/2259694.irdbgypaU6@rafael.j.wysocki/>. That is,
> 57c31e6d620f132dcf610b2c52b4cdbd203c6f4a is bad and
> 88fad6ce090b395af4c654594a54589a386bf24b is good.
> 
> #regzbot introduced: 57c31e6d620f132dcf610b2c52b4cdbd203c6f4a
> 
> Maybe acpi_mark_gpe_for_wake was initializing something particular to
> Toshiba hardware?
> 
> To reproduce, just boot and try to use the hotkeys. They won't work. For
> more detail, use libinput as follows.
> 
> Here is a sample of pressing all the hotkeys in order on a working version:
> 
> + libinput debug-events --show-keycodes
> -event2 DEVICE_ADDED Power Button seat0 default group1 cap:k
> -event4 DEVICE_ADDED Video Bus seat0 default group2 cap:k
> -event1 DEVICE_ADDED Power Button seat0 default group3 cap:k
> -event0 DEVICE_ADDED Lid Switch seat0 default group4 cap:S
> -event6 DEVICE_ADDED Toshiba input device seat0 default group5 cap:k
> -event12 DEVICE_ADDED Synaptics TM3322-002 seat0 default group6 cap:pg
> size 95x53mm tap (dl off) left scroll-nat scroll-2fg-edge click-
> buttonareas-clickfinger dwt-on dwtp-on
> -event3 DEVICE_ADDED AT Translated Set 2 keyboard seat0 default group7
> cap:k
> -event6 KEYBOARD_KEY +0.000s KEY_MUTE (113) pressed
> event6 KEYBOARD_KEY +0.000s KEY_MUTE (113) released
> event6 KEYBOARD_KEY +2.427s KEY_MUTE (113) pressed
> event6 KEYBOARD_KEY +2.427s KEY_MUTE (113) released
> event6 KEYBOARD_KEY +3.879s KEY_MUTE (113) pressed
> event6 KEYBOARD_KEY +3.879s KEY_MUTE (113) released
> event6 KEYBOARD_KEY +4.587s KEY_MUTE (113) pressed
> event6 KEYBOARD_KEY +4.587s KEY_MUTE (113) released
> event6 KEYBOARD_KEY +5.451s KEY_COFFEE (152) pressed
> event6 KEYBOARD_KEY +5.451s KEY_COFFEE (152) released
> event6 KEYBOARD_KEY +5.937s KEY_COFFEE (152) pressed
> event6 KEYBOARD_KEY +5.937s KEY_COFFEE (152) released
> event6 KEYBOARD_KEY +6.362s KEY_COFFEE (152) pressed
> event6 KEYBOARD_KEY +6.362s KEY_COFFEE (152) released
> event6 KEYBOARD_KEY +6.625s KEY_COFFEE (152) pressed
> event6 KEYBOARD_KEY +6.625s KEY_COFFEE (152) released
> event6 KEYBOARD_KEY +6.868s KEY_COFFEE (152) pressed
> event6 KEYBOARD_KEY +6.868s KEY_COFFEE (152) released
> event6 KEYBOARD_KEY +7.110s KEY_COFFEE (152) pressed
> event6 KEYBOARD_KEY +7.110s KEY_COFFEE (152) released
> event6 KEYBOARD_KEY +7.312s KEY_COFFEE (152) pressed
> event6 KEYBOARD_KEY +7.312s KEY_COFFEE (152) released
> event6 KEYBOARD_KEY +7.495s KEY_COFFEE (152) pressed
> event6 KEYBOARD_KEY +7.495s KEY_COFFEE (152) released
> event6 KEYBOARD_KEY +9.331s KEY_COFFEE (152) pressed
> event6 KEYBOARD_KEY +9.331s KEY_COFFEE (152) released
> event6 KEYBOARD_KEY +10.949s KEY_COFFEE (152) pressed
> event6 KEYBOARD_KEY +10.949s KEY_COFFEE (152) released
> event6 KEYBOARD_KEY +16.572s KEY_BATTERY (236) pressed
> event6 KEYBOARD_KEY +16.572s KEY_BATTERY (236) released
> event6 KEYBOARD_KEY +16.997s KEY_BATTERY (236) pressed
> event6 KEYBOARD_KEY +16.997s KEY_BATTERY (236) released
> event6 KEYBOARD_KEY +17.503s KEY_BATTERY (236) pressed
> event6 KEYBOARD_KEY +17.503s KEY_BATTERY (236) released
> event6 KEYBOARD_KEY +17.705s KEY_BATTERY (236) pressed
> event6 KEYBOARD_KEY +17.705s KEY_BATTERY (236) released
> event6 KEYBOARD_KEY +18.145s KEY_BATTERY (236) pressed
> event6 KEYBOARD_KEY +18.145s KEY_BATTERY (236) released
> event6 KEYBOARD_KEY +18.348s KEY_BATTERY (236) pressed
> event6 KEYBOARD_KEY +18.348s KEY_BATTERY (236) released
> event6 KEYBOARD_KEY +18.711s KEY_BATTERY (236) pressed
> event6 KEYBOARD_KEY +18.712s KEY_BATTERY (236) released
> event6 KEYBOARD_KEY +25.610s KEY_BATTERY (236) pressed
> event6 KEYBOARD_KEY +25.610s KEY_BATTERY (236) released
> event6 KEYBOARD_KEY +26.561s KEY_BATTERY (236) pressed
> event6 KEYBOARD_KEY +26.561s KEY_BATTERY (236) released
> event6 KEYBOARD_KEY +27.673s KEY_SLEEP (142) pressed
> event6 KEYBOARD_KEY +27.673s KEY_SLEEP (142) released
> event6 KEYBOARD_KEY +29.666s KEY_SLEEP (142) pressed
> event6 KEYBOARD_KEY +29.666s KEY_SLEEP (142) released
> event6 KEYBOARD_KEY +30.009s KEY_SLEEP (142) pressed
> event6 KEYBOARD_KEY +30.009s KEY_SLEEP (142) released
> event6 KEYBOARD_KEY +30.494s KEY_SLEEP (142) pressed
> event6 KEYBOARD_KEY +30.494s KEY_SLEEP (142) released
> event6 KEYBOARD_KEY +30.798s KEY_SLEEP (142) pressed
> event6 KEYBOARD_KEY +30.798s KEY_SLEEP (142) released
> event6 KEYBOARD_KEY +31.082s KEY_SLEEP (142) pressed
> event6 KEYBOARD_KEY +31.082s KEY_SLEEP (142) released
> event6 KEYBOARD_KEY +31.384s KEY_SLEEP (142) pressed
> event6 KEYBOARD_KEY +31.384s KEY_SLEEP (142) released
> event6 KEYBOARD_KEY +32.072s KEY_SLEEP (142) pressed
> event6 KEYBOARD_KEY +32.072s KEY_SLEEP (142) released
> event6 KEYBOARD_KEY +32.776s KEY_SLEEP (142) pressed
> event6 KEYBOARD_KEY +32.776s KEY_SLEEP (142) released
> event6 KEYBOARD_KEY +33.458s KEY_SLEEP (142) pressed
> event6 KEYBOARD_KEY +33.458s KEY_SLEEP (142) released
> event6 KEYBOARD_KEY +40.569s KEY_SUSPEND (205) pressed
> event6 KEYBOARD_KEY +40.569s KEY_SUSPEND (205) released
> event6 KEYBOARD_KEY +40.813s KEY_SUSPEND (205) pressed
> event6 KEYBOARD_KEY +40.813s KEY_SUSPEND (205) released
> event6 KEYBOARD_KEY +41.642s KEY_SUSPEND (205) pressed
> event6 KEYBOARD_KEY +41.642s KEY_SUSPEND (205) released
> event6 KEYBOARD_KEY +43.179s KEY_SUSPEND (205) pressed
> event6 KEYBOARD_KEY +43.179s KEY_SUSPEND (205) released
> event6 KEYBOARD_KEY +43.705s KEY_SUSPEND (205) pressed
> event6 KEYBOARD_KEY +43.705s KEY_SUSPEND (205) released
> event6 KEYBOARD_KEY +45.085s KEY_SUSPEND (205) pressed
> event6 KEYBOARD_KEY +45.085s KEY_SUSPEND (205) released
> event6 KEYBOARD_KEY +48.515s KEY_SWITCHVIDEOMODE (227) pressed
> event6 KEYBOARD_KEY +48.515s KEY_SWITCHVIDEOMODE (227) released
> event6 KEYBOARD_KEY +48.858s KEY_SWITCHVIDEOMODE (227) pressed
> event6 KEYBOARD_KEY +48.858s KEY_SWITCHVIDEOMODE (227) released
> event6 KEYBOARD_KEY +49.425s KEY_SWITCHVIDEOMODE (227) pressed
> event6 KEYBOARD_KEY +49.425s KEY_SWITCHVIDEOMODE (227) released
> event6 KEYBOARD_KEY +49.667s KEY_SWITCHVIDEOMODE (227) pressed
> event6 KEYBOARD_KEY +49.667s KEY_SWITCHVIDEOMODE (227) released
> event6 KEYBOARD_KEY +50.138s KEY_SWITCHVIDEOMODE (227) pressed
> event6 KEYBOARD_KEY +50.138s KEY_SWITCHVIDEOMODE (227) released
> event6 KEYBOARD_KEY +50.340s KEY_SWITCHVIDEOMODE (227) pressed
> event6 KEYBOARD_KEY +50.340s KEY_SWITCHVIDEOMODE (227) released
> event6 KEYBOARD_KEY +50.745s KEY_SWITCHVIDEOMODE (227) pressed
> event6 KEYBOARD_KEY +50.745s KEY_SWITCHVIDEOMODE (227) released
> event6 KEYBOARD_KEY +50.987s KEY_SWITCHVIDEOMODE (227) pressed
> event6 KEYBOARD_KEY +50.987s KEY_SWITCHVIDEOMODE (227) released
> event6 KEYBOARD_KEY +51.786s KEY_SWITCHVIDEOMODE (227) pressed
> event6 KEYBOARD_KEY +51.786s KEY_SWITCHVIDEOMODE (227) released
> event6 KEYBOARD_KEY +52.287s KEY_SWITCHVIDEOMODE (227) pressed
> event6 KEYBOARD_KEY +52.287s KEY_SWITCHVIDEOMODE (227) released
> event6 KEYBOARD_KEY +56.994s KEY_BRIGHTNESSDOWN (224) pressed
> event6 KEYBOARD_KEY +56.994s KEY_BRIGHTNESSDOWN (224) released
> event6 KEYBOARD_KEY +57.662s KEY_BRIGHTNESSDOWN (224) pressed
> event6 KEYBOARD_KEY +57.662s KEY_BRIGHTNESSDOWN (224) released
> event6 KEYBOARD_KEY +58.188s KEY_BRIGHTNESSDOWN (224) pressed
> event6 KEYBOARD_KEY +58.188s KEY_BRIGHTNESSDOWN (224) released
> event6 KEYBOARD_KEY +58.450s KEY_BRIGHTNESSDOWN (224) pressed
> event6 KEYBOARD_KEY +58.450s KEY_BRIGHTNESSDOWN (224) released
> event6 KEYBOARD_KEY +59.230s KEY_BRIGHTNESSDOWN (224) pressed
> event6 KEYBOARD_KEY +59.230s KEY_BRIGHTNESSDOWN (224) released
> event6 KEYBOARD_KEY +63.563s KEY_BRIGHTNESSUP (225) pressed
> event6 KEYBOARD_KEY +63.563s KEY_BRIGHTNESSUP (225) released
> event6 KEYBOARD_KEY +64.109s KEY_BRIGHTNESSUP (225) pressed
> event6 KEYBOARD_KEY +64.109s KEY_BRIGHTNESSUP (225) released
> event6 KEYBOARD_KEY +64.888s KEY_BRIGHTNESSUP (225) pressed
> event6 KEYBOARD_KEY +64.888s KEY_BRIGHTNESSUP (225) released
> event6 KEYBOARD_KEY +65.080s KEY_BRIGHTNESSUP (225) pressed
> event6 KEYBOARD_KEY +65.080s KEY_BRIGHTNESSUP (225) released
> event6 KEYBOARD_KEY +68.559s KEY_WLAN (238) pressed
> event6 KEYBOARD_KEY +68.559s KEY_WLAN (238) released
> event6 KEYBOARD_KEY +69.536s KEY_WLAN (238) pressed
> event6 KEYBOARD_KEY +69.536s KEY_WLAN (238) released
> event6 KEYBOARD_KEY +69.758s KEY_WLAN (238) pressed
> event6 KEYBOARD_KEY +69.758s KEY_WLAN (238) released
> event6 KEYBOARD_KEY +70.304s KEY_WLAN (238) pressed
> event6 KEYBOARD_KEY +70.304s KEY_WLAN (238) released
> event6 KEYBOARD_KEY +71.163s KEY_WLAN (238) pressed
> event6 KEYBOARD_KEY +71.163s KEY_WLAN (238) released
> event6 KEYBOARD_KEY +71.406s KEY_WLAN (238) pressed
> event6 KEYBOARD_KEY +71.406s KEY_WLAN (238) released
> event6 KEYBOARD_KEY +72.412s KEY_WLAN (238) pressed
> event6 KEYBOARD_KEY +72.412s KEY_WLAN (238) released
> -event3 KEYBOARD_KEY +78.318s KEY_LEFTCTRL (29) pressed
> event3 KEYBOARD_KEY +78.321s KEY_LEFTMETA (125) pressed
> event3 KEYBOARD_KEY +78.322s KEY_F24 (194) pressed
> event3 KEYBOARD_KEY +78.480s KEY_F24 (194) released
> event3 KEYBOARD_KEY +78.482s KEY_LEFTMETA (125) released
> event3 KEYBOARD_KEY +78.483s KEY_LEFTCTRL (29) released
> event3 KEYBOARD_KEY +83.436s KEY_LEFTCTRL (29) pressed
> event3 KEYBOARD_KEY +83.439s KEY_LEFTMETA (125) pressed
> event3 KEYBOARD_KEY +83.442s KEY_F24 (194) pressed
> event3 KEYBOARD_KEY +83.556s KEY_F24 (194) released
> event3 KEYBOARD_KEY +83.559s KEY_LEFTMETA (125) released
> event3 KEYBOARD_KEY +83.562s KEY_LEFTCTRL (29) released
> event3 KEYBOARD_KEY +84.578s KEY_LEFTCTRL (29) pressed
> event3 KEYBOARD_KEY +84.581s KEY_LEFTMETA (125) pressed
> event3 KEYBOARD_KEY +84.582s KEY_F24 (194) pressed
> event3 KEYBOARD_KEY +84.660s KEY_F24 (194) released
> event3 KEYBOARD_KEY +84.663s KEY_LEFTMETA (125) released
> event3 KEYBOARD_KEY +84.663s KEY_LEFTCTRL (29) released
> event3 KEYBOARD_KEY +84.821s KEY_LEFTCTRL (29) pressed
> event3 KEYBOARD_KEY +84.824s KEY_LEFTMETA (125) pressed
> event3 KEYBOARD_KEY +84.824s KEY_F24 (194) pressed
> event3 KEYBOARD_KEY +84.902s KEY_F24 (194) released
> event3 KEYBOARD_KEY +84.906s KEY_LEFTMETA (125) released
> event3 KEYBOARD_KEY +84.907s KEY_LEFTCTRL (29) released
> event3 KEYBOARD_KEY +86.505s KEY_NUMLOCK (69) pressed
> event3 KEYBOARD_KEY +86.626s KEY_NUMLOCK (69) released
> event3 KEYBOARD_KEY +87.613s KEY_F10 (68) pressed
> event3 KEYBOARD_KEY +87.754s KEY_F10 (68) released
> event3 KEYBOARD_KEY +93.300s KEY_NUMLOCK (69) pressed
> event3 KEYBOARD_KEY +93.462s KEY_NUMLOCK (69) released
> event3 KEYBOARD_KEY +100.823s KEY_SCROLLLOCK (70) pressed
> event3 KEYBOARD_KEY +100.985s KEY_SCROLLLOCK (70) released
> event3 KEYBOARD_KEY +101.288s KEY_SCROLLLOCK (70) pressed
> event3 KEYBOARD_KEY +101.430s KEY_SCROLLLOCK (70) released
> event3 KEYBOARD_KEY +102.442s KEY_SCROLLLOCK (70) pressed
> event3 KEYBOARD_KEY +102.563s KEY_SCROLLLOCK (70) released
> event3 KEYBOARD_KEY +102.704s KEY_SCROLLLOCK (70) pressed
> event3 KEYBOARD_KEY +102.866s KEY_SCROLLLOCK (70) released
> 
> Here's the same test with a broken kernel -- it only starts responding
> when I get to the keys handled by 'event3':
> 
> + libinput debug-events --show-keycodes
> -event6 DEVICE_ADDED Toshiba input device seat0 default group1 cap:k
> -event12 DEVICE_ADDED Synaptics TM3322-002 seat0 default group2 cap:pg
> size 95x53mm tap (dl off) left scroll-nat scroll-2fg-edge click-
> buttonareas-clickfinger dwt-on dwtp-on
> -event4 DEVICE_ADDED Video Bus seat0 default group3 cap:k
> -event2 DEVICE_ADDED Power Button seat0 default group4 cap:k
> -event1 DEVICE_ADDED Power Button seat0 default group5 cap:k
> -event0 DEVICE_ADDED Lid Switch seat0 default group6 cap:S
> -event3 DEVICE_ADDED AT Translated Set 2 keyboard seat0 default group7
> cap:k
> event3 KEYBOARD_KEY +0.000s KEY_LEFTCTRL (29) pressed
> event3 KEYBOARD_KEY +0.003s KEY_LEFTMETA (125) pressed
> event3 KEYBOARD_KEY +0.005s KEY_F24 (194) pressed
> event3 KEYBOARD_KEY +0.062s KEY_F24 (194) released
> event3 KEYBOARD_KEY +0.066s KEY_LEFTMETA (125) released
> event3 KEYBOARD_KEY +0.066s KEY_LEFTCTRL (29) released
> event3 KEYBOARD_KEY +1.448s KEY_LEFTCTRL (29) pressed
> event3 KEYBOARD_KEY +1.452s KEY_LEFTMETA (125) pressed
> event3 KEYBOARD_KEY +1.453s KEY_F24 (194) pressed
> event3 KEYBOARD_KEY +1.509s KEY_F24 (194) released
> event3 KEYBOARD_KEY +1.511s KEY_LEFTMETA (125) released
> event3 KEYBOARD_KEY +1.512s KEY_LEFTCTRL (29) released
> event3 KEYBOARD_KEY +1.630s KEY_LEFTCTRL (29) pressed
> event3 KEYBOARD_KEY +1.633s KEY_LEFTMETA (125) pressed
> event3 KEYBOARD_KEY +1.633s KEY_F24 (194) pressed
> event3 KEYBOARD_KEY +1.712s KEY_F24 (194) released
> event3 KEYBOARD_KEY +1.715s KEY_LEFTMETA (125) released
> event3 KEYBOARD_KEY +1.717s KEY_LEFTCTRL (29) released
> event3 KEYBOARD_KEY +1.813s KEY_LEFTCTRL (29) pressed
> event3 KEYBOARD_KEY +1.816s KEY_LEFTMETA (125) pressed
> event3 KEYBOARD_KEY +1.818s KEY_F24 (194) pressed
> event3 KEYBOARD_KEY +1.914s KEY_F24 (194) released
> event3 KEYBOARD_KEY +1.917s KEY_LEFTMETA (125) released
> event3 KEYBOARD_KEY +1.918s KEY_LEFTCTRL (29) released
> event3 KEYBOARD_KEY +3.645s KEY_NUMLOCK (69) pressed
> event3 KEYBOARD_KEY +3.705s KEY_NUMLOCK (69) released
> event3 KEYBOARD_KEY +5.745s KEY_SCROLLLOCK (70) pressed
> event3 KEYBOARD_KEY +5.805s KEY_SCROLLLOCK (70) released
> event3 KEYBOARD_KEY +7.430s KEY_SCROLLLOCK (70) pressed
> event3 KEYBOARD_KEY +7.552s KEY_SCROLLLOCK (70) released
> event3 KEYBOARD_KEY +7.957s KEY_SCROLLLOCK (70) pressed
> event3 KEYBOARD_KEY +8.058s KEY_SCROLLLOCK (70) released
> event3 KEYBOARD_KEY +8.402s KEY_SCROLLLOCK (70) pressed
> event3 KEYBOARD_KEY +8.443s KEY_SCROLLLOCK (70) released
> event3 KEYBOARD_KEY +8.604s KEY_SCROLLLOCK (70) pressed
> event3 KEYBOARD_KEY +8.685s KEY_SCROLLLOCK (70) released
> event3 KEYBOARD_KEY +8.928s KEY_SCROLLLOCK (70) pressed
> event3 KEYBOARD_KEY +8.968s KEY_SCROLLLOCK (70) released
> 
> 
> On a working system:
> 
> + udevadm info /dev/input/event6
> P: /devices/LNXSYSTM:00/LNXSYBUS:00/TOS6208:00/input/input8/event6
> M: event6
> R: 6
> J: c13:70
> U: input
> D: c 13:70
> N: input/event6
> L: 0
> E: DEVPATH=/devices/LNXSYSTM:00/LNXSYBUS:00/TOS6208:00/input/input8/event6
> E: DEVNAME=/dev/input/event6
> E: MAJOR=13
> E: MINOR=70
> E: SUBSYSTEM=input
> E: USEC_INITIALIZED=8887326
> E: ID_INPUT=1
> E: ID_INPUT_KEY=1
> E: ID_BUS=acpi
> E: ID_PATH=acpi-TOS6208:00
> E: ID_PATH_TAG=acpi-TOS6208_00
> E: ID_INTEGRATION=internal
> E: LIBINPUT_DEVICE_GROUP=19/0/0:toshiba_acpi
> E: TAGS=:power-switch:
> E: CURRENT_TAGS=:power-switch:
> 
> On a broken system, event6 is still MAJOR=13, MINOR=70 but it has been
> re-assigned to a speaker; meanwhile toshiba_acpi has moved to MAJOR=13
> MINOR=69 and event5:
> 
> $ udevadm info /dev/input/event6 /dev/input/event5
> P: /devices/platform/pcspkr/input/input7/event6
> M: event6
> R: 6
> J: c13:70
> U: input
> D: c 13:70
> N: input/event6
> L: 0
> S: input/by-path/platform-pcspkr-event-spkr
> E: DEVPATH=/devices/platform/pcspkr/input/input7/event6
> E: DEVNAME=/dev/input/event6
> E: MAJOR=13
> E: MINOR=70
> E: SUBSYSTEM=input
> E: USEC_INITIALIZED=9257335
> E: ID_INPUT=1
> E: ID_BUS=platform
> E: ID_SERIAL=noserial
> E: ID_PATH=platform-pcspkr
> E: ID_PATH_TAG=platform-pcspkr
> E: ID_INTEGRATION=internal
> E: LIBINPUT_DEVICE_GROUP=10/1f/1:isa0061
> E: DEVLINKS=/dev/input/by-path/platform-pcspkr-event-spkr
> 
> P: /devices/LNXSYSTM:00/LNXSYBUS:00/TOS6208:00/input/input6/event5
> M: event5
> R: 5
> J: c13:69
> U: input
> D: c 13:69
> N: input/event5
> L: 0
> E: DEVPATH=/devices/LNXSYSTM:00/LNXSYBUS:00/TOS6208:00/input/input6/event5
> E: DEVNAME=/dev/input/event5
> E: MAJOR=13
> E: MINOR=69
> E: SUBSYSTEM=input
> E: USEC_INITIALIZED=9014054
> E: ID_INPUT=1
> E: ID_INPUT_KEY=1
> E: ID_BUS=acpi
> E: ID_PATH=acpi-TOS6208:00
> E: ID_PATH_TAG=acpi-TOS6208_00
> E: ID_INTEGRATION=internal
> E: LIBINPUT_DEVICE_GROUP=19/0/0:toshiba_acpi
> E: TAGS=:power-switch:
> E: CURRENT_TAGS=:power-switch:
> 
> 
> Here's the .config I used while bisecting: https://gist.github.com/
> kousu/4c8b4b1dd35621bc287fd654179ce9fa/
> raw/321d86332f1c8e681fce99f2c23d6762cc185c9a/kernel%2520.config
> 
> Here's my dmesg:
> 
> - working: https://gist.githubusercontent.com/
> kousu/4c8b4b1dd35621bc287fd654179ce9fa/
> raw/6c577488c0477188cf187a04d71e455bc6488204/working.dmesg
> - broken: https://gist.github.com/
> kousu/4c8b4b1dd35621bc287fd654179ce9fa/
> raw/6c577488c0477188cf187a04d71e455bc6488204/broken.dmesg
> 
> (note: it says "toshiba_acpi: Unable to query Hotkey Event Type" but
> that's a red-herring, both versions say that)
> 
> Here is my dmidecode:
> 
> + dmidecode -t system
> # dmidecode 3.7
> Getting SMBIOS data from sysfs.
> SMBIOS 3.1.0 present.
> 
> Handle 0x001E, DMI type 15, 25 bytes
> System Event Log
> Area Length: 124 bytes
> Header Start Offset: 0x0000
> Data Start Offset: 0x0000
> Access Method: General-purpose non-volatile data functions
> Access Address: 0x0003
> Status: Valid, Not Full
> Change Token: 0x00000000
> Header Format: No Header
> Supported Log Type Descriptors: 0
> 
> Handle 0x0025, DMI type 32, 11 bytes
> System Boot Information
> Status: No errors detected
> 
> Handle 0x0013, DMI type 1, 27 bytes
> System Information
> Manufacturer: TOSHIBA
> Product Name: TECRA X40-E
> Version: PT482C-06D00UHQ
> Serial Number: [REDACTED]
> UUID: bffba9c3-e4c8-4d87-8665-b3172752031a
> Wake-up Type: Other
> SKU Number: PT482C
> Family: TECRA
> 
> Handle 0x001C, DMI type 12, 5 bytes
> System Configuration Options
> Option 1: GSW:1000000000
> 
> + dmidecode -t bios
> # dmidecode 3.7
> Getting SMBIOS data from sysfs.
> SMBIOS 3.1.0 present.
> 
> Handle 0x0012, DMI type 0, 26 bytes
> Platform Firmware Information
> Vendor: TOSHIBA
> Version: Version 2.50
> Release Date: 10/19/2021
> ROM Size: 8 MiB
> Characteristics:
>  PCI is supported
>  Firmware is upgradeable
>  Firmware shadowing is allowed
>  Boot from CD is supported
>  Selectable boot is supported
>  EDD is supported
>  Print screen service is supported (int 5h)
>  8042 keyboard services are supported (int 9h)
>  Serial services are supported (int 14h)
>  Printer services are supported (int 17h)
>  ACPI is supported
>  USB legacy is supported
>  BIOS boot specification is supported
>  Function key-initiated network boot is supported
>  Targeted content distribution is supported
>  UEFI is supported
> Platform Firmware Revision: 2.50
> Embedded Controller Firmware Revision: 1.40
> 
> Handle 0x001D, DMI type 13, 22 bytes
> Firmware Language Information
> Language Description Format: Abbreviated
> Installable Languages: 2
>  enUS
>  frCA
> Currently Installed Language: enUS
> 
> 
> Please let me know if if I can provide any more information. I could
> provide acpidump if that's helpful.
> 
> Thank you for your work :)
> 
> - kousu
> 
> 
> 


