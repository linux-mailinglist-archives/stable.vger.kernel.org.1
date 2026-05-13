Return-Path: <stable+bounces-246796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NSYDjhHBGrNGgIAu9opvQ
	(envelope-from <stable+bounces-246796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:41:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E8530D1A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 945893015D06
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3533A3E717F;
	Wed, 13 May 2026 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzfLSY7c"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFE3C8733
	for <stable@vger.kernel.org>; Wed, 13 May 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665209; cv=none; b=brcAAcsvvb97tbYxiL1y1Q5T2QsYI5gCqxSyYaKvmDkilBowR7YIJJBc9tJ3KwMoTFxL8pAFj9m1L1Feqf0TZLogt6y4QP6/hPo+LxrQVd2p32yxo0PuTGrj1hbM/1YrXKMOl5E0H9mSqopfRv+HYkcbA5+eAEDnNJP5KCFYLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665209; c=relaxed/simple;
	bh=R0E17z7r+LYNRSdvyWdyqZP/kUEcYvbbo/0Srhey10I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gD0C1ad8xwOkCu2Va9YMAQJxB1h5Q8Vb1i2f/4/XsUfu/ipO3nQBxSPVw+1e4BJ3BFDpUkpUG7QU8Mu/dghbz5s95VfMvn4wUKnz+/zIn6xcJyW4g3Hrt2t/Eb4hI+ffsdBNpnxAZXorXevvxMKmQHSjgyr6jyXR7Lc4Csm7v30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzfLSY7c; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so63267175e9.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665205; x=1779270005; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R0E17z7r+LYNRSdvyWdyqZP/kUEcYvbbo/0Srhey10I=;
        b=jzfLSY7cavs/yDze9MwRISa4ZVPK0xcg57MsYPaKKvuUfUGPFvgOL3vfG4i9SK0pW+
         dnpgDl50cbs8UeSa9HbLysiymQJxV3uX27T0DUlr4ipnTI/fDJFBPFn0CdEJe9464sKN
         MSDuwj2/jo9IpenDpG7Um0i/EVQaih42OzMEQYo9ayIFask/liz7ia9BY4AIxmHG/9ZM
         EO1u92uTKIR3pUGClzhfsUr19Sjec2mU3/MSgz+eTv5iExRED4X/gqy07BI5GbEzgKlq
         6qQe1QhGHKjWZ32UoeJ56xHnwVJd37S7GFK7kZHAzeXT4SaG0NPrDDG0gQpTNcgFE8vd
         giLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665205; x=1779270005;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0E17z7r+LYNRSdvyWdyqZP/kUEcYvbbo/0Srhey10I=;
        b=YsqO/d+YBVRovAyOZRKhnnXRWACv5/3LD7rfzM2omdI+65jq0tc1uoKcTl3GY7E+Il
         6Xkigf4U5DSNq4IqHl77XAgQVnwbLfEGq/97lA3eNppXkZyJTWRvZIKXj1yGQUgRY57G
         H3jufj+F0HxuNtoX7lgoFyddMRN5H8FW/A6sDhieVknn0GrCbIvsj/F7lXq74aYHaX4x
         yQKZRGzFq/fmiMohVBrLKvwNpWTT1oOAmLX+yYsU1tuO2JpmMlC3CEwU84fVRBqTnrY3
         sdf5aBmJXwBLp0Dmufb8Eh+jCKMZPShwJtwGIxH05sk3rDEjWzT07ji20S+c9clEHMDa
         36QQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uVc3bih3/5WNwbQdeqt8fW+AXC8tAO3D49EhPMv3JjwxyF+Pz6G47fg/t42ts5R6qZARGExA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPdbjPjoOwUZ2Ok1uHa89AYcBtDSmCnfWFzvchTut3y0/7gjn0
	l6ElQcrI/8aMoBrRurtpswjbL3WjIL4aLCM9HO5LSMJ5J9qYK3oPwRSF
X-Gm-Gg: Acq92OGu5hdoAZYIwrTXXjMMy5BHDEaJ9dc+UnfvMLpa8dGPGJ+iYKKr9bUx0OG661V
	fI36rtEqSy1p2NLPYiuE3U6SbLDls5OimML81CFYW0P3bvN20wyKQGMbR1pN4JiktTZmFRQsOVp
	G99CzF4YTUR98nRU8e4ZIlAbEbgPerMAaZnedcik6LTomkmuDyhaHxWC8+K39mxHZAYp9g77yAG
	nUxg1uv2kuoO95JE0lknXsJgaZvce28mYCWjT9MdYZvcKT383KcaC14Jgt7dCviFFBDr3OtzKIn
	nyAZ6QP2h/I7Re188ngNvcOK3HqcxJpJndKUQPOEzXjKDAIOV0vFTCxact3hGEdtNiASFpe0AEE
	m4oZzTWNnGIHYsWterN5wZAmZ1t1We3d/p62iNdv+yyem9p6q75Pduda+o+nZF5WtTk9O5PxwOa
	psDMJgNZe/6cxsMUEYxa18eBDOVZ1hHOVLdFIMy8QGgL7eEloC
X-Received: by 2002:a05:600c:8b12:b0:48e:978f:c45a with SMTP id 5b1f17b1804b1-48fc9a3ba11mr39073755e9.19.1778665205077;
        Wed, 13 May 2026 02:40:05 -0700 (PDT)
Received: from vitor-nb.Home (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce37b308sm65629665e9.10.2026.05.13.02.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:40:03 -0700 (PDT)
Message-ID: <17e3511e4bf46f83c91088bd4e081d4323e1bd93.camel@gmail.com>
Subject: Re: [PATCH] pmdomain: ti_sci: add wakeup constraint to parent
 devices of wakeup source
From: Vitor Soares <ivitro@gmail.com>
To: Kendall Willis <k-willis@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Kevin
 Hilman <khilman@baylibre.com>,  Dhruva Gole <d-gole@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 tomi.valkeinen@ideasonboard.com, sebin.francis@ti.com, devarsht@ti.com, 
 vigneshr@ti.com, vishalm@ti.com, vitor.soares@toradex.com
Date: Wed, 13 May 2026 10:40:02 +0100
In-Reply-To: <20260512161737.pflweaz2r3q3nrfl@uda0506412>
References: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
	 <becb54adc0bea88578c8fe4c7c1b7b68bf5cc6d4.camel@gmail.com>
	 <20260512161737.pflweaz2r3q3nrfl@uda0506412>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A66E8530D1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246796-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivitro@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 11:17 -0500, Kendall Willis wrote:
> On 17:51-20260511, Vitor Soares wrote:
> > Hi Kendall,
> >=20
> > On Wed, 2026-05-06 at 22:16 -0500, Kendall Willis wrote:
> > > Set wakeup constraint for any device in a wakeup path. All parent dev=
ices
> > > of a wakeup device should not be turned off during suspend. This ensu=
res
> > > the wakeup device is kept on while the system is suspended.
> > >=20
> >=20
> > Thanks for the patch.
> >=20
> > I tested it on our Verdin AM62P. As expected, suspend now fails cleanly=
 with
> > "-
> > 19" when an SDIO WiFi module is registered as a wakeup source, instead =
of
> > crashing on resume:
> >=20
> > ti-sci 44043000.system-controller: PM: failed to suspend: error -19
> >=20
> > I did not test the IO daisy chain wakeup path, since that is out of sco=
pe
> > for
> > this patch.
> >=20
> > Best regards,
> > Vitor Soares
> >=20
>=20
> Hi Vitor,
>=20
> Thanks for testing the patch! Could you add your Tested-by tag?
>=20
> Best,
> Kendall

Hi Kendall,

Sure:
Tested-by: Vitor Soares vitor.soares@toradex.com

Best regards,
Vitor

