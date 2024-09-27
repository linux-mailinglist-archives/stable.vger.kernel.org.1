Return-Path: <stable+bounces-77870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E70987F22
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 09:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DD71C22D54
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 07:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCE117C9B8;
	Fri, 27 Sep 2024 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rypwgteq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96486BFC0
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420870; cv=none; b=N2pr54PbSWqgTR5QdAJz4ebbqo0lxs1fiD3cmLx7AkR3xBtjt31KzYccVyXF44FlWx08wCGaG4jxVDW+3yvSvMW/fvcRJAKzkm6Miq2F9KHus/dnUs1qcg7H3iUK4J4c443vtri2iS7OsDYIlO8UdSD1JpliHSpPGXOuL4idZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420870; c=relaxed/simple;
	bh=W70e6iiDaCpib+TE/Ouz8u1gAKPcXJbKo4xZC7JpTPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFeXmGgTKMH+AFHiyyZ84w7V99oMtG9v9pnB63Dy0E/oJ5/U40qEuPMg6hsO1ICMmSnyqDEcssXXjtgWN4Ik74uLNqWQCuTdL+vzztY9303OuAevFgGyM8zBCqLxx+plYq9osxUNhA1bwpFe9C2bQ5YgFARrCh3z1RcdsfxzXrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rypwgteq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso17934775e9.0
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727420867; x=1728025667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TclUmNl+mEJN7UB0vi1aCVc79ZezAtt3jamN25qcvw=;
        b=rypwgteqVcNziVuorgqa+IpCUe1GahCHmiPg4Pk1s2CXSjdzGWDQAa3gdWwOOthO8h
         SkRJqNsG2YOnqPXLiaotC8re3wvUUoRE0BDneaM7b4RYtTXVXOjGxrLU3V+kuxpYk4oo
         cMzMnYWf0OLdlSdzRzWEwAq5YvwxdywusTmPoo6Wvxc9CV1Rdv7pE2tQ0eq5UAHRCKDc
         jYmwyiTBZXX9JjEv/8PzXE/5Hq0FKjBDWifFoxPQK8zHJLwe07Lf/utfklyXYKmuCaTK
         azDY/ALj0lDOHAGbQXBIIEPTRrGdmtJM87k3CtKwF4uA3EFam0zWT/+7nOcCy6o4gTKO
         Ax4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727420867; x=1728025667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TclUmNl+mEJN7UB0vi1aCVc79ZezAtt3jamN25qcvw=;
        b=gk8uvhXhNeZ34Xq5YR0svW0ekMIr2obpHIDb49tJH1HPzMN52tAcwwglDFhI9QXZ6A
         9Gibwb1hu/Rud8Ynm/3Ut+I8jswtyNAn9CkeJbNidgbHfx2TsVY2NLzHrzjgMLE6cTZW
         ZPdCBEEgHJw4KNTxs0EY8EiDrHHLqmwiCqLMJE/3xm22Y/chgD4Prkz6NDXzjoaqx4xW
         8kWbkbHPTniacJf94vLANKXAItToh67nnWtfDD9nF+DjOlsmCyzfLgdihps4Btj1au5s
         Et3gjRQCgCLq43RAweE663vs2x/6SyqpxNuApGN5wA8jzAnXu37ZKGhc2u2hrehUJJb6
         /6gg==
X-Forwarded-Encrypted: i=1; AJvYcCXzbLDueJSfeBbb2klxffq9R+Gg/7i8N1cE0hEqRoi60nQAtw/DVwTeWE1WDQYNX8b6SpKVQXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWj0T2YJ+RZxc1Rk10VnFErq9ucQCd35L1HUr0n8de+IPU8wF
	oI91CTiW2/LXxEDxd1t90Eb+L1WBMQpv2LoRRpaw8fSlj6Ha23oxGS3t/hGLoka/W3rj3iOkOSt
	s7n8W0Mf9K+r/i91n8epbSJEP5G7G45e2UeYx
X-Google-Smtp-Source: AGHT+IEYwN3TOsl+c28IvkDqXwinzUTagPXnNK0vbOUrvdfHpmordLeUXZZYBG6rDRpPb+Qx5kO5KjOTCWGsy4qePog=
X-Received: by 2002:adf:ee06:0:b0:374:b6e4:16a7 with SMTP id
 ffacd0b85a97d-37ccdb12819mr3587930f8f.8.1727420867114; Fri, 27 Sep 2024
 00:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-5-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-5-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 09:07:34 +0200
Message-ID: <CAH5fLghsesAW=wXz86OXUrJtO4So_jYSmOzocJ9RxrrrT=+MaQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] binder: fix BINDER_WORK_FROZEN_BINDER debug logs
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:36=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> The BINDER_WORK_FROZEN_BINDER type is not handled in the binder_logs
> entries and it shows up as "unknown work" when logged:
>
>   proc 649
>   context binder-test
>     thread 649: l 00 need_return 0 tr 0
>     ref 13: desc 1 node 8 s 1 w 0 d 0000000053c4c0c3
>     unknown work: type 10
>
> This patch add the freeze work type and is now logged as such:
>
>   proc 637
>   context binder-test
>     thread 637: l 00 need_return 0 tr 0
>     ref 8: desc 1 node 3 s 1 w 0 d 00000000dc39e9c6
>     has frozen binder
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Acked-by: Todd Kjos <tkjos@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

