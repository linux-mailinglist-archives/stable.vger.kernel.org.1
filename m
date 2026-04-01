Return-Path: <stable+bounces-232860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGfOJjqJzWnFegYAu9opvQ
	(envelope-from <stable+bounces-232860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:08:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E313807E6
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73BBF3030D7D
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 21:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058DF3BB9ED;
	Wed,  1 Apr 2026 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krEMnF3q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0683B9DAE;
	Wed,  1 Apr 2026 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077556; cv=none; b=WnkPO1BmxsdKMrol6mz7xGwbJfK6Enlni2Q0aemBlRcAc5a+5D/vY29tE9raZEQZ9VvakeWN5qS7ODjQqe4IXc30ljksK0nfeDSiOEd0XI6NO/MZI0YVWmPgASYEqHUc73Sb1/JnLguCdl02somFVQTPnphUMAXfFcz0nbAhGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077556; c=relaxed/simple;
	bh=VTJNLZuP0d5iYMFSsflQykMnmNGpGOWAK0gArje8TDY=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:Mime-Version:
	 References:In-Reply-To; b=d55jk5kwu6DBrfmY4Sm1u4l4O+XW9b61kQSQNNK+dXZfUq+1Z8rYYRIQEPTjk1cIekeEsNe3jf2+SyWmsB4QG/GTfnbns49Fv1NWVdZejHBRhvT+kE/UfZ9+cPx3kS7my34ZaOiBn5RXouR2x1YAYCIEpo0zHR7N/ueoWld7riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krEMnF3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486F0C4CEF7;
	Wed,  1 Apr 2026 21:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775077556;
	bh=VTJNLZuP0d5iYMFSsflQykMnmNGpGOWAK0gArje8TDY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=krEMnF3qKUgljrTJ2OV2Cpr0v5pNrLvU4jk10Gv/s+dlCGXVHEDSohJiRCp7XEHVT
	 dnfxiM/gu/eMaXodrvkF6IOXcFJHJHo52gT+zBU6VxsUkOFoEsAfXbOcL/Mr3y+aqM
	 pAAgu8D3qBdlydHquZBhXRVjnuHm/NRt23JJxyrVmfUCbOY540u+orB0YogxWP2fQi
	 cuDzABVDyZt6uTkdTdTSKpge0EEGgmYHqvTN7At5ia4VwU/HFM+jyPx/kp9fusKwwL
	 oyHWGy16H6RItAB+g8B+3LD0cXwlnhcCtrmYQgthElpj+yCa+tpA+oCCMvEObQtH6U
	 w3ApTrO4BasPg==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 23:05:52 +0200
Message-Id: <DHI4H61YSZGE.BBM3H9B3H8F7@kernel.org>
To: "Doug Anderson" <dianders@chromium.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] driver core: Don't let a device probe until it's
 ready
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>, "Kay
 Sievers" <kay.sievers@vrfy.org>, "Saravana Kannan" <saravanak@kernel.org>,
 <stable@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid> <DHH1PD0ASG8H.1K3KG9L658DYN@kernel.org> <CAD=FV=XJ2qOZ7ftDg70AhD0GRX6TfQb6OVyNaUfFg42+hmwxGQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XJ2qOZ7ftDg70AhD0GRX6TfQb6OVyNaUfFg42+hmwxGQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232860-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37E313807E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 31, 2026 at 5:26 PM CEST, Doug Anderson wrote:
> Hi,
>
> On Tue, Mar 31, 2026 at 7:42=E2=80=AFAM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> > @@ -848,6 +848,18 @@ static int __driver_probe_device(const struct dev=
ice_driver *drv, struct device
>> >       if (dev->driver)
>> >               return -EBUSY;
>> >
>> > +     /*
>> > +      * In device_add(), the "struct device" gets linked into the sub=
system's
>> > +      * list of devices and broadcast to userspace (via uevent) befor=
e we're
>> > +      * quite ready to probe. Those open pathways to driver probe bef=
ore
>> > +      * we've finished enough of device_add() to reliably support pro=
be.
>> > +      * Detect this and tell other pathways to try again later. devic=
e_add()
>> > +      * itself will also try to probe immediately after setting
>> > +      * "ready_to_probe".
>> > +      */
>> > +     if (!dev->ready_to_probe)
>> > +             return dev_err_probe(dev, -EPROBE_DEFER, "Device not rea=
dy_to_probe");
>>
>> Are we sure this dev->ready_to_probe dance does not introduce a new subt=
le bug
>> considering that ready_to_probe is within a bitfield of struct device?
>>
>> I.e. are we sure there are no potential concurrent modifications of othe=
r fields
>> in this bitfield that are not protected with the device lock?
>>
>> For instance, in __driver_attach() we set dev->can_match if
>> driver_match_device() returns -EPROBE_DEFER without the device lock held=
.
>
> Bleh. Thank you for catching this. I naively assumed the device lock
> protected the bitfield, but I didn't verify that.
>
>
>> This is exactly the case you want to protect against, i.e. device_add() =
racing
>> with __driver_attach().
>>
>> So, there is a chance that the dev->ready_to_probe change gets interleav=
ed with
>> a dev->can_match change.
>>
>> I think all this goes away if we stop using bitfields for synchronizatio=
n; we
>> should convert some of those to flags that we can modify with set_bit() =
and
>> friends instead.
>
> That sounds reasonable to me. Do you want me to send a v3 where I
> create a new "unsigned long flags" in struct device and introduce this
> as the first flag? If there are additional bitfields you want me to
> convert, I can send them as additional patches in the series as long
> as it's not too big of a change...

I think the one with the biggest potential to cause real issues is can_matc=
h, as
it is modified without the device lock held from __driver_attach(), which c=
an be
called at any time concurrently.

(I think there are others as well, but they are more on the theoretical sid=
e of
things. For instance, dma_skip_sync is modified by dma_set_mask(), which
strictly speaking does not require the device lock to be held. In practice,
that's probably never an issue since dma_set_mask() is typically called fro=
m bus
callbacks usually, but it's not strictly a requirement.)

More in general, from a robustness point of view, everything that is set on=
ce at
device creation time is fine to be a bitfield; bits that are used for
synchronization or are modified concurrently, I'd rather use bitops.

