Return-Path: <stable+bounces-260465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6CppBUVjIWpKFgEAu9opvQ
	(envelope-from <stable+bounces-260465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 13:36:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C563F79C
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 13:36:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="E7/qztfG";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260465-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260465-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6836B30A1C36
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7AB41C31D;
	Thu,  4 Jun 2026 11:31:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D93402442;
	Thu,  4 Jun 2026 11:31:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572713; cv=none; b=JxmsNssTps+w6iFSjDA3RPZldXD1jZ/02Em2gjQHPfYfcxk3rQDgRuoDUqkDWm2nINLOI/8EA1G4fg1KIOFD4eC8LLKLxOJjCknEJ4ARdY1pPVTfhwogm94JZkPE0/UrSit0JSEWiGNeHUZPOUK0jhPQKhbO61DAtNuGhIYDbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572713; c=relaxed/simple;
	bh=bsa1jnN9EKkBwXlgr8xmI7rOSZf5eJ5lbPwcqhxOq30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzJx0EUYYd/BfjiFeJUz3TAptWS0yx+fMsaWbhP8KCBXPuZ4o3EpFAlobYGeAB87Tueh5SJqv/UUHs4RJUaKbBrJ2yeNrMhDwwyiJvusFYGu5Gck6jsVE3PyDaoIR6OCSJhTNJ+XBLxTtI65mmjPm3PzIWEK2xbMbUr2k6XnYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7/qztfG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5FB1F00893;
	Thu,  4 Jun 2026 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780572712;
	bh=AIzXNElv+eVz+Fw+Twv7xF83NqwaQAYmHeMAronAqWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E7/qztfGUd2WYES2vdR4LejTuRUMtP7fi8vsZaeGe7wh3E7uymM+7ULRqOuHv0zjM
	 Mdsfhkz7cQhdsWtcwrwhoqRnX/UFvquE0c0skBUnrsLY8gyNKUOxSgq+3wpzVhq1FN
	 UFFzEUF4jM+cTeoeNfmOK8FycGv4oAvQNKeXqe78glhWlilVnL0g9zTvDxlsIzJOM+
	 xc323UeBu1XV4TrEM382xBlXdoh3g3Fs+d8+2blbNmXKWGhYd9IHYvXZRRkpx+qmyj
	 db8O+bL1+CEfptZ60CCkyL9V/B3loYpfhhYjEpMufVrEp844tgZdhYT2iAIPUuNtF7
	 r29Ofu/CcjRTw==
Date: Thu, 4 Jun 2026 13:31:48 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci_brcm: fix reset refcount leak in
 brcm_ahci_resume()
Message-ID: <aiFiJJPOQgQABuXm@ryzen>
References: <20260603102420.3735032-1-vulab@iscas.ac.cn>
 <aiFNiWf7bs2pmPFh@ryzen>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiFNiWf7bs2pmPFh@ryzen>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:f.fainelli@gmail.com,m:dlemoal@kernel.org,m:linux-ide@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[iscas.ac.cn,gmail.com];
	FORGED_SENDER(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-260465-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 880C563F79C

On Thu, Jun 04, 2026 at 12:03:53PM +0200, Niklas Cassel wrote:

(snip)

> The documentation for reset_control, explicitly says not to do this:
> https://github.com/torvalds/linux/blob/v7.1-rc6/drivers/reset/core.c#L365-L366
> 
> And in libahci_platform.c, we always do either:
> return reset_control_rearm() or return reset_control_reset():
> https://github.com/torvalds/linux/blob/v7.1-rc6/drivers/ata/libahci_platform.c#L188-L193

I realize that I am stupid...

The code is doing it on two different reset handles.

My comment that the cleanup in brcm_ahci_resume() should match that in
brcm_ahci_resume() probe still stands.

i.e. you should also add a call to:
reset_control_assert(priv->rcdev_ahci);

And you should do it after disabling clocks, just as brcm_ahci_resume().


Kind regards,
Niklas

