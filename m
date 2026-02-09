Return-Path: <stable+bounces-215509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKdsFOH6iWkiFQAAu9opvQ
	(envelope-from <stable+bounces-215509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:18:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE481111D1F
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2D0A30045AA
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084C37B409;
	Mon,  9 Feb 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="zQGG9RsE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374323E23C
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650334; cv=pass; b=pFv5i2OtEO5aSFzwPvYGBoaCrLjlbMb80f7P9HRe0XPJg5RsByHRCKvgoHl91xMQQ8FTJKxBSbknZlzPxL1O8EJ4rJZvt9vTEW+x/Ag99vFmvQbO4LxBwUGXY4Q+By6Qx5fZ+1rNJiIEgXjSjbleqhetOrkp/EiKS/vFJmEFD+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650334; c=relaxed/simple;
	bh=dIWXmylZPzNqdN6BM181qWUOHr0EYoBlXJFLEn66gf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJxyxPIih7KCA2DWAocF9OsJ6NFVXoOf57ICVJAJCZYhN4NqjNl4sBbmvnDVcyA/SPTMGoGYWvb98S0q0/HBP7rnxXDkMsMgNeoUkSK6Zucs/sxlniL6d3OyXKjjlUxwRtSN8kx61D4huwCFTwYyDTAoZBQqh1vb6cG3QjTRh3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=zQGG9RsE; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8e9f89a8e3so501741666b.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 07:18:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770650333; cv=none;
        d=google.com; s=arc-20240605;
        b=UFABXDEDXJ2FKMoEFbav1v7APWTzbNItsP3Qy1hyM4WJLFW33nAdU8nPXR3duEofYE
         qSwsnO3AMkaCPtRbzNhWHvcKtNKeFGIWFLrLYiz3YpUY6Md0dT/bTMaAgGS87/3RV1Mv
         3W6zg3W2KrbMNW8vtEoUtvMiKiAU3VSXxZLrHCava3W/veQhSUL6gQkrDP3BLCtFlJ3v
         6k/cPSCNSJ9tkcqmaFM9NeLXfnG4F/Mu3bj0zwmq0GpQvoA/eph7XiGi/ZfvBlOAk7yd
         4qfpny5+BjC8WqmIWVs+SuxqDg7kNqkTJ/YfZTUmlx5RR6z3O3leQFyx44Tb408C3DuQ
         FjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sWZTFl9HnKvhHeUb1Vsrqj6kNSRtJUq9FBG0uoT0OjI=;
        fh=Eg1ADjqyrqcWW2zs2FTzBmofppMsiu2E499/mEC+efk=;
        b=jiSYNUXzM1Ps3UOKMW/4gjaK0DUQpm96L86+VrJhLRgXVBaf78p5ZrHpJL/Ub7Y5AK
         xBaHL1+rQgEy2m+muVBotpC06mF0unCXiXwyxQncOMFfgWLcMzukixM0Sq++mT3HBhyf
         C+DFuSb+RG2d6YGK83EF2zTiF/NZvwlYDLrbitwlxCs57rpdiLKfYAakmDGx1hFJjnia
         Qzwph7/8j6TshDIWGC4VFAt65kfk6r3qBm3Ql22FWJTAVncg7Xynhkl7tjgVBOmQVpyE
         OnkV8GnI9B4Ku+pef9DTU9hzHm1Hj6RPyYCmQRgS+gbj57mQPBhFDlvRXxy/D62MUfd9
         FQBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1770650333; x=1771255133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWZTFl9HnKvhHeUb1Vsrqj6kNSRtJUq9FBG0uoT0OjI=;
        b=zQGG9RsEINuQ4pz6XMSjMEAs75/TyiClNt2exu7J1EoQF5QFBzleTEyk1TC77w/bdQ
         cdYFM8UPksv0Cwil9uSHlYciocJoxp72UPBsokkUk/NbQ4M4wqU62S/GDQn7ad6XZrer
         gJ5s/74nc0Ub2EyqdLk5TzZpGd7xRlh0TzwxQs86+dvcxgpbb7Ij6p9B2fACMB3EtiLe
         R1MegnAyvPpzj8tFdyyiA0FFZW874hxNO6P/mP3zLq2SXnKDXbQCJhDYJWzvPUcDobTA
         ogMQxa1nl/Y8Yn3tQhWWyg8ZvpnL4p8mIQRBBkbeWvVruc5vOQ0fghQ2djz2vc/FYOeN
         i4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770650333; x=1771255133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sWZTFl9HnKvhHeUb1Vsrqj6kNSRtJUq9FBG0uoT0OjI=;
        b=Ai6OrTPj/5fXke7LLZ5ZHSNHk6d2uhHZkffaUy+JW7Y6Z+4dkOazvxSUDZwLJgICPu
         AIuuBEMdHCaQanZnLPNgNyif8vn7GdPG9vsP6QnyvWsen+nXFBRPeL46d3O+7ZI+whmp
         mHcCV2hDy/eUlHnm0TmBqijBaWpAqRybOypCLbSBa2tkqDxXY38cF3PyWrZZCVa7MPTz
         ibxL8JPaaDCl/j9C04pPcBymb6UXkE8JzIvULGa/bm/9x6nbhxoMaKwDyOtkR7oYwowx
         rMsTvFfCxxKWsPsPb4SsMO4KQMfrKu2mZkaTaMAd9l2H8TGhP3WWmUoCZPyLhhzOaJD6
         gwAw==
X-Forwarded-Encrypted: i=1; AJvYcCWduxcFVjAaNQa3uzRS1pUGesAtAr5qyIw/heU4oIWKErrW/p8ni7Ks6/rDkTqSOhwaXBq1YpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcjtt+yEIINe7uMY4jEafRschi9ykED0hnnzZSpLNE49S3zE0O
	41wQkcjuE4wwB9p/A4K28PQbiu96+h8RtN5dE+FT2h1MzC+//WgZW53uHTFSI4jkUJh8DxAlXCi
	KfKyH23hMxocVLMmaJLyrvZVDE3V3Mp3QmqSs6lgRKA==
X-Gm-Gg: AZuq6aL1eweiDZjeM7B4JiJXyUNlwYgIBYO07xwql7dr7tLtqAKZDedRXltCYVJNqYK
	duWuggVDEuQ+5fZRX8Ld0Uqqgmtgh5CnhyXIJLegRCao/7n2NK5dm75Of+YT+KKmxfI+6Mi7n1z
	SVkZG3QlX/fkCNmg5PRTfOJRuzWFBV2N3Io8bY6C7ppK7bqLj5q/IoQQYvXdBgTITTJVmKNCI+2
	KLA8ZxPMBNBHZWrNTpX2y3ShNkjXwvFS2APSqPu0nObkUm4QW3nNwj04wvpnMSKqaVFohImGJgx
	X4mQHfLUVNFg8+zXWdzRdKztFfhDiGfFIiq2Bw==
X-Received: by 2002:a17:907:6d0c:b0:b8e:d4ed:5ea8 with SMTP id
 a640c23a62f3a-b8edf2ffe66mr675457466b.42.1770650332900; Mon, 09 Feb 2026
 07:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-ufs-rpmb-v2-1-5e1572ee52bf@flipper.net> <e96f69b108eb13a87838581aef9325dd74c556d0.camel@gmail.com>
In-Reply-To: <e96f69b108eb13a87838581aef9325dd74c556d0.camel@gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 9 Feb 2026 19:18:41 +0400
X-Gm-Features: AZwV_Qi7l8Lun8llFPbeVBs0F2HyCOP24UjzbWTJPUSSNzBWpVTvupK184oPlqU
Message-ID: <CAKTNdwGSYcD430zcuD=z=o5=pRDDvZtDNSY8SYtnyiuUB8r2Bw@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: ufs: core: Fix RPMB region size detection for
 UFS 2.2
To: Bean Huo <huobean@gmail.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Bean Huo <beanhuo@micron.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-215509-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[flipper.net:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,micron.com:email,jedec.org:url,flipper.net:email,flipper.net:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BE481111D1F
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 6:51=E2=80=AFPM Bean Huo <huobean@gmail.com> wrote:
>
> On Thu, 2026-02-05 at 12:30 +0400, Alexey Charkov wrote:
> > Older UFS spec devices (2.2 and earlier) do not expose per-region RPMB
> > sizes, as only one RPMB region is supported. In such cases, the size of
> > the single RPMB region can be deduced from the Logical Block Count and
> > Logical Block Size fields in the RPMB Unit Descriptor.
> >
> > Add a fallback mechanism to calculate the RPMB region size from these
> > fields if the device implements an older spec, so that the RPMB driver
> > can work with such devices - otherwise it silently skips the whole RPMB=
.
> >
> >         Section 14.1.4.6 (RPMB Unit Descriptor)
> >
> > Link: https://www.jedec.org/system/files/docs/JESD220C-2_2.pdf
> > Cc: stable@vger.kernel.org
> > Fixes: b06b8c421485 ("scsi: ufs: core: Add OP-TEE based RPMB driver for=
 UFS
> > devices")
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> Hi Alexey,
>
> please address Bart's suggestion in the next version, and add my reviewed=
 tag.
>
> Reviewed-by: Bean Huo <beanhuo@micron.com>

Thanks Bean! Added in v3, along with the fixed comment per Bart's feedback.

Best regards,
Alexey

