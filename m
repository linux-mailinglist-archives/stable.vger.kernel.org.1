Return-Path: <stable+bounces-222607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN4QLLqapWnxEgYAu9opvQ
	(envelope-from <stable+bounces-222607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:12:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A381DA719
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE3B73059AB1
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE9A3F23DD;
	Mon,  2 Mar 2026 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKLiSzKJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF73FB066
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460357; cv=none; b=Zcu2Wd9Av0e44ahe+CE62S/8RI5PHNotHHV/wK08sbKKUM9MKvpEro9Jdgvipp/vm5V2O5EjB1/TFgPWiCbqYfLgpmuakCIigmHhZZu16+TY4fmaj1N4W4F5KUqIzoB9N+M7/7M4AZgctDMK5Lk7kFwvGJuaLq7doQ3OhVs9tQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460357; c=relaxed/simple;
	bh=QXoOraSuBz+Dt8jV1pHCfQO70vsAR0gJLEmUXyrxxEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGMUTCkUo6H0qveFHiVYoOnyqTW/84CLlnVSLjFEXDPcndlcPfOP58NnoWCH7cScPU99bsfa9gJozJod68jKduZh8qXL4WFqmeaATRgJAHenwcY69RDS4Q5hhTvpccKsIvZlqMFT5/ywFnNq0BeEqfABXYzW4TaayaXCayyrZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKLiSzKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7341CC19423;
	Mon,  2 Mar 2026 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460356;
	bh=QXoOraSuBz+Dt8jV1pHCfQO70vsAR0gJLEmUXyrxxEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKLiSzKJImMMklWAz+8bSgbFCe7SpYJ+MVyx8+0/8/ln5o3au1QRnOuEQLXkkDk2n
	 IpSPIWM+EpCLBaXNaggNZosOk40fGwoOIGJonvigT5r5aTqfh9akXi3lZBKa+ghngh
	 dfXMx3s/6DbvA20j2xPRJGtWXqLJGCxpdKmzcrAuSML+1CHHLkrakfnIoMNFEEQdQ1
	 ltaUX0KpDKepeaQEChaJXoZ9V9tyw79ALUrcdzmZzesfe/tFuvtIBRkL7JGr5+yB8X
	 +jHSFUVM/QHYQFSsVNOWjcMy/fd8mN4yDe/zhUYoOdLMHO9Fdj3k1jS0pQ9TEV7xvc
	 BK5LdXEMSMwFw==
Date: Mon, 2 Mar 2026 09:05:55 -0500
From: Sasha Levin <sashal@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: Consider applying patch to 6.12.y
Message-ID: <aaWZQ5JG4ndWDxov@laps>
References: <CANiq72mESZc2RfL2_5wt=LEg6M_7TZ__uELZ2tN=XGwB5Md_vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANiq72mESZc2RfL2_5wt=LEg6M_7TZ__uELZ2tN=XGwB5Md_vg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222607-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37A381DA719
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 02:15:49AM +0100, Miguel Ojeda wrote:
>Hi Greg, Sasha,
>
>Sending this separately in case you don't track all replies to the
>`FAILED:` messages:
>
>  https://lore.kernel.org/rust-for-linux/CANiq72nHESphKjW7uXm2D7HCNWNxmZ3nv+CSgrzEGgSKZ4_taA@mail.gmail.com/
>
>I am not sure why the patch failed to apply -- I would like to
>understand what happened there, in case I am missing something. I
>suspect something odd happened, since other of those `FAILED:`
>messages were strange too, i.e. most of them didn't seem to apply the
>`# ...` instructions, which is why most failed.
>
>But at least for that particular one, the patch should still be
>applied and it should have been cherry-pickable as far as I can tell:
>
>  0a9be83e57de ("rust: kbuild: pass `-Zunstable-options` for Rust 1.95.0")
>
>So if you cannot apply it, please let me know!

Hi Miguel,

It's already in the 6.12 tree. There's a quick explanation of what went wrong
with those queues (and caused the FAILED: spam) here:
https://lore.kernel.org/all/aaWWE5uQqz_eG69i@laps/ .

I'll spin up -rc2 with those missing commits.

-- 
Thanks,
Sasha

