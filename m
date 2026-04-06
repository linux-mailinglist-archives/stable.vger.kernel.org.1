Return-Path: <stable+bounces-233399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKGnBRno02n/ngcAu9opvQ
	(envelope-from <stable+bounces-233399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 19:06:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8013A5905
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 19:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4021A3014973
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1CB38CFFE;
	Mon,  6 Apr 2026 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zds2IdXK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0A27702D;
	Mon,  6 Apr 2026 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495187; cv=none; b=B+NUPq/7KykaL0hmW06jDIB6pbHMbf3lfwial4+U4nlTyiINKvrjB0nmrOrn09qQrYctvcsVAiToLQpgzcezfbgR+A5Ib53hkFPR4murFBdRYvmlHOyhb+RCDpDRxPrjJXEC4BQY10MuhpWF0OBnuTXDRLB4GGa/D8kizegvFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495187; c=relaxed/simple;
	bh=7co5qYaCTt2lAcu3Qxgz96zOFLh5VcoDjJWji5G8mx0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2UJjIw/5R0+XrjJQ81cKOHXltlr3Z8/ZN8gc9UWFKTcyHwigiKmpndDWt7nA5Ho9LdCGkVYVpqPvjJIeGWFO+duuJRB+9qGZf7wgVG+PWa6kkcZHdKyfWmtGVUOsJtzz8qYef2Jc5jwsaBcEUhOHnZlt8kUNYdtHqYWhSt1g5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zds2IdXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14393C4CEF7;
	Mon,  6 Apr 2026 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775495187;
	bh=7co5qYaCTt2lAcu3Qxgz96zOFLh5VcoDjJWji5G8mx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zds2IdXKdToqdr710Z/F3OQJ4icohN3QzmhcdPsNk33HAT5RMFRhq3dad6ZYqxjmo
	 BQafXBgbt/cxr4pajwZTeMSqYTdIaPkqFEhn/d9o89fmVQsf/vynV4nY92U2wHOS0I
	 knYXoU4+KsHGZ453XR2uwIC4Rb//EGYZeJghfXeLhITPzdthGuPOwwOY9gDwFkU3xl
	 SOedn6/DISdKAwl1qIoj2zNx9/BDaVM/vpcrv54EgldncwSwmV2PmWoa9hiKH0ESNA
	 PVNjvTEIfSbo8rvcuICyWPemeCUD//KRLqLnEp7iPwgEYvSepfFyAqtSeSsClQTSYP
	 nbmTkH0Sti/JQ==
Received: from cu01147a.smtpx.saremail.com ([195.16.150.122] helo=lobster-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1w9nP6-00000009GtC-2iQl;
	Mon, 06 Apr 2026 17:06:24 +0000
Date: Mon, 06 Apr 2026 18:06:18 +0100
Message-ID: <87zf3gauid.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Doug Anderson" <dianders@chromium.org>,
	"Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Alan Stern" <stern@rowland.harvard.edu>,
	"Saravana Kannan"
 <saravanak@kernel.org>,
	"Christoph Hellwig" <hch@lst.de>,
	"Eric Dumazet"
 <edumazet@google.com>,
	"Johan Hovold" <johan@kernel.org>,
	"Leon Romanovsky"
 <leon@kernel.org>,
	"Alexander Lobakin" <aleksander.lobakin@intel.com>,
	"Alexey Kardashevskiy" <aik@ozlabs.ru>,
	"Robin Murphy"
 <robin.murphy@arm.com>,
	<stable@vger.kernel.org>,
	<driver-core@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] driver core: Don't let a device probe until it's ready
In-Reply-To: <DHM80WWSJ2XX.Q2X67PU4K1KS@kernel.org>
References: <20260404000644.522677-1-dianders@chromium.org>
	<20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
	<873418d2fz.wl-maz@kernel.org>
	<CAD=FV=WV2SJwiC7CHEzG=XQJ=tG0P7JSLzU16f0px4j1qmwxUw@mail.gmail.com>
	<871pgscaj0.wl-maz@kernel.org>
	<DHM80WWSJ2XX.Q2X67PU4K1KS@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 195.16.150.122
X-SA-Exim-Rcpt-To: dakr@kernel.org, dianders@chromium.org, gregkh@linuxfoundation.org, rafael@kernel.org, stern@rowland.harvard.edu, saravanak@kernel.org, hch@lst.de, edumazet@google.com, johan@kernel.org, leon@kernel.org, aleksander.lobakin@intel.com, aik@ozlabs.ru, robin.murphy@arm.com, stable@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233399-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9E8013A5905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 06 Apr 2026 17:43:22 +0100,
"Danilo Krummrich" <dakr@kernel.org> wrote:
>=20
> On Mon Apr 6, 2026 at 6:34 PM CEST, Marc Zyngier wrote:
> > On Mon, 06 Apr 2026 15:41:08 +0100,
> > Doug Anderson <dianders@chromium.org> wrote:
> >>=20
> >> Hi,
> >>=20
> >> On Sun, Apr 5, 2026 at 11:32=E2=80=AFPM Marc Zyngier <maz@kernel.org> =
wrote:
> >> >
> >> > > +      * blocked those attempts. Now that all of the above initial=
ization has
> >> > > +      * happened, unblock probe. If probe happens through another=
 thread
> >> > > +      * after this point but before bus_probe_device() runs then =
it's fine.
> >> > > +      * bus_probe_device() -> device_initial_probe() -> __device_=
attach()
> >> > > +      * will notice (under device_lock) that the device is alread=
y bound.
> >> > > +      */
> >> > > +     dev_set_ready_to_probe(dev);
> >> >
> >> > I think this lacks some ordering properties that we should be allowed
> >> > to rely on. In this case, the 'ready_to_probe' flag being set should
> >> > that all of the data structures are observable by another CPU.
> >> >
> >> > Unfortunately, this doesn't seem to be the case, see below.
> >>=20
> >> I agree. I think Danilo was proposing fixing this by just doing:
> >>=20
> >> device_lock(dev);
> >> dev_set_ready_to_probe(dev);
> >> device_unlock(dev);
> >>=20
> >> While that's a bit of an overkill, it also works I think. Do folks
> >> have a preference for what they'd like to see in v5?
> >
> > It would work, but I find the construct rather obscure, and it implies
> > that there is a similar lock taken on the read path. Looking at the
> > code for a couple of minutes doesn't lead to an immediate clue that
> > such lock is indeed taken on all read paths.
>=20
> Why do you think this is obscure?

Because you're not using the lock to protect any data. You're using
the lock for its release effect. Yes, it works. But the combination of
atomics *and* locking is just odd. You normally pick one model or the
other, not a combination of both.

> As I mentioned in [1], the whole purpose of
> dev_set_ready_to_probe() is to protect against a concurrent probe() attem=
pt of
> driver_attach() in __driver_probe_device(), while __driver_probe_device()=
 is
> protected by the device lock is by design.
>=20
> [1] https://lore.kernel.org/driver-core/DHM5TCBT6GDE.EFG3IPRP99G7@kernel.=
org/

I don't have much skin in this game, and you seem to have strong
opinions about how these things are supposed to work. So whatever
floats your boat, as long as it is correct.

Thanks,

	M.

--=20
Jazz isn't dead. It just smells funny.

