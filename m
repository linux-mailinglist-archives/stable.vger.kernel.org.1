Return-Path: <stable+bounces-204576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE025CF1317
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 19:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28EEC30056CE
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E072D8782;
	Sun,  4 Jan 2026 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEuqlHrv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153521B196
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767551437; cv=none; b=DBO4Cdrp/zwY/wy+FQouwg21wFkAoEzbFIqPc8pr7CMxsddIkRLH3umX6J9VvhQ83v3QXQg8v9GQSdAYMPT6lNZCrXa2ug5k8x4RmOfGigjQdworP9oY39APfpq77aX+8sJRA89RSn825xfE4DzOOFwuYB7YRPvooL2PivVPx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767551437; c=relaxed/simple;
	bh=2FMf9qZWkndgIdfX4lTJCzcI5l8G0uyat9bQRXb33QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o15bBCoY/jAhKOdXcQU4ttcTC/8mLrPM1n2LKnB+MTlyY/H3zg81h6PcqgY1rJkS+UysyQ57fx0YGheV9dVbZmUAHt3e0vk6Wn1gKGK17u7cAwBRW2RyUrK8g0GgQRw+mfNvMhWErs/Kk68IIjW05lYgnHagSng0FWxMK+4/oNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEuqlHrv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34eeffdb197so1241823a91.1
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 10:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767551435; x=1768156235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FMf9qZWkndgIdfX4lTJCzcI5l8G0uyat9bQRXb33QE=;
        b=dEuqlHrv9XK4/Gsrv5670oGsNlMPeqeT+5l5lNDFwG0f7TZw/NyZ7MBqF6uRt/7MRt
         +ovD3OKGSU50Pk7mV/7LGII4zAkbRlJ/49Pg+Xo1iwtHyY5M/ya0D6mEd9GLCYJdGkAI
         q0kAS4S8EZoCboReGac0uRZCwHWL0NbhB43EX5UcZCexGD6IcIygn7lYvnVCxnWQKItB
         sNNPD5+D0A5pq2L9+JkaUp+eSWvBA8h2FF724lATjpLyPAiJyaiqcsyccTiEfior1Vmi
         h/1ICqEUnoNm3Z74AyRG07Z+v4imw+SxF9J3effMrLaDJUo+ptxfzfSVXPwUsPRVBuuO
         2EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767551435; x=1768156235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FMf9qZWkndgIdfX4lTJCzcI5l8G0uyat9bQRXb33QE=;
        b=vb8mlwQQUVuTTtJgKI4AIW8NnK4e2udgg2V+knxZd8QtXUxLfCaJCs3lbNPY08NORw
         y7uBMU6e9f74NS2m8Udx7RnI114JMIKXg37AaEPDjd4FP8R5qqlnYnq8OCLN4RtbqwBa
         PFOxzWVZnflGJAYdnl+DQlJNZWVYo+5axiUZ8GeQ78mdE5S8GhwgnHX5vPvlmOuV/Gxe
         0LcR62pYlBvhDt2WJY606gsfZi70AR3ioTAXL6pf96NXvMSM+/EvHvxoNPmKDWoyrOGW
         z3ihIK5ggByWv423yhA8SVDVovUJZ3q0zG+GPPQA0sztARQUBw0Ceq9JQL+/erAvB1TM
         ZjwA==
X-Forwarded-Encrypted: i=1; AJvYcCXboDVop/2YRVJbzA7AoLIOQmBmr7pDP5MmhkBlo+zncup+i46QzbFvc14VL1StF2dggpHFC8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3WHB3v+QGINDaD1wB6ajpl0GqkukifeWW8+jZow/rAvKb37Q
	zRBemJV1Wua5mgS5/251WcWci+k86R/vR1Ci6xiKDCOJQx+vYHrQ/E/3wxQ/ywNNvXmGKbPknEa
	FMaSU2bFbZHQ1eVz2MCtNdBE6WfQEuNk=
X-Gm-Gg: AY/fxX7cb1g00YyCjgTvsBHN9xzbcEnhZWCWIrnQhtSpIAZn+IdnhcDX68KyNkQnfgJ
	oy4bgJrFWbj4J/191WcemUxbQPaBvDFSIdt+56da0qGAy+FfeMROvaYgVUnXapiBX3aeHY/O4XL
	mpbmVs/EyR659RFXXLUsStuHpcV0Zmre+fNuzGarrpbI6RQnRI8Qm56+kuH0fEyl1DJHFxwGs83
	lzQo2Nth4xYvRBbVVK1BcmX7GZ3LwMTNNPcyip7rZwe8McN1rzLyN4TgyEr7hnfjCRoR7PnFPCX
	nzk92EmNWapeswu2xvSwdB+fwDGADDUCTlMEXmx+gBcJR2UGgLmCUbzwfpCZz+Wh3lt7vGezDOd
	ezWabtQniHNej
X-Google-Smtp-Source: AGHT+IEN2ZV3PmHk0U2hOsgfRRLfJgqnWA5WvTpO/3j7uswcdn3JtlcK4tmqCIPkoBBSPuwlNN0Yrlooa7Bsvz6TIxA=
X-Received: by 2002:a05:7300:478d:b0:2ae:5e96:9d1b with SMTP id
 5a478bee46e88-2b05ec30b31mr23553167eec.5.1767551435363; Sun, 04 Jan 2026
 10:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103143119.96095-1-mt@markoturk.info> <20260103143119.96095-2-mt@markoturk.info>
 <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org> <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>
 <aVmHGBop5OPlVVBa@vps.markoturk.info> <CANiq72=t-U8JTH2JZxkQaW7sbYXjWLpkYkuMd_CuzLoJLbEvgQ@mail.gmail.com>
 <DFFV41VPS2MU.3LHXU4UKITD0U@kernel.org>
In-Reply-To: <DFFV41VPS2MU.3LHXU4UKITD0U@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 Jan 2026 19:30:22 +0100
X-Gm-Features: AQt7F2okothj0EUO08sp-m1M34yUfQk5IAvASw86NPhWXjzTsfL5KrZGM1vaSm8
Message-ID: <CANiq72=fFZpWJ9BvHEBqi4chZO3rFo8+-F9=myW1f_JzJ0PNrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, 
	Marko Turk <mt@markoturk.info>, Dirk Behme <dirk.behme@gmail.com>, dirk.behme@de.bosch.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 3:08=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> In general I prefer to only add a Fixes: tag for the commit that introduc=
ed the
> issue.

If their scripts track moves well, then it is great to avoid it, but I
am not sure how well that works or not or in which cases, i.e. it
could look like two different commits introduced the issue and thus
one backport could be missed. Not sure.

> Again, I could also remember this wrongly, but I think I just recently re=
viewed
> such a commit from Sasha. :)

Hmm... I also had a few cases where Sasha autoapplied, but in most
cases, I had to provide custom patches when they didn't apply cleanly,
even trivial ones.

Cheers,
Miguel

