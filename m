Return-Path: <stable+bounces-241785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KcHHWMy8WkgegEAu9opvQ
	(envelope-from <stable+bounces-241785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:19:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE048C864
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 031F430333B0
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC993612D7;
	Tue, 28 Apr 2026 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRjobvbt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE739326938;
	Tue, 28 Apr 2026 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414749; cv=none; b=bhWhwwSonD0jmwGw2hkG7rhgoR9gRvy25RiRBtwbI78ShYpDzGhmv27jJwYIzTGaqfzrIHy9UJAmhvr0uliRAczZWeZ54gBLWcHn1yYHCOzGYfjB7Ccey9OZCkXvBqVMG8GjykCuWErFPYQvMGCVudsPueGCrVbMFgTF8QsP2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414749; c=relaxed/simple;
	bh=2ydHrepadZAfQ2jtcURiGR0LxBj8zKyg9diPS+eZSWI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dtSKg5mFshn4JzAoP+1TEIie/MqWqVFuNJnYzPlEyipnr0YlKmJtO9JZbuPz/u9mq9f1XCuJxu+ASWXviOmm22k76TyYeexDJMF028G+ig77SS72BUJUpMnv19SrSKAq6lE06uMOTcXevFnixpjJAzVakCL0+R60UTDebdeBv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRjobvbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C8EC2BCAF;
	Tue, 28 Apr 2026 22:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777414749;
	bh=2ydHrepadZAfQ2jtcURiGR0LxBj8zKyg9diPS+eZSWI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qRjobvbtVbeFDfg/YvTKRsCetqwfC2ueOHYv+6+63L5xiO+ZwC1FpVs4D/kGNQoE/
	 61gNEC+X+nR/HJMZHzmruqKZqSg1FFuNw+xc/sWztSFCOcuhxLW8xi/cQTFJr39JGq
	 a+z3Y5yQ5B7AD8GIDn5V6/KeYFCCgefqEmhQULGjU0eUFoY5iEyX8pESJIxBIycKCj
	 NWM/NwuKxhzDkM/7/gDWsxOa52qw2PXUJQLqhYT4LV5CUSwT5aJpoEzWfPqs9Wj6Yl
	 cijzBVy+4otIxNfyNBbNUokhL0QRGyKGyqblFvZ/MvXYDxwlVBanAOOdme5pzA2MDE
	 2Fj5+mYCu8FZg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 00:19:06 +0200
Message-Id: <DI54XY4CNFCD.30M3UJGK1M3BE@kernel.org>
Subject: Re: [PATCH v2 1/2] driver core: faux: fix root device registration
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260424153127.2647405-1-johan@kernel.org>
 <20260424153127.2647405-2-johan@kernel.org>
In-Reply-To: <20260424153127.2647405-2-johan@kernel.org>
X-Rspamd-Queue-Id: D9BE048C864
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241785-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri Apr 24, 2026 at 5:31 PM CEST, Johan Hovold wrote:
> A recent change made the faux bus root device be allocated dynamically
> but failed to provide a release function to free the memory when the
> last reference is dropped (on theoretical failure to register the device
> or bus).
>
> Fix this by using root_device_register() instead of open coding.
>
> Also add the missing sanity check when registering faux devices to avoid
> use-after-free if the bus failed to register (which would previously
> have triggered a bunch of use-after-free warnings).
>
> Fixes: 61b76d07d2b4 ("driver core: faux: stop using static struct device"=
)
> Cc: stable@vger.kernel.org	# 7.0

I think this is more of a theoretical issue, do we need this in stable tree=
s?

