Return-Path: <stable+bounces-158519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48483AE7D66
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD9D3BFBE9
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F3F28850A;
	Wed, 25 Jun 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzYhxl8d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E71F9F61
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843528; cv=none; b=avkvym817tHMPCFYdBTLkAf9OS23LHLOcmqHScNfiOu62QFg4Oco45n8AVHrfeM2Xztav4X3pXe6+Q4eEaMOJp9M1hvFsviMORQ8NLcLGM2nyDTUWjjHodLnsfEddaIcC99+BwvtPjF/XDMhz2Oi0CsZVi/3ABLT0uSvwRH9VhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843528; c=relaxed/simple;
	bh=KUy+S/anecKVDl6akzXnp11UuSHFhzHbMvHULZYFPmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5oUmLorIl1hOUVzuA65trsEk7Gs0MHymUr1EYwG4x6AVN8eFs/jw/zW4eHbnlv3G9H8KIwtVVBHXro2uZbD6vPOPgPGWt5Ij13tsFlNaY4gLKT+Hm26maOGQoAWre5ss9IleK5DlJrnZ7EBtozxB5oyCgogqs2m+HARM96jw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzYhxl8d; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b26fabda6d9so1199988a12.1
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 02:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750843527; x=1751448327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUy+S/anecKVDl6akzXnp11UuSHFhzHbMvHULZYFPmk=;
        b=jzYhxl8dS9F4fKNABjzVK8wwXCg3d/Jq+K+OYsfYpIkif3kszFacpFSSDF1nfEDKy9
         JUW2TDAza6ofpdlu4DHNtAlM2nQyqkUfxtdskwu3TrMRTsIBtIAdd0KVIpDeOCOwCVlv
         jqV+aLlpC0ttXIOqHv2+edWNRqB0hvT0WtkRqWHEdxn7tuPBbcNXZH244UaXlUSdGCj0
         egdENywJFOEiVbVC0tI/mnYNR8pLNTQDeu/2FBljT7vq0Aj6cTN8zCOAAepW/8yeHz9a
         DW34WRtTOXq2q8BEM245WSV1SI6iPyFLfrGrG9YmvZGZzPJdcvcdrR+++6golIKFOXq4
         G4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843527; x=1751448327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUy+S/anecKVDl6akzXnp11UuSHFhzHbMvHULZYFPmk=;
        b=e9q5DrwKv9mw2I7NVGD/kQkvv5LSxI8X8l6gvqVuGdS/OHubHAN8XhSLp4QFFbU0iW
         kfjuvs8D/N3scJvrOI7rbl17O5wiKcuqJ8QdXgw7UdfbPqpuck+SB2Yvqe8BTj2sDspf
         IyHe8lNMjfWIRGWN3fLw/VLd8eFQl8wAM5W/FOfJNkk5dU8iPnbb8BkF0Y7hujc1BMYH
         pAVVPNbv3V4OxLH7EHXys+MUi/JRaqAVmCxICJHNsV4EP64OkKfMk++vscjTzS7U1/CQ
         E8PI7Fj6tzaAIFXVQLh/+2ndYobT11nqWlnAhSH0oD7fwPAPYTThRZDakcF9POO2wBkF
         GTJg==
X-Gm-Message-State: AOJu0YyEL23YY/JYcNhG03s/QuAMD25O5yRHew8A9VZtlLhLVWqFUuIU
	39kk/SXLiOzlOZs/jiWAiNLtE1NuW1x46VNY9GkiLwCiXSamfcNTDelSBqYUo/+1TLvVaj2dh8D
	QNpOya7y8CU3yJ9Y9PMXWgAT/VP7uux4=
X-Gm-Gg: ASbGncuYACFnab9Ks9ZMBglDs/viFe/nhany0JvWd798RkoE136FSzlMuc6vblnxG1k
	h2suFPv62P/0OtjQX2ZIROVVAoch6rNBc6ZvtQLjQ17UYAuJ2xUXzishFlBKQvMqUqUF/9BXo3a
	PrwTucsPmImkSV2jWIv55HJu/Zln7xkaIsiVzhCf4aFas=
X-Google-Smtp-Source: AGHT+IEo0CwBuaz8DIwVd84OoyEnlb/3IbZ1/7JBRSH/amnf4+fj/whyTG5W64dbXQ9RpCYVknp+cDnZjhSPsYtE+fk=
X-Received: by 2002:a17:90b:51c6:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-315f25545b6mr1346699a91.0.1750843526665; Wed, 25 Jun 2025
 02:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624170413.9314-1-sergio.collado@gmail.com> <20250624170413.9314-2-sergio.collado@gmail.com>
In-Reply-To: <20250624170413.9314-2-sergio.collado@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Jun 2025 11:25:14 +0200
X-Gm-Features: Ac12FXzXblrPRGdVqW0JkY82uNKUPl71Z8Hfd-Wybqq0K3LJLjP16nd8hgx5vos
Message-ID: <CANiq72nb1BkqNgTY7MQHN=YYq=1E6t9+--sfhmutanNuikEwbA@mail.gmail.com>
Subject: Re: [PATCH v2 6.6.y 1/2] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 7:04=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Rae Moar <rmoar@google.com>
> Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/504
> Reviewed-by: Rae Moar <rmoar@google.com>
> Acked-by: David Gow <davidgow@google.com>
> Signed-off-by: Shuah Khan <shuah@kernel.org>

I would have also signed this one again at the bottom, even if it
originally came from you. But the stable team may be fine with it.

(The SoBs are a "list", not a "set", if that makes sense, i.e. it is
supposed to reflect how the patch was handled.)

Cheers,
Miguel

