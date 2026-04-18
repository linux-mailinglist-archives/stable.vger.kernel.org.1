Return-Path: <stable+bounces-238540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN/KGnTy4mmrAQEAu9opvQ
	(envelope-from <stable+bounces-238540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 04:54:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F741FCEA
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 04:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A87B30A6188
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 02:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321A82D249B;
	Sat, 18 Apr 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5NJc7Zz"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D125D1E9
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776480614; cv=pass; b=kkOeI/656Q2ISmqbg+6ir/BH/1gg2m6oye2JYlBHBDJfxO9YIZsaxpJzG+zqCkCrqD6o0kdNP+EZk/IIWUBANrXj3Y9ceqH8NgL6Ur1E0yBtSTrDADXRcnMGfHyFTgi7ybNdCb1qtilmp0+Xtn0xH5orp/4v8TA3qe5ymeGPF54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776480614; c=relaxed/simple;
	bh=sTpB3zFGMA4+49UPAPJnoMPYvm1cGwiY/ChissLecvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hg1zc71CRX5CoP/nr/vB0i51w+Amue7UwcDHYAw85I0NZhMq0ufdEXtIO+dadZkqCLN7+dSmaTxQCppYNoafQ9Bjf1pFv1uvKeHLRsLQReK0h19Kv0Q0mZeJi3F3sm+MDZs9xtKXOnsEpF9qx0uHfKw3Ev8ZsvzU+SzpCwIrqCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5NJc7Zz; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-679b072ed3aso706138eaf.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 19:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776480612; cv=none;
        d=google.com; s=arc-20240605;
        b=boal0Kj6cnAFJPhlWF9/XVOhC9vHSlaHsqq99S4VD8Q5gMgAkgYTunY+dpZ7qRCcll
         zutdkx3ezPz6hNu+wRS/01pCfezEf+5Lm7iwTdpHJrneyuNjOsV5+X+CxP+tcNNVsCkJ
         n6gnDmMNVSq1FZZ4cUsPOtczo0ghQVYad55VsY2bO+mxmQbL34CXEo+DCD24vZDNkVvf
         tCgKd4a6MkLYwOwL9JpU2IVmkCwaXa042r1NVlqp5NMgv7+W0mnUfWRLWka4tfHoFy8H
         3Sq4HdWeTVxPA24F1AOMS1yp4ZcHfHad/6lYXJ4lV1Qvitl5VVy67R9Y4/Xrg4egjtWl
         hwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sTpB3zFGMA4+49UPAPJnoMPYvm1cGwiY/ChissLecvk=;
        fh=9Dg/kA5RjXA3wsPE2sUVgRXFab+6rrkB7VqwYUizo4k=;
        b=Ncfn8X6UXNrQxvCxt6zDdgMUWtWLcExThkLq5upNI87XzxSKNJEJfRiRLWYlk5Z5AZ
         8FFTV8cKIA8TvLDVUXvAwvNM2861+btcB0lJzvw96sVE4BrEwaS6nkCeAFdcFFXXKbAL
         kINJUhBaUxPeRL8qt3x8UTyPjNrCuTSbb3Dt53jm422/I6ypSIzj8vIPfNaQpemsUfH/
         M9qk4KcGhEd+cFIS4plpcKgCqAaswbOvmOr+MbP2MVvMfgUPFcr5bYVFkkQCA8JrDRVI
         /tat7glTQ9M/clOcxG0nz3xocKUSXPTHOKJiVrbPBL147LubgBjfnqI7STVgdtfC5pV3
         rK3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776480612; x=1777085412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTpB3zFGMA4+49UPAPJnoMPYvm1cGwiY/ChissLecvk=;
        b=L5NJc7ZzD0XXlkyFqphmwJmka1ifEx9lll7Ih42v1Pxw6TPc6HSqH1N2zLl5Udogbd
         UeWodJKrbTNtEoaFGu2iYhcw9/yihXYsxUhcOIzAzQPSUzbl809K3yX3r+YGyaBfAGUh
         TIyP0/iVY+aySRe8Y+mSD3V+wHus9MuP0Bj1xMWHM88XDNTq9q/rs+zFhsne6K7QtfQB
         FIKhmeu1RJFRDH+5asPJYrsoreqXu9Kgzqtypuld0LWlUg6Lyi04fcBAlgUFFrsbEDhg
         ZREqERpnbnpRhWMMgcuV6UJhLdIUlkGHN0DkUQMWrsTSJjY3u6UshQVnVev8mfsQS/6D
         oyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776480612; x=1777085412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTpB3zFGMA4+49UPAPJnoMPYvm1cGwiY/ChissLecvk=;
        b=JE0GLDD0NAVFA51D6iXDAWEbUdIAYhW6Pt2NV9knVZfy7GF4vo7hGYP3P3mvhYVhHr
         IPsj/CH/sqZqePFyoZ4ZjF8aSd3YMUVcF0BfmWxSfRZfiRV8cEYRWYceFSMTL4kB8BsB
         GLZ55xs+md/eWbUJ9MIk0xT2y4bgOTM0yV/zLLBFMIU7D8rz2jJA3OHsWTfkgqcEUYUO
         xDL2o0idvNplmURTGAp74+F6cmg4cxAcQ6xOvwnls9PuxvSCNHAvSzMyX5bXITB8SCj7
         tqkCJNDWBk6HE1b6+LtjBvzfjLmDITqno3DuFRw01V2uA6IfwsDcm3+oyOGfHIqcbT8l
         kjIA==
X-Forwarded-Encrypted: i=1; AFNElJ8yYu0tQotgartRWdcRof9xlA/q0Shu2+vPsgttEUprbOW1aCxoUEm9O5vZ2oMBMqgMaEqOe0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuIYT0EZHCfyPRn7gpxH0eY4EYVo4+gqHWt/Qk6M15y1MnJ+Q
	pHXfcfStqtc4YQThV0eif440OqbWiwoUtrU90koHAGBiH+KtYJNWQyMDFKnxl7XaEMiEEhDtrnN
	seq9uvU2o2ZlQg5Yh4nIxGhbRvIwNJlo=
X-Gm-Gg: AeBDievq0IllKS6sonCQUd15YLsiaFuxemEzAw1RUWdDDFCQ2aLxlVDeTYdervciEXG
	Ap3dw+5Zkkign4OsfVZ7cqamtKpvi0ElJVIpXW35IF1nJlfZM4fENLXDGcB56sQd4grMPX/apXo
	+OMvNNopvCcGu7YiR3DwScYmrvzzJEoienhvWjt4GnpiqqC/tEJV23FQ/QuCGvaR8qJTOTYb7Ky
	DlaG4G61wcLFKMlv9Qovy2Lo5nbCBtxOUbx2j2tV/pzEMKN8JMqgmsdYQVaYPpmKv0pG2FZvu7Y
	gW4BVBQb9rmau+EyOuA=
X-Received: by 2002:a05:6820:604:b0:689:7cd7:259e with SMTP id
 006d021491bc7-69462f44c08mr3366697eaf.57.1776480611628; Fri, 17 Apr 2026
 19:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABb+yY23aTXeXu6G-8sHjw32DCqmhsJLu2Mt-txenOgTBiyv+A@mail.gmail.com>
 <20260417084335.2092188-1-joonwonkang@google.com>
In-Reply-To: <20260417084335.2092188-1-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 17 Apr 2026 21:50:00 -0500
X-Gm-Features: AQROBzBa_VS1wWtSKDMjmtBp02-qplt4Nx2TejF_JEV5fvEqT0eLpBXx6xGnZnk
Message-ID: <CABb+yY2yBZ+hgr-=Uh_sRk-TJZRfsk2AYtoS5rPtUN8kVsUScA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mailbox: Make mbox_send_message() return error
 code when tx fails
To: Joonwon Kang <joonwonkang@google.com>
Cc: akpm@linux-foundation.org, angelogioacchino.delregno@collabora.com, 
	jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-tegra@vger.kernel.org, matthias.bgg@gmail.com, stable@vger.kernel.org, 
	thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238540-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,collabora.com,nvidia.com,lists.infradead.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 047F741FCEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 3:43=E2=80=AFAM Joonwon Kang <joonwonkang@google.co=
m> wrote:
>
> > On Fri, Apr 3, 2026 at 10:19=E2=80=AFAM Joonwon Kang <joonwonkang@googl=
e.com> wrote:
> > >
> > > > On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@g=
oogle.com> wrote:
> > > > >
> > > > > When the mailbox controller failed transmitting message, the erro=
r code
> > > > > was only passed to the client's tx done handler and not to
> > > > > mbox_send_message(). For this reason, the function could return a=
 false
> > > > > success. This commit resolves the issue by introducing the tx sta=
tus and
> > > > > checking it before mbox_send_message() returns.
> > > > >
> > > > Can you please share the scenario when this becomes necessary? This
> > > > can potentially change the ground underneath some clients, so we ha=
ve
> > > > to be sure this is really useful.
> > >
> > > I would say the problem here is generic enough to apply to all the ca=
ses where
> > > the send result needs to be checked. Since the return value of the se=
nd API is
> > > not the real send result, any users who believe that this blocking se=
nd API
> > > will return the real send result could fall for that. For example, us=
ers may
> > > think the send was successful even though it was not actually. I beli=
eve it is
> > > uncommon that users have to register a callback solely to get the sen=
d result
> > > even though they are using the blocking send API already. Also, I gue=
ss there
> > > is no special reason why only the mailbox send API should work this w=
ay among
> > > other typical blocking send APIs. For these reasons, this patch makes=
 the send
> > > API return the real send result. This way, users will not need to reg=
ister the
> > > redundant callback and I think the return value will align with their=
 common
> > > expectation.
> > >
> > Clients submit a message into the Mailbox subsystem to be sent out to
> > the remote side which can happen immediately or later.
> > If submission fails, clients get immediately notified. If transmission
> > fails (which is now internal to the subsystem) it is reported to the
> > client by a callback.
> > If the API was called mbox_submit_message (which it actually is)
> > instead of mbox_send_message, there would be no confusion.
> > We can argue how good/bad the current implementation is, but the fact
> > is that it is here. And I am reluctant to cause churn without good
> > reason.
> > Again, as I said, any, _legal_, setup scenario will help me come over
> > my reluctance.
> >
> > Thanks
> > Jassi
>
> Hi Jassi, can we continue discussing this issue from where we left off la=
st
> time?
>
Long passionate essays are difficult to read, so I haven't yet. A
simple description of some setup that you think is not supported, will
keep the discussion focused.
If your platform is supported but you think the api is not clear,
updates to the documentation are welcome

Thanks,
Jassi

