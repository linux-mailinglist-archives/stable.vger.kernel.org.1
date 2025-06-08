Return-Path: <stable+bounces-151947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3A0AD1369
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 18:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76727A5518
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F0419DFA2;
	Sun,  8 Jun 2025 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf5LsKRj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B8149C53;
	Sun,  8 Jun 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749401834; cv=none; b=sBnQx75TL8ySj9QWwPcQk0uXf9Md3mWCgyoLSpoYUYsMjAHnKClaj2zFKKjR/S1iauVeQsTWYbAgFEPGpYqH6VROAqTbxkBK+VKU/FeBVh3SpHO4xeMipoWVwtTbfi3NZj2woP1CnfRMZR7jz9+mE3tFv2H1c/rrQ8YKx9MbZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749401834; c=relaxed/simple;
	bh=V97iY1Sq/zaYk+CjyZO3kcrQTN6xQUok5+0Jb8EJswI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vss2A1gNeR3OutIcAPHEJ+oIiITj5+IuoblZmjg5osnnSa1C6jQYgrBdEBFKEVXtWbk4xJKrE4D9PxWzTs4wUSClt8MjmUq9VAYn3Ip31ohs82N1dwD2D1QEzkgOqICqHxV7MJKR94uMlPrp2pMNKeR1zKZSUv4PGqyOwYhitTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf5LsKRj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313336f8438so596107a91.0;
        Sun, 08 Jun 2025 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749401833; x=1750006633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V97iY1Sq/zaYk+CjyZO3kcrQTN6xQUok5+0Jb8EJswI=;
        b=Bf5LsKRjYbGayxpS5NDYWI08fIx3IPyDpgxPTnDwEeQbzARgW4ykGKmkBOzlxgIsz1
         2+cAdJ12d1uwQWUcoifO8HI0n9G+B4QgKiYJYUQdqtO0RaizaiXP0IUMZTXH7hRXm8/1
         OZeo8v6/tWT9dUqO8QPVerA+3FbwCXTUEd/bHN9C8sDnPtHoX9EhoTZKgZVgvVIyxdAn
         +eACYfQrNlwIjqqQthvEfosJ212IMt4fsJiN73aoj/OcU82TOrwwBI0AjbRqUIfP9blA
         Rsc4jN8DCpuNb49ZEGMIFfP/o8xmQYJxPs6hcAz4pLzzntZpvtJEaw59Yzil4oBkNL8r
         XEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749401833; x=1750006633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V97iY1Sq/zaYk+CjyZO3kcrQTN6xQUok5+0Jb8EJswI=;
        b=YGdGIhyJ5PeUgrijS5zUyg2nN9Wvm+/ac6KLXiEwrRSHJX0OPFNOLvm/8+8rjeKjZy
         smOFFi1KqpU50OP+9ysrdMP1CMsQbVvC6U7zIJZrm2hHe338Jdc/xVCa6NBq/PaQauwm
         bpLdKIipo+lyk+d0xxPwBtrlxlVIq9g7Em2LPTTny31RbeTrI1EmocuCVF4qwfW9SbuI
         WPcyiY/+TCy9KUvw++FB0b61ANwGpflHT+49PzaktiV4hRYtfMNZeWk+6q/fHSMZ88xt
         968SCKDpxhAsYfT79VYC2CFYM+lpF9yS0PTYELWHI+BaYkA0ttkjlEQQ8rsarPBNlVfW
         8wvg==
X-Forwarded-Encrypted: i=1; AJvYcCUp3byN6H09ZedL3bc/TFp9j7TkqW5T5s5mCxyYqHNhzUUN3BTrO57JwR5KcqZjqxvAIfGTjbLv@vger.kernel.org, AJvYcCWIn3a7g5prlTC309+RBaTTX0Ah2Ax5mHGoMi9QVPIBNkxmr8X9lz+jBgcJAlCaE97DZP9cCdpluIK5xGaphA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNY1Vp/YvZVUkxCANhexfW5o02cEPW8JMvBYe3+JdTy+3l0u4
	d29YUp2gggT5fVeRx0dqqL4UiGP4dnuhafhpJ90eHMnn0HTfljK4mIVg42BVdlejhU9iabiSeVC
	Z5mPMkWfJ4CgTztsVv3vAXFshlC5QMcv8LnVHzPA=
X-Gm-Gg: ASbGncscIbJTY3ZamYdvoUKz3Ec0+gNSDx3gC015aYjtkZWemWjVvov2OzzaaZgXtaZ
	lP++m3ux60JKEQoohqQ4LrdwPiFfOQC5IE1zJssWhGyDvnL2rXYjYldxhA1NBdapityIsOQuWPg
	3ktywCCT5utwaRWO1g3GIUwqadodll+QF6Tw3qJQOCSno=
X-Google-Smtp-Source: AGHT+IEn/11AnIHAJzGyPSjYoXDr3J0HfM90GHhu9iLYWLiUi5kqf/09bR9Hl9j8YAgaJ20xruk04JEWnpV075/+d1s=
X-Received: by 2002:a17:90b:1dcb:b0:311:c1da:3858 with SMTP id
 98e67ed59e1d1-3134debe401mr4991508a91.0.1749401832725; Sun, 08 Jun 2025
 09:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608125527.934264-1-sashal@kernel.org> <20250608125527.934264-3-sashal@kernel.org>
In-Reply-To: <20250608125527.934264-3-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 18:57:00 +0200
X-Gm-Features: AX0GCFvKosMGvMiB-oBY4D2DWnpstHFS6w1KStG5spKOTYbIiFQlSfQdEsHubVk
Message-ID: <CANiq72mnDqq1NftH6Y+u+Acvb1wL5M_7kv8-4bum7zUW6iiW9g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 3/8] rust: module: place cleanup_module() in
 .exit.text section
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com, lossin@kernel.org, 
	aliceryhl@google.com, gregkh@linuxfoundation.org, dakr@kernel.org, 
	trintaeoitogc@gmail.com, gary@garyguo.net, igor.korotin.linux@gmail.com, 
	walmeida@microsoft.com, anisse@astier.eu, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 2:55=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> **YES**

Same as: https://lore.kernel.org/rust-for-linux/CANiq72kEoavu3UOxBxjYx3XwnO=
StPkUmVaeKRrLSRgghar3L5w@mail.gmail.com/

Cheers,
Miguel

