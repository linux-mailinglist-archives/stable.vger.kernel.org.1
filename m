Return-Path: <stable+bounces-245835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFSFKrNQA2qR4QEAu9opvQ
	(envelope-from <stable+bounces-245835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:09:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485B52460A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B770304290A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE43C8C69;
	Tue, 12 May 2026 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvtoakmb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B193A59A7;
	Tue, 12 May 2026 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601895; cv=none; b=t5uHkXhcVBFXJm2FeZHgCyBzcOPbFb4kERazlcY3YppZGCXTr4XE6cP28+y1QJ3D1ufYhIpObh2wViMcZGG+w+NIj4RfLKaYi+j5PHoxIx+2JYgw3gQx2p/DRaruxzvtDZWTxUNOMPWnlPE+X6+rSfkjCFgYHaBzN878mkM7Xlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601895; c=relaxed/simple;
	bh=yNslzli12YKyZvlTHWY9UvoN4jJ9sdRDmcEAHEZTQQ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q38/b8T938GxbxpA/vUzixQzmrrgeK8dArBARWUarwUyGgS6/mdE+Eo8r+uxAo2c76UMGbH+0d66KqYyWbQCd/8fgWu412IpoCCqWfnCha2vxZXAiKL6CcecSq+kksUhm7I9AhRp/7Pre6sEqT2uTndafmffvUEqJVqKsSf37FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvtoakmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E61AC2BCB0;
	Tue, 12 May 2026 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601895;
	bh=yNslzli12YKyZvlTHWY9UvoN4jJ9sdRDmcEAHEZTQQ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Rvtoakmb0htAdo8CaX4xrzAbM8hNYEEz/rLZWgwEdvN8mYD+fJuxiqRV+mKAf0URC
	 KtSOqk1VeAwcBMoXShBGQJraFn3cLRADuvh+XgwMEeX/vOFrL7636Gq0p1rsA0AkU6
	 guhdqOjGfJUp4mw0eRN8SrovG5TQePor5nXmqc7yHnB/9NAbu24YRLYT9ffLXbMGIs
	 ObLcTsT+jTSD3VJew+bWvotIn1Vh0dshpQ44Oh4kZfTYa6L0Qb+oF+dxNa5N4BKnY9
	 Mm017n3Jx/j+ElLTvwaBtcc51UizLCSONG4bYDbpWqnUdIXztV+TvMYixhYpmAgq+N
	 XTj2YaNC6yaBQ==
Date: Tue, 12 May 2026 18:04:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, Ping Cheng <ping.cheng@wacom.com>, 
    Jason Gerecke <jason.gerecke@wacom.com>, Viresh Kumar <vireshk@kernel.org>, 
    Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Lee Jones <lee@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
    linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/4] HID: Proper fix for OOM in hid-core
In-Reply-To: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
Message-ID: <op9823q8-55ss-91s3-7690-q5prq170s265@xreary.bet>
References: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 6485B52460A
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
	TAGGED_FROM(0.00)[bounces-245835-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xreary.bet:mid]
X-Rspamd-Action: no action

On Mon, 4 May 2026, Benjamin Tissoires wrote:

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

I have now queued the first two in hid.git#for-7.1/upstream-fixes.

I expect the remaining two will be applied once respun with Dmitry's 
suggestion on proper guarding.

Thanks,

-- 
Jiri Kosina
SUSE Labs


