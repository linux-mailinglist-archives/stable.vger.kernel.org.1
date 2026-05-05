Return-Path: <stable+bounces-244196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ4kBSAJ+mlsIgMAu9opvQ
	(envelope-from <stable+bounces-244196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:13:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A241F4D00C8
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F32D3028AAF
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E4A481246;
	Tue,  5 May 2026 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KPox7L/h"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93CE31716E;
	Tue,  5 May 2026 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993937; cv=none; b=bDFmB9Ay4XPbg7nD+4NM0HTWZgnqvJZANI/JTCWdDwQt97yXMGteNsyhzIUSVX1lXvzMLdRKt9Prd1oN7DFa75cKC4mM5I02O1/EkRsD4I0fdpK4L1jtYowuVT++j/2RPp/7Ij8HGwRtqMLue11v/0QLlUdTTHsLUKuN3zr7b/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993937; c=relaxed/simple;
	bh=wS7Iyl4Ksq8TuCfTCVP/989EIkQJI5Y2q7NIRRFZvzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DDVZ7VYEydbJT1qXf9FMknGlLyFu8bhpMANpzNDYOiOq7LJkABe9l4vx1TvyqfUqND80rHeiN7CcHUtSmUxp/5Mmq4Vz++V0sdKtQEMIU0edTdqt07VRWhWHmHtUd/+3zTnmbM7nlfXo8wfnrfSKEY3uSyVXjsr/0scNdSraTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KPox7L/h; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E017DC5D73D;
	Tue,  5 May 2026 15:13:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E54276053C;
	Tue,  5 May 2026 15:12:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B797011AD02B3;
	Tue,  5 May 2026 17:12:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777993933; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=27Qnd+ZboYtUoEDTDZ5XvOCVg1Pfk5BRU8+b+eKxg/c=;
	b=KPox7L/hOjw8e9BwBbS2GG+/A41j3+1C97H/i3XnNYZ6LkW/nofs0NoPLmmKXyZufKyJr9
	BTN5SVTCeeh8RZ6U9SCAUfZoe0XRUYLQf5pmLU+SpQ9tvdBMyybaEk8pizblAM1YGdqR/O
	bRhQb/mMkAeViHfsdZdOju8+CfGBj04KUjbcPLET8lwBAYDlZZZs4nF3MIZsthw4cu3Dhq
	fbUOAiKq8FWKt7FatduA5iT3kGbT5zdYhC7aas9ema6zQBDiMNCOPIYaQ38pbxLhp87auf
	lYTHiY9gzRWP3FV8yZtqPYCWtLmK6Kdvt9MrTxZ9sUd69elI22jTww+IJ153NA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lee Jones <lee@kernel.org>
Cc: Valery Borovsky <vebohr@gmail.com>,  Ben Dooks <ben@fluff.org.uk>,
  Vincent Sanders <vince@arm.linux.org.uk>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v2] mfd: sm501: fix reference leak on failed device
 registration
In-Reply-To: <20260505150013.GC2661693@google.com> (Lee Jones's message of
	"Tue, 5 May 2026 16:00:13 +0100")
References: <6b4a9f5ae8a316b6f07f72f2fe3f0b8fc5f18dff.1777889235.git.vebohr@gmail.com>
	<20260504124841.443496-1-vebohr@gmail.com>
	<177790275684.156214.6563585281874262911.b4-ty@bootlin.com>
	<20260505150013.GC2661693@google.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 05 May 2026 17:12:11 +0200
Message-ID: <87pl39oppw.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A241F4D00C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fluff.org.uk,arm.linux.org.uk,linux-foundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244196-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]

Hi Lee,

On 05/05/2026 at 16:00:13 +01, Lee Jones <lee@kernel.org> wrote:

> On Mon, 04 May 2026, Miquel Raynal wrote:
>
>> On Mon, 04 May 2026 15:48:41 +0300, Valery Borovsky wrote:
>> > When platform_device_register() fails in sm501_register_device(), the
>> > platform device allocated by sm501_create_subdev() has its struct devi=
ce
>> > initialized by device_initialize() inside platform_device_register(). =
The
>> > error path logs the error but returns without dropping the device refe=
rence,
>> > leaking the memory allocated by sm501_create_subdev():
>> >=20
>> >   sm501_register_device()
>> >     -> platform_device_register(pdev)
>> >        -> device_initialize(&pdev->dev)   /* kref =3D 1 */
>> >        -> platform_device_add(pdev)       /* fails */
>> >     <- dev_err() called, kref still 1, sm501_device_release never call=
ed
>> >=20
>> > [...]
>>=20
>> Applied to mtd/next, thanks!
>
> I think you misread the subject line.
>
>> [1/1] mfd: sm501: fix reference leak on failed device registration
>>       commit: faa9bba3fe2f37e7dcb26d4501d890fbfd7df160
>>=20
>> Patche(s) should be available on mtd/linux.git and will be
>> part of the next PR (provided that no robot complains by then).
>
> Please remove this from your tree.  It should be handled via M[F]D.

Yes, it took a bit of time for me to receive my own answer so I replied
to the original patch immediately stating that I dropped it. For some
reason b4 applied this patch, whereas I was applying another m*t*d patch
from apparently the same series (?). Both the contribution and b4 behaviour
was strange.

Sorry for the noise.

Thanks,
Miqu=C3=A8l

