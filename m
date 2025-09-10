Return-Path: <stable+bounces-179194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196AB5159F
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 13:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6567171CF1
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE361268C73;
	Wed, 10 Sep 2025 11:26:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E03313526;
	Wed, 10 Sep 2025 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503601; cv=none; b=RxArgqRGYcRFInArNmJRRbT21e++eWv4f5ENiFjhc2QgoiH6F5ib49hJBQyCOpG/jSAg7B4EjWXLdVph8Jgcnx9TDihOSifTsIdXRmIimHdpqKrGjLmJwiLDD1XUrmh0UtOTV7wRMECoNMxuxrlVg18s3aOY5EfQ37G8wzuHmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503601; c=relaxed/simple;
	bh=9A/+Jl1iaYTBA92IVzHH5LyJ1K62t4u/S6c38+cVgK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J/J14m+i8eLZUtZ+NJCtCUkbwp0TATEuHLoo5Y8CT4XN+y3oTikXLGAGNdYjM7lxfJYP1Uojhp9JAUScb7zxx3sN/QQY9ad1hxgj9MXM0exO5MZ9JM+p6KmCKrZWBtfswfVW7dO+BrUqDPUWPNJ1tnq4GYEQKdsR7aj1F3yMFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4cMJKz31Ljz1r5hm;
	Wed, 10 Sep 2025 13:26:31 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4cMJKz0m5Fz1qqlb;
	Wed, 10 Sep 2025 13:26:31 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id g6C75_oYFWsS; Wed, 10 Sep 2025 13:26:21 +0200 (CEST)
X-Auth-Info: L8z1TJlNxCzTgyCseFs3gJOGQviCk5ZiscXQAcpoBPsvQ1tdp1edomGRnmNhfKfL
Received: from igel.home (aftr-82-135-83-103.dynamic.mnet-online.de [82.135.83.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 10 Sep 2025 13:26:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id E70C32C1975; Wed, 10 Sep 2025 13:26:20 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,  Lance Yang
 <lance.yang@linux.dev>,  akpm@linux-foundation.org,  amaindex@outlook.com,
  anna.schumaker@oracle.com,  boqun.feng@gmail.com,  geert@linux-m68k.org,
  ioworker0@gmail.com,  joel.granados@kernel.org,  jstultz@google.com,
  leonylgao@tencent.com,  linux-kernel@vger.kernel.org,
  linux-m68k@lists.linux-m68k.org,  longman@redhat.com,
  mhiramat@kernel.org,  mingo@redhat.com,  mingzhe.yang@ly.com,
  oak@helsinkinet.fi,  peterz@infradead.org,  rostedt@goodmis.org,
  senozhatsky@chromium.org,  tfiga@chromium.org,  will@kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
In-Reply-To: <cd9d62b4-addf-49c2-731c-ec7c89cbebc5@linux-m68k.org> (Finn
	Thain's message of "Wed, 10 Sep 2025 18:02:43 +1000 (AEST)")
References: <20250909145243.17119-1-lance.yang@linux.dev>
	<yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
	<99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
	<875xdqsssz.fsf@igel.home>
	<cd9d62b4-addf-49c2-731c-ec7c89cbebc5@linux-m68k.org>
Date: Wed, 10 Sep 2025 13:26:20 +0200
Message-ID: <871poesg4j.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sep 10 2025, Finn Thain wrote:

> So you'd have to patch the uapi headers at the same time. I think that's 
> "feasible", no?

I would surely be a big task.
 
-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

