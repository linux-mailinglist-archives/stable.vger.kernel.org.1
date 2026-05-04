Return-Path: <stable+bounces-242966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jTLME45n+GnuuAIAu9opvQ
	(envelope-from <stable+bounces-242966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:31:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE53B4BAF21
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B4C1300678C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEA737BE6F;
	Mon,  4 May 2026 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTvNNvOy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB50934CFD6;
	Mon,  4 May 2026 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887112; cv=none; b=sI/mOremAkVfYGh/a7K/qwjQgxca5FY9a18DMIf9X2HRdQYdN80ZwqlYaYsA/VuyteCR/razdKpqWm8YcbYht+rj7S++lNr2jHZ2uSWbmxNf/0OfQZJiXa7LeRVOsTS5CqOd+P2Vipugkr0G9xzV0HsenRkGnklNG4JXUhUcv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887112; c=relaxed/simple;
	bh=jK7LX7CZZc6vAL2TRvrSWHbkmr37igAqzuml4yVAFMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc4/z4+D+DNwlmVaUTpnGsPMGCNSanFL+O36pCyEBjXAvTiU4OI2INXCTcjrA9IQ9kkRrcCY+O6obGIffWBrBp9Uyuz6ZKZqsAVLl1ZLefuc9fDkrCxEC7CRVBS7uz2NgIvvqxbjQWBSNEPOZDxkjmpNy7BCYG3Or0etUiBPiRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTvNNvOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44684C2BCB8;
	Mon,  4 May 2026 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777887112;
	bh=jK7LX7CZZc6vAL2TRvrSWHbkmr37igAqzuml4yVAFMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTvNNvOyUQnDUk9HijCP1jx6eqymW90Q2cpLkrTh1jI6gWBTDeMbyWor3SN0lwKj+
	 M0h0EugNAbetQIZMYZkAUA4ocRZ811PTHm7lP6IImzjzYLtwtJ0fz4/z9Pz4ESTKv1
	 HWN/kH9H4IIKCI/6VzEIrk2VwohVB//h70GOr4pgLGbanl7NBwozKCJXdfJiIZDCes
	 Af55zZ+jcDOHWQ1KeJ/rgnUTrCmLnMLv7txxD+NJkpB2XcbQZkO60AYTbhQv90MvLL
	 cAlYdDz0D7XYBwnctqLCyYq8Km+tHst7XO5iV2pwfXuSqZBcQlYaD3kf19MqspdZab
	 YKA+y+CGsEd5Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wJpeX-00000001lnX-2NlD;
	Mon, 04 May 2026 11:31:49 +0200
Date: Mon, 4 May 2026 11:31:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Viresh Kumar <vireshk@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] HID: pass the buffer size to hid_report_raw_event
Message-ID: <afhnhcMVSBLYboEo@hovoldconsulting.com>
References: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
 <20260504-wip-fix-core-v3-1-ce1f11f4968f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-wip-fix-core-v3-1-ce1f11f4968f@kernel.org>
X-Rspamd-Queue-Id: CE53B4BAF21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242966-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Mon, May 04, 2026 at 10:47:22AM +0200, Benjamin Tissoires wrote:
> commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()") enforced the provided data to be at least the size of
> the declared buffer in the report descriptor to prevent a buffer
> overflow. However, we can try to be smarter by providing both the buffer
> size and the data size, meaning that hid_report_raw_event() can make
> better decision whether we should plaining reject the buffer (buffer
> overflow attempt) or if we can safely memset it to 0 and pass it to the
> rest of the stack.
> 
> Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c |  6 ++++--
>  drivers/hid/hid-core.c             | 42 +++++++++++++++++++++++++-------------
>  drivers/hid/hid-gfrm.c             |  4 ++--
>  drivers/hid/hid-logitech-hidpp.c   |  2 +-
>  drivers/hid/hid-multitouch.c       |  2 +-
>  drivers/hid/hid-primax.c           |  2 +-
>  drivers/hid/hid-vivaldi-common.c   |  2 +-
>  drivers/hid/wacom_sys.c            |  6 +++---
>  drivers/staging/greybus/hid.c      |  2 +-

The Greybus change builds fine now:

Acked-by: Johan Hovold <johan@kernel.org>

>  include/linux/hid.h                |  4 ++--
>  include/linux/hid_bpf.h            | 14 ++++++++-----
>  11 files changed, 53 insertions(+), 33 deletions(-)

Johan

