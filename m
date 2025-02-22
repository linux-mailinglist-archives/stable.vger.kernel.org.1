Return-Path: <stable+bounces-118673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEA1A40BA9
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 22:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E2F18985B8
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 21:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ED11632DD;
	Sat, 22 Feb 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finder.org header.i=@finder.org header.b="qDpxXn63"
X-Original-To: stable@vger.kernel.org
Received: from greenhill.hpalace.com (greenhill.hpalace.com [192.155.80.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218DA2036F0;
	Sat, 22 Feb 2025 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.155.80.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740258827; cv=none; b=Z5VOubBsVF23iM7UYwC+ioRhXRAcgk7LOUVB7An62UXbZRm9V5sDzJCvpd5wbsLHVM4kIXLIi2iOnIT467Nj2+8yK4S/CntXaz+wVcDRrBhnz51Q7pZQdlqH3Pt2WNxgLQDGwRiOm33MOmuCsspOomYbH0nt83wT4KCR6Re9Sz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740258827; c=relaxed/simple;
	bh=o/x1hdw9Aw2nr0C9JEL0Jjs2LvEUh9Qcolc273fdpRI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p5igNrIcovJd4s9yBa2rDYWmUFlyriSeXc9hSU3EvU6g/5LDMWXhn74au3sXzC1LFIe+FIjuV1f4IoVt/AAIZSecVkJ/sA+Z23q9SkoTvyDltLJyoKv67zOMUDaxSEGkEKBAm3kNgzY9HsaqiyaACPqDgvgxWnQ1oBbNUhDupic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finder.org; spf=pass smtp.mailfrom=finder.org; dkim=pass (2048-bit key) header.d=finder.org header.i=@finder.org header.b=qDpxXn63; arc=none smtp.client-ip=192.155.80.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finder.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finder.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=finder.org; s=2018;
	t=1740258470; bh=o/x1hdw9Aw2nr0C9JEL0Jjs2LvEUh9Qcolc273fdpRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qDpxXn633joOKC7+I1+WrBmclkSJNJW2m9HDYu8NfPQoHsEzTG30f0cDXZEfWCcOP
	 9YVuUbhnoMisR76s/WG9sgv650ctiCMZx/zIV2ncsteTMd7/QQIL3Z0E0gKCWFxNv9
	 dZbtHRKo55Hb/YNG9DWKXJ4qMe5gGJj7KjGCkEEaVrikPub7krsIz9NdoqQi2giNEv
	 NxBY3tQM3ghlOIuxvyVxcqSmiuNCT2tPVjKRSiiEwc1a2woWxEEcGh7HIhNfQdfg2m
	 EwDWKi1SjQ5tkmJtaGAP59BZAnYfjRvZ7PeGkp159sCz+EVeUykEKXNzWGUCAC51GF
	 EahrsjSRMNXTQ==
Received: from mail.finder.org (unknown [192.155.80.58])
	by greenhill.hpalace.com (Postfix) with ESMTPSA id AA819129F;
	Sat, 22 Feb 2025 21:07:50 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 22 Feb 2025 13:07:50 -0800
From: Jared Finder <jared@finder.org>
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: hanno@hboeck.de, kees@kernel.org, gnoack@google.com,
 gregkh@linuxfoundation.org, jannh@google.com, jirislaby@kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without
 CAP_SYS_ADMIN
In-Reply-To: <20250221.0a947528d8f3@gnoack.org>
References: <202501100850.5E4D0A5@keescook>
 <cd83bd96b0b536dd96965329e282122c@finder.org>
 <20250221.0a947528d8f3@gnoack.org>
Message-ID: <491f3df9de6593df8e70dbe77614b026@finder.org>
X-Sender: jared@finder.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-20 16:10, Günther Noack wrote:
> 
> Jared, can you please confirm whether Emacs works now with this patch
> in the kernel?
> 
> I am asking this because I realized that the patch had a bug.  We are
> erring in the "secure" direction, but not all TIOCL_SELMOUSEREPORT
> invocations work without CAP_SYS_ADMIN.

I confirmed that Emacs worked fine with 6.14-rc1.  My understanding is 
that the Emacs process relies only on TIOCL_SELPOINTER which it needs to 
do to draw the mouse pointer after Emacs' redisplay.  It's fine for 
TIOCL_SELMOUSEREPORT to not work in an unpriviliged Emacs.

> If this specific selection mode is not needed by Emacs, I think *the
> best thing would be to keep it guarded by CAP_SYS_ADMIN, after all*.

This sounds good to me.

Reading over a documentation proposal for TIOCL_SELMOUSEREPORT 
(https://lkml.org/lkml/2020/7/6/249), I can not imagine how a userspace 
program that was not acting as the mouse daemon could successfully use 
SELMOUSEREPORT as the mouse daemon will be fighting with it.  Any 
legitimate setting of mouse state (for example, setting the mouse x/y 
coordinate) would need to be done with the mouse daemon in the loop, in 
which case the mouse daemon might as well send the message itself.

   -- MJF

