Return-Path: <stable+bounces-201140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E49CC1308
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 07:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D07063065785
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 06:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6DE335067;
	Tue, 16 Dec 2025 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyVWoQYW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C124A078
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765867696; cv=none; b=eyBDMFQ2+5KDP+7Y3Y1xfMTWFaUVtyVWiqEvNgcp5szBtHsJxCnewPkh8N6OUIYJvb+WMGJR2S5sfAWUCdfGfe+JSSiVUC0wBYJXVM/QXhiIYMtCavw4JUbx/nM31DB1Kti0Qi75/6kU/fhG0CYT/9cf13vnoctgfApwQP/26Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765867696; c=relaxed/simple;
	bh=XbjqoHUIU3a1ZFsUT8DFzfG2VSs9bjURyTFJQy2NTwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0lp8hlE/XyNgAptQNU/kLJ5GXW0ryLSzBzATrs44bAE9S4CmY8uKcvG0k+zZseXQn5eEuJM3D1DpSXu6txh8uLKpzg5L0iiQvWv638P/lc46rVs9CajsF/Ojohmp4zayitE31ld6JG8X7XkGZApN7brLVJWm6Cq5wvEzqXuFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HyVWoQYW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso3388601b3a.3
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 22:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765867692; x=1766472492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXvk5bRi95IWruHOumptdvOPeruXtrXt/fRRdDpxzJ0=;
        b=HyVWoQYWLc4fJR0kjr7X0jLqpMfzVtn23HQWhtcARifFZW68UcR2/Q7JRD5AsX2WNH
         apFi/NFmIaAWPDw/qetF296ImzE4krZ0+oAOIKVMKcWLxZWZJHafi5NV06LQlPU/GOqj
         Pf89QHZRi/ZqTL/QO60c2GAds85laxLqGWgouuX9teJdfZdzn2NSHfBV5oVVSf4+E7nN
         Sipz+Va0480WEjfWKQUyyID55DrhhhvZA43EBIXJDfr6dyaO3ftuXzco5Wb4Q2DbR0m7
         iRuXC9a7ziXJxgY3FvQ40iCNFFSii1m2Hr/opRMMujS6pYskbMuBASXeOs/YSAIrxnNG
         3kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765867692; x=1766472492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXvk5bRi95IWruHOumptdvOPeruXtrXt/fRRdDpxzJ0=;
        b=j7AZZnTOT4qdLqspSxKmJJ9meQGBqWnjxGSzWUpUeOsTQYtAhQrunvJ3Y08m+Gkz/u
         uedBGizIagwYsOtkEk0B6Sv9ZELQh2ffgYcAdz0p1zh/YSvanLIVLIf8D9HB8IdalCpY
         nvHQJGlaAv8b4X9n8VXnG5rBZsq44pVlbX4nJtd3m6Haapr3iZ7HeOIKodU6yBcB5Hvd
         LDcrpoGN9nOfmHyniSJ0K+GDRAUJk4zpHZHZ2I0xmtOt9if2xefHK9JohuWAhGrJ81Fz
         ak+q73Le52QkMgTNmlMksMHTBK5xgd6LjAPaE9dQNEsPm05vxFoQms7opgH8zKKyP5dY
         rFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJANSJQtnyAz39EqNVw5EhHmswN1R8svWR8mxu/REfi4vNlJZGyDRnmNpe5nwhLuNgCqiGQ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2Wo+qw1DhiTLECAJDpWoqz50Pe9X9QFPE/bqAO0EY/fdF6e7
	WHRzv2cDKDIH1E50Sp4nxFRY/OfArpdH//+QZ/4TEYv99mKFDlUW1Tzytzmki7EbVmA=
X-Gm-Gg: AY/fxX6yReE++XaC3CPoUqXLB+rik5f/5cOsKCygftzVXrmaaKw1voLARAkm19EYciK
	VKh/tmXehX6qYihN7mqpjcm31ZNsSoO9uqSZ05Ui8Fo1J/T3p1weWqBT7rez7KbQZ6KvAmcFdzk
	oUWTRUa0s42lKFzmf2C/4mbGAkdroNlGBpoQrs1LuN4ff/ScBAMoz8Sp23T2PZGxc/6OyaXcUoR
	vu533RdQhyiNqZ+bx91LatL+HxAwv+Is5FZo938irGL3ji9wxgVfo4TU8axu2CqQJPCEq7AyIq1
	dI6Hl+2CplJLAq9ImNG2rEJfTiOEqXkhitQTciAjEMhtBsRFtu8N2A4SmF9aRPoK+nQqgkQ6wph
	5gY2F2YA8fO69jM+6T/oU8Iur7RdFRNuxrbHMSuSuh54I+pjj104reJ0n18c8fPUc90aIPreKhi
	rFGbJ5zrBEAhMs5kDDmdPVxg==
X-Google-Smtp-Source: AGHT+IFzzFaXnJeraUPME9Aylh9mLw15QjjXw7/fzU43Ce7vyfidUr9cW1cN1E1++irSuRY2JI9fsA==
X-Received: by 2002:a05:6a00:400d:b0:7fb:e662:5b9 with SMTP id d2e1a72fcca58-7fbe6620b81mr594505b3a.31.1765867691516;
        Mon, 15 Dec 2025 22:48:11 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c585cde0sm14320732b3a.69.2025.12.15.22.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:48:10 -0800 (PST)
Date: Tue, 16 Dec 2025 12:18:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
Message-ID: <xhpapgzctldhwhjdaomu252vqyrljwunc4gis6neuap4x3nppp@rqbrauohopgv>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
 <20251208-io-build-assert-v3-3-98aded02c1ea@nvidia.com>
 <20251208135521.5d1dd7f6.gary@garyguo.net>
 <fmdoyqoyksspygcjg3wbqxtqqntunk2wfny6vvt3iq6wddwuzr@a4kfi2hcc5x2>
 <20251215111430.756f8872.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215111430.756f8872.gary@garyguo.net>

On 15-12-25, 11:14, Gary Guo wrote:
> Thinking again about this I think `#[inline(always)]` is fine to keep as
> it can also be used to indicate "this function shall never be codegenned".
> 
> However I do still think the comment is confusing per-se as there is no
> "optimization" for this function at all.
> 
> RE: the patch I am fine either without this patch picked or having this
> patch in and fix the comment later.

Thanks Gary. I will keep the patch then and apply add-ons later.

-- 
viresh

