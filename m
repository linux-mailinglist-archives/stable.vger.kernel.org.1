Return-Path: <stable+bounces-81311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1673F992E72
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E5A280FD0
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B51D45FF;
	Mon,  7 Oct 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY0GTKc4"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5551D433B
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310201; cv=none; b=JVqJMlS6/vdBh7a6zFlOY7QfSN3hrkzRetT+Yd2AmDyOJiXBfTsHIPCFvz6JI6Z2lAaCYz9iCguZm2SAkFA3aBFU3WIkk0tB/hpWsIGlfpA2QzeEWUsDwjy9XOKxSWf6PpeK2XKdkmdDqo7l1UIF/lzuByiiTCyU+NIuU4Llzws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310201; c=relaxed/simple;
	bh=JJrXGFchIfKB+nqq84X7PW1mg9ZpExaujNMlZ7+tOjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hv3zyfjufKG5vO/Lafj8O9bqyd96PiSabArQsbWwjieGaWKmpZuPw2FJR6Im3yrFliC0idAHfHX+iqMJUMusJQlPZs9ZbYpYPlLDkjYux2pTiucMVGlxTO2Lz4DwnR0pD8EuTXIgFNHr6/RoQdfbJpYGIMUHYyoh1hh1wZMVBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY0GTKc4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fac5eb10ceso40691801fa.1
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310198; x=1728914998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JJrXGFchIfKB+nqq84X7PW1mg9ZpExaujNMlZ7+tOjM=;
        b=dY0GTKc4t2wC1J9PhyBmy/rXTCAzjFFACWVlYsRx4FBg6Vf30yI8qYNidQfu9izF9U
         0Ychl3DJUz4jTTchako8RGMUPaYTJK/sMVaePpA1Wrye8Y1WqNbj3qCLZc/TTdw3Q5CP
         SiVNntmrcgxK7kF8R+ak/SJQhVL5cLLyMiZcj8DL0r3oOQDXdSrplZhMx5+4wr1tfEPp
         fgIpKHW4js1FMMtvG+wg+NVFZrUwanSxnfcm3Ba5cTCaRTDHIxAILR2/zvH1HsPIVhnN
         PxuvPRMpLEo4Uf0n1AO7P7hTvVWPZWXjrbNVXUfPXFNzqnfsAMyWvtrSwUVTYBAQojlR
         82lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310198; x=1728914998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJrXGFchIfKB+nqq84X7PW1mg9ZpExaujNMlZ7+tOjM=;
        b=Y3Q6ClXTllS/C1hv3OZyhxyFng+ecXUWAqxPTlBGXP/lT6FnhhSs8FXdHuOf0oT4bG
         2ru8iVcCtviTGvgjS8D3orxXicUGl8wCqlMPA4oQcvNxuI8YFEeHytSkby6igW5V3mXZ
         EzWBpQ39INf9bMeSWv35H9fVQyO3I4NEGvEf2VU/XduAl35aejgoVqjnFR7u09JjyxkP
         40MbfcNYlhqhwWThHua3wgroqgeNus0xwlsqIATORnBQHmJdxl9M2o1zXLvnaCu16gok
         eMQQ8hUk9LfWAiW/T/AomDEGqqp0WuPGHYa1yPV1/KCJayatbwOnnQs3kLxeTbHfeCWn
         wSIg==
X-Forwarded-Encrypted: i=1; AJvYcCUoOUTROM9yVsMwqhjfIB41COJFRV1+w0wFAARGQKq6v1O5LOwYaiUmlmkb0UhLlK2gi9tYKLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5//071AyMt8dpntgPbqfeP+ykNXis9hQKWdczodESWx0TwD5K
	DN/yGIhtiK9jcFQCevbGplFIq5c5uYqz12YzWPYUBHCW1l1R74ndVC7c6bBHewqrclZcF5OY2r/
	ObThJXnUNhWdUq8nuVk6CfeaamAeX1Q==
X-Google-Smtp-Source: AGHT+IEA26HYrdgp0mkpHFed51h+xzzQQwqMtjYFdsOZSZWn7VAiBWEpDjb0JMKbV0P+I/GEjExTOoJhl3JeV7WUIz8=
X-Received: by 2002:a05:651c:221a:b0:2fa:cefc:7386 with SMTP id
 38308e7fff4ca-2faea1b788bmr53643651fa.4.1728310198047; Mon, 07 Oct 2024
 07:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUWN_mZ8w+5ZMdNR=YsZTFZ+hRYVr31PHqKc+8tfb2uxUQ@mail.gmail.com>
 <ZwPolgvq4ZhB7zDw@sashalap>
In-Reply-To: <ZwPolgvq4ZhB7zDw@sashalap>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 7 Oct 2024 16:09:21 +0200
Message-ID: <CA+icZUVTsoir_ybxpEEH1JH=sk4Q405QOJzJ3vtMfbZfRe0UeA@mail.gmail.com>
Subject: Re: Wrong tag for queue/6.1 = v6.11.2
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:56=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Mon, Oct 07, 2024 at 02:58:51PM +0200, Sedat Dilek wrote:
> >Hi,
> >
> >can you check the tag for queue/6.1?
> >
> >Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git/log/?h=3Dqueue/6.1
>
> Woops, fixed, thanks!
>

Looks good.

-Sedat-

