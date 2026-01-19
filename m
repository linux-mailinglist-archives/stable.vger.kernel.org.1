Return-Path: <stable+bounces-210414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488BD3BBCA
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 00:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C9EA303A009
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 23:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5B2DC79B;
	Mon, 19 Jan 2026 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH6vWDt3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF2500972
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768865696; cv=pass; b=pf9Z0sF/iF4G9qFeQMT+NrDeEKz1pJluj2shRtYFQ7STawmaQYk3lI2C2CsFsdyiKqFh2DeqfWvOmP2HXffv0ll65/L66rzlkNqBJWgTGYk7C0lInVJOjQYZB4Tk+7wosuoilVhQGH+VrwVn8bKr+7Nu19KyjDEVutfU2Pc0Qgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768865696; c=relaxed/simple;
	bh=ZZ3bHuhkIR99WX0mMtcMVkbpFCn0Hj9dtyBxtjPmz8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0KUt38Zc64eautzZCZX/Ec81qNlYUDgBPLqc3HSMVElIuTvsXMbUyx+yIPqHvNPqL8cg2+KL+o5opoXXHonX2R2Uk+4SMcQKK66C3MVAZTzGVlkUhcCFmhKzf0TTs4XIdv1OMin9PPVg+94bcFsXUnSYUJK2Vm0AYAtASYEjlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH6vWDt3; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233c155a42so6170852c88.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 15:34:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768865694; cv=none;
        d=google.com; s=arc-20240605;
        b=ILaeLCGRyTYyXaEkC28G8fbbylG7CjPkzMa0O65PzXovA4O7kP+hDham3HnvwnWj5s
         w8Pby5gPTyM3hElm9qQLwr3wibVLUHuN1kDh3yV/klEpb1wsLoGv2uMCnmKuHANNLVAJ
         5DpGnV8HwSHKqKunx0UuG/4S9q21HJvqx8pYKhWLORZazW37p/0o/YTpuKztHjC7Sqel
         jWhdD5BWKy1fiNQXdGqiDJbtuQNReAecLaou4jUf+vOG9A5eiiIL1bVd7jHYP1jthSvF
         Ac7UHDoOO9xdoOoQCG5xpUSpTzSNN0mn9+LYFk1IiBipfbRpkgjYbPNipoymQ2OCEpck
         5wAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZ3bHuhkIR99WX0mMtcMVkbpFCn0Hj9dtyBxtjPmz8o=;
        fh=3nwMOfN4QpuF8AED7FKLaHvikVfHE6oAME9LLXF0tB4=;
        b=G6D/WjqXPhwMnDT5msxF9nZE3j6VKtENlp27JN8lqViB27ucO3iUJUA5Gmv3Zzgdpg
         rmHE3YSGflWSHKkNoZseFc6zQPXcpXpNYJ68CYeNs1iF5IFDy/Ud7g4nMI8UQqyh9bm5
         2gBMj08leH740xkQZYnJCmGjDuCHCb/7s4Z9yTqo1s4XM0HJGXZp2dGWn071Q6CEGybd
         JxmfZQRzZqCbInwafw10dorwnUns2nKEjY65OAkNwApI8c1ffw7jeTeMiYazk62NevY+
         7L8iZbRFYdGeWB2kmwOccmPiWWgnFDq8RehdZ0c3PVai7J9pnSmM6b2ccekXYI3I/FDZ
         O+gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768865694; x=1769470494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ3bHuhkIR99WX0mMtcMVkbpFCn0Hj9dtyBxtjPmz8o=;
        b=mH6vWDt3ocQ+K9Y7ch5dtPt5ZunVJmaBiuvAdXA7Ouzp0l+Sd81SNh+KcJwYVw0CKH
         ynWyoQVwKLmWqV4H3Xwq7cfsl86SrszM0KX8JbXPZwu/XikdsnHTANt7bV3meNyOjSy+
         WsJdahH5tGdlHe2sgFlZVmEuPKBXc9/WPQjwS+MVoYicOK4xqyJ45xvLXkPDLiOavtWy
         MwgM9J52RbzFqqDIfHAQFjsjjesg2IbmqZh1SKqJK5iRXyrGM6euUg0XzovN4izDsQur
         SF3mAqZImOdP5BaJyyk6eQWWf6Cu2u/LoRQ2A/kcZ60HR8BtbmO4CkJnO8BxtzoraPBS
         HJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768865694; x=1769470494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZ3bHuhkIR99WX0mMtcMVkbpFCn0Hj9dtyBxtjPmz8o=;
        b=GVZMxz8xOehjxS0yRQyVeBZ1cDPyPIH5VqFR1u+srOb7kUufhhHZRRUFiKJr6nPVp7
         SqZTzPBiPJT3JX/ZxUonV8POTNJT170AwxxmFvSFsyktaErI08KWspT49Db5NsFS0gyg
         68QU2+VjwkcfoR9KXfD1NibvFfA7Exsfejz+1itQnF0DbRZKEDis73Gqc61UNgwaGPyC
         BYeHHX6WdaLdW14RQ4oQwQR4F87qY2NY5zfIRXb1OUKKKYVHLtjzRp+dajzWeZs7N+U8
         Vt3sK3pB5diwEcqmYRDGsZQdkB44pTQzZ9Wnp15ItzVpR4KZz+krR+fUvz6uixdgvLPk
         agEw==
X-Forwarded-Encrypted: i=1; AJvYcCV3bIkfYkG/ZvDYZbcgsznh8eVCjLsVjmxzLR8hk899Kz0N5R3GG35YsuTmbO9/leoI45vbMSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBTnFyTlkoJN6sLSdaN+aaqmd8z+IXSBFGph4isePBrtwdPW5J
	U321UDT224qHwNmGQEsgbUCGIsZPrZ0zo64whcsn/JnCK8mO7Q8aDktnDyoBiV0VdCz+oC4ceTP
	Ad62B5P6V3pYaNetBAxJYud4OyC77z0Y=
X-Gm-Gg: AY/fxX7m8Sb9WFpLluGpOhALA7wC6d52Jx2lEb16ZNOPvshyLCUAQq2vgf+CDdx8a0J
	m04jaXwZXKHxRETRJb8VS88zqyKpw3EKMxFQVyCFl+MSWRjMk0MEHXFU/33IbRGhRyWHMv33gQg
	PLBVziqLceVVYi4mcH9PssA1UwIHek6f1dc9r9XfDgCpcIneiw+J+6o9DvJNt2dvjlcXk1U/AbA
	ggpEG1ZIv92J6+cKWKkAhkre5x8Te/o5NA5W0pP5yMvPl1mDUdNfbHwRIJeNs/SbKdkKduiKJJn
	+ktmXLLaB425YJEsbqHCkviUzvc=
X-Received: by 2002:a05:7022:eb46:20b0:11b:95fe:bedf with SMTP id
 a92af1059eb24-1246aab3428mr65745c88.27.1768865694289; Mon, 19 Jan 2026
 15:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119071039.2113739-1-danisjiang@gmail.com> <bc2e8ec1-8809-4603-9519-788cfff2ae12@kernel.dk>
In-Reply-To: <bc2e8ec1-8809-4603-9519-788cfff2ae12@kernel.dk>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Mon, 19 Jan 2026 17:34:43 -0600
X-Gm-Features: AZwV_QhrkvTrXYGNnwhF1DWukVwYJ8GmYYaxLKmVuQL8w42ClSQRPQ1oHjc-dFY
Message-ID: <CAHYQsXTHfRKBuTDYWus9r5jDLO2WLBeopt4_bGH_vVm=0z7mWw@mail.gmail.com>
Subject: Re: [PATCH v2] io_uring/rsrc: fix RLIMIT_MEMLOCK bypass by removing
 cross-buffer accounting
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:03=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 1/19/26 12:10 AM, Yuhao Jiang wrote:
> > The trade-off is that memory accounting may be overestimated when
> > multiple buffers share compound pages, but this is safe and prevents
> > the security issue.
>
> I'd be worried that this would break existing setups. We obviously need
> to get the unmap accounting correct, but in terms of practicality, any
> user of registered buffers will have had to bump distro limits manually
> anyway, and in that case it's usually just set very high. Otherwise
> there's very little you can do with it.
>
> How about something else entirely - just track the accounted pages on
> the side. If we ref those, then we can ensure that if a huge page is
> accounted, it's only unaccounted when all existing "users" of it have
> gone away. That means if you drop parts of it, it'll remain accounted.
>
> Something totally untested like the below... Yes it's not a trivial
> amount of code, but it is actually fairly trivial code.

Thanks, this approach makes sense. I'll send a v3 based on this.

--
Yuhao Jiang

