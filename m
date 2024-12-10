Return-Path: <stable+bounces-100391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311419EAD69
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5D016BCA6
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8F0212D6D;
	Tue, 10 Dec 2024 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBiqUEl4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9BD212D63
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824621; cv=none; b=ISzkDXuXgI4DPijOopYlTIAGVtU3sf3ikjdT6ipAjENoviBbyWCWlgpIdNpOvTQ3prT3p5RYBRRb2lV2cXNIQJAbiWsc3kwxl7b6rxC2diV1UU24twK8W4rHn6CgylAB8v/MDhhTMTPQfHJY+DJ/C+YK8wBQm6Bw2d1pkxJy/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824621; c=relaxed/simple;
	bh=y31oOrXJ0m5oBAbBr596XMgmsc3QRtLaFk4/EWE9zyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMP8Y47ObLFwMZPiOgNOQxMKiNZPpYrf9xgHUblIwUlPkakC9R+BIi8VfqpL7VQVrnk1Cm9+qyIzuMl29OlQ+HzBAl6OHsnpxpo4CxVz+cEf6Uo5Ja6rZAL7QkbZByUHUyQKT7JkMfEUOzoVc8ohyoFOW8kc96Pi6cC48lIhNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBiqUEl4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee9b1a2116so581996a91.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 01:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733824620; x=1734429420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouzO1WDJZL0nWUUZ/LilrqkE+A2FmZpXU80dMIbyzMM=;
        b=TBiqUEl4lG0aTa9zh6MQErRXpX5xit2abWexlwBsPIMkeg8q8HxsUoEUyGTLVEzv+G
         MhsYrnPlvExKQH/P+0d8Lq+1Np6yBbubDy334hKZrMUFPuugfArhiM0bTbmx97BAyVd5
         Uh8YhsjWnQFmWmIvL2W+lBYDFIFuidTkKbxK1Kmsh66YA4AkzMVQ8veAMKMSvD96nt1y
         kc86Az57y4QpKwXoQORb0bX0GczYkUrLvuQRgFHqWZQl4S1tcmMIwHGxiijH718xexcz
         5aL6mH8I2vo6AURWq2YA7ta3REBQNRI1oCm6sS2ds0TCMZxiIemARsBkyE4IJ9eXm7fQ
         iiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733824620; x=1734429420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouzO1WDJZL0nWUUZ/LilrqkE+A2FmZpXU80dMIbyzMM=;
        b=FQeoup+XsWvBIerOZixktWbMUIJignnsa4sO5nUBP9P/OC45rqQxkTd+SLyDENmC+t
         vOa9diq9C5nI1KUiTJ1Ga+ZXgQ1CA22hhQJmQP8f/gZmzhxNm5n11uLanBAyJzbArIxD
         D4YdvIVBV7pSKmsIOhJhq5PLHtprNdpYqlQN484FrPJzGB/rg6Px5ESRjF61YzfFaZuv
         kL1KmdNxP3kgPQJhBYczC2NZXTK3id5y8mARW1ctgCl7hTNXMOGBZ5msJdKNId3XQIuz
         xRgKoSiGQQ8cVKK5p3AYw8LHeE2jNmVKdoTFu0JG+0Ce4rXqe831veKrus0jZBXJ+AtK
         ge8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXzf2LvCqFBsKgbH8I+kRjvUHaCcJK2LcOSnBt5ZqHJDFLX7JL0wt7A+v4NXi8RMBE7YKDsKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMh3HJPSPuI//UIb1ZHKHkw+MqJvoKqqMgB8+STh9jqkRLs1J
	6escHe3+Zz46vRWxGtvgzwVKXbDEefw9CUIjHUq6UWB5DzHvadYDRz0NTipdUXxmcWFkD4uEUZv
	jGIUsWpXTRRpk7Qc4ie+OIW5Y5kg=
X-Gm-Gg: ASbGncuWMn3h4vqODjcinSCzdmd7IFKxfBCV1tQgLUDmXiijbKY7BnuJMu6K7MogM/4
	Vp5/FOpQLI6lrceoolwXun4CeG1nkZjwdhLg=
X-Google-Smtp-Source: AGHT+IFYZMypul+/BzklYUzNZQLMS5nebB41f+fqxPurV22Rwov2tqOfX7bFCLbxTitXWl5k17sy8RRqlMMnfqxyC2w=
X-Received: by 2002:a17:90b:4b10:b0:2ee:f1e3:fd0c with SMTP id
 98e67ed59e1d1-2efd4a6130bmr1621584a91.8.1733824619840; Tue, 10 Dec 2024
 01:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72=ryzv+5UT2jXALNebpYjxm_guSsU-XXm-0BM4WULPYhw@mail.gmail.com>
 <2024121039-sizing-drivable-5ccc@gregkh>
In-Reply-To: <2024121039-sizing-drivable-5ccc@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Dec 2024 10:56:47 +0100
Message-ID: <CANiq72nYT2UJE-ZB0qMQPJW=Rdxs+g+LmA7kZi_wqB6sG8uq_A@mail.gmail.com>
Subject: Re: Apply c95bbb59a9b2 to 6.12.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 9:51=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> Please submit a working version, we don't want to have to fix conflicts
> in a way that you don't agree with :)

Done!

    https://lore.kernel.org/stable/20241210095506.2027071-1-ojeda@kernel.or=
g/

Cheers,
Miguel

