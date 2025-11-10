Return-Path: <stable+bounces-192947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A426C468B9
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E7254EBBB8
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B630DED7;
	Mon, 10 Nov 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3Xhu7Pn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309081946AA
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777015; cv=none; b=Wx8PFI6ht1vbC14zoXndfDJ0DJzr+LNve/IoHPN5il7Wj3IshSskz1U7L7iW6AZJkq5SHc5J6GA66E0cI324yialxukjKDTD8xvtO0uFFvrqvl8nTBNuszKP8JUB85683i6GVrHN588hf/UStOB6QyEfbJYjdhSpqU3tFblU3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777015; c=relaxed/simple;
	bh=1oX5sv3ST9fJabfGW1uKl5Y8Fpn5YczdxeGyYrbM0mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGPOo03iFN4WpTuCul8e3UyfxlA2lzxjJlHk+46nXq93JrawpiiSEBqxpJUf4lEoGORajAfUrh6murNuKn/tevmpq+PLvZ5SKTHJtg6ASZibm5YUFjutvLpaoQpptvt8a8efor32g9pQ4mBnW7Vx3VZeW0NbsOunjY+D5z6WdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3Xhu7Pn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29800ac4ef3so1571045ad.1
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 04:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762777013; x=1763381813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oX5sv3ST9fJabfGW1uKl5Y8Fpn5YczdxeGyYrbM0mE=;
        b=H3Xhu7Pn8SmMHS6T5AjHGO6UuUEKQHRodC6TOwlEcQq/ClXAT4EpEzvuaT9xh6/65X
         qcioyd1RnbHEwIfBZabd4w4ohP5ZAfXEA1X3KV1vBqvYFx60Y3R6KG40TS95BGdoaiTe
         sQMLb6ryvCdq3mFppCVuIs0j54VNnUu/JN/LMLgVk+VkvWkBfM8P1bFIvWLJvuD5yI5F
         0oItttr/nWg7mQKIkdbv8v5IccZG8yQzrWtEHp2oV4prVgKj3K6YfTCLfoynZzZyFlCn
         6yZIvhQGklgnEORm3rKt4XLLQDxCAlpgLkwT0eYXd0at6/8SBrXJn1sG1MqCoabYODMM
         qA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777013; x=1763381813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1oX5sv3ST9fJabfGW1uKl5Y8Fpn5YczdxeGyYrbM0mE=;
        b=YJI7LEGnEn5hHaNtROohOvybhPLOL4+QbKhdnYAAnPQ2IWxIAo/3zA4fxXwHRbztlA
         rjYld+zaDVkNb64duDdyLeWyoX0bNA0Dd33Uq1mBhs7u2rjiBuTxsrGQfHqXQvzgaToC
         /4NE/gUju2sbnzSqF/X+n5uc9FvAU097BUICrmzbX3ZIAPLC49oFVESEy3iKuf49jTwX
         DY9lRkVMGU9SD17cA2AeqgqBUKPg+ITizQ2gaLlSovgrc8elM1cUbazqELzcAjF4vxAb
         QZh0xqF1JeNj3kg6mIMPEv1AN8/HIXSMStH4gDXqyod5g6YrVdhuWxIjiGVmNcKmQA0r
         ouMw==
X-Gm-Message-State: AOJu0Yw8Wn3z646vfI9N+U9wcEWXP8XOH+9kucuRigY840HB4rvAvany
	tUa1xS3ok8RjJjdY7U/g53x9d+dMfYP2GQRRqb3V/2du7nl8oBNfkpAMhTIXot4ZueP2Jaj72mz
	KR0wYTFsAmjYSaGo0INBrlc0yO3z7amE=
X-Gm-Gg: ASbGncuntiTp8dm4VvhUoYRqdwhMPSFf5v+YlKd0f7RubR5RXt81uX8sOrVM5TrmTqm
	sv9BMJd21dIwEYZVbCSs0VQvZ0ZMwGSJgNOD7jVtMQopJcZKYxJpYeZHh2aFIfcBdQ+vPNTugZy
	KScLvhNm738bKN0bKNppRpxNNlvI42GnVzUjvtdFuA9oITjUDTLBXLMLHfpGHIR7uqg48QV4QmI
	ZfUtkcGxneRQkvchXiw4GVA0jRUIWH1lv6dbn9pnx3weV01LBiSv+8RMNQkInVP5uii0I47LuYP
	9N0S3vX4+IMQkT32/py0yE6xVOQFwWtf5MO+yzFyyyBZ/IqEf/Y71QeV2Os+lI0tvUnHhP5Xxww
	2/XEo8off2Sktkg==
X-Google-Smtp-Source: AGHT+IG+qS4ySrIqs6amJuuUdny9RQ1RBnVhYEPMcitN85KJm6s3e90Y3M7UstY+ES2Z0LL0I2UsCs9kgre9mb7lh1Q=
X-Received: by 2002:a17:902:e847:b0:296:549c:a1e with SMTP id
 d9443c01a7336-297e5649f22mr53234455ad.3.1762777013417; Mon, 10 Nov 2025
 04:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025110805-fame-viability-c333@gregkh> <20251108140352.127731-1-sashal@kernel.org>
 <CANiq72m3Rv+L8P1J+JZu4LnR6YUKqssQu0G0yMQa51xCQWK+-w@mail.gmail.com> <aRHXUKkqKMwn7xvX@laps>
In-Reply-To: <aRHXUKkqKMwn7xvX@laps>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 13:16:40 +0100
X-Gm-Features: AWmQ_bljciek7rj2ZaUuC07-bBnO1Ue_QbexfXOZt51X8Ptx9LOoftVYiPGP98I
Message-ID: <CANiq72mHKzcfcH0WZpx=46+ryeARZVscyeDqCc2pdhca7uNV0g@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] rust: kbuild: workaround `rustdoc` doctests
 modifier bug
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, "Justin M. Forbes" <jforbes@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 1:15=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Sorry, it should have been s/added/removed - there's a comment upstream a=
bout
> --remap-path-prefix that doesn't exist in the 6.12 tree.

Ah, so just adjusting context -- got it, thanks!

(I got confused because in the other Rust patch you said that, so I
thought this was about something more involved.)

Cheers,
Miguel

