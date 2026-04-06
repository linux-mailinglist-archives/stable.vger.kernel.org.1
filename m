Return-Path: <stable+bounces-233419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGWhLbb302k4ogcAu9opvQ
	(envelope-from <stable+bounces-233419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:13:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C9D3A6100
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDCEB302DF88
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72A3939DD;
	Mon,  6 Apr 2026 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCI5rBpy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67963914FA;
	Mon,  6 Apr 2026 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499104; cv=none; b=Bah9Ueme8l/o+v0yfQzKBU7R6iPkBy44ub6vt0I2K7K3PMTmQ4TSgpSf5Dn23LgjJfWhrqVrQPnNbgGgFu7lePYSAZkUsSIcCLTdYlK07bVbKJ9pkY054cwF9JdJ+XQuUXzULFCqF0hOHPSpPEDWkLyuFU+w2Qn40MxaCVKkDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499104; c=relaxed/simple;
	bh=Fjbm0t4D8Qab4np5wAewyOBhNbrK/ouXRGsh6ZtA4M8=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version:
	 References:In-Reply-To; b=ZFkKI9YneifJXKOXlC0MmgINArQt3Ep/NBSg9XX+nwYN/Im181hxQ9qz99cQCBCrmMODHihsZeD0KK3owLno8D9vjWSKme0GV51pjHmyvP5qRXYbiAJ6ASc1rTsdrlkqSypnFIUtdpMcsPfEu2gHONG5gsYJDiHU8whyopDTSOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCI5rBpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827BDC19421;
	Mon,  6 Apr 2026 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775499104;
	bh=Fjbm0t4D8Qab4np5wAewyOBhNbrK/ouXRGsh6ZtA4M8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=KCI5rBpyDGm09Jm97YU0FJmeiWiPqmZPMPMjbg+leHYk3+uy/h8/bJ2mPeNP0KVt/
	 yre1cs/UAj9GYvkunInD3LEP6+fVnUeTpZvzSaZJ66RZ5TxKavNKiQ4dIHXCck3pbh
	 0/MwvIc2tVGWaVunxh6mjEIyid5X8icgmQo+6xyH+tJVK9hbU/0rxseVUt94Hdo/Ef
	 Hhkt9/4bvf3gYnnIZCAVcWqG9MPXt+6qNLJpo/7gMaZljDdHummfrFIbzEtC80hr88
	 E4VR7O8ApqCfElxc+B3ltgN/o0PUns43w8POQ5SQb7koUgvdGi8va6DIxjnUOEu8SG
	 n4WkWLjg7qTOg==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 20:11:39 +0200
Message-Id: <DHM9WIABIULA.VZ9HOKU62SC9@kernel.org>
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
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260404000644.522677-1-dianders@chromium.org>
 <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <873418d2fz.wl-maz@kernel.org>
 <CAD=FV=WV2SJwiC7CHEzG=XQJ=tG0P7JSLzU16f0px4j1qmwxUw@mail.gmail.com>
 <871pgscaj0.wl-maz@kernel.org> <DHM80WWSJ2XX.Q2X67PU4K1KS@kernel.org>
 <87zf3gauid.wl-maz@kernel.org>
In-Reply-To: <87zf3gauid.wl-maz@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233419-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 50C9D3A6100
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Apr 6, 2026 at 7:06 PM CEST, Marc Zyngier wrote:
> On Mon, 06 Apr 2026 17:43:22 +0100,
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>=20
>> On Mon Apr 6, 2026 at 6:34 PM CEST, Marc Zyngier wrote:
>> > On Mon, 06 Apr 2026 15:41:08 +0100,
>> > Doug Anderson <dianders@chromium.org> wrote:
>> >>=20
>> >> Hi,
>> >>=20
>> >> On Sun, Apr 5, 2026 at 11:32=E2=80=AFPM Marc Zyngier <maz@kernel.org>=
 wrote:
>> >> >
>> >> > > +      * blocked those attempts. Now that all of the above initia=
lization has
>> >> > > +      * happened, unblock probe. If probe happens through anothe=
r thread
>> >> > > +      * after this point but before bus_probe_device() runs then=
 it's fine.
>> >> > > +      * bus_probe_device() -> device_initial_probe() -> __device=
_attach()
>> >> > > +      * will notice (under device_lock) that the device is alrea=
dy bound.
>> >> > > +      */
>> >> > > +     dev_set_ready_to_probe(dev);
>> >> >
>> >> > I think this lacks some ordering properties that we should be allow=
ed
>> >> > to rely on. In this case, the 'ready_to_probe' flag being set shoul=
d
>> >> > that all of the data structures are observable by another CPU.
>> >> >
>> >> > Unfortunately, this doesn't seem to be the case, see below.
>> >>=20
>> >> I agree. I think Danilo was proposing fixing this by just doing:
>> >>=20
>> >> device_lock(dev);
>> >> dev_set_ready_to_probe(dev);
>> >> device_unlock(dev);
>> >>=20
>> >> While that's a bit of an overkill, it also works I think. Do folks
>> >> have a preference for what they'd like to see in v5?
>> >
>> > It would work, but I find the construct rather obscure, and it implies
>> > that there is a similar lock taken on the read path. Looking at the
>> > code for a couple of minutes doesn't lead to an immediate clue that
>> > such lock is indeed taken on all read paths.
>>=20
>> Why do you think this is obscure?
>
> Because you're not using the lock to protect any data. You're using
> the lock for its release effect. Yes, it works. But the combination of
> atomics *and* locking is just odd. You normally pick one model or the
> other, not a combination of both.

Yeah, the choice of bitops was purely because previously (in v2) this was a=
 C
bitfield member in struct device protected with the device lock. But, not a=
ll of
the bitfield members were protected by the same lock or protected by a lock=
 at
all, which would have made this racy with the other bitfield members. I.e. =
the
choice of bitops was independent; see also [2] for context.

[2] https://lore.kernel.org/driver-core/DHH1PD0ASG8H.1K3KG9L658DYN@kernel.o=
rg/

>> As I mentioned in [1], the whole purpose of
>> dev_set_ready_to_probe() is to protect against a concurrent probe() atte=
mpt of
>> driver_attach() in __driver_probe_device(), while __driver_probe_device(=
) is
>> protected by the device lock is by design.
>>=20
>> [1] https://lore.kernel.org/driver-core/DHM5TCBT6GDE.EFG3IPRP99G7@kernel=
.org/
>
> I don't have much skin in this game, and you seem to have strong
> opinions about how these things are supposed to work. So whatever
> floats your boat, as long as it is correct.

Not overly, it's more about calling out the fact that probe() paths are
serialized through the device lock by design, so it seems natural to protec=
t
dev_set_ready_to_probe() with the device lock.

The fact that dev_set_ready_to_probe() uses a bitop under the hood is an
implementation detail, i.e. it could also be an independent boolean.

That said, as I caught the issue in [3], I also mentioned the option of an
explicit memory barrier in device_add() and __driver_probe_device(). I.e. I=
'm
not entirely against it, but I think the device lock is a bit cleaner.

[3] https://lore.kernel.org/driver-core/DHLITCTY913U.J59JSQOVL0NH@kernel.or=
g/

