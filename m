Return-Path: <stable+bounces-262531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fbi6CO6QKWrVZgMAu9opvQ
	(envelope-from <stable+bounces-262531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:29:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6106E66B7A2
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:29:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QYzRmzWU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262531-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262531-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 355CB35A8637
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9D438FFE;
	Wed, 10 Jun 2026 15:49:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6942EEDA;
	Wed, 10 Jun 2026 15:49:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106554; cv=none; b=p/w23ZtF0qchB5FgABFOEvATkNr3G1M1ejwiEAsIdcR4BA909ynnHttQzhTC9WyQOQ3/wZmwopDnH04z8EYeUQdD9BlDMffGgH2gS6a+Y33aKIcs/vtdY0v8uNwGIyRI+gFnRFUhQF943XHZJF/DXIq21KfSJLgaqNHVJWh6VkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106554; c=relaxed/simple;
	bh=lw/YhXsIeU7NOrU9PiYQ9fZo1hmL45YGBzMzMm77OHg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OMa+bZZqrMeUgBgAWI2x6kj4FmIRcxEnJ9lrrnC4p/Ps4VEVu+hBbw9FH+35a2Q3nVd3E90XDwy3MaaSTr14rla7JjsgS/st4Wln2bicFpBYcyq2I3NfKXonv0PRo0wed8kyeSfbmrz27i9xVfU0K5puSynsbMjSMtbgm1OrwMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYzRmzWU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004121F00898;
	Wed, 10 Jun 2026 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106553;
	bh=e+YlvzaUoI0gKhrkq5d9qFwyHnzNTSPSorvr8Xds2AE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=QYzRmzWUVVJ7BW2ggFTiHHCOQ5e9sUBhriT09CY6uHti8UWQ1UE+763sviqcCWPHJ
	 YkXbwzAI0CbSShULS79X1c7d0WpRrnbubp24E6Rg92JzYHfixizOQVybLU8spr4wP5
	 /+pjLP/huKYy8TQ4oBRJRMAKFC3L72aaM6/5BzEMtBOVEgQbOUwml0ohA7ezbREDNz
	 AF4uxwq66Tyourit1F0tCwc/D7Twg6diE4AZYlwIQXGxq1wc9KHBHaSJ6RZynuk5bo
	 mfgsW9DURtUWTlaPO8dxDpPMHtYY0BzhWKF8LUL7eLy9JBf565f1+bmIQvsdq39M1n
	 I4EunVPHxxYAw==
Date: Wed, 10 Jun 2026 17:49:09 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Ijae Kim <ae878000@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: stop hardware after post-start probe
 failures
In-Reply-To: <20260604045710.25512-1-mhun512@gmail.com>
Message-ID: <q6s5p2n6-0288-4p74-5qo8-o0qso665r1r0@xreary.bet>
References: <20260524175552.1973-1-mhun512@gmail.com> <20260604045710.25512-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262531-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:ping.cheng@wacom.com,m:jason.gerecke@wacom.com,m:bentiss@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ae878000@gmail.com,m:dmitry.torokhov@gmail.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[wacom.com,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xreary.bet:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6106E66B7A2

On Thu, 4 Jun 2026, Myeonghun Pak wrote:

> wacom_parse_and_register() starts HID hardware before registering inputs
> and initializing pad LEDs/remotes. Those later steps can fail, but their
> error paths currently release Wacom resources without stopping the HID
> hardware.
> 
> Route post-hid_hw_start() failures through hid_hw_stop() before
> releasing driver resources.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: c1d6708bf0d3 ("HID: wacom: Do not register input devices until after hid_hw_start")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> Changes in v2:
> - Drop fail_quirks and use fail_hw_stop for every post-hid_hw_start()
>   failure path, as suggested by Dmitry.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


