Return-Path: <stable+bounces-106799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1199A02258
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18271630FD
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDA11DA112;
	Mon,  6 Jan 2025 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="H6G+hVW6"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE91D935C;
	Mon,  6 Jan 2025 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157607; cv=none; b=XoyKVllFICVzhz9avzGOzSlJQWLrkEDUadEXZVQLon6hyNW3Ga3rqRTHsZwzLjBYrApAKkevNRMlvGPbONof/ZpU1gQ9p+te3qhXM1wc2FzkVD9xlIgw5dhHqADy4LOUozMOU0adqS6PfeDz1rbjcJAA0i2ziaHbs2hxKnDjspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157607; c=relaxed/simple;
	bh=odrdTO5O0rEniTcE1eV7WzfcuDhinmrYoT91areJi24=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=G+TY7q8RRrroKSRzGV1zhje/7svM717+9yYgmnZcHv1GWPYzBUqilRGtD5tTwYxkivFJy5Yr2VKRMtMBC0iWg0pWxWBHypY3FjuA7FbuyZr35coGBVykDmsUf42DkZx2JyRG9h1VYphl4GY8z8upN/deXG67g6Rbp/zdXU5Hnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=H6G+hVW6; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736157292; bh=No06V+8q8JBfJr+GfYmrVNeP1TRqGKgHXiwOwFF1FP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H6G+hVW6l4Bs+LhwEJJJ355nA223im7jvAK1VfOrRRg/UrGOE+VfzNyTnEegYbH90
	 6Mz3I1wEAv3R8fu4cAdscyEyrJxOZxe5hNzG1BjOgtc4S+s7AbkR0woZ4pX8zp2yqZ
	 dZ9y2hLyDPUpRuCtoM6LbIKkX1tCjf1VCAaTY0vI=
Received: from localhost.localdomain ([101.227.46.164])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id C2902420; Mon, 06 Jan 2025 17:48:41 +0800
X-QQ-mid: xmsmtpt1736156921tcpukmmgq
Message-ID: <tencent_C5D662949D58221F89531E4CC3CE72879507@qq.com>
X-QQ-XMAILINFO: NnA3IMNPwBd+w/Yg1uKuc/Ew4ioUNz+bURqbe8urInqzl+oq1pi4fpDds/i+Y8
	 /1PlJPF+nhxfkeoXv6giLUYUjkvULTCI0qRxw1IKU+ESV7REOj41O1LVVxcrzsS3CxXu115+nYWl
	 ONFmsnQu2Fd0wJaBxVXzI5Rsc+tXIhVQSvBJezjnwTZb5ie+LbO05GIl5Y0b325VhkOJS8xfbCwL
	 dJus1EQwaszpBzqgTHYjbkT7hh4BUvgE44gobqLa+ImEpwtA6uNwWDBplkU9+g4lIkHqPqCLxIKt
	 8GAGtdWfWIH9V3wQPHx/HfZuFJE4WRWeiRdXUp8bxgfUmR5SM1iZKFw+9JTg8Or1UvcP3835LwjC
	 oVJgx69BFFx3ny+3ZMae5cH9+BdMURJEaOCSMkiZakHKztMLKgi7YHxtuFJI9EEZ8Z3S4VuVuOJK
	 OMDyoeAcseCf8rDujwd2LILSzDmykqzdo+qkAgvoPpPZX1FMx/7TvUoHUdpmaN8rxFz6Lsl43TNx
	 Y1MGjTPNEoGjbqo84WLsxlKcep8naUBlALo6pi4g86pBVBSpcRHEVI+zEJJpWiv8P1eldiCBohKW
	 NvH0Rx0Kvce8twWL0ubtKzFodL3T5Y01I6HsoW5WusskIGCiDV3FR3YqL8BII1e1uGnGANLAPEYl
	 kAdV9KK3xYlPmNbnVkhOWhx9mArvndeAx/2ErZBNv4ZGUN4JZiVo/ktY7Z8w9sCtm2rPYzm79/6b
	 /aOzbUszkpS653kAO7cqfdKh6LUQCLHz1IzkI1yep+q+sHh//9ZfLz4dHEitQQwGzcNIg2UKCAmR
	 AFPWWiP3NG6Dt4s/iTzj5QdgQb/5Ulru+04LEJpg5IisYXMfY/W1aSXJA6hxMK1grqKVp7v7+3nt
	 9cNUH+w7ZeURz2bd9beUI3EfpQD8hhEdlnznGQ1V67Ud/n1IFnws5fuKpi+jntO3ZSbvyDK/9/38
	 /R1/OtdylHioG3tqU8Rn7sA557aJKmqOClf8EBjAv0GWr9DlavQyrwwbP7QfT4d38Me6krlu0EDv
	 DZWC1jZDwPRcJlqXX03xGAGX0cS6wcKq3Zzq3T1g==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: wujing <realwujing@qq.com>
To: peterz@infradead.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	realwujing@qq.com,
	sasha.levin@linux.microsoft.com,
	stable@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH] sched/fair: Fix ksmd and kthreadd running on isolated CPU0 on arm64 systems
Date: Mon,  6 Jan 2025 17:48:40 +0800
X-OQ-MSGID: <20250106094840.123528-1-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106092134.GA20870@noisy.programming.kicks-ass.net>
References: <20250106092134.GA20870@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reason this issue does not occur on x86 architecture is that x86 does not 
use the `select_idle_cpu` function for core selection. Instead, it uses the
`select_idle_smt` function. However, there is still an issue on x86 where 
isolated cores are not properly excluded. My other commit, 
`sched/fair: Correct CPU selection from isolated domain`, addresses the issue 
of isolated cores on x86.

> Your subject explicitly mentions arm64, however there is absolutely
> nothing arm64 specific to this patch, as such the subject is just plain
> wrong.


