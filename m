Return-Path: <stable+bounces-192966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80424C47603
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 15:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D8349D51
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16137314A9F;
	Mon, 10 Nov 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2APgdQ6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5C313267
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786642; cv=none; b=s9TT9CVGRcw41IpqZx9a3gRLS8WNsCHeClZO1nFaFJLE4+5w9vlD98aKgiTA5/+jaasSO5hR4kjzS/UxYMMPzmynd9crqG9f7333qPTCG3qhCOli1CGZ9a1/rfAZCzoFSSGo9WTGiTmZA5qmaA9WInVjWzCQRXJdt/8dnp+CWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786642; c=relaxed/simple;
	bh=XrYjurcXwMFuI1n6vQ4mS/+j3z0zFW9n2Q2HRAorD/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iOEYbUmr99y6zXODRxOq1oUWkv0wAI4e/LE6ZBIS1eVGSNDLyM8Ir3oE8Up7E/g32bfSKTGJG9CN3ZY8FLN2yciuvXyJyawkuOD4bgPHwkWAUHrsDobn1SxWYHBNVwkhUBwEfGeHj++2u3fHgJVOWUahR4Zmc/3eaOJNGncQyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2APgdQ6; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b70bca184ccso338581566b.2
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 06:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762786639; x=1763391439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XrYjurcXwMFuI1n6vQ4mS/+j3z0zFW9n2Q2HRAorD/k=;
        b=z2APgdQ68ppohMezTmMnZUfXJwArZ+yKG2bGNYUSiLZUZi9tdGyAt8NDkBH3P/eXwE
         LSceGSJUCNJHwSQlVLYkNWD+AQSmJoGCl5ksxV/2Fd64cm3YDojMcOirkQLf087pRVaQ
         WfmdSbxqgGycjfK4OOlWtjVIpALEF5q9Po+mMSLqT/WGCy8xkhb9T41e50ssu3Ru8Uci
         BgOv9WtcD8YYVx/F7KjtpacxOnm5g/bb9z3CPOzPlq3wBGa7iU+KXrO0j04GfZRSyNLI
         6cXRItaSLfwQqE8FZOtSIm4b3cCxkEiiYvnWc3gCWj9BLkenWXT8/FVQqoHtmAzZTz+1
         R2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786639; x=1763391439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrYjurcXwMFuI1n6vQ4mS/+j3z0zFW9n2Q2HRAorD/k=;
        b=BDaieHTqIQRm5K8m33jOp6ZalL5OWsOqYRTOcV/CoUiORanmr3WuZKHtaufM+iqsqY
         2O6pXIINCI5/37/q4SgWwkdWTECQe0LmEL77odRZgCDYZIEaClllJf8yUxTH+vgu177U
         Ca3En3OZUCS/EkQG6drPnN1Q14UuBZPAUXDr6j53HC5Oz/zG1ssHAjuC2Og41qIRqvRs
         xQxZjfhMsA8S5WWkoyKh5t2zfpdb/tnxw/BImSL7xFuwDUGp5LSaU+09pAiHPgXaaWDq
         mOZTRuaFS43ZdjQTuc6A9Qgoq6dNaRhResZI+DxzXsBfC95RHa45SJKtPWn38nEzK0oT
         ST6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5Zn+83khRL78vcf+TbWakkbpZCcycO1j3IUbejoWvZ9LNGIsdVwyuHVB5UCgFw76zoxNhZyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjMcblUuvaLym+GewQeYdEm4/kDXA0OTB2zx+LYIf3m+GS/7aH
	SHvqJXTavczet2nNM94QoNxJf5QSHB5rBiGtKawY3rDQxYLN92Et/m90AW0BU0oclHLia51VTDq
	3eAWI80+K3g7xTPM6+A==
X-Google-Smtp-Source: AGHT+IGOnlG8lE2H2BKECccs5w83Ie0qMvDDSxYqNCeNyk/4OUCiSM9N6qmdcMFCMYYfeMybQOzcZG1uqwa4NcY=
X-Received: from ejcvb9.prod.google.com ([2002:a17:907:d049:b0:b72:b433:246a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c85:b0:b3b:4e6:46e6 with SMTP id a640c23a62f3a-b72e02ca1d9mr839517866b.1.1762786639240;
 Mon, 10 Nov 2025 06:57:19 -0800 (PST)
Date: Mon, 10 Nov 2025 14:57:18 +0000
In-Reply-To: <20251110131913.1789896-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org>
Message-ID: <aRH9Tjf0tszyQhKX@google.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 10, 2025 at 02:19:13PM +0100, Miguel Ojeda wrote:
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).

Is gendwarfksyms actually present in 6.12 upstream? I know we have it in
Android's 6.12 branch, but I thought we backported for Android only.

Alice

