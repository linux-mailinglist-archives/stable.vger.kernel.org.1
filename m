Return-Path: <stable+bounces-70093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F40195DE87
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9755428312C
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206117BEA1;
	Sat, 24 Aug 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCgxsA+1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0317B4FA;
	Sat, 24 Aug 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510742; cv=none; b=JqY/aEFH+MozAYgIuguy+LuvT79Q8rv9iI2H0xXFpxMJkIqRcQ3MwISLzCMCcI1AGZIk6qpwV36pBFtCrnXSAo1fJCcPIkze2Krk7X26wBMTTLiBD6hs1p6/JHOea+Dpte88zP0eAZJI96b/soCLB8sTpquLEbrNp0k3Eufr/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510742; c=relaxed/simple;
	bh=yKLhO3zezTu0gCGd5cg8+djuu5pIiliBtywC6Akap6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlcxVvNHxUCVJ7L9NPwj5y65PineBG0Ul8EvSyKYEB1FlaMSXfyQ50/szVTvQnuIdd/ItDDlymghYjU/NfvFRZOzk5mhQIHRrnlCEw+kNm4jGxUayW/2VRe/lBRUQ8NLboHCXYAkx8x/KmllQ5+oLtnsc3KJqfcbVSYi6apaOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCgxsA+1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3c4d47c65so346177a91.3;
        Sat, 24 Aug 2024 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724510740; x=1725115540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKLhO3zezTu0gCGd5cg8+djuu5pIiliBtywC6Akap6U=;
        b=WCgxsA+1IwOJNw6fwvpzXbwV8QHUE7JImk7pTELqO7HG+oG9jSaWqMCTqfKDsk9QcK
         nBW1MgEHcnhz1j1bh+ymz2WS35l4HGev5VNnNH08f3vAPaqQsXDZ24Ef8bYlnmYJ6S5h
         Wb6yFuJlBDVhPJH9L6HLDP9Y7tKXQUbi0PztSGtpYYim9VGowh0hU8/BA8VEiA7LSANi
         1QLpDjCTeXUPeDV4lgof3bN8IYM0di8cgsqJGE795EwGjaOx1PSfBL6NdNdASySdu817
         uuhUB2FcDDbmZMox6iqJPRjKfpldUbbn0oLCoduT/rDtKRXDWuRy5yR6bPXFg/Rcwjef
         NjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510740; x=1725115540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKLhO3zezTu0gCGd5cg8+djuu5pIiliBtywC6Akap6U=;
        b=rfU3YzbvyijypEu/xbQekuiycfM6bWlmkotiQqcfXXjWSzb45xv+HZYeJOD3mhE1Ys
         JAdtb+9D23zkmLq9Bevxigm71xIpg5LuH7WFWYxSy/58urnck57sbE80QKMZ0yVM/d7i
         1yl9n4QU8IV2K38uOJgYlbjwutnw5ug/WqvPHTJ7iJdWItsNUTk4nS7EchODFmizGf2f
         9zGag/0SvVobwQ/u5QBnPHNb3WOFnAPFVRDCw7rAZ5CIMflWourX6848zrH7FKbJCF16
         bKJnZ0SZwpw3lcjI1GCv5rWpcjwRRMyJ0mtrd75rimICE2v9v13XWjzD/j0jvS2vjB/v
         YdWg==
X-Forwarded-Encrypted: i=1; AJvYcCU+wBNKkLYwGEOx8PT64KD/I7icPFf64u7RSIJvLRADNdDB8qFpZVpq2S1a58Xs//raWcYAMKiuoWUx8za5vg==@vger.kernel.org, AJvYcCWzsjahOR2Wt7xWwlpq4W3KfLdIw2jAPMMCkwrmi4QUAxqo+T+kn8vuJPjwoT9EdtW56htMJ/1p@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ5NcPQauC4nFEisnB6Zj+F34I8CHBhpVXPf6rnvaY+zmMmFOd
	PoPUz8xoQjqh4QIIRIc6sbsHC67PIQ4tfMcKhhHu1KiqT+necwcJtNEHgpFaiz6qmEJlYHT6hfD
	ke7efAguDnah2K9T6m/dYXx1YBJikAw==
X-Google-Smtp-Source: AGHT+IG2pOUh/RdIDD4HJhpLQFu/6mJsVtWEw/QQs9gHbugsCMIuE2OZlKfhKgjE32K6g+F41j+0L8StPt0D3dJghog=
X-Received: by 2002:a17:90a:c713:b0:2c8:e8ed:8a33 with SMTP id
 98e67ed59e1d1-2d646d65c1cmr3652428a91.4.1724510740295; Sat, 24 Aug 2024
 07:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823140309.1974696-1-sashal@kernel.org> <20240823140309.1974696-8-sashal@kernel.org>
In-Reply-To: <20240823140309.1974696-8-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 24 Aug 2024 16:45:27 +0200
Message-ID: <CANiq72n-kZN6nVCNt+4ouW6WFWyg2+Zws8yVksZerLtN8-DoKg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 08/20] kbuild: rust: skip -fmin-function-alignment
 in bindgen flags
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Zehui Xu <zehuixu@whu.edu.cn>, Alice Ryhl <aliceryhl@google.com>, Neal Gompa <neal@gompa.dev>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:03=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Zehui Xu <zehuixu@whu.edu.cn>
>
> [ Upstream commit 869b5016e94eced02f2cf99bf53c69b49adcee32 ]

Sounds good.

Thanks!

Cheers,
Miguel

