Return-Path: <stable+bounces-40568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA98AE354
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9271C21C7D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476276CDCC;
	Tue, 23 Apr 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR2KeAFH"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908384691
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870268; cv=none; b=rqghj1gwOTAzWmvMFgXWirtyaCNHrohJ2wnMZbCrqNPgOsgCku/V8nn0/4jtEwVwDKQ0j7LTAXtyxzw/doiAw4ABK0nX2IEaTCuxKMYVcMuCh1RDYMYfoUTSWeqqJLGeltQDt0JEij4249dfCty/SW3EhDDvDIPXAlKSsBC4jWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870268; c=relaxed/simple;
	bh=DPXUSPQEUnEjHQ/Pp6wI9M3Ge96OWj5w4ZVkia6nETw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/fFHH5XAmqJ+DKMvAhev07RWBPiv7+Xq0EKTmWecc0P3puACRtB3frfmSSt8/lr31pW+UbxMZo6grEkrscnl/JkhuofYLEdLuqvMVv2z/PGUsCTCU8U2WQLw/qt7XbGo56fm6JOh4+FVyK0rgeB8dkqUvaUK222ubI44GoulUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR2KeAFH; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so27863601fa.0
        for <stable@vger.kernel.org>; Tue, 23 Apr 2024 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713870265; x=1714475065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPXUSPQEUnEjHQ/Pp6wI9M3Ge96OWj5w4ZVkia6nETw=;
        b=XR2KeAFHO5vii41GmAna7yc2xs0An3QOpEtFCATVa4Ck8JmDjC4ZssF4nt2WPiz4EL
         3KMjSA6kDJEN+CCZga2gvQjYEEq+BuQxBEpMNO+ErZSIXjGcezxpkaQOPwepPHIK6P3t
         WCm853iiLscbBhbUiLgvqyEip/QG/w36P/Ej3kdiadXlMo2RjCf8NrUAezno/JY6KeZp
         pN8vvSuwyHHhibCaoXHgxn5oioX1B8I0E4JDisUbUxdUr2yAQZg3zxboSEOWIAHH3Pes
         34bxXluMVUH8iexgf8NEUkn9O4hgnuG62gHyvVeyq5Kivurfg4+WTQwGeeX1tY481pKr
         +2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870265; x=1714475065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPXUSPQEUnEjHQ/Pp6wI9M3Ge96OWj5w4ZVkia6nETw=;
        b=d+r76TDdmDTicC6myw+k9O5we8EN1UZcLURSwqhG/rALmtGQxzVWoi4W1CYIHcemB0
         g2UfIUqBCmmEBGeBCQ3oem0+WrvDd3GejdCfl5XcTUuHKgNZlEG4nmKvWuAUD2MOkDH/
         T52NasFfARfJj+bm8YaaMwIm4Q4GLu/VOJVp5QmqO8YYNiWYcui3t7LFm37fqjRpWC1P
         kWF/MjWRYXjeVy+U61MrB6JEZy6DLIKD85N2Jq1prrsMsnhNJyiNEeeaVbFAL3C4mUiL
         Xo/L0jMTowZK+RqeAoWRHtXjrUTiRW1znLPeQrjHzjePYipmHajZCdnUP8HB3PyPf2K+
         SAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6XcQU2/YRr4ZqBf7vDAbU0iiVapQkOI6YlfriLyqhfc8oMPC+grs/tlxxAd6eksYp3jhgryZw/8x9J7ROzUFsq3hV9MS4
X-Gm-Message-State: AOJu0YxdEOV9xX+kIck9pBmI5ox1FVodGSIWcCm3GN585b2vLnrg9Nps
	gtLXYBXY9u3XPCXGez4afjfgGRXwTUnqmT/ctlw8cs44G7WxUTfkU6dOesn19TODleiujbEKQ4G
	ghpQjd67u2DHxAL4WlLL8xeoDqDXKMh2gIVQ=
X-Google-Smtp-Source: AGHT+IFpRiRA7x6atazZQkbP3x3P1CJiaM9KtrW5nGtf5tlpPeZtBy7C+TKlnoBNTkowo1Wg9FQ+J3/GKf7+Mue933M=
X-Received: by 2002:a2e:b80b:0:b0:2d8:636c:b4ad with SMTP id
 u11-20020a2eb80b000000b002d8636cb4admr9067449ljo.35.1713870264456; Tue, 23
 Apr 2024 04:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <715eaf46.7523.18f098372d3.Coremail.zhulei_szu@163.com>
In-Reply-To: <715eaf46.7523.18f098372d3.Coremail.zhulei_szu@163.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 23 Apr 2024 20:04:13 +0900
Message-ID: <CAMArcTW_m8Bjnx0YGHajQOi99qvo_TgD4_TLMs_HC+kCyxRY=A@mail.gmail.com>
Subject: Re: 4.19 stable kernel crash caused by vxlan testing
To: zhulei <zhulei_szu@163.com>
Cc: davem@davemloft.net, jbenc@redhat.com, sashal@kernel.org, 
	stable@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 2:53=E2=80=AFPM zhulei <zhulei_szu@163.com> wrote:
>
> Hey all,
>
> I recently used a testing program to test the 4.19 stable branch kernel a=
nd found that a crash occurred immediately. The test source code link is:
> https://github.com/Backmyheart/src0358/blob/master/vxlan_fdb_destroy.c
>
> The test command is as follows:
> gcc vxlan_fdb_destroy.c -o vxlan_fdb_destroy -lpthread
>
> According to its stack, upstream has relevant repair patch, the commit id=
 is 7c31e54aeee517d1318dfc0bde9fa7de75893dc6.
>
> May i ask if the 4.19 kernel will port this patch ?

Hi zhulei,

The commit 7c31e54aeee5 ("vxlan: do not destroy fdb if
register_netdevice() is failed") was not backported to 4.19-stable
tree.
https://lore.kernel.org/stable/15641355392228@kroah.com/

So, you can request a backport.
Please check the URL:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Thanks a lot!
Taehee Yoo

