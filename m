Return-Path: <stable+bounces-104169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A289F1C14
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 03:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80D67A04C8
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 02:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391921773A;
	Sat, 14 Dec 2024 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TOAfIOYs"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7195511712
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734143148; cv=none; b=ZLy2SO75QJhG4UdpRTC3R2UKCrj8E8EPGWiJqWD292nU0D1TZSzPwxwuhBnPFBz10aABBuK38BzjU1FjDN8X52fBBib4YhsQnTF+hSiexu84tPvKhACpSGjIT0a6PFEqNAoF3pq5YPdkcAYri/XJu3jLoi7yK58rBvhUtfPUcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734143148; c=relaxed/simple;
	bh=iq6dDBbndLiY2DDddQXufq1/8xq38ddxvn4I/8Ms6j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jl2EG3m0pHOLFfYfAjM8pHM/moZkYe/gY0/3+RcXsXSeuw5Ir79qV7CX4uU9iSWn8+6WagF4q1I55nqvzYPdoLP0d7RW7smedwNaz69PudCn6WZEUqczeFp639JgQffODtobsoUAbwjehucDwL8no3f/jHRS7KvSjGHvUPt8+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TOAfIOYs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4678c9310afso62831cf.1
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 18:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734143145; x=1734747945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iq6dDBbndLiY2DDddQXufq1/8xq38ddxvn4I/8Ms6j4=;
        b=TOAfIOYsGw09snwAdKsaL5dpulvRx5JP4DLhNeR3ZP4b/iSTmcS54EfV/GxkD5OQsK
         atmrKU8y86YWDwP3dIzcykV0tx8QhggnwCpKju3bb/tbDcRZ1N/3P0eZ04zeBoDl4vKD
         JgYCf3a75hyXrFZFCiL8VICVTeLPubtpKsW3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734143145; x=1734747945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq6dDBbndLiY2DDddQXufq1/8xq38ddxvn4I/8Ms6j4=;
        b=rz5uj8IE97dGZGQXeFuK4zm6IyQXvTHAvWHcSpkpjoJFkTusY6WLA0iN9mfV0lb2Vt
         mbDJHd2h33ngCN2qH9oJuI89K5u2ZSAEmG8srnvENxTWw2gKdeagrEyixvK+dECj8z4N
         xyQmun5b7r9tY01nZP7/nMysRh5sfyf4CMSmd+DsM4hGQFKGEE1HsI0GCmaaMcUcsdYw
         WUjlh2sPvNKGKOBGYgrGAxoIVCN1AIGF7ex1OqYP2i04Jx8qrw3ByGS1eVl2X/KQXkbm
         BvI7p6/vF4lTgHAkeXm18dWxUVSI2htIkJJgRmwOtecvDbl8RV5kGifrg8HqoyHN4g7m
         zm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKwokdKYt+Pg1oStRC0vfwBlu1ESDDPY8WjgiOcBmH/tI4g5kKxTMgdNfEDUMD2s7pkluRlRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzFxyqRVE+KpqpwK0k243Iauxoh4qjOLdk0iAYSYok6sr6VDKK
	+0PulbgCM7oG8U7N1skgs77q88cQKZgAjJVfq5tjwxe3EaGidocSuo6OHbn3cOz7lCplwj7FRLZ
	HOMb/Wq1keMjedCopB8By+NZ0bhDdpESAcI0S
X-Gm-Gg: ASbGncvUmhmM6uzAFIZX1JNqUwz2ij3LMHO5dV9Es09Q5UUosHnb+bckS1HCw6q5PbC
	vo5ThqGxmO1VvbIIGOFbVEuJ4WnkcYu1II/w=
X-Google-Smtp-Source: AGHT+IEOn70h5dn6BYdJXbg/aSWnK5Ci6RKTe7m32gd+98te1xMx5Rg0/FeuU5bBDSrYLKEpYMEBBJdcHNY+XpSFfJI=
X-Received: by 2002:a05:622a:89:b0:467:7f81:ade0 with SMTP id
 d75a77b69052e-467b30b4e71mr1334511cf.24.1734143145148; Fri, 13 Dec 2024
 18:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214005248.198803-1-dianders@chromium.org> <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
In-Reply-To: <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
From: Julius Werner <jwerner@chromium.org>
Date: Fri, 13 Dec 2024 18:25:34 -0800
Message-ID: <CAODwPW_c+Ycu_zhiDOKN-fH2FEWf2pxr+FcugpqEjLX-nVjQrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, Julius Werner <jwerner@chromium.org>, 
	linux-arm-kernel@lists.infradead.org, Roxana Bradescu <roxabee@google.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, bjorn.andersson@oss.qualcomm.com, 
	stable@vger.kernel.org, James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I feel like this patch is maybe taking a bit of a wrong angle at
achieving what you're trying to do. The code seems to be structured in
a way that it has separate functions to test for each of the possible
mitigation options one at a time, and pushing the default case into
spectre_bhb_loop_affected() feels like a bit of a layering violation.
I think it would work the way you wrote it, but it depends heavily on
the order functions are called in is_spectre_bhb_affected(), which
seems counter-intuitive with the way the functions seem to be designed
as independent checks.

What do you think about an approach like this instead:

- Refactor max_bhb_k in spectre_bhb_loop_affected() to be a global
instead, which starts out as zero, is updated by
spectre_bhb_loop_affected(), and is directly read by
spectre_bhb_patch_loop_iter() (could probably remove the `scope`
argument from spectre_bhb_loop_affected() then).

- Add a function is_spectre_bhb_safe() that just checks if the MIDR is
in the new list you're adding

- Add an `if (is_spectre_bhb_safe()) return false;` to the top of
is_spectre_bhb_affected

- Change the `return false` into `return true` at the end of
is_spectre_bhb_affected (in fact, you can probably take out some of
the other calls that result in returning true as well then)

- In spectre_bhb_enable_mitigations(), at the end of the long if-else
chain, put a last else block that prints your WARN_ONCE(), sets the
max_bhb_k global to 32, and then does the same stuff that the `if
(spectre_bhb_loop_affected())` block would have installed (maybe
factoring that out into a helper function called from both cases).

I think that should implement the same "assume unsafe by default
unless explicitly listed as safe, check for all other mitigations
first, then default to k=32 loop if none found" approach, but makes it
a bit more obvious in the code.

