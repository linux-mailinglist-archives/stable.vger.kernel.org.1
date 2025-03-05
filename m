Return-Path: <stable+bounces-120435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046C8A50093
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263531612A7
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D8D248884;
	Wed,  5 Mar 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBkRY4SB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D437080E
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181541; cv=none; b=LfbhRshSRbegoGTW/Pa7J0FOXK0eu8IqT/ydv61T7dJaMOMsOTKByYKmMXHJ4VqvWDIXA+HYATN4wwkesgv2JfRF7wa87D1+dlu1FdbnJ6snN3H6r71cFz9DB3Fej0HfIYVywNCe3OH03pZe/OeWVzfGnryfMtuwUmLH3OXYDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181541; c=relaxed/simple;
	bh=MA/Tl5K/HzeGHY11yV+JGFQTHKF6NRYd26L2b8QqFyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RW1HDqEWdkX+raQdGY/kJWHp3+8n8MeQSUokogDOp5kJYEqyI6E4siri7otp/GRjHOWo/3AzT52WL1SSKiSGkAJDIx9wbRnoF2GP7Bfl8J7qRiWj+NyI9VHVNQzrWY8eMc/9ZvgZx2u1sfDme2kNa3BjA5h9s0k7xGN7CsiYxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBkRY4SB; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-390fc428a45so1725908f8f.0
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 05:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741181536; x=1741786336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhZGVnCd1LrD1r7cIo0XuyDXMDAukxGRXDEbG9YaT9M=;
        b=BBkRY4SBFth7JiXR1NcIKNRPFp3Zbo0aw+tS8SJkPtCT11RxGZouVhU73Qr3AVcwZS
         CkeeogZi8PLjLQGh/GPFLtoQFRgJWxgCUMd1DZyhjJyA7PXU3Nl+9yS5y/In2aEdEJE2
         SXmemAE/W2y6ZD5lgWqrfrlrQDdMDuNoS8uOqcqVFHF1jPvUUlV2i4TeqzoF2K3bsIWb
         v5820P6avKywS7f0ThGy/B81G2HNDGbad20rEjITW5IYfKdvbnVufn7jdcTBkq0QQ2Li
         3D2YWf893AAV/xzPM0giFzWdLA0PTXMLEXGanI1+Q8cR5q+tCeGfWWRGX0TZXZH6WLp1
         dBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741181536; x=1741786336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhZGVnCd1LrD1r7cIo0XuyDXMDAukxGRXDEbG9YaT9M=;
        b=Cvwtmz60hMPYQ5NJXae8w3bXbxIio7CafmbyfEnP4q2B3xhDArxkh5HUoZL7ffq3lU
         7Eqk88Jcm06QVRhlFQcSwGOFlylHaUrCLJLuEeT3ehtUOVb7TQbZ9sAHLTqxyqVLTFFc
         8vvwfu3VXPH50bbLqf00yGe7yhdbY+UySydBg8898J8+vQwmnIUZ3C8aoMKFZBNbupyp
         Kn5VL/9ExhKDttMjawY7LC7qGsdlnwsuwKFRZs3IVMlqerhQA2u+DunI7yMzJxR+eyDE
         p0Ygp8cPKy59ujTlAY4S9a+b6YRX8sku3iPDw32I6s25Ysed2lOfcexZAblJgvQn3wBp
         YCDA==
X-Forwarded-Encrypted: i=1; AJvYcCXj+obGzFkjhRAI6VadFO8V18/m71XA3lwwhPeOmO0C2Uwq40XltGSPHtk8ibrXNK7NRxeu/hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLaAJpB+beVYI8iTtmrqnZA7QCOwO6oOBYHmqmktGWu2tie4O
	A7C4ra8Lv252R8QUXclfVMtGOhTvM58e6Ggj7kWhjxcba7LUJIGig/Xzq/SiwswSuMjR0qZ6z7h
	NACZq/pzlrcsMzg==
X-Google-Smtp-Source: AGHT+IGqv7w5ZYvUvIWCvfPNCsKIl2w0sI3jypHqC/lLiiOmT2zEfZbYg6IijEn1V2yDy4haEHjOc40D25h5t60=
X-Received: from wmbhc17.prod.google.com ([2002:a05:600c:8711:b0:439:8e3e:b51b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:188c:b0:391:23db:f218 with SMTP id ffacd0b85a97d-39123dbf45cmr901576f8f.40.1741181536569;
 Wed, 05 Mar 2025 05:32:16 -0800 (PST)
Date: Wed, 5 Mar 2025 13:32:14 +0000
In-Reply-To: <20250305132836.2145476-1-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250305132836.2145476-1-benno.lossin@proton.me>
Message-ID: <Z8hSXgC-ecXCEPiS@google.com>
Subject: Re: [PATCH] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<KBox<T>>`
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 05, 2025 at 01:29:01PM +0000, Benno Lossin wrote:
> According to [1], `NonNull<T>` and `#[repr(transparent)]` wrapper types
> such as our custom `KBox<T>` have the null pointer optimization only if
> `T: Sized`. Thus remove the `Zeroable` implementation for the unsized
> case.
> 
> Link: https://doc.rust-lang.org/stable/std/option/index.html#representation [1]
> Cc: stable@vger.kernel.org # v6.12+ (a custom patch will be needed for 6.6.y)
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed` function")
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

