Return-Path: <stable+bounces-249557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGC5Jq9JDGoMdAUAu9opvQ
	(envelope-from <stable+bounces-249557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:29:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A43B457D9E6
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5538030B36A3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9E5494A0C;
	Tue, 19 May 2026 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TINSegdQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF648AE1D;
	Tue, 19 May 2026 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189239; cv=none; b=s1ijFVWWpLyY3cbXTTPNKJuw8yen4dxT9iyyvWg7h9mmDyO3X0uRO3XGERDZxGHjQ11kBgKcpFI7hbfLtsiPUNMS7Cy6tFOw2Een6kMkvx/n4ettK4PGuHf/GzKNfPIyQnZhjFbCZDogWwg6rMFwza0Un5trZOEo/Pj1vhK1JLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189239; c=relaxed/simple;
	bh=mfa9SifBsP6J8LO5EKlvOvLigWU4xg3oCF/9wKmqQeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpSlAUazcE0k7Kr/FjIckT7Ri/TZsci9i1YoNow7p2ZlHbHZdkJg2Bzano3tCDwbGBcxPDd4wDuGu+0wvGIjiNTHjCGb9mTSXoVkFkfPMY00rBIR3JJVC/iS+EZ7dkLjVVW6YRXVccDWcw30TelX1orIkCNyw5y6afYL18MgFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TINSegdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130F3C2BCF6;
	Tue, 19 May 2026 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779189238;
	bh=mfa9SifBsP6J8LO5EKlvOvLigWU4xg3oCF/9wKmqQeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TINSegdQ+UDTB7rVfCHhUs/rdE3ytigX9A4BdoHdLu1rGN8SqmQS7VdUE3pIBW0hU
	 rwIXtyiYtEmBHYgKtNyuZv55/25EGbgTd35wFbw7iCd+22NB3AmwrMVEkiHykgPBzX
	 rYp92El0+gN5tE6nQj8JDS18grnn1RgoJtaZt125Xo3Uy18u+wGkoyHnnY3Eg7k1g2
	 7F0+hLsOzU1cruUDNxF08AhRexpixj1MsUjP2nxG3zd0Ken8LmczF+ODmD/El4T7YJ
	 l5j9TjKBOT3DdMEdFYdLF880EzspbcUrGwQb9TO4B0WLtIJVV/gVc3wtq0hzsGWTUl
	 W25qeKIZ/P+fg==
Date: Tue, 19 May 2026 12:13:54 +0100
From: Lee Jones <lee@kernel.org>
To: Ping Cheng <pinglinux@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: Fix OOB write in
 wacom_hid_set_device_mode()
Message-ID: <20260519111354.GT305027@google.com>
References: <20260513075935.1715836-1-lee@kernel.org>
 <CAF8JNhKTMpT3CGq_oDqaGVygqXK0jjvrvjxbAWUerqtWzdB9+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8JNhKTMpT3CGq_oDqaGVygqXK0jjvrvjxbAWUerqtWzdB9+Q@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249557-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,wacom.com:email]
X-Rspamd-Queue-Id: A43B457D9E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 13 May 2026, Ping Cheng wrote:

> On Wed, May 13, 2026 at 1:05 AM Lee Jones <lee@kernel.org> wrote:
> >
> > wacom_hid_set_device_mode() currently assumes that the HID_DG_INPUTMODE
> > usage is always located in the first field (field[0]) of the feature report.
> > However, a device can specify HID_DG_INPUTMODE in a different field.
> >
> > If HID_DG_INPUTMODE is in a field other than the first one and the first
> > field has a report_count smaller than the usage_index of HID_DG_INPUTMODE,
> > this leads to an out-of-bounds write to r->field[0]->value.
> >
> > Fix this by storing the field index of HID_DG_INPUTMODE in 'struct
> > hid_data' during feature mapping.  In wacom_hid_set_device_mode(), use
> > this stored field index to access the correct field and add bounds
> > checks to ensure both the field index and the value index are within
> > valid ranges before writing.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 5ae6e89f7409 ("HID: wacom: implement the finger part of the HID generic handling")
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> Patch looks sensible to me. Thank you for your effort, Lee!
> 
> Tested-by: Ping Cheng <ping.cheng@wacom.com>
> Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

Thank you Ping, I appreciate your review.

HID folks - any movement on this please?

-- 
Lee Jones

