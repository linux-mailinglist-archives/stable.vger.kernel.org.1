Return-Path: <stable+bounces-226892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJkwABqwuWkkMQIAu9opvQ
	(envelope-from <stable+bounces-226892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:48:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9788C2B1BA0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00D4F300BBA9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2D325714;
	Tue, 17 Mar 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeNbeeS1"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CB285C88
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776918; cv=pass; b=srjzMj6zIxmD2rNiu3Nhz3EgQv+T/ibKoIsiEvIo5D8SB6bRxRi4Ab8/ZsmdRPLDOGbDOZKdZ66VDwl/bhNfpmHVIDrEgJL/aEoxZhKC0BdHzm6PRi8d3GKI2g17zsfWBx6mHksyiCSTq8nS8Mz6V2BaLCvOkYxmjP+o8ShTpcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776918; c=relaxed/simple;
	bh=at1k0kn6fTTPQA+HIlCY+DsBGv8Sub72wHsmakW5ET8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6mq80LpNpBKcwHgvxFuwUMKSRwdaf6yX9hVCPaTFM/ET8v/My7Ed1YUtwjaB8zFdDNrWngW20XKvzbfkyPAyyEXGG8CPX3mN+h5yCwoE0hvIjhsbeQaBktUHoKqaflao6I6QW1SZKMS5QbjPk7WTbLQYh3ARDrDnt+680ZVKng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeNbeeS1; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128b9b7e3edso109556c88.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773776916; cv=none;
        d=google.com; s=arc-20240605;
        b=b3T5xNM38xnuIxf77LCCKVBLzMXkhvBBcjhFRGWjpjG0Nx6hVxW7Wv/58QpMkMoL50
         xIUgW7A9o5gN0JgCA8VepW7Yy/s3XGcmRRUoQpA1XiJlrDlIT6Y2nZaYkRlAKUD+JuNj
         iQ9PSTOZV8ae+K6piB3gMGJAbndF5248gcoh4VVrvG27KjCtVXB/VVm9B5Ov2Q+oLcG8
         TagMamX1s6fTyXLbhGrZe3mzKWRo+s++RUV8HJXCIQqYPej2h3sMF05kys90mv58AF7+
         5yRLU6865jnxJ7SExI2aRAZ0Dj/qo9GqtNkaLxihtIgZx5DBzwSmOngfOzyRc+fc94/4
         YunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZR68tqLqYaTbBWC4ZvIpqSiIjzkYBPYPzLDQM+z3q0=;
        fh=ERthpobYDTklzUnp2NF3uTvndaH+JYUR/FCslmfhikw=;
        b=QKlCFjQDI3mFlXaUMRp7Q/YZKDc2ViKh8JYclTcW5xRws2j61OW22x3q3r1IhpFhHI
         yI+o3caPpesXxvF4ve9vfmxsnShY0XyQIGecaltNwlajoeTsy/TnUlRCY/b+/oXBMfDF
         p72T7e2T+fYip5fce0hVNPzno4NVV414KIlMwxOHk+EnWKOBUrSup0a//2lezLq28nj6
         eZBvlCXqNITHJgpPvV+BbSGk9l3AXqvOk+DPstz2BzodVJ9+fi3OQusceioDO4ZSWPyz
         K+y2fb20fsFNiZlbReJjVO+IfrcoA+VthCptlbbn4VyGoAsz7h5Qrg+Wtt5hrnF3wpgb
         I8ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773776916; x=1774381716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZR68tqLqYaTbBWC4ZvIpqSiIjzkYBPYPzLDQM+z3q0=;
        b=WeNbeeS18DXloST+3zj0LIqtOnaOlwx+UePsxO9z8O1k8pyUucRmxBzWFVrwqlbYIT
         dyLZn/heIKGXYS+tE9pIIhawteiy3jHD7g4DVmCl5OvYjk2Mx6keFwIYZWjDHAl4PNgm
         4MkuAfDhza68M+N6APFuvoQ1AvsfBhZLyWgivNGTGKFApG7IE72pphw6lRaNHvl07VP/
         2rePJxQ216466V+b4iaakEt7lC/xds+Y3KWlFvdDR/6hBJnhSqvv2vcL9QQQxsljzIat
         MutLuCdLMZ/k5FxuY5zNlWZqd1FaSxvuvQCrABKk0AocCkBFObRWmFTBY+U+TOC2pnfu
         NjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773776916; x=1774381716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZR68tqLqYaTbBWC4ZvIpqSiIjzkYBPYPzLDQM+z3q0=;
        b=QCzQ6H1BRAwvfpcUiVjfrexWZhT/+8j01w4ITJByBtb8xPLWoLtu5y1ZIdbVPFNo8y
         X2eiyXnRw1W9RF67+f9FBrnRrv32mNXt7TJIXYnNu1q1d6+X4Vrel+/Zxigksgxbnk2F
         2BI8wqqEiCeH6cVFKFQMwoX4eSeLo7PrkHtQygWaJFkRFEc820DPrj8U9Zq03bVzm8V0
         Vk6YigQGm0DC5O4QRj5Nf5hytqe4Y+g09HEnSEx+lq0L0u5dHOqj+JvVR8vvMTidNDhj
         ONZxncc9cpmIHos4AtZAvuubgRLf3x2/qZ6fss9TXiOBWYKfhg/Q5y5wUycPlVfGoffw
         EeRg==
X-Forwarded-Encrypted: i=1; AJvYcCVyOkBrAx4RO326r33fv00PNeSa1bL1dpQQAUpf9/Ppxfp3KV1JWbCfKVIPpbrUvFXq5OULeRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdh3etnMhrv0Pik4au8+mZK698xFk9XRszO60VYvmnWrS0cTq
	1p3tWTw6T7+0lvjEwSJgQrutInjTij/9hD1lUhmNZruYRICSII91r9xjZxc/8aEwmnKPJ9kDvdB
	ZZQtX0v5YHsYoe7ezT351s2uQMe+uBas=
X-Gm-Gg: ATEYQzyUyLiJ4N5O+Pwm8payKBFt/gk5fHfL/JmlmlXnuoUhiA/no1dVlkMw5qhScGO
	KMoj3B2IwGGfXTJW1sHZtGdb+VlmUhjtWgFNagvglQ5gp/mVCFsKm+CUvYAFSz22uCE44RDPecL
	k9LrxIa3tRf/hTvOZKnkUyfCZldCharymgCYcvUruG5GQI35QcQd0/+2ompETPZuwuAs/RtqeYn
	zhgfI67TC5wH0RbV3xt/Sa44tyPeLQH544sV7/l5GSQ52cgzCwDXlX0ImDoZ4bawFkApVOx6Lkg
	wA9C0Lg=
X-Received: by 2002:a05:7022:6088:b0:128:d24a:a5c1 with SMTP id
 a92af1059eb24-129a71b42cfmr402951c88.28.1773776916013; Tue, 17 Mar 2026
 12:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315232500.251088-1-CFSworks@gmail.com> <bbc55ded3e226cee35e04a071400981e2069eb3e.camel@ibm.com>
 <CAH5Ym4j6gPCR9UhM1ywkDmvcDAccNrL72LFLy468T4PfPTxU7Q@mail.gmail.com>
 <cebd075d8e2e7e926fbcb56b19ec43fe7dec6ef1.camel@ibm.com> <CAH5Ym4hjSxtVG1v58Yd83FYeU+8+S_1M2_5pPJmMs=_fHb7orA@mail.gmail.com>
In-Reply-To: <CAH5Ym4hjSxtVG1v58Yd83FYeU+8+S_1M2_5pPJmMs=_fHb7orA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 17 Mar 2026 20:48:24 +0100
X-Gm-Features: AaiRm50NvrjdiizwGHwwvI76QCvgHLwjqKbJM9xXqNl3BgKYYWVZdHXFwxQ0QAw
Message-ID: <CAOi1vP88hEdnZXyib+toGumicWzoH+_iYbfFUut8Mvq+s_3xRA@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH] ceph: fix num_ops OBOE when crypto
 allocation fails
To: Sam Edwards <cfsworks@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Xiubo Li <xiubli@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, Milind Changire <mchangir@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-226892-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idryomov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9788C2B1BA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 8:13=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> wr=
ote:
> > I think that it makes sense to create the issue in Ceph tracker and to =
add
> > Closes to the fix.
>
> I don't currently have a Ceph tracker account and don't think I can
> add anything of substance to an issue report. Feel free to create the
> issue on my behalf if it's important for Ceph's processes, and I can
> Closes: tag it in v2.

Hi Sam,

It's not important.  A tracker ticket is useful for when the issue is
purely reported as the placeholder for investigation, log attachments,
etc.  In this case you both reported the issue and proposed a fix for
it, so the patch description is the only thing that matters.  Creating
a tracker ticket just for the sake of it isn't needed.

Thanks,

                Ilya

