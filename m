Return-Path: <stable+bounces-210446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC22D3C056
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 08:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42F4F50898E
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065E389E19;
	Tue, 20 Jan 2026 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJss081o"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8CF378D6A
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892736; cv=pass; b=SGXZLEzNCQHM3QQnGDanDKk7l0NZFPjjLy7zdZ0sSOFRhgWcVY+rcTROJ/DVBgiM/ZiCe5DPnu8PVXUJd799ZkscdND4YFlX8htDDNBBpcXYIEX61sPWWMUGzbDVIXrrVwEY6e0AdmSNeM2pT9LaeNlET+whAqVQQVcxVivMrEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892736; c=relaxed/simple;
	bh=7u3LFKR7PiJpIeA+QR71UF/La+iD1BubfJTWEVLv87g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLe5UH47ai5e0GZDcr79H//tS6/UTZ3w27BgiTTn4DHfcWZFHYlhw7CMRfmVozJ5re3S42/lCzxxOwwy5s6Ermvyf4E0o+0PLpD0W5mV0a3IQ2W3/HTxXLxE9KmWJV2WZBLRwDYczoF0bJz4rBDZ4n2zQfR9AclJwy4UxHSvC3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJss081o; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b6a93d15ddso4860857eec.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 23:05:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768892726; cv=none;
        d=google.com; s=arc-20240605;
        b=KPV14rutAnJu98891uSt0glQ2Jzwt88hKCR1s0X5jVxBM3tECvydshz61c4CGyQbAG
         lRGA0dD9dOtQMXjPh5A9JbmzmTkYVbuumO75BPCNZbnJBJRminNAWLP7pspAVlcHxnb2
         J86pHlMq4X0Qk5Jx4IxZ3mFsl+qoUTKldiz92IHFE9Bsr6rBZTBrrOjZM/MHWeneTEYZ
         uLYYP4IV2bNgBnXx56+2R0ho27UQAd7nN/iwIM5uChWjr2ow+xhgEv9mlAIDtfZ2JuL9
         ZSftWjFcJp1zAb2D5QP9PGQkrQv+q/H68t0FUs9qa4+crQ/cqzKWJmDEdxZqjTfeHULp
         YaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7u3LFKR7PiJpIeA+QR71UF/La+iD1BubfJTWEVLv87g=;
        fh=9+VHORgPh/xbvJ7C5Xf1yUZunaffUNxbmB5zTkE46Nw=;
        b=H/DxC+mhYelVdaEqcV1YeBeFHYsN6z/zvDPwSqU2e9i84Xed5dao5pN2uw1fHLHVaF
         RyzPmZ0kcdU5JO/i3F6oEU9vVqaTEXbtW7KWz8n12FQWWCVpBxErOoo+FBaxmrQ1QVoM
         088rQHwyvdHSuuvSG9RwsDxoZcAiV8g2UBRiYtY9aJrPciZj/zOyi8YfEn4sYMK7w9lh
         z14HHfkT+lB9X1dVI1lpM34GvZS+FEF6yR8D/SyzUXsqqYoifwSnUlOI4+lLV09qWJsB
         RwqDRw+8qvP4/b2jkyHevYqY68kDP7TI/KAuYFCyFkoPI5TVM0fbRZ04nDpTervNO3pO
         n3gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768892726; x=1769497526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u3LFKR7PiJpIeA+QR71UF/La+iD1BubfJTWEVLv87g=;
        b=GJss081oG9WQMg62peZUpGJ48ed+dxIs3wbhhi/P7JPikEqK5ABWSjCgSsimnQpNFM
         JDO8u2JY/31brT1GyqmvftZZq59quJH0GS5JnU70xnN/DrjffBt6qbC9D2ex75S9Fs84
         +sKFhT/+OAsYyjUPXByYh2CzwpYfByxIRux5NKpNq2PynK9epxlNJnRFUeR9wijMGnhw
         ASHLPaAPhh5Y3UyqQ2R+JxznKU4FVWJmp0J3j51Y00UCifzuDBU7DtJTexSrBrRVo6i7
         66O+BOm9RsPDDIIiQj5EFpX49ggPHNM9LwM2jSHxPi8sU/CmnP9w59fuVXQy3ewQ3Yy6
         ezYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768892726; x=1769497526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7u3LFKR7PiJpIeA+QR71UF/La+iD1BubfJTWEVLv87g=;
        b=J2CxvQd2hBi9urB1lVCW0SeI5rN0PNak/mZlWUuPQrlcx8gmxTR92bM+oInXo8E+TF
         SHQvtKrwp4jdfoP7RrCAD3ONK+2+1ymev9KnLdA3Hojh0ZvxjBYVLWH3VVXu4+LwfBD5
         ucWvyLVhMNXdmMvQs+s3v9D34mqM5q+yaQWTyStobCICxOzO8Azj+7vkzfIUfhu37UG6
         aUUD00HA8OzO4PVYAJMYuE1DFc7FLjS+g4O1vF4wU8ND1eU9mfflN66TffxgCFr6MBJY
         nLL3Vbu7NwiJb0Av7rr977/PMhen0pzv6uBpja0ieeKfjAAHII8jOlzoQd1qy8fX+VOD
         co8A==
X-Forwarded-Encrypted: i=1; AJvYcCUvrOCe1RlW/k3kd09Ygl1v9r3kjRqvKm8f4/pjLZhAlXo/j32aH8fkszvShtlgQbRsudIjqwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDjZcohR4c4JW4ftvjXBbwvvYK7RF1whwGgmya8Um8DJbDauz
	KjN/o5/q1W7eRHqyYiahIU5GIMfHSSAGN/lVvwBY1Wz7A5pyxc5AjlMX9TIwWZrjafaniSALbYZ
	UQ45kXlVb0emHruHT9Q8mCbIS77VlEjs=
X-Gm-Gg: AY/fxX5zM6mp0IkszftmNk9OQUbsW/Je9N0MhDm+AovUCufuvHjOKb5x+FZ53Ln+dL1
	/jj5gy4m1A8TpBaFY8JuQLmd74uVzP/Ulr7YiMhdV7B8AQVve04sA49RoIGcmOb5SlxVThhGh3u
	ueRMgC5xq8uNuUuMQLY4/IT5ujtVM2/8F12bcQCilHjnbeUoMAfj+fIYUPOu8fexRVwoIR/TGSB
	AUZcb/wT2O2asH0yG1nWLeBXZqk1WeAXgGopwe7xonUnQ0Wz6gqbWVOBBfFYpJ44IHQZMzNtipk
	2MW5/gLS4SrWgExm/MMSlvohKMM=
X-Received: by 2002:a05:7022:4394:b0:11c:ec20:ea1f with SMTP id
 a92af1059eb24-1246aabebb7mr790262c88.33.1768892726001; Mon, 19 Jan 2026
 23:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119071039.2113739-1-danisjiang@gmail.com>
 <bc2e8ec1-8809-4603-9519-788cfff2ae12@kernel.dk> <CAHYQsXTHfRKBuTDYWus9r5jDLO2WLBeopt4_bGH_vVm=0z7mWw@mail.gmail.com>
 <2919f3c5-2510-4e97-ab7f-c9eef1c76a69@kernel.dk>
In-Reply-To: <2919f3c5-2510-4e97-ab7f-c9eef1c76a69@kernel.dk>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Tue, 20 Jan 2026 01:05:14 -0600
X-Gm-Features: AZwV_Qhjs1DeQ5q3LqpnpDjn-ntJzACaBKK4Zhzd4f51YbjZA3cWNbJGpFmWlo8
Message-ID: <CAHYQsXQK4nKu+fcni71__=V241RN=QxUHrvNQMQtPMzeL_z=BA@mail.gmail.com>
Subject: Re: [PATCH v2] io_uring/rsrc: fix RLIMIT_MEMLOCK bypass by removing
 cross-buffer accounting
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Mon, Jan 19, 2026 at 5:40=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/19/26 4:34 PM, Yuhao Jiang wrote:
> > On Mon, Jan 19, 2026 at 11:03=E2=80=AFAM Jens Axboe <axboe@kernel.dk> w=
rote:
> >>
> >> On 1/19/26 12:10 AM, Yuhao Jiang wrote:
> >>> The trade-off is that memory accounting may be overestimated when
> >>> multiple buffers share compound pages, but this is safe and prevents
> >>> the security issue.
> >>
> >> I'd be worried that this would break existing setups. We obviously nee=
d
> >> to get the unmap accounting correct, but in terms of practicality, any
> >> user of registered buffers will have had to bump distro limits manuall=
y
> >> anyway, and in that case it's usually just set very high. Otherwise
> >> there's very little you can do with it.
> >>
> >> How about something else entirely - just track the accounted pages on
> >> the side. If we ref those, then we can ensure that if a huge page is
> >> accounted, it's only unaccounted when all existing "users" of it have
> >> gone away. That means if you drop parts of it, it'll remain accounted.
> >>
> >> Something totally untested like the below... Yes it's not a trivial
> >> amount of code, but it is actually fairly trivial code.
> >
> > Thanks, this approach makes sense. I'll send a v3 based on this.
>
> Great, thanks! I think the key is tracking this on the side, and then
> a ref to tell when it's safe to unaccount it. The rest is just
> implementation details.
>
> --
> Jens Axboe
>

I've been implementing the xarray-based ref tracking approach for v3.
While working on it, I discovered an issue with buffer cloning.

If ctx1 has two buffers sharing a huge page, ctx1->hpage_acct[page] =3D 2.
Clone to ctx2, now both have a refcount of 2. On cleanup both hit zero
and unaccount, so we double-unaccount and user->locked_vm goes negative.

The per-context xarray can't coordinate across clones - each context
tracks its own refcount independently. I think we either need a global
xarray (shared across all contexts), or just go back to v2. What do
you think?

--=20
Yuhao Jiang

