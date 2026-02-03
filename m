Return-Path: <stable+bounces-213268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMWFHVMWgmmZPAMAu9opvQ
	(envelope-from <stable+bounces-213268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 16:37:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A2DB5E0
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 16:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 547343003EB5
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FD53B8D61;
	Tue,  3 Feb 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRbMDmyE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D772DB7AE
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133030; cv=none; b=j65V3KZxPAOGkPcLH5vQ+atEWOszEAh0aNfCcORy3O0p/b1f1dKiDpNSuliZkKfVH2B3L+e+TZ8jC1rc1elA14kX5QS0q9FQNEfdLNn1dvRVAHdRmuQe+gdlba6cFrotR5yPjmzTUjy8p6Hlj1SegDzpT1VQMEBX0eE/zXLUHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133030; c=relaxed/simple;
	bh=+92HvwUv0D9Te2Lzog9lTtSDIhdyomwaTdqHn2cdgqY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=K+qaDiqQCqX+qrghTDTan1jaLCcefJV/0rDYObL3hD6UeILNvWE6420dzVBGLJ3eEYi7Oe04oFNMcrfpPWZtN9mPa7t3zc529hgVMbmS4PuRq1LIgatqmXg/gQYpgdPLWd5lAFXKSyKF4hSdnvbuegTkIk73PXn6uluY0yvrNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRbMDmyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC35C116D0;
	Tue,  3 Feb 2026 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770133030;
	bh=+92HvwUv0D9Te2Lzog9lTtSDIhdyomwaTdqHn2cdgqY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=aRbMDmyEJUJJxr/uuq9hcztqChiHwbrX2U52O2ZmrE6uR3ctLPeQ9E2wa/T9I88KK
	 h6jos09N/q+B6uWsRbAOUkebuRVDIwVBEz+dxI+R9+Qz6w+Gm5xbcvjRWalh2nwNC6
	 GuBaNEkzsOMTvNmsLUGL+O0oWRTmNRPSKY4Rbq0Urbbv6dqdnnL3Q8pOVdL8M1hKlv
	 Tc3lvlJ55yLP4G4nl1I5FU23GGW6Gxe5dyQt25A2XGgkAY+s1HymyAMM6j1zmIeVwN
	 S73w2taQiUNrdTQu3nf7y2ES+4KrH9dNWVpo0p8XQyclAfKMl1kwx0YRLZv9Tb8Yej
	 LCbAK8wTUCiLg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 16:37:06 +0100
Message-Id: <DG5FSE0B706U.1VFSJLK4DOD5C@kernel.org>
Subject: Re: NV04, 6.18.8 crashes on NULL pointer dereference
Cc: =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@sysophe.eu>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>, "Lyude
 Paul" <lyude@redhat.com>, <stable@vger.kernel.org>, "Dave Airlie"
 <airlied@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Maxime Ripard"
 <mripard@kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260201185705.0c5364f1@hemera.lan.sysophe.eu>
 <20260201231451.1ef0128c@hemera.lan.sysophe.eu>
 <2026020353-running-unhelpful-fbd2@gregkh>
In-Reply-To: <2026020353-running-unhelpful-fbd2@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213268-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC2A2DB5E0
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 3:38 PM CET, Greg KH wrote:
> On Sun, Feb 01, 2026 at 11:14:51PM +0100, Bruno Pr=C3=A9mont wrote:
>> Bisect completed.
>>=20
>> The offending patch is:
>> commit 448a2071a843831fe5fa71545cbfa7e15ee8966d (HEAD)
>> Author: Lyude Paul <lyude@redhat.com>
>> Date:   Wed Jan 21 14:13:10 2026 -0500
>>=20
>>     drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)
>>    =20
>>     commit 604826acb3f53c6648a7ee99a3914ead680ab7fb upstream.
>>    =20
>>     Apparently we never actually filled these in, despite the fact that =
we do
>>     in fact technically support atomic modesetting.
>>    =20
>>     Since not having these filled in causes us to potentially forget to =
disable
>>     fbdev and friends during suspend/resume, let's fix it.
>>    =20
>>     Signed-off-by: Lyude Paul <lyude@redhat.com>
>>     Cc: stable@vger.kernel.org
>>     Reviewed-by: Dave Airlie <airlied@redhat.com>
>>     Link: https://patch.msgid.link/20260121191320.210342-1-lyude@redhat.=
com
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>=20
>>  drivers/gpu/drm/nouveau/nouveau_display.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>>=20
>> It landed in 6.18.8. Seems like not all chip generations are ready for
>> atomic modesetting.
>
> Is this also a problem in 6.19-rc?

I did not test it, but a different mail [1] suggests that John did reproduc=
e
this in 6.19-rc7 too.

I've already picked up a revert [2], which should be in linux-next and shou=
ld
soon be in Linus' tree as well.

[1] https://lore.kernel.org/all/87h5s34d36.fsf@jogness.linutronix.de/
[2] https://patch.msgid.link/20260130113230.2311221-1-john.ogness@linutroni=
x.de

