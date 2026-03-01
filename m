Return-Path: <stable+bounces-222449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMiCDvUZpGm2XAUAu9opvQ
	(envelope-from <stable+bounces-222449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:50:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C57F51CF3A0
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA7F3300BBB3
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660E2D248D;
	Sun,  1 Mar 2026 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="sPpZJmG9"
X-Original-To: stable@vger.kernel.org
Received: from mail-244120.protonmail.ch (mail-244120.protonmail.ch [109.224.244.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F22DEA86
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772362224; cv=none; b=WXcdILp/JFlJIJDhhSdW+psdNN/G9nt+TvbxVxVRVqnAN+ui7ncnWsdWRapUAoMikBtvfm5rLyNS5bKI+J01jeFpIPffuQYpsQocvH6n/MxhiaM9vi2d8+Ze9daFjmux2GNa75/plUPpLgHIo1T3zRQ8TTvUwbCa9aLRE3hBQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772362224; c=relaxed/simple;
	bh=PMlROIEhmcodwbmyQo1sk3XPSfu+oied45xlm2/sdW4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unGLjpl8tFgeJnCjkb4+q2b9UAXZ3PU09/XxH8ElRVwt+TulwVdC+SUR3YTRukFH+XToSVRSzu0kyeGWL3c+nDsHSkUr0etKRtPGRh5Q7sK6AqS4y6r/fRYcB8L1pUqrOfJXc93y+lh6jbRAEeTFe2VsuAqHTbz2m6svuu1VotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=sPpZJmG9; arc=none smtp.client-ip=109.224.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail; t=1772362215; x=1772621415;
	bh=R7RG5cX3jzjy/gZ6+BdLw3VrQludWqwNSUDy9qHvdZw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sPpZJmG9+9FUwq1b9urqmEG9nnto5SoEu5hOj+P8v5eba2W22YUZJv7F3y6qkKxN3
	 MVtG2DR8TsahuBiQCGEXA521fB6IfneN+omXY7BoM6FW+wbWcb3RkSHnOSous/GR6d
	 RyW8A/8iKdad2DPXd/F26+Pose4MrYk3SYwkzZRh1BO7BD26kt2njtAz+ukCgYNrCx
	 bo1tyzCu+HpX3Rf5gnK6/L7fwpCIORH/I9jO2RiZOEcuSrS9L5FkpJwoLc8NYk5eqa
	 T3jE9gmpR4JLUKmtbnyFxTOAC7eEHMDS7C3bosvhU10bCl9NoKmOQAytJjrQttnwJw
	 EZVKtnhignolg==
Date: Sun, 01 Mar 2026 10:50:10 +0000
To: David Lechner <dlechner@baylibre.com>
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: st_sensors: fix trigger allocation
Message-ID: <4FQ68Smsz_F43-ks0XkXrc7KG3Ngp1kNuSerbAMvDFkgsR_p6MyzTvFB6_pozp-R2WrQqvB2NsKhaDBXjcjAEL8uLeiiyl0tWGGpaHCFYKQ=@vinarskis.com>
In-Reply-To: <20195663-2091-41eb-b4b3-e8542d29ae32@baylibre.com>
References: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com> <20195663-2091-41eb-b4b3-e8542d29ae32@baylibre.com>
Feedback-ID: 158356072:user:proton
X-Pm-Message-ID: 7911a91325f06bfcf511369ee1ddd2c3c79d3c59
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[vinarskis.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[vinarskis.com:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222449-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[vinarskis.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@vinarskis.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Queue-Id: C57F51CF3A0
X-Rspamd-Action: no action





On Saturday, February 28th, 2026 at 20:22, David Lechner <dlechner@baylibre=
.com> wrote:

> On 2/28/26 11:11 AM, Aleksandrs Vinarskis wrote:
> > Current hardcoded name prevents adding multiple st-sensors devices
> > on the same platform. Fix by aligning trigger name with other drivers.
> >
> > Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> > ---
> > Some platforms such as Dell XPS 9345 contains multiple accelerometers.
> > Fix st_sensors that currently only allows one device at the time.
> > ---
> >  drivers/iio/common/st_sensors/st_sensors_trigger.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drive=
rs/iio/common/st_sensors/st_sensors_trigger.c
> > index 8a8ab688d7980f6dd43c660f90a0eba32c38388b..3b5615d1b6dd66ee0af6ccc=
83eb2fbd7b2c64d29 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > @@ -124,8 +124,9 @@ int st_sensors_allocate_trigger(struct iio_dev *ind=
io_dev,
> >  =09unsigned long irq_trig;
> >  =09int err;
> >
> > -=09sdata->trig =3D devm_iio_trigger_alloc(parent, "%s-trigger",
> > -=09=09=09=09=09     indio_dev->name);
> > +=09sdata->trig =3D devm_iio_trigger_alloc(parent, "%s-dev%d",
> > +=09=09=09=09=09     indio_dev->name,
> > +=09=09=09=09=09     iio_device_id(indio_dev));
>=20
> Is this something that could potentially break userspace? Or are all of t=
hese
> just "always there" triggers that userspace doesn't have to touch?

I don't see why it would. This simply makes the name of the registered
trigger globally unique, the same way like other drivers already do.
Userspace does care about these but it relies on capabilities as per
my understanding to figure what sensor it is. I have tested it with
`monitor-sensors`, which relies on `iio-sensor-proxy`: in both cases
accelerator device was detected.

Alex

>=20
> >  =09if (sdata->trig =3D=3D NULL) {
> >  =09=09dev_err(parent, "failed to allocate iio trigger.\n");
> >  =09=09return -ENOMEM;
> >
> > ---
> > base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> > change-id: 20260228-st-iio-trigger-8ee1f219b566
> >
> > Best regards,
>=20
> 

