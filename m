Return-Path: <stable+bounces-77816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC529879A6
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 21:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FAA2868AE
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3C170A19;
	Thu, 26 Sep 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="TfixhxBe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456B15D5B9
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379366; cv=none; b=bK0kaQxQAxNSuv4JLgRycCXLxuX75M1tZedFyaH0pu6z1tDeJUlc19YYtDN8LQiPQzbb63FJaKTOuk0MxP/4GslVyGLMhDBiQqwWtZurfQ97fHybNWkW+YBM4Nvq9wYUVyIEAq8msx3k6m1Ji4Nk2c8US5ULLf5kLVLHLTdVp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379366; c=relaxed/simple;
	bh=OjwzO8U4Nl9a9d6DsrKZwuVD1pOWAqJqR+jVh+h8Lwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=W/TvV4UUCXFWsXb9fLW+77nqmsIkmy57U9VIbpah8diIObZEtRhZQ6HU6cEd1RZngBABkc0eh2G3ZrVr5M03v+827KQOn7R5VyN+rV3GMpGGwC8rDvdxpyzM4K2X9EtHnzxVC9Tyw9xTFBbNH6X4gz76zCq9ToKIRKlbpf5G3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=TfixhxBe; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727379362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mR6SUqwAUrkRrdubkcM5YRxoFpswlfS/u9CbOLYcrp8=;
	b=TfixhxBeaaT3ngWkT8YAEZeeCcvHscxvHMNMBhlJSS2tMW7TkC1rwIF82mhC8zLrKJu+Mg
	m5rhpgVFuc/e+dfpj85brHSiiLAcOL1rEa3jD7StaQsuAQYblvK1qj2kBWKqz/71p5VzUh
	pk5YvZK1Rml+emEzf8y7U2l2A3cOVY8=
Received: from g8t13016g.inc.hp.com (hpi-bastion.austin2.mail.core.hp.com
 [15.72.64.134]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-jAyA0-NyMVedodNRNv1Dmw-1; Thu, 26 Sep 2024 15:36:01 -0400
X-MC-Unique: jAyA0-NyMVedodNRNv1Dmw-1
Received: from g7t16458g.inc.hpicorp.net (g7t16458g.inc.hpicorp.net [15.63.18.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by g8t13016g.inc.hp.com (Postfix) with ESMTPS id 9AA446000A94;
	Thu, 26 Sep 2024 19:36:00 +0000 (UTC)
Received: from jam-buntu (unknown [15.53.255.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by g7t16458g.inc.hpicorp.net (Postfix) with ESMTPS id C82096000543;
	Thu, 26 Sep 2024 19:35:59 +0000 (UTC)
Date: Thu, 26 Sep 2024 19:35:38 +0000
From: "Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, qin.wan@hp.com
Subject: Re: Request to apply patches to v6.6 to fix thunderbolt issue
Message-ID: <ZvWIQW5o5sTKvfJE@jam-buntu>
References: <MW4PR84MB151669954C1D210A0FED92128D632@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>
 <MW4PR84MB1516C1E8175FF8931ACF8AB18D632@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>
 <2024091925-elixir-joylessly-9f33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024091925-elixir-joylessly-9f33@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 11:04:23AM +0200, Greg KH wrote:
> On Thu, Sep 19, 2024 at 08:38:52AM +0000, Wan, Qin (Thin Client RnD) wrot=
e:
> > Hello,
> >=20
> > =C2=A0=C2=A0 There is an issue found on v6.6.16: Plug in thunderbolt G4=
 dock with monitor connected after system boots up. The monitor shows nothi=
ng when wake up from S3 sometimes. The failure rate is above 50%.
> > =C2=A0=C2=A0 The kernel reports =E2=80=9CUBSAN: shift-out-of-bounds in =
drivers/gpu/drm/display/drm_dp_mst_topology.c:4416:36=E2=80=9D. The call st=
ack is shown at the bottom of this email.
> > =C2=A0=C2=A0 This failure is fixed in v6.9-rc1.=20
> > =C2=A0=C2=A0=C2=A0We request to merge below commit to v6.6.
> >=20
> > =C2=A0 6b8ac54f31f985d3abb0b4212187838dd8ea4227
> > =C2=A0thunderbolt: Fix debug log when DisplayPort adapter not available=
 for pairing
> >=20
> > =C2=A0fe8a0293c922ee8bc1ff0cf9048075afb264004a
> > =C2=A0thunderbolt: Use tb_tunnel_dbg() where possible to make logging m=
ore consistent
> >=20
> > =C2=A0d27bd2c37d4666bce25ec4d9ac8c6b169992f0f0
> > =C2=A0thunderbolt: Expose tb_tunnel_xxx() log macros to the rest of the=
 driver
> >=20
> > =C2=A0 8648c6465c025c488e2855c209c0dea1a1a15184
> > =C2=A0thunderbolt: Create multiple DisplayPort tunnels if there are mor=
e DP IN/OUT pairs
> >=20
> > =C2=A0f73edddfa2a64a185c65a33f100778169c92fc25
> > =C2=A0thunderbolt: Use constants for path weight and priority
> >=20
> > =C2=A0 4d24db0c801461adeefd7e0bdc98c79c60ccefb0
> > =C2=A0 thunderbolt: Use weight constants in tb_usb3_consumed_bandwidth(=
)
> >=20
> > =C2=A0 aa673d606078da36ebc379f041c794228ac08cb5
> > =C2=A0 thunderbolt: Make is_gen4_link() available to the rest of the dr=
iver
> >=20
> > =C2=A0 582e70b0d3a412d15389a3c9c07a44791b311715
> > =C2=A0 =C2=A0thunderbolt: Change bandwidth reservations to comply USB4 =
v2
> >=20
> > =C2=A0=C2=A0 2bfeca73e94567c1a117ca45d2e8a25d63e5bd2c
> > =E3=80=80thunderbolt: Introduce tb_port_path_direction_downstream()
> > =E3=80=80
> > =E3=80=80956c3abe72fb6a651b8cf77c28462f7e5b6a48b1
> > =E3=80=80thunderbolt: Introduce tb_for_each_upstream_port_on_path()
> > =E3=80=80
> > =E3=80=80c4ff14436952c3d0dd05769d76cf48e73a253b48
> > =E3=80=80thunderbolt: Introduce tb_switch_depth()
> > =E3=80=80
> > =E3=80=8081af2952e60603d12415e1a6fd200f8073a2ad8b
> > =E3=80=80thunderbolt: Add support for asymmetric link
> > =E3=80=80
> > =E3=80=803e36528c1127b20492ffaea53930bcc3df46a718
> > =E3=80=80thunderbolt: Configure asymmetric link if needed and bandwidth=
 allows
> > =E3=80=80
> > =E3=80=80b4734507ac55cc7ea1380e20e83f60fcd7031955
> > =E3=80=80thunderbolt: Improve DisplayPort tunnel setup process to be mo=
re robust
>=20
> Can you send these as a backported series with your signed-off-by to
> show that you have tested these to verify that they work properly in the
> 6.6 kernel tree?  That will make them much easier to apply, and track
> over time.
>=20

We used the below command to apply the patches. Is this helpful, or is=20
resubmitting the series still required? If so, what script do you use to ad=
d
the "upstream commit" lines to the commit message?

git cherry-pick 6b8ac54f31f9 fe8a0293c922 d27bd2c37d46 8648c6465c02 \
                f73edddfa2a6 4d24db0c8014 aa673d606078 582e70b0d3a4 \
                2bfeca73e945 956c3abe72fb c4ff14436952 81af2952e606 \
                3e36528c1127 b4734507ac55

It's commit 709f7c7172ae ("thunderbolt: Improve DisplayPort tunnel setup
process to be more robust") which solves the issue, and the pthers are
dependencies.

> Also, you should cc: the relevant maintainers/developers of those
> changes to allow them to comment if they should be backported or not.
>=20
> thanks,
>=20
> greg k-h
>=20


