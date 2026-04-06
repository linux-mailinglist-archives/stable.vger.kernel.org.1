Return-Path: <stable+bounces-233397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKbuMrzi02nJngcAu9opvQ
	(envelope-from <stable+bounces-233397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 18:43:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CFB3A564E
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96DEE300461F
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 16:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D5E38B7A5;
	Mon,  6 Apr 2026 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mcu+9ys0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884F1BD9C9;
	Mon,  6 Apr 2026 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493808; cv=none; b=iyrE4U1QrnwR60gpJhVlUjasVej1G1u4OCqufYgyy6omNFpMGAUzsLOk/n1bs7kfQZFA6TKs0i1BHIavmCSlt3rp20tImXkybF49bZsqlC0MAKNl6Izje3ouGtgXC4JyOfJZddkfK3AnM52Zo/oS36Tlj1uuOHqNTFbJXotGmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493808; c=relaxed/simple;
	bh=t2nairURilNVeA5ZLt+us1UXJazwwPGEI+lCH8zr7/M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Flx8dc2FQ1MxrVO4yNO4gHoCObokjSrBjYco49oLvu4A9rjYPqDMi1Br68SfShBT0Wl7my64HoBk+nRQGYSSTfb+lW+AX/uGyeSTjd/KoBtGD8O/atbpl7HHirWQESEF033WYKWGRx/PKxdStrV0GVH4mcHIvxFpvlIB9gFOUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mcu+9ys0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9874C2BCB0;
	Mon,  6 Apr 2026 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775493807;
	bh=t2nairURilNVeA5ZLt+us1UXJazwwPGEI+lCH8zr7/M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Mcu+9ys0jkPEr8W+pPHNW4xGPubr86s7XnNnYwOA/IOYwNLIQPNssG0A9Rvq3PsCl
	 iOiYERHvU9aEHmkYlc7nw9mQJ9Gdk6Sx5eAjHRxGBKOFfxP8+JqUxSPB2iqqrmjnjQ
	 A48NzKl4Ruyy1YZBIDJNYxlqaO/+KxG5aER3PbbPGHhtcPf1Y9kq2Q7LN2SxeNl9WQ
	 dIfZ3XKeknqvSZGQyXH1BvX+hSLUP6Jm2lTzHlHLmjIapeTVjgXS64E2sSRsqy3ThO
	 dYKnqaywdq9rbZtP0E/csgLUoFRpW4XgTwlZx4SpRMJXIW3LmtiRyh0G9SyHb2tMKF
	 2O75UZ00G0qTA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 18:43:22 +0200
Message-Id: <DHM80WWSJ2XX.Q2X67PU4K1KS@kernel.org>
Subject: Re: [PATCH v4 1/9] driver core: Don't let a device probe until it's
 ready
Cc: "Doug Anderson" <dianders@chromium.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Alan Stern" <stern@rowland.harvard.edu>, "Saravana Kannan"
 <saravanak@kernel.org>, "Christoph Hellwig" <hch@lst.de>, "Eric Dumazet"
 <edumazet@google.com>, "Johan Hovold" <johan@kernel.org>, "Leon Romanovsky"
 <leon@kernel.org>, "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "Alexey Kardashevskiy" <aik@ozlabs.ru>, "Robin Murphy"
 <robin.murphy@arm.com>, <stable@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>
To: "Marc Zyngier" <maz@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260404000644.522677-1-dianders@chromium.org>
 <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <873418d2fz.wl-maz@kernel.org>
 <CAD=FV=WV2SJwiC7CHEzG=XQJ=tG0P7JSLzU16f0px4j1qmwxUw@mail.gmail.com>
 <871pgscaj0.wl-maz@kernel.org>
In-Reply-To: <871pgscaj0.wl-maz@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233397-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 32CFB3A564E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Apr 6, 2026 at 6:34 PM CEST, Marc Zyngier wrote:
> On Mon, 06 Apr 2026 15:41:08 +0100,
> Doug Anderson <dianders@chromium.org> wrote:
>>=20
>> Hi,
>>=20
>> On Sun, Apr 5, 2026 at 11:32=E2=80=AFPM Marc Zyngier <maz@kernel.org> wr=
ote:
>> >
>> > > +      * blocked those attempts. Now that all of the above initializ=
ation has
>> > > +      * happened, unblock probe. If probe happens through another t=
hread
>> > > +      * after this point but before bus_probe_device() runs then it=
's fine.
>> > > +      * bus_probe_device() -> device_initial_probe() -> __device_at=
tach()
>> > > +      * will notice (under device_lock) that the device is already =
bound.
>> > > +      */
>> > > +     dev_set_ready_to_probe(dev);
>> >
>> > I think this lacks some ordering properties that we should be allowed
>> > to rely on. In this case, the 'ready_to_probe' flag being set should
>> > that all of the data structures are observable by another CPU.
>> >
>> > Unfortunately, this doesn't seem to be the case, see below.
>>=20
>> I agree. I think Danilo was proposing fixing this by just doing:
>>=20
>> device_lock(dev);
>> dev_set_ready_to_probe(dev);
>> device_unlock(dev);
>>=20
>> While that's a bit of an overkill, it also works I think. Do folks
>> have a preference for what they'd like to see in v5?
>
> It would work, but I find the construct rather obscure, and it implies
> that there is a similar lock taken on the read path. Looking at the
> code for a couple of minutes doesn't lead to an immediate clue that
> such lock is indeed taken on all read paths.

Why do you think this is obscure? As I mentioned in [1], the whole purpose =
of
dev_set_ready_to_probe() is to protect against a concurrent probe() attempt=
 of
driver_attach() in __driver_probe_device(), while __driver_probe_device() i=
s
protected by the device lock is by design.

[1] https://lore.kernel.org/driver-core/DHM5TCBT6GDE.EFG3IPRP99G7@kernel.or=
g/

