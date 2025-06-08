Return-Path: <stable+bounces-151949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF35AD136E
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 18:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993CF3AB993
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2AF1A262A;
	Sun,  8 Jun 2025 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F19uCx0W"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512F219DFA2;
	Sun,  8 Jun 2025 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749401899; cv=none; b=mhBTkqWRsEIrzOgdMkbUP5NZQ78lL1aQ/HaWBxZ1oqsL6J+4u/Bk46J4x5SxD/G4WLlwM0yaPk8/q8QGmLMPdxYUoeFaBQYW5g90aGBHoSWr8Y8jUs5Es2pU2PnTVKhaZXJnFXbjv0N6YfDeGctvHMVJQoquffAPTvskeAeYbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749401899; c=relaxed/simple;
	bh=ES1nmazJC3eHPE4Dm72aaF6T8bwJef75vhIHbVci3TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZDKiQaiUF7iNqUyKKn3veX0r9uBQ9xpFLVTDKTj0C9WpNHWbSpe6hEsbcFwFusM0bG+jvX3jDLWk4x1jX6N2KV4Gu3DbH8EQ3NfST+TKWZqtUKVuKf1SE+PQDrRLAk3O3vBNcGkTTV2K2gaxG+78JKIsW7+VMZrT2i4CGKSSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F19uCx0W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234c26f8a25so5692985ad.1;
        Sun, 08 Jun 2025 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749401897; x=1750006697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES1nmazJC3eHPE4Dm72aaF6T8bwJef75vhIHbVci3TE=;
        b=F19uCx0WP/zQvjcB0knB8Pm4txk7JtSRt/1dUMedjcJoTpI1rpVI9lx444tLLqAeTZ
         /K2cTV2/elNzNJSAq6LGlEdubp4ZXm118ZkPhsiCFi9EYhPc9fOucYN62HPVb3Pwn+YU
         tfkmZaR3nQG0abd9zWkAjUUIezpbhgMpzDVZlNIx5z6qM+IQDOOjhlkfgvBLyOH95kgn
         3jVx4BCLHEANYfvz2Q2N+NCCcmM+ewNZidQTkHMu2wLU2UTIyB+by8ID6qHGzfsXBYVp
         mfUXHGRr59upVEOdlrxy2eYcswo4yMQ9skJ4YzzTcb1sskptIWjAuDrfzmmjmsx1t8fS
         PgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749401897; x=1750006697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES1nmazJC3eHPE4Dm72aaF6T8bwJef75vhIHbVci3TE=;
        b=D15Y5GRIWd+51kFwHR4WlCBLKXvfenQyIWrhM2sykzxIE3BVKsx+mWNZNEmsgGTQVV
         NbxREFUEnH/+IGMpz+VboaCVHzEcMmKcjCUz0r3RyRbS2pENcpwHLZ2CIxAeKnDGBfGH
         ZKwIpxRUGvei0qYbZ+mPfPKHLP13uXVg2x/GCMZjzK1kTwxTUq5mEbHtkGXoYUn1tpaG
         QGegtii5ef9v/QvJWnnOOdQyDjHK3auumSoSHsHl19CjyBFi5pIEld/gjxWYujH357wo
         P3muUooDCXe2KOBdeJyR2QDSznrSy44UGT/lHLkz5lYxkrbmoINkaVdXY5jQmWSa1gHY
         C5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9u70ts86o1XS1ozYFQ8+3hBe55jdTrKOWJsGuyyStrmtPq9XG82zhwDOjEw5hUK8wUQoVGgsNN6wvR7mu0Q==@vger.kernel.org, AJvYcCXOFxTqTOhDs8kwCBCKIu8ajBIOEp2L1CGYB4N6jRnLK9R4uF2OqAp3ulkew5Iv8scwxPiuSGPv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Tnu5ARRVpeNN0/BzJOqSauJtdlqVWH1aJ27GPDO/bPID40JL
	ddyZpF2XXUNWYLzAwIS4BCy9d91rHR88jukyj0dg7qRpPRS0sS2/VAzvcWld3BhlEt2CBiGTPRq
	DipeKyXZSA7INwebecKRahHCpQ45s3yJVMvFmXEw=
X-Gm-Gg: ASbGncuOSDJVu+yE/F44fHSqAtDXNVEPP53W87vzzv3aLc63VjgpNprAGQ+D2429mRU
	3oLTxdBv/+3V3f68A/wwBMDYXKFGMBociqiKWpiFiNylKyz4dLeuFC46LBFxpox8P2LMnLRDGLL
	oRPcvjutz+15+g/5cpDBjA+F3ePbmj3cjD
X-Google-Smtp-Source: AGHT+IHc9krOpM5WexDVkHYBds+VEhCjzZygfB71gm4bGafsCOVjq+AnZZljwFNAqrP6GYyN178LCDCabGr9gE2vf4U=
X-Received: by 2002:a17:90b:350f:b0:312:639:a06d with SMTP id
 98e67ed59e1d1-3134e413149mr5680859a91.5.1749401897584; Sun, 08 Jun 2025
 09:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608125447.933686-1-sashal@kernel.org> <20250608125447.933686-3-sashal@kernel.org>
In-Reply-To: <20250608125447.933686-3-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 18:58:03 +0200
X-Gm-Features: AX0GCFvZAeGmWU_hALb_8QuNqIlLnjRr8v5cZM9foJ-4o1tCZgAMz6lnNnKkYK0
Message-ID: <CANiq72nVAUMK0z7tN4-uS_LNNgJstf6Foufe8OfpjfVvg1ahPA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 03/10] rust: module: place cleanup_module()
 in .exit.text section
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com, lossin@kernel.org, 
	aliceryhl@google.com, gary@garyguo.net, dakr@kernel.org, boqun.feng@gmail.com, 
	walmeida@microsoft.com, igor.korotin.linux@gmail.com, anisse@astier.eu, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 2:54=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> **YES**

Same as: https://lore.kernel.org/rust-for-linux/CANiq72kEoavu3UOxBxjYx3XwnO=
StPkUmVaeKRrLSRgghar3L5w@mail.gmail.com/

Cheers,
Miguel

