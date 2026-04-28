Return-Path: <stable+bounces-241700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKQOHg7X8GlHaAEAu9opvQ
	(envelope-from <stable+bounces-241700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:49:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E7948839C
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7D4F301C6FA
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9353C1961;
	Tue, 28 Apr 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dGOXt3Dk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A03BED06
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391360; cv=none; b=hnsH4IyVK3l+l9AE2DAIHNpWS7x7fVRpj6qUuQdXiyGqvurJOInSbARH4m6zev6C0Wgfy6ONSserAosGh2A8/QRdxX3Rr3SifoilTJ/eyyXb2yW12u/GwwqghPUthEauiDZpqgoS8WY/cS5Xwyehs7Uv91r5Ycgy144eXGng2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391360; c=relaxed/simple;
	bh=ajbkEbKDdLbKymtMUQjuNsnZglOkHRFWBqwK7N6UE2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sto+EBbhiSEAFmjW222mc2Q6lwLo0TVnqBY3CKXDRuXrQEZfTHgVyWsCBIwLQT+BoeipY7QB+Avc5UpUVX//WymnTTtu/apifnSFjYO+wibEL3jCspfyOREzOYl+uIU7McXal2AcNryEYVTr1w21yK41bbgjTwwrmsnQryvYtAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dGOXt3Dk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67893fba9c3so10922989a12.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777391353; x=1777996153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajbkEbKDdLbKymtMUQjuNsnZglOkHRFWBqwK7N6UE2E=;
        b=dGOXt3DkK7d6ToHP5Cme31DCsZbT7Fl5NkknKct2+BL6sz6uh0HVzUNcP8/IaJjAz2
         mxDsQk1BWu1FaPOSGaPNWhhZHf+17VaIgvIH7yZAvMimusmBXW/oBZfO7FtWacElHvFI
         lpZ31iu9Adh6j6aQ2tipA5JqZSKXCd5tQrpcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777391353; x=1777996153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ajbkEbKDdLbKymtMUQjuNsnZglOkHRFWBqwK7N6UE2E=;
        b=kRv5yYZ9mWz+yr4vhwYgYtV5QUh98do1VT32xvY9MOUZ/kUv2HzMlh/I2kl5/fXUN/
         wG5t5J7WwqfJBRnLqVI+rC4uhR9JOqEf+gG5BZyTIrQahv62n2/VV+b7LvEKKLOef1tc
         2p0SeQa8XKgzNGl8+WAfs6Ewd4uaq3eMOXzjA5KYv0Bm4vw+f9+pqnnpazvG/fDk4ntH
         4bZqvqHd7OUMyRkscatIxLFdbom6SRjbrJhl2z1BKyZW0EGKxiOKzq5emU81GpXOpjOR
         0pTV1oHe+e1C08S0xEyY9JpA15wCtWG7M/dDCmLOz6i9Y3yRlpaCDgJDn8s5EnB9NkT8
         GgCg==
X-Forwarded-Encrypted: i=1; AFNElJ+eK/HnBrlN7NP39R7AmLcn1T0ZHy/48VD8BA0ga7t+JabQuPpyCHy01oGOOhoTm4XSrAigC14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfAlHwY6o5JxinFP7ZTS5k+MeZQjTdq//HzTIpcS0ccROXiN+9
	AYlJIlWeuUOTdco9IhY6KsOK2t+TfISk44Gv7hbCeRVmu7TiyF+7AomlscdkqE7Shw5BgRP0zW3
	/jHFDs8tv
X-Gm-Gg: AeBDiev65U4ZiOEoi47MRetq6T6Xsyc01nj8IONr5p8fRY5KHy/AZQ45ft26/iXM1pj
	TtyXuOEFQ9qzx8lrT3n+43aIUFwocnPSkmX6dlgJHyXjAwyV9gmmggJAcXEC7cEbQGBNznE4z7q
	j9p1VOHAFXUE8wWr+TDojFgEhG0YaLvakXYJ9EVBd9J51lML405IrCvS4mHFe3QiryukAq7bp7I
	1qa+26AJB2bc53H2UY9BFVNnmldIMpY2rrPS/TO3J6Dl+qunSsCmFr0dqubWeSNVjPfCQamrASc
	dtKfJq/tsM5st0Pgy92sQmqR5HQvOZfkj/DhYJBhJxhMNU7kwEaP0SjC3BlfJ+sdICmM9OV/OA9
	GgJc5hFLI4iB2xqRe1979fUvSVqOungnQ/JeoGjep5mJ6aVU9QM3Nc3uCLcQnkMcE8TmR/zTgyZ
	L5N0aZwyKf6de+DfW4eYombwhZ3ZOfyQAOIndNUgQ9ndY4XwOIlODWsMCIG8Wve35qKTxym0IbD
	Mx0wS1hQQA=
X-Received: by 2002:a17:907:78b:b0:b9d:31c2:37f9 with SMTP id a640c23a62f3a-bb8014fa56dmr221408466b.2.1777391352418;
        Tue, 28 Apr 2026 08:49:12 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80853b64csm118934566b.12.2026.04.28.08.49.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 08:49:12 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so6499859f8f.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:49:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+4Ol/1cBH5PuiIxpIJg2q5YN4hBSAvG7GvAsXLdA+QtCbP+7fMyH+dvtY7FaU+3dVDj5u/aCk=@vger.kernel.org
X-Received: by 2002:a05:6000:26d2:b0:43d:300b:2285 with SMTP id
 ffacd0b85a97d-44648b50d01mr6684095f8f.11.1777391350488; Tue, 28 Apr 2026
 08:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
 <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com> <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
In-Reply-To: <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 Apr 2026 08:48:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-FUw_MqE2ufv=ngBS3ho4vg-QKokav+MeP7XAAjXUbg@mail.gmail.com>
X-Gm-Features: AVHnY4KcDuFY0KOauqhFMmUAZtkIYYE4OelTMMpZ8zfK3NDGP7A542OgIRYDm-o
Message-ID: <CAD=FV=X-FUw_MqE2ufv=ngBS3ho4vg-QKokav+MeP7XAAjXUbg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending
 disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 16E7948839C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241700-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,iscas.ac.cn:email,chromium.org:dkim]

Hi,

On Mon, Apr 27, 2026 at 10:49=E2=80=AFPM Icenowy Zheng <zhengxingda@iscas.a=
c.cn> wrote:
>
> =E5=9C=A8 2026-04-27=E4=B8=80=E7=9A=84 11:24 -0700=EF=BC=8CDoug Anderson=
=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >
> > On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng
> > <zhengxingda@iscas.ac.cn> wrote:
> > >
> > > When preparing the panel, it seems that it always expects commands
> > > to be
> > > transferred in LP mode. However, the disable function removes the
> > > MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> > >
> > > As the unprepare function contains no DSI commands, re-adding the
> > > flag
> > > just after disabling the panel should be safe. Add the code re-
> > > adding
> > > the flag after the two commands for disabling the panel are sent.
> > >
> > > This fixes screen unblanking (after blanking once) on
> > > mt8188-geralt-ciri-sku1 device.
> > >
> > > Cc: stable@vger.kernel.org # 6.11+
> > > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as
> > > separate driver")
> >
> > This "Fixes" looks wrong. The bug was still there even before the
> > driver was broken out. ...and it looks like the driver that this was
> > broken out of (panel-boe-tv101wum-nl6.c) still has the same bug?
>
> Yes, but I think the fix shouldn't be propagated to the other driver
> because of the same reason with breaking out the original driver.

...but doesn't all the same logic apply to the other driver? Nothing
ever adds MIPI_DSI_MODE_LPM back in.

Even if you don't fix the other driver yourself right now, the proper
"Fixes" tag is when the problem was introduced, not when the driver
forked out.

-Doug

