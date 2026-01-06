Return-Path: <stable+bounces-205593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D574CFA396
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2868D303F7E9
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295FE2D77E2;
	Tue,  6 Jan 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ap2na+KJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADC21A92F
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721208; cv=none; b=N/sPRx+0C3aKkDt9i4mDhsTdPVKBraMzLisM58bNZFiK+2XfenDM9ShyfWILS3avVHviOyWT6c39HoQRKUA+iuLeyACRtccuU+ZUjdp2eQ/3AY0Qp4nE2T7Hygmj5inoJBquuJx+tEo3TTsFfQnW1W5xe9t4Mbaqe14X2CCSlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721208; c=relaxed/simple;
	bh=C+K0pugC42dKNe5Lg5PpIsrRcNGMne12C9aznegF4kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wj35jeKSTzH8Q28f7HSu8xl1gaCWBySzS1PQccKkoLPNtNIJLCaAhVy8jVMDmx7A70NJ0QMEt4iw37qyMM6p6OkuvFep7UdRavBa9yeRnkadTtvpYSkxbKQakynT5ETZUtyguwKCEICbgtZbKuXBPGWRIZfQwfLkOor2hIO1al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Ap2na+KJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso1749796a12.3
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1767721204; x=1768326004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C+K0pugC42dKNe5Lg5PpIsrRcNGMne12C9aznegF4kw=;
        b=Ap2na+KJ0rWRrIlNtTjIZKRslkOBP01Yo9XGbuFeyYhuR31K+01h545Uxe5Z+Ckg3g
         AqzVtioIo6XW7wo86waeRvqwcVYzb52ukq27PJh5UBe5EdubBwL85XY//YlX5XY5PXyH
         8uWtod2YBk/t1bMx58O2cuCFHh+Sy99FhitwbI1zO+IJ5IeYnXQTJSkUkbE2CRWsJ5bS
         QtGtBIoVdQ1RBMrVymn0/9fLk8zFU8/fOS2oTtp3B1elYb22L+E2QxKlY2HuCYLp07iP
         bDOEeCKiD/I9Hk8RviW8jhMvBO0NPpWP/8HW3IhN9XrwvSFJQma8lIRcejkRWswhBVXv
         ZX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767721204; x=1768326004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+K0pugC42dKNe5Lg5PpIsrRcNGMne12C9aznegF4kw=;
        b=oeGA6CqrFWoE2rrJ2KYyktH0j3SnE1+MLRXARc3CRxnSRYyt/u4daFFMWAGbu/GcnN
         0S7jNivFdF75dVEMy5MJf7SeHXZWxlNIwJMe9/OJABv7iuEuZRBEC9dzBEUyHrmH4/+D
         8PX+/6j1lXQ9S/JxTCuhM907CYW0UXwfuQjtRLS6ge27QO0quMzt9H6JtRxL/KasWGra
         aoSYzCtAymSPQ5J2Alpud5Bc2RBElZ+DobsuIvF+i7hFNxhlMi15/mO88Iy9B7fb7bfK
         dqJnQdMJ/CDwrYgZ62VoKdwWDX80NHEQLHmDDCTI/ubRzYF4+PJITZExJOnhCwOwYbs7
         QLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjlC91VaK5cE5IgDEtah6Mh/q2YAmYLkDRF7GJViq2d9QeOOmXUHdMIP3WyINHP80TP6MR6Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBjMc8Ji631Y3hp3Lvy7ahCGPRZWt7kZUNSNjPjXG9LRoKLRwD
	6RSXX+lP/f26V5AL3gEeyYo1k9xkGyqHrYWvK5ZH15w9TMTt7VxWRKWyuSz1I77KR3rYS2emJWK
	gCptoCvyOidv+OkRI+zSFA4wthrQsfiLeQ6Xz51pm
X-Gm-Gg: AY/fxX798m2N4g0a3A72jmUGOxi1Da//T0/EuwiqZVkc3KQJj1JIxTmaL6reOqFV2Dy
	eygyBxvE0XSsDtMJIcw2hMnkfuMfZxvhY59ybJ5SjexUJD3yNUqmyDjUGylVclJ54IghDijBtN8
	/dJ2fEVYRPAamo0dYtjYF4lUr6W+oVYEM10HgRYAsdhBH6E+hpMznxst+/TnSrzQ68oOmeTwd9t
	NNPiGEFSOXVcPIlIiRO0TIpP9vAH7oU1EKtK+GnxoGfXySqqeg+kC+1OWQ2vOSvKGdwed+S8q+u
	ev6e9xdutneASlP+JpFXlIDx+S0=
X-Google-Smtp-Source: AGHT+IFuxDaI2kZ7cHSY2Kz1GjfzJaY1eypcwp4cBlF+EgBynjn5Bn9sDbWxNkqBQGo+Ag362FM7cepnVAWFp8yjRik=
X-Received: by 2002:a05:6402:430a:b0:64b:4c70:a5f0 with SMTP id
 4fb4d7f45d1cf-6507967c1f2mr3123713a12.24.1767721204380; Tue, 06 Jan 2026
 09:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABEuK16m+msavH79AZxTRSqOsS5MQmOnsZZ8tZuKY5WWwz3bFw@mail.gmail.com>
 <20260106122145.42e4ec09@gandalf.local.home>
In-Reply-To: <20260106122145.42e4ec09@gandalf.local.home>
From: Sahil Gupta <s.gupta@arista.com>
Date: Tue, 6 Jan 2026 12:39:53 -0500
X-Gm-Features: AQt7F2rgE_ZkqaV6Qp1Le8nRnQr9lZIjOGXOC391_JEnLYDbd_vknu4KpfrJbhQ
Message-ID: <CABEuK15immVy=+Ji3soYwB=q3tKcNVWuForEhQSPqNOqOye3bQ@mail.gmail.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>, 
	Kevin Mitchell <kevmitch@arista.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sounds good, many thanks.

Sahil

