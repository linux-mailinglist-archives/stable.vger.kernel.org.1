Return-Path: <stable+bounces-244351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOCRLuMG+2mbVQMAu9opvQ
	(envelope-from <stable+bounces-244351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:16:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC124D8744
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CA34300DD62
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9839B971;
	Wed,  6 May 2026 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODNh/plo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E162D1907;
	Wed,  6 May 2026 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058973; cv=none; b=dEn6sNO2N2z7FuM+DnT8YXYROZl01c8w0KdtC1lPJrQir04WQfoXfA0KpIXB6ns4ADZoIOEYLlzUMEpcUh9MhQtizSwdsNGF/7Tz1G+K0jhFOI8/SkRNi3b03ZcXOefhOS4ktOzGjcrUzUkW4n+jlInvvVJ6gyePhC0wi/3+Mgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058973; c=relaxed/simple;
	bh=1kYG0k2tEVtubWrZEIB0wmkkpyz8/sB/Ms4TujhtBms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od47OfNcEOSbfDXj6S3X3FFHn6/jgxSjKfDu2waOBcBTd7VGRv70a6Yz9vliEWiOxRU1Lp09rJTEjWmvmifCltWdGhCRFLJuTRSjjEWBRMhVvH0b2/8OhPAT2hS29f4xK79ERBe+f5u79aUBxfbQMcs5NnRil1k/CKsjUAtkofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODNh/plo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C31C2BCB8;
	Wed,  6 May 2026 09:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778058972;
	bh=1kYG0k2tEVtubWrZEIB0wmkkpyz8/sB/Ms4TujhtBms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODNh/plooM7UycNr844RLfOUm4vHHusx1hm5rm4AUkC6eJPcnunHvk/oYolPGPgUy
	 GOMQ7hZKjVwa7/+hCQpFJEdyTVtgPoXdQ7KlU+KUtrfVwZa/qAltkSRBpFgZ2ADB4y
	 s2VflufvWVXD9/rV5Seoh0IDCoCvjHLFnRyQ2kkoEfIGYI8/yE5GhZbWa7CZ7jiPha
	 FVIyhNSMz90vdixi2FrlM7gxP1ui0UXK240uOhqoTWMCoh1ySdL9vB9R41qk6AFkdK
	 KsUbHQCKyYP7d/nKwe9WDG2OX5XRWcfrwHNG6jfoVOzCIXAAaDaBX5NPzUlumDI90L
	 fg5P606Bw1d9g==
Date: Wed, 6 May 2026 10:16:06 +0100
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Icenowy Zheng <uwu@icenowy.me>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/4] HID: Proper fix for OOM in hid-core
Message-ID: <20260506091606.GB305027@google.com>
References: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
X-Rspamd-Queue-Id: 2BC124D8744
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244351-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 04 May 2026, Benjamin Tissoires wrote:

> Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()") enforced the provided data to be at least the size of
> the declared buffer in the report descriptor to prevent a buffer
> overflow.
> 
> We only had corner cases of malicious devices exposing the OOM because
> in most cases, the buffer provided by the transport layer needs to be
> allocated at probe time and is large enough to handle all the possible
> reports.
> 
> However, the patch from above, which enforces the spec a little bit more
> introduced both regressions for devices not following the spec (not
> necesserally malicious), but also a stream of errors for those devices.
> 
> Let's revert to the old behavior by giving more information to HID core
> to be able to decide whether it can or not memset the rest of the buffer
> to 0 and continue the processing.
> 
> Note that the first commit makes an API change, but the callers are
> relatively limited, so it should be fine on its own. The second patch
> can't really make the same kind of API change because we have too many
> callers in various subsystems. We can switch them one by one to the safe
> approach when needed.
> 
> The last 2 patches are small cleanups I initially put together with the
> 2 first patches, but they can be applied on their own and don't need to
> be pulled in stable like the first 2.
> 
> Cheers,
> Benjamin
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Changes in v3:
> - fixed ghib -> ghid in greybus
> - fixed i386 size_t debug size reported by kernel-bot
> - Link to v2: https://lore.kernel.org/r/20260416-wip-fix-core-v2-0-be92570e5627@kernel.org
> 
> Changes in v2:
> - added a small blurb explaining the difference between the safe and the
>   non safe version of hid_safe_input_report
> - Link to v1: https://lore.kernel.org/r/20260415-wip-fix-core-v1-0-ed3c4c823175@kernel.org
> 
> ---
> Benjamin Tissoires (4):
>       HID: pass the buffer size to hid_report_raw_event
>       HID: core: introduce hid_safe_input_report()
>       HID: multitouch: use __free(kfree) to clean up temporary buffers
>       HID: wacom: use __free(kfree) to clean up temporary buffers
> 
>  drivers/hid/bpf/hid_bpf_dispatch.c |  6 ++--
>  drivers/hid/hid-core.c             | 67 ++++++++++++++++++++++++++++++--------
>  drivers/hid/hid-gfrm.c             |  4 +--
>  drivers/hid/hid-logitech-hidpp.c   |  2 +-
>  drivers/hid/hid-multitouch.c       | 18 ++++------
>  drivers/hid/hid-primax.c           |  2 +-
>  drivers/hid/hid-vivaldi-common.c   |  2 +-
>  drivers/hid/i2c-hid/i2c-hid-core.c |  7 ++--
>  drivers/hid/usbhid/hid-core.c      | 11 ++++---
>  drivers/hid/wacom_sys.c            | 46 +++++++++-----------------
>  drivers/staging/greybus/hid.c      |  2 +-
>  include/linux/hid.h                |  6 ++--
>  include/linux/hid_bpf.h            | 14 +++++---
>  13 files changed, 109 insertions(+), 78 deletions(-)

What's the plan for this set Benjamin? -rcs or -next?

-- 
Lee Jones

