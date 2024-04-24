Return-Path: <stable+bounces-41351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BEA8B0719
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 12:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841091C21377
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 10:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C3159209;
	Wed, 24 Apr 2024 10:18:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A11419AA
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953901; cv=none; b=uzXrPUedpMu+WQnrLnvCvR2hotLHl6ClFjdlH9LuvlFDoXDi2hhgbEwcpm0/jqFHDgokzEkTrbs5suU/VQMVdEYWLg1myAnXcPr6N/dX65ps0Sspts3dF7xK7px+WMbU1AAiJgenCBDcUOKuvZObkCpov4kQPFfP4RNTb3K3pc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953901; c=relaxed/simple;
	bh=Ms/kL5uYZ8RGAy+Ewand3vQOkDQURuccLAcO7HmSPd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j724NbaQu5b7VevzB/i+o9IWZg2hRjiRT0MwB0iwh2qC0jJVEwDbBlokW7aWrR5r2Ow2RlbBcoi2GcBIcDRKDToxwJmBiDvIfHCHpqmCdx4F/jFJoxwJ1tPjwMzHaLnQR6yPe/i9XsbeAhKVenvrUe/jeh/lVoVzYjdyi3Ga+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-an_liTfIMIWa-05WnuWjYg-1; Wed,
 24 Apr 2024 06:18:14 -0400
X-MC-Unique: an_liTfIMIWa-05WnuWjYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 187CF38049FC;
	Wed, 24 Apr 2024 10:18:14 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 63AFF1C060D0;
	Wed, 24 Apr 2024 10:18:12 +0000 (UTC)
Date: Wed, 24 Apr 2024 12:18:11 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 2/3] macsec: Detect if Rx skb is macsec-related
 for offloading devices that update md_dst
Message-ID: <ZijcY_DHlmP84U4S@hog>
References: <20240419011740.333714-1-rrameshbabu@nvidia.com>
 <20240419011740.333714-3-rrameshbabu@nvidia.com>
 <ZiKIUC6bTCDhlnRw@hog>
 <87mspp6xh7.fsf@nvidia.com>
 <ZiYseYT62ZI0-_V9@hog>
 <87plugpqrk.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87plugpqrk.fsf@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-22, 22:55:02 -0700, Rahul Rameshbabu wrote:
> On Mon, 22 Apr, 2024 11:23:05 +0200 Sabrina Dubroca <sd@queasysnail.net> =
wrote:
> > 2024-04-19, 11:01:20 -0700, Rahul Rameshbabu wrote:
> >> On Fri, 19 Apr, 2024 17:05:52 +0200 Sabrina Dubroca <sd@queasysnail.ne=
t> wrote:
> >> > 2024-04-18, 18:17:16 -0700, Rahul Rameshbabu wrote:
> >> <snip>
> >> >> +=09=09=09/* This datapath is insecure because it is unable to
> >> >> +=09=09=09 * enforce isolation of broadcast/multicast traffic and
> >> >> +=09=09=09 * unicast traffic with promiscuous mode on the macsec
> >> >> +=09=09=09 * netdev. Since the core stack has no mechanism to
> >> >> +=09=09=09 * check that the hardware did indeed receive MACsec
> >> >> +=09=09=09 * traffic, it is possible that the response handling
> >> >> +=09=09=09 * done by the MACsec port was to a plaintext packet.
> >> >> +=09=09=09 * This violates the MACsec protocol standard.
> >> >> +=09=09=09 */
> >> >> +=09=09=09DEBUG_NET_WARN_ON_ONCE(true);
> >> >
> >> > If you insist on this warning (and I'm not convinced it's useful,
> >> > since if the HW is already built and cannot inform the driver, there=
's
> >> > nothing the driver implementer can do), I would move it somewhere in=
to
> >> > the config path. macsec_update_offload would be a better location fo=
r
> >> > this kind of warning (maybe with a pr_warn (not limited to debug
> >> > configs) saying something like "MACsec offload on devices that don't
> >> > support md_dst are insecure: they do not provide proper isolation of
> >> > traffic"). The comment can stay here.
> >> >
> >>=20
> >> I do not like the warning either. I left it mainly if it needed furthe=
r
> >> discussion on the mailing list. Will remove it in my next revision. Th=
at
> >> said, it may make sense to advertise rx_uses_md_dst over netlink to
> >> annotate what macsec offload path a device uses? Just throwing out an
> >> idea here.
> >
> > Maybe. I was also thinking about adding a way to restrict offloading
> > only to devices with rx_uses_md_dst.
>=20
> That's an option. Basically, devices that do not support rx_uses_md_dst
> really only just do SW MACsec but do not return an error if the offload
> parameter is passed over netlink so user scripts do not break?

Forcing a fallback to SW could be considered a breakage because of the
performance regression, so I don't think we can turn this on by
default. Then I would simply reject offload on those devices. We could
have a compat mode that does the SW fallback you suggest. I don't know
if it would be used.


> > (Slightly related) I also find it annoying that users have to tell the
> > kernel whether to use PHY or MAC offload, but have no way to know
> > which one their HW supports. That should probably have been an
> > implementation detail that didn't need to be part of uapi :/
>=20
> We could leave the phy / mac netlink keywords and introduce an "on"
> option. We deduce whether the device is a phydev or not when on is
> passed and set the macsec->offload flag based on that. The phy and mac
> options for offload in ip-macsec can then be deprecated.

I thought about doing exactly that, and then dropped the idea because
it would only help with newer kernels.

--=20
Sabrina


