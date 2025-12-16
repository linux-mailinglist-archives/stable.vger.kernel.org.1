Return-Path: <stable+bounces-202709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C1CC3C1A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09F03012952
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B9A33D51A;
	Tue, 16 Dec 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8GO2Xxr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F7339857
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896118; cv=none; b=DUQxxQAyGukoiByymjFJnBtgH51NZjz+UQ9Lc4pxL6FjTyQiURr1xxlc2hOmE3PAgR50EZFqTMP1EukFn+J8D9nTc+3vS0bSYBv4jyyB/X8ys1QnNdyjvcF/VVd3r5VLuXGQw1WFOsYe0qWJl6x33oie7Va3m5KA/rbNPVnT6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896118; c=relaxed/simple;
	bh=GcmsVh81EPRglScizk3u6c6zc0imNsEO8zBP3X7zTI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWkfrlxgw2AcPhODXHlVgMHS3nUwzFeJAnkHMuV9gt4lqNO1fTxhDWrpT2UyxaPlKPCEhfd2SLQnIB9Dsm6EywctLi/I5l/rrYXtZrkljDS8F2Ae4CeFDvtGAfYPlrCCjpISp5+uGzFYR8lmJ7vN8EEpHlzrQCUyL5FeHaIAmUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8GO2Xxr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b728a43e410so737252366b.1
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765896115; x=1766500915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKhhZCZ5BMNvuKBSscW4xFg80GIsuJjSxZdB89waxC8=;
        b=j8GO2XxrFIfFFCyA+O7Zf1ks/757dwI0isspaJO6U/ZKcHTCQSCPzmg676PjLigdfs
         YSrkLMM9NoCi+gW7kDQbBIguBj7DxrRN92pFXKdgDxvVSTWtgZhtPW21rXylD5w5UHND
         U3epEMCOV/tOUrQC37vDLtXto3xXFMeq8RsU7ceTzPuPiLHAG79uyFV2NVW+2+bSwo/C
         QzMUIui9oiqkURSbagTnMEiWHSo/rXfe66G73+0JrgRM5TLbcygs/IF+dHGHXkx54tbh
         eIqrxE6oCNFDqYopgxlGgzOBxF189A1RVDCOnKTOZSpHFjc2dO1ogI5Pths57b6P0edO
         7heA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765896115; x=1766500915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKhhZCZ5BMNvuKBSscW4xFg80GIsuJjSxZdB89waxC8=;
        b=NntiQFCrlUE9nUMOgn45cGiBsVWAYnjDn9mDAS1TWB5w0PMZ0Mc42ZVYq0RvAsighL
         O2LhVyB4FFod6wk269LrFMFaa9uTVMYNNjgzaGDT1bNetqIIRhDw27GzHWoJ9tZXubx1
         wtQVQ92C6BhbRmBpQVXloahPYIBrTTx/UAV2pvdRDah5F1jn71tKBc6ioHIoxr3EUxNH
         iopB4k9QTY/D7V8A0Rub9+PAmMS2exIAwrmElrDdoi1Kh5odBdC4r9S8yT5F5oOpxuWC
         BZUZggxoF5F8MtKHeNgjKZmLV6EBX61oRAh+z5AuB7tkAn5mx+G1Uo6MfGZVi7Q+ArzU
         nKsw==
X-Forwarded-Encrypted: i=1; AJvYcCUHlGkC6o78PJmZEW2KSxA5vGKzsX3IGPxAfMSp2PhyWttHQyvny7zA6WfjtvR+NAnkniMFmso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MjSQ5zn1ooDKKHhTC5hecattBJOsL18FitilygMdn9JuB+TN
	y7a6JRKN6ibl+jUCh9pL5uaC8xN9ByM5/LUdok/CPERC6k5tLOc/q2rA
X-Gm-Gg: AY/fxX5Tz5z5LWdViv/zny/Zd3uofhBeIM8lqtDk43k9s1OMG3qjBYo9KSQQ9wjf0NZ
	J3TuNw1b8E9LWr+cvD76NALA+fFWSsqlM/x22YReSJ/SEIdPwBvJ5xcnrBaM4Rel+6zRQyFvhYM
	HKdtZ0pjg4sj0yIZEz8Ymh5CwDZxYOUXxNZuDw5OhAgpRLaIFa1ZRNZPl6eLE+4edclTgMY+g6l
	zz5r7j0PmKlI82QE5EHYSRTRr6KUbkv1pGQzYmb/yUVsW4aFofqPlb93Ka3uR9IIwOyIDQRqxXG
	Iy3LYWBwfFOdJvL9R6jD3LydG+zEx6KvfHHZnEQj4bIVmfzP9J5BjS5ZLvIEcx6rTb6ptZhcetj
	QQ2QvDo4pSsMr2TmicaHHaGhTCr69BRoUH/RuI3OkYPKrzaDgeCc7mE13RhYFM5gtuV82xfBZ+K
	JGnJJ5CRbdMMPi/TC/i/tQ5n4=
X-Google-Smtp-Source: AGHT+IG2eeJsem6ZFRGiTw+NwisDAZ+3SHIeXNcmnaxykLecsCuhc1aufmqpuqSo8Y4ftNwLIvjHPA==
X-Received: by 2002:a17:906:4fc8:b0:b79:f984:1557 with SMTP id a640c23a62f3a-b7d23c5bf6fmr1614360966b.46.1765896114506;
        Tue, 16 Dec 2025 06:41:54 -0800 (PST)
Received: from [10.27.99.142] ([193.170.124.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2ebaebsm1717413666b.21.2025.12.16.06.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 06:41:54 -0800 (PST)
Message-ID: <0705db10-3cbb-4958-a116-112457f9af6c@gmail.com>
Date: Tue, 16 Dec 2025 15:41:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARMv7 Linux + Rust doesn't boot when compiling with only LLVM=1
To: Rudraksha Gupta <guptarud@gmail.com>, stable@vger.kernel.org,
 regressions@lists.linux.dev, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, llvm@lists.linux.dev,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
References: <1286af8e-f908-45db-af7c-d9c5d592abfd@gmail.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <1286af8e-f908-45db-af7c-d9c5d592abfd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/14/25 12:54 AM, Rudraksha Gupta wrote:
> Hello all,
> 
> 
> I have the following problem: https://gitlab.postmarketos.org/postmarketOS/pmbootstrap/-/issues/2635
> 
> 
> In short, what is happening is the following:
> 
> 
> - The kernel boots and outputs via UART when I build the kernel with the following:
> 
> make LLVM=1 ARCH="$arm" CC="${CC:-gcc}"
> 
> 
> - The kernel doesn't boot and there is no output via UART when I build the kernel with the following:
> 
> make LLVM=1 ARCH="$arm"
> 
> 
> The only difference being: CC="${CC:-gcc}". Is this expected? I think this was present in the Linux kernel ever since Rust was enabled for ARMv7, and I never encountered it because postmarketOS was originally building the first way.


I've managed to the get the build setup for qemu-armv7. For some reason
I could not get past the initrd even on kernels that are supposed to work,
but I think that is unrelated (and not a kernel issue).
On the linux-next kernel I didn't get any output on the console from qemu so I
think I've reproduced the issue. Changing CONFIG_RUST=n did not change the behavior.

So I this is almost certainly a LLVM/clang issue and not a Rust issue. I'll try to
do a bit more digging, but I'm not sure how much I'll get done.

Adding the LLVM and ARM lists to this conversation.

Cheers,
Christian

