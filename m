Return-Path: <stable+bounces-52305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59063909CFC
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 12:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEA31F212E4
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA96186E59;
	Sun, 16 Jun 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcHIcquk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3E225CB;
	Sun, 16 Jun 2024 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718534335; cv=none; b=DmWtiKr1nj1/OVkCAt/x8NqoEcoyLeyX0I15vGe4DGSYH0MvEZ8qyP+uhSle1mhASJe94QMFA9cYrddWhIIVyIKd8QYX6N+yYbWDU6CRmPpLpCKPWVAJ/9XqK3TbgQoG+ZbvsIosZPDNiSlH268RXd8Aziimax1nu0544V7k39o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718534335; c=relaxed/simple;
	bh=n0LaERsn5Ds36h6PVoMho1cDafuJqvfMGBy+bvKEBmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZYS37h2w+jbVXTGPsL2g8zfpOTjR2a6gZJ3MRAxgbfNrgPFCU/CgiYSYv+t+gIZsbhPtylVLlVx3K9t2JEqNUHSbp6FBoWBrvmCGVREu/c2BnozCyCdOvnhU0+Byd6k5f7xYPjkvCCG0aeQWUxG0PU79tBTHFyyuzpjb07zdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcHIcquk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c2ccff8f0aso2902278a91.0;
        Sun, 16 Jun 2024 03:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718534334; x=1719139134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgdSxt5+meSRURqqigWrDUkjDZ8g9qstYcPDzSx3UJU=;
        b=CcHIcqukFVcGhJqbp0ZzsrO8C66f9//TcMGXODR6x/KWVYOErtzN7I8PEARblxNc3D
         PPUV1Dx0IAWgI3wxUWaWr8lB8Y0lkjFA0EgkM/LWvtpQVCYH7uN8lfFgy6t9zGrjYnqP
         LCLCBxyPUvcOUXGQl+BpH4o/D8FHCI1iA3OvzeqepoOdI8uQ1lyI/ymJXIQmpq34R1bE
         MPysptqD64leEnGUuzWVMxOPRyHCKEX+T47q2AgI3bqPTqT7g8kSYawhT12lzJT8+/oS
         MQcBGIIr5cQ1iv6MhCNMMlMUdreiQatgbl9+iK80Ji8hNZ3YBfk8s8ClD647CFd0i8wa
         XLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718534334; x=1719139134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgdSxt5+meSRURqqigWrDUkjDZ8g9qstYcPDzSx3UJU=;
        b=ovj8OW+5W9F/2AC7IiM0s47cEpQgY0vKJGRVATziIzMFW4MKQ+dvf0sPjXHidqHz31
         PO+Uy+D89cmWSYcf/EQ78fw09LiPsD7bGpou7esZNKVYcofgkHfqgVvFCZVBsZjxv9bY
         Y9ILu49gian7NZqriLHXqZWhxvMjt4cA3KJ4I7Mipft3PKo0g2b39xJH+l23Z14VYmzG
         xOSNzxev0+c96hKTT6w5ba5+h0Jw6o+1fZT209FdB7grOXJFDtCg/TwScl209PissJZr
         7wk2e48JFpz9Vp4tafpWetxT/udZVoJn3Ih9jHAm/cEBb/2RGYIkTouAAEeoPTVoh3HW
         D+9w==
X-Gm-Message-State: AOJu0YygrEZglBRERjzI5zupiM+zgUVtiOGWpicOR23762JoxJcB+px0
	S7G4JaDPf7CRRJkfo/iIkNiatfV9u7q13TTo18jF3KWuax0vM+42JYyziMf1tEU2PX2SaV/8GCV
	48tkLWJl4ej/JIb45pwpm4H0hmGHwa/z44Gs=
X-Google-Smtp-Source: AGHT+IFttbigH29muyl5Jbl/tX7srjz1gdrLi8KC8UjbLUEo0771BK8taFAdailCvL8wsy2Y2Oh/Xcn/0iqyh1BWM3U=
X-Received: by 2002:a17:90b:80d:b0:2bf:ac8a:c795 with SMTP id
 98e67ed59e1d1-2c4dbd356afmr7614814a91.34.1718534333704; Sun, 16 Jun 2024
 03:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616021129.1681226-1-sashal@kernel.org>
In-Reply-To: <20240616021129.1681226-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 16 Jun 2024 12:38:41 +0200
Message-ID: <CANiq72ma2Q1tvNboDyKOP+zOuefCW8Ooq_9cUx46MkFOG-8YRA@mail.gmail.com>
Subject: Re: Patch "kbuild: rust: force `alloc` extern to allow "empty" Rust
 files" has been added to the 6.1-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, ojeda@kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 4:11=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
>     Cc: stable@vger.kernel.org # v6.6+

This cannot be backported to 6.1 unless we upgrade the compiler, since
the feature is not available in old versions.

For future reference, this patch got picked for 6.1 a couple more times:

    https://lore.kernel.org/stable/CANiq72=3DV1=3DD-X5ncqN1pyfE4L1bz5zFRdBo=
t6HpkCYie-EQnPA@mail.gmail.com/
    https://lore.kernel.org/stable/CANiq72ndLzts-KzUv_22vHF0tYkPvROv=3DoG+K=
P2KhbCvHkn60g@mail.gmail.com/

If I had known it would cause your scripts to pick it up repeatedly,
then I would have probably avoided `Fixes`/`Cc` -- it is a very minor
issue.

Cheers,
Miguel

