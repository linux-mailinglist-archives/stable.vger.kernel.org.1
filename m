Return-Path: <stable+bounces-246701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNkfER2yA2qy9AEAu9opvQ
	(envelope-from <stable+bounces-246701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:05:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D7552B2BC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9409B3064665
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260CF385D76;
	Tue, 12 May 2026 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="El6s+MY0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669B9342524
	for <stable@vger.kernel.org>; Tue, 12 May 2026 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627095; cv=pass; b=C+TF63lUH7vJVRLmF0sxCXenogifphmqOahCAK3cN2h0d1SezI/Wgcp21Lre/P64pz/cGVdxwJnHCHyk+bgq0bSHd/3zo3M76DCc8T5H5D8OtowuXtx7nZVEJ4zyAPpuvMZDNk+Fik67BPQERFis1DHk5qHQSMGpz3xcacbkMsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627095; c=relaxed/simple;
	bh=KpOoX021JXCFcKPdmiwJvqTk4B77UB3nIONU7aqJx+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXxML7HBV2Iye8Tgg8jagZHfYyl6WNNmcr5pXJgdumuIZ6GuciIEopFIikhwVPhBXcor3PHraLr5/1vwTy8E1i8NhzP/4vM65yhYYjFY7Jn0+3CgOxLHDo4LuVYaOclodsw0x5eKkh2zIBJQt/NhSnvnttmK9UWNcMaDNPemzIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=El6s+MY0; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so815e9.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 16:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778627093; cv=none;
        d=google.com; s=arc-20240605;
        b=TnbcgivyhL93wS/ueuCgYFOzQecvBcy8x9dq0lDrARcBSE02wMLXCBOHpxgvq12fpA
         WAdhFASCHoymT4zKf08iGUWnwuy27ZCj5Vfxe9lG5rdw8UMaSb4Kb1CGYNkmBqls8r4k
         quKIkhOFbS06yFUvQne/yAaa7fdRcbdfSz7QP93NUq8rDmgL482X6v2w5g19tA3xpDIX
         C6lTtg+CP46Ndpl5X1j1aL2vzsUk3Q1BA/FuMfmyiubgnAj1yONXHnNeeCK6iW0/d0UW
         /ieVxGdYgcIqxp08FdGJ8Q7CGXMEeKwVjkJcL/eBazUAcreIGCTJWNW5iT50m5RwCKyB
         mv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KpOoX021JXCFcKPdmiwJvqTk4B77UB3nIONU7aqJx+I=;
        fh=Rt+i/RubTUG1FcVxKbUHUboVGPEg4Tx87m8SpxHbTp0=;
        b=RHJtGGIjuHpiDoJ41quint0tK+7WnroiroZVmRXV8q/DpZ5WRhtsWloml+io1wY/nP
         zKZP/9T2CnKYNMmHGvOhD+2Wu+vVds7bLcKRKFXTYxFaN+8WKyhL736ukHpCI4kTOTe/
         W4LgqDbkFsUnYgDe6SiJmDHPLRHyj4IlWQK2uBZRh/oTbX9S2ltPXaCB3AlxhaY2PrBy
         eU8HZpxOLmss3TVUfgB+P5YtgBbrzoFkNSt/Gip0OYaSA3ttFTjRT1beQFW3+0S27fYX
         xp71y8DHFHlpqPUr4gqSXGBdQgkc9GGhatxQEvt9Kw8jst8XwVODx0A059ScUyWb/JzK
         5zlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778627093; x=1779231893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpOoX021JXCFcKPdmiwJvqTk4B77UB3nIONU7aqJx+I=;
        b=El6s+MY0RwRfrcvMJFu1fCTk7Gl6iq1K8hWq2suS/LAXuE/Bt9BjKyHGPYtJOevaID
         Qovmfm5WT+OfuBhPCaBHz44y+ogRsCxYXdgHftm4iz5+cqzCDaLz7KTrPoNwPHD8NqO0
         bD33SnixcpGpqmGq+d3W8VqkvnM81aE/WcaMbCaYG7bOctLWDJjHSJhLh3wXm4fAq1vs
         vWHjBWBTsn+nlVUfCHqmMk2pn4A8KHcgZi5W9BU55Kz7jkMWS0kND6gGBBSvMFi/AVup
         A8CpL6a5nA9VA/rx1NY1K7mRtMqr65/ZDglauSdfArN9KS6vKR5F0prWudFS7/MsKEf0
         QuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778627093; x=1779231893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KpOoX021JXCFcKPdmiwJvqTk4B77UB3nIONU7aqJx+I=;
        b=jUhA2MzmRplv8+lg2hTtCiXyBx9oj32L2p2o+KVY5hqMahL5w7Pm86m0/adTf+WCaV
         num+fsq+9PF5vy3y24pXoAJvmGiR7TQe4X1fNH/SLCV1aTiAuHRyF6boG84a78X4oYJQ
         4F8+seQANYrLGyG95IPF0altT75Rd1zNMel2GgP1yaAtwmZfUNW3tyohtvnto+Soji3L
         0wjf9NlttsiGIAlYT1bwL1vesF7CdINTDlO9viO2/kYu1k/NBm6jUrqa1WsY4QIHV6k3
         JIkhqbFvyhOul/07WHRGWQDLk012SzbrA7wzMEgZp04wqYepeA0KH8K+Yba5jRI9GB+N
         8/oQ==
X-Forwarded-Encrypted: i=1; AFNElJ+q+JwCBvsfnp7QzCG8XyitUpa97AHO/4YPcU9vV3THfrMeTIzyzbrNiofAkr2xWz5/GbS9eVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaie3EiLO1YQrGiWq4rYgVWSmqc6W0z4rQY4rEysmlytKfvVg5
	WA5K+LDZ4MXVGEj3jMfglPMrq0rAnDWEIuCC3i4UgHYX1vcl7qwt63xXgXjBD5cSmYfKbeHWLYd
	JuXdNtBzdRlUDVikYg2qACrUc9dQxojg3rj1OJwZv
X-Gm-Gg: Acq92OFxsaWSr7etlsW1OfpgHhd5mAeG/3FWSYg3zY4Ci3z1VOMw3HUWJX4Df3hN1xI
	vrSrQ2LGR2hiGxBLiOyC4PNgkJ5t/lMvEiWIJmNYnAlQHCBksdvOxn3w2Dr/50Yr5g+whW6MiWN
	WEu+tUc0x6NkIiTBEyQNSUa0s2Lc+6VwVBQk3xzXV/mA2NGWgduevnujuM5pVD31Fhjf0OLIcNf
	4OmkF/pUZF6r1/4A/8YhiDfgTEqd6EQodQJDHaFnp02YBGtFbyVECC5UtHzVy/tg2eK8Cr/40MR
	ZINLaKgD0AV+oXPVk4jRQxTEuem4B6jpe38lKhsCTk3OcOBd+9Kw4PncWl3p3jCJXeLEJ66DlyO
	8E56vNM0M9pTmmik=
X-Received: by 2002:a7b:c455:0:b0:48a:56fa:36dd with SMTP id
 5b1f17b1804b1-48fcaebf3b3mr120885e9.11.1778627092566; Tue, 12 May 2026
 16:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417154704.1186803-1-tjmercier@google.com> <89s27nso-4053-p971-4q69-p4nqo5n7p65q@xreary.bet>
In-Reply-To: <89s27nso-4053-p971-4q69-p4nqo5n7p65q@xreary.bet>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 12 May 2026 16:04:37 -0700
X-Gm-Features: AVHnY4LH5AHtFpO25VgzAeX3k2o7aRw38Q8TFmJHj5_FfZZxyPG2XicnoUV5PV8
Message-ID: <CABdmKX2sLGEFZDziwKG3rJOYQsdyUVUxM68xbLe5WGAPoy0AYQ@mail.gmail.com>
Subject: Re: [PATCH] HID: playstation: Clamp num_touch_reports
To: Jiri Kosina <jikos@kernel.org>
Cc: roderick.colenbrander@sony.com, linux-input@vger.kernel.org, 
	Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org, 
	Xingyu Jin <xingyuj@google.com>, Roderick Colenbrander <roderick@gaikai.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A0D7552B2BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246701-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 8:55=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Fri, 17 Apr 2026, T.J. Mercier wrote:
>
> > A device would never lie about the number of touch reports would it?
> >
> > If it does the loop in dualshock4_parse_report will read off the end of
> > the touch_reports array, up to about 2 KiB for the maximum number of 25=
6
> > loop iteraions. The data that is read is emitted via evdev if the
> > DS4_TOUCH_POINT_INACTIVE bit happens to be set. Protect against this by
> > clamping the num_touch_reports value provided by the device to the
> > maximum size of the touch_reports array.
> >
> > Fixes: 752038248808 ("HID: playstation: add DualShock4 touchpad support=
.")
> > Cc: stable@vger.kernel.org
> > Reported-by: Xingyu Jin <xingyuj@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Applied, thanks.
>
> --
> Jiri Kosina
> SUSE Labs

Hi Jiri,

Thanks for applying this. However now I see that a different fix from
Beno=C3=AEt Sevens from around the same time has landed:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D82a4fc46330910b4c1d9b189561439d468e3ff11

That fix was not yet present at
3cd8b194bf3428dfa53120fee47e827a7c495815 which I used as my base.

His patch prints and returns an error in this situation while mine
silently avoids the OOB read.

So I think it probably makes sense to keep Beno=C3=AEt's patch, and drop
mine since his code means mine will never be reached.

Thanks,
T.J.

