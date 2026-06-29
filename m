Return-Path: <stable+bounces-269697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RDQgCX48QmrJ2QkAu9opvQ
	(envelope-from <stable+bounces-269697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:35:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E66D8495
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:35:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nsI5JgCR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269697-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269697-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0C3230172FD
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498473F9A0F;
	Mon, 29 Jun 2026 09:18:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4E3FC5BE;
	Mon, 29 Jun 2026 09:18:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724705; cv=none; b=SmNA+4P4ElJz1qHa0ySoQrvDa7ZDcCnohsumHzv3iJFkxB1rnUnEN3pMfGRvDnK6WfyQ0xq5gztyELox/YYXMlP9TFAWb2kIubsOFqATWvo/s3iZ/FFFZwx8VuDB9pLtLMfxQEhve6WqRwnweECg6Ori/RzTxyDN04LSsqquozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724705; c=relaxed/simple;
	bh=sJKNtE95R5L+yo7q9jl3+KbIcC66zPXSE+Ab5FZZs7o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tSbL9751ZxOzRTHDPIDiKQ6zs11PAWHxqNlIrTqhu/Z7YOgb1fcBItDDDdMMnsxtjNtH8d9QWfCuDw+aDMj2UeptEC6lUDlwIYLir6xy+q1YkSt1VT3/Ztn1U5bsn+iS1LNsaEyJe8m15n3N+pW7LF99/vZpz48uO90+O/ZuMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsI5JgCR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7F11F000E9;
	Mon, 29 Jun 2026 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782724703;
	bh=7JktU4sf7enyE9ymlnEnWDK2ubbaQM7VRZFQOV/uzsw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=nsI5JgCREXFgGS/h6fw5pb7ioF6D/w6HGbVK0PphL9vzHMAPIYlJAEo1eRDYqhUVm
	 QUCFg54pedBvK9iRJH8hURe9aDSBiCtQ37wW8qArBow/fSSntWsOTSz6bHYtUiVACf
	 /DKuGHNr/6bed38uAUUMDxDhwCUF2E9WzyXSkQX/KV+QdcEzJcefV57Pddh5/Scg3K
	 KDyInWNXfCjjVTCMODZvcxcGico4rxI21qZFKEb5NRxPALggLDqpITH4Hv7qAGvx67
	 EmxyHU0lGWmxRSTp2IsKc35tBA5sWjKgYE7TWcqpCDZxUyjIQaS6tcvuB1DyqTHW35
	 v5jM4K4jVC/Zw==
Date: Mon, 29 Jun 2026 11:18:21 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: HyeongJun An <sammiee5311@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-dj: Fix maxfield check in DJ short report
 validation
In-Reply-To: <20260618063737.211468-1-sammiee5311@gmail.com>
Message-ID: <5s454s07-8sso-p157-9047-o3o5r1276p86@xreary.bet>
References: <20260618063737.211468-1-sammiee5311@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sammiee5311@gmail.com,m:bentiss@kernel.org,m:lains@riseup.net,m:lee@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269697-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xreary.bet:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D1E66D8495

On Thu, 18 Jun 2026, HyeongJun An wrote:

> Commit b6a57912854e ("HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT
> related user initiated OOB write") added validation for the DJ short
> output report, but the error path dereferences rep->field[0] even when
> rep->maxfield is zero.
> 
> Commit 8b9a097eb2fc ("HID: logitech-dj: fix wrong detection of bad
> DJ_SHORT output report") made the check conditional on rep being present,
> but a crafted descriptor can still create report ID 0x20 with only padding
> output items. hid-core registers the report, ignores the padding field,
> and leaves rep->maxfield as zero.
> 
> In that case the validation enters the rep->maxfield < 1 branch and then
> dereferences rep->field[0]->report_count while printing the error message,
> causing a NULL pointer dereference during probe. This is reproducible with
> uhid by emulating a Logitech receiver with a padding-only DJ short output
> report:
> 
>   BUG: KASAN: null-ptr-deref in logi_dj_probe+0xb1/0x754 [hid_logitech_dj]
>   Read of size 4 at addr 0000000000000028 by task kworker/4:1/129
>   ...
>   Call Trace:
>    logi_dj_probe+0xb1/0x754 [hid_logitech_dj]
>    hid_device_probe+0x329/0x3f0 [hid]
>    really_probe+0x162/0x570
>    __device_attach+0x137/0x2c0
>    bus_probe_device+0x38/0xc0
>    device_add+0xa56/0xce0
>    hid_add_device+0x19c/0x280 [hid]
>    uhid_device_add_worker+0x2c/0xb0 [uhid]
> 
> Reject the zero-field report before printing the field report_count.
> 
> Fixes: b6a57912854e ("HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related user initiated OOB write")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


