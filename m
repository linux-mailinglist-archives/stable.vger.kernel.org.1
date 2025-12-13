Return-Path: <stable+bounces-200956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D66CBB50E
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 00:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F4D63009ABC
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 23:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C830EF63;
	Sat, 13 Dec 2025 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJZ0MqAK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1F23A994
	for <stable@vger.kernel.org>; Sat, 13 Dec 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765670049; cv=none; b=Ruvd1Z5S+BjAWfXhyQVi78CDDJiemmiSjne48n3zHXeQaGt8M2ikHstJNfupAmtneSDyJO6JNY49NRYRksNZzxiYRg4oYzBfXErJ4wuPF8plO8t2cFZNjwv7BX62bCXrKxbc5EBFmQODxlMmmUyQX86PkDqY06E6IFSF8RbnzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765670049; c=relaxed/simple;
	bh=dMvsk4TMnTyWR5/Ns04LifXAo7hjvc9/eJzEhni+uvA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cl9uTL3F6KLn4ahqWt48EghRKWj8tAiI7u+Oe1mD6W8VVb90QNb24Z+tJ8kiMlcvigtC5LBBSLs5tzqSOvIyqEyDspnlTlDSQaW9oiiXWKxGfPHB+kDEK6ApFYjVsCdUBK9KC/7sKop8RgxejLPLysc/NDTu/ISdJs3T56a//54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJZ0MqAK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso1381019a12.0
        for <stable@vger.kernel.org>; Sat, 13 Dec 2025 15:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765670047; x=1766274847; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYN/3SFl60V2M0Q1BmnbULjYHcf9XcZ8oKvOquVNi9o=;
        b=cJZ0MqAKQOp4n4tWifHNeXmpB0/4DuEWx8DEe/DN6A9O3sf5rxKVulAEoZH4QDh7Nv
         cENKwSukLPjG2bar4uRgWNoiTv2IUbjPX2WfZ0Uyuk1cIJwJQFCBbnh8DCca4+eGRnjC
         Z6YJKuyeAFrLYczYL6dnwE8PU0EpusfRcrFk/F2/dcPw+qFe47cH3Dd500qi9erf7TzS
         OZBy0mTN4eZmS3hzTGZLd1twH/RMgjaiy07IPAbB2bFuGnDb/nWDSc9MWRzFRmvL/Oal
         XqALSjgmHMur8+6SakJu6EV8O4f1UmMYEWLYAw1mZ/cJKK+ZLf2KwYQZCBKAmCvMYcU0
         m0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765670047; x=1766274847;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYN/3SFl60V2M0Q1BmnbULjYHcf9XcZ8oKvOquVNi9o=;
        b=twx7hnFWBvAJAXsxXfURgUPF43343lZzASkUSodnevU1P01aj4Lf+kSSVWfhIgYPa7
         Xr/mRtJ3PruDTfCOdXDQIdCAxFtlqA0/ShLA0/Qk4ayCorFzAHKMwLuY52B+ZcrpOTCL
         +Uz9EX59KGUhmiFDPP+KYhq8BSeFjclgiblOhmOcGGqYnqOl8hFinVKP77q8J7ltWT0l
         OF7IrHpBtDO6Y9lct649SaK4Cx4nNgEsIdgOccxxk11wnsmqXsdW0RRls+5gyvT8Nl5q
         YpiooIsXzGGhXIYUzTtx/LuVPKjimXbroBG+MmaCRMBpT7rbC/FMOR2QtLivunbbAFga
         NcmQ==
X-Gm-Message-State: AOJu0YzftIzjuAjUll226LHLzO7KGqS5VKae8MIJNOVVZ/bt6JgbkVgN
	P4o1UjNniNq8U/XOrGmA/5Koi44vNrWHZ8X4RKqmxfY21F26uqDEOCrGPPR2m3huzZE=
X-Gm-Gg: AY/fxX79qt07/+h6QtNGKWIAl5kkKHAuchz49Mdju6aBTcHvoE+A6LMkf72Fnu3nX3g
	eVwdQ+LVx4e0uqMJ9XAv1B+vRqfPWirXdS4EQPXeweic5AUYSmf+RfNY2edpeRs3H7Dmc5GDnYy
	Ac6mVMxKxHGOvSnf3UiiZrET+pts1T+0sFB3//16IpbbwDov8cSea81TaAMRR5m9p52AzzH65mS
	YF+1NjgcJS9bFEw0U4ety1bNlxSNFggd58+3RTue1lK/gFXABGSXtY7AlWKpIB8MqJeZYyzePB2
	Vcuq5SWpIGMiYYM+G1DmTUu/TfR/rBTxX8QHaBwZjK2DbfzKR/9ULjg44X5EONyPRoLeZsfsFlH
	Qr8tDAyuxmjjMNfJm9Plm+0jq+JtYqjygBqXigpiI5mvxDaPLl2ITORKnl98x48/UhW25g6rkqC
	4BF7rsyiWbIpql+PFMc+srlutvSnAz7N9QEjaZFJCmHKGobVKMlwLOiNWAIz/4BQOVjA==
X-Google-Smtp-Source: AGHT+IGDoWXmCM9OrPKNNZApGm50I1zqnlGU64Afsrvgz02JemgL7gneo2W2ox30974U77jX1cNJlw==
X-Received: by 2002:a05:7022:ea49:b0:119:e56b:98b0 with SMTP id a92af1059eb24-11f34c02b7dmr3531294c88.23.1765670047330;
        Sat, 13 Dec 2025 15:54:07 -0800 (PST)
Received: from [192.168.68.65] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2b4867sm31845185c88.6.2025.12.13.15.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 15:54:07 -0800 (PST)
Message-ID: <1286af8e-f908-45db-af7c-d9c5d592abfd@gmail.com>
Date: Sat, 13 Dec 2025 15:54:05 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org, regressions@lists.linux.dev,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Cc: =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
From: Rudraksha Gupta <guptarud@gmail.com>
Subject: ARMv7 Linux + Rust doesn't boot when compiling with only LLVM=1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello all,


I have the following problem: 
https://gitlab.postmarketos.org/postmarketOS/pmbootstrap/-/issues/2635


In short, what is happening is the following:


- The kernel boots and outputs via UART when I build the kernel with the 
following:

make LLVM=1 ARCH="$arm" CC="${CC:-gcc}"


- The kernel doesn't boot and there is no output via UART when I build 
the kernel with the following:

make LLVM=1 ARCH="$arm"


The only difference being: CC="${CC:-gcc}". Is this expected? I think 
this was present in the Linux kernel ever since Rust was enabled for 
ARMv7, and I never encountered it because postmarketOS was originally 
building the first way.


Thanks,

Rudraksha


