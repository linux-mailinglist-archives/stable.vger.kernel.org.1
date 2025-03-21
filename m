Return-Path: <stable+bounces-125757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D949EA6BE9B
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 16:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE9C482154
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4E22ACFA;
	Fri, 21 Mar 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=glasklarteknik.se header.i=@glasklarteknik.se header.b="lygATNJo"
X-Original-To: stable@vger.kernel.org
Received: from mail-01.sigsum.org (mail-01.sigsum.org [91.223.231.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A281E22FA
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.223.231.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572016; cv=none; b=LpgYjtTYDrxmksdmd1QcoN3WpyBPWkV34cLeNkvYSWxGCEG2s6vMfy1BULUtlNJ5eH9G9o0QD5rGjrWbEUB9tuzIDKEuGkmgew0s+t+NB5dw7EAZ46eH5sCtCU3hvIGhlyiM+SzryXbWsSZbiy/2E8PouKB+Sqv6SsLm0qbUrO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572016; c=relaxed/simple;
	bh=l5uXOQgUtf9vCYbWInTQrj8XEm/DQMTvTvhEflApOHg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=W31WfKyREQw5IXbs1bOUqqy0ZLir59MFoZn/qN2cl3iab89ZFgMsOXL6KrhIgcRn4a20IYOyz48BG04BjGUMy+YEXiU0ZQWLBpvq9/+xS1pdaXfpoPvOQ/+H6dmrVeFj51Img4YtnwepJiFh/eFA7DL5mPQPvyveZHfR0bUWAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glasklarteknik.se; spf=pass smtp.mailfrom=glasklarteknik.se; dkim=pass (2048-bit key) header.d=glasklarteknik.se header.i=@glasklarteknik.se header.b=lygATNJo; arc=none smtp.client-ip=91.223.231.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glasklarteknik.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glasklarteknik.se
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E3CCC13C8;
	Fri, 21 Mar 2025 16:41:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glasklarteknik.se;
	s=dkim; t=1742571687;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=luqQiyuyjNAsw515KM4PvvMhNhUysTYJueyAxpe0yug=;
	b=lygATNJoRFpCcBPZcqZ5jOsFBYAu0MqpGNT7OULyMBgUr16YQySZeU2yKf5xjiCvxEzSX+
	tV86wwUevzDxyNtCg+8N5qcE7VjULqbtSmywi1d12pkOUfF95QUmcvtF/JqwQeI7mNnOHt
	qduse6qPmJfM6i6Bx0oXOPc6t2tED4ohRfdCZR9WCbJIAkcBtgxcW2qSsxD7FqdA3kJhm6
	AwTTZOm0N+1VqP+1Hj4SsTsrj35lfKOUyPogBsZvU75iau7uiWwLthk9pUJfkb4wLnBYIg
	ILNsmTrOpgKNL/w3yyPF/59tmBolmIwgDXK/O7LbxzTjQWZ/mcJqwwoCr5iPnw==
Message-ID: <c368b604-9022-470b-8c23-60bf53892cb0@glasklarteknik.se>
Date: Fri, 21 Mar 2025 16:41:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, kexec@lists.infradead.org
From: Elias Rudberg <elias@glasklarteknik.se>
Subject: x86 kexec problem in stable 6.1.129 and later due to change related
 to PGD allocation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

The following change seems to cause kexec to sometimes fail (not every 
time but about 50% chance) for the stable 6.1 kernels, 6.1.129 and later:

6821918f4519 ("x86/kexec: Allocate PGD for x86_64 transition page tables 
separately")

The commit message for that commit states that it is dependent on 
another change "x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating 
userspace page tables" but that change does not seem to have been done 
in the 6.1 kernel series, which could explain why the 6821918f4519 
change causes problems for 6.1.

This appears to be a problem only for 6.1, for the 6.6 and later stable 
kernels there is no problem.

I think the reason this problem is seen only for 6.1 and not for 6.6 and 
later is that the change "x86/kexec: Allocate PGD for x86_64 transition 
page tables separately" relies on things that are not available in 6.1.

In the tests I have done, kexec is called via u-root.
More details are available here: 
https://git.glasklar.is/system-transparency/core/stboot/-/issues/227

Cheers,
Elias

