Return-Path: <stable+bounces-144271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43146AB5E77
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 23:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7339B3AECC7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 21:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614B81F8756;
	Tue, 13 May 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DTW7a0zr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBBD22338
	for <stable@vger.kernel.org>; Tue, 13 May 2025 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747172229; cv=none; b=SEZ0q1TZbRAtqNgOevIUYgkDcqWUiuaQjcq0rQrJ7LMbIGMNUuFsj5htF3BplxEdkogypF4oFokagLFWcok4vm7Oyd7RA63kKPQVCqgYW8g9WnhywxZRxhqI/oafWuh5G+F+Td8e+eLyq5Iru2QkPeTyUYbhUCFXUzIF/HuFkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747172229; c=relaxed/simple;
	bh=PO/ZnToiSQshroU62YU04Jbjh5HO510+sm2n/R7pJeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9XxmHIMnBLT50hqQKNOiEHas1ZqGXKKbdx67jHOxhKYdm9sJd9h0vCYtT+gnmI2mSsQEBHzhpqpuyaERZ0NRjWuaAJSZHD2vuhwZfbYyz/hjfc/AWN8Aakebn9Sa6T6OQAAzHPq5WdKoqckaQU09jcYvCCLdUXNAl6DbACXhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DTW7a0zr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad243b49ef1so664652866b.0
        for <stable@vger.kernel.org>; Tue, 13 May 2025 14:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1747172225; x=1747777025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PpGt0/4BlhEjF3LhxkoQUInU9xlE4Lld7uIpl3WRJ5c=;
        b=DTW7a0zrgyKgo4ABlEzTsAZmvnL3ehXNIha2LPqr9qW+vW+lQCRPYku3q+d8B4n+07
         H60UaBeSoinvt/OQ8Sy2y3sU8Cujh2fbPhl6jgzYKrHX07L6xoH3/81f423vINdLokWV
         SR1Zvg51o8TELpNKKknnYS3vYxaDGPga+K0F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747172225; x=1747777025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpGt0/4BlhEjF3LhxkoQUInU9xlE4Lld7uIpl3WRJ5c=;
        b=a5m+2e04n1Y/E9jB1kLX6Mkvm+absvQU8vvaZn1yI77dGWfwbkK0JGZH7mqFJz05Sp
         8/uCDcZPF06e8mHIM6QjmejAUnN7LaC0tLZWVJmhGmW+DElgo8aE4t+uXed6jQh5iMF3
         hATWO7At53Mdbx5hBaZtE7fHgbQXgH44l6zwxgEqaWHP10HYkbh+4J5+FplhF220BfPC
         5fPW6NTWsDehg32HsVAajpiZWL88X7eEA2ivbbwQ2RMDCDSo4BS3j9c1Anj8MV7RIjSo
         S9e0vogi5H/2XxaQFEb33XQOpFPqfoO4e6ITo8yi4YKCwxBQbBrosvPM00Rwlo5OWNPa
         ydQA==
X-Forwarded-Encrypted: i=1; AJvYcCVv0qUSLmG71qz6MZesdU3DKKWWvAwmf7L+awZGMzsJy6vW4cOVRnXpk4v99tU1GIGMUTPcmr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLIixZa4LdFoP88rcxT7AqurERvN9IxtG+WWtJ0vA1oD1WICqP
	omsxMZP80YjvOXJIaWCdwtPHOYwaJyF3oU8+Tku56qi5tlexzs9mV6rt2+50uIKE0DSyqeGDFHw
	IjqAVEw==
X-Gm-Gg: ASbGncvvnjrlRbFmdbfrjRQuYbiXJx6HRZpEUoNNzqOOhJBMqtmE7OKV7rNOPTEaKc+
	9LZbpbWD2K6q+KcZo3lPMjlMvANDAWBdiNbTBtvtz4DXlSZAxx5s+hHDTXZ+xJ62kBBE1LJQY5G
	eF0hCZTLj5NyHtq5Oj57owh4/ezUPiDq5h8SYudSmXuYNdcTavCFE+P6qszIleK1TI37L6cLDpH
	O3fDxBhDKeiPsiklU78Gc/TjQrTFrK7srco2EvDXqMOrwU6B6vksFOwvdovQZHHvobtTtXUp+cJ
	ZEwax3Mu0/D+GV7C8SnbAdjICk8FHQEtRZqeThxj0XB/G37XU+bl8BEncLZIlJiMZEkt1DOu1Bw
	vJYNLiDzBRQbc1RIuCsxUbrhqbA==
X-Google-Smtp-Source: AGHT+IE0t4qfIviN9g2v1P8z68rLwb1UEn/vSLg7XlH1AjzJlIJhmT8HmYdHQ5oHTMni8XrSRpl+AQ==
X-Received: by 2002:a17:907:1c0b:b0:ad2:e683:a76c with SMTP id a640c23a62f3a-ad4f71326eemr101807366b.7.1747172225041;
        Tue, 13 May 2025 14:37:05 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad226f2466asm747507166b.143.2025.05.13.14.37.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 14:37:04 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbeadf2275so10689828a12.2
        for <stable@vger.kernel.org>; Tue, 13 May 2025 14:37:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFvcyTMO6Epeq6jmh4GHc8EauvU5tsOqjpryZiuzNIGtyOAcEPTZqd/DGNk/NyW85U2dTyTao=@vger.kernel.org
X-Received: by 2002:a05:6402:5208:b0:5f7:8e59:15d7 with SMTP id
 4fb4d7f45d1cf-5ff988c0538mr505870a12.1.1747172223719; Tue, 13 May 2025
 14:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513025839.495755-1-ebiggers@kernel.org> <688ec9f5-b59a-46c0-97d9-f4d0635fac6e@intel.com>
 <49808711-a5af-488a-9fd1-246c4da10100@intel.com>
In-Reply-To: <49808711-a5af-488a-9fd1-246c4da10100@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 13 May 2025 14:36:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-eB38UMFNna8svJy+=pS2=PHQ8f9-_8wVrVG2wh0zeA@mail.gmail.com>
X-Gm-Features: AX0GCFt2gxwB0LdDLQ3EofXx6pOOcaJcwz4xjs3v92rWAEBosi4IjQfmpE37OT0
Message-ID: <CAHk-=wh-eB38UMFNna8svJy+=pS2=PHQ8f9-_8wVrVG2wh0zeA@mail.gmail.com>
Subject: Re: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
To: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 13:32, Dave Hansen <dave.hansen@intel.com> wrote:
>
> Linus, could you pick this one up directly, please?

Done. Thanks,

                 Linus

