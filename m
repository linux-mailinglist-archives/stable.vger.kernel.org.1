Return-Path: <stable+bounces-179165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE84EB50EA3
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E9D1BC503F
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 07:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410502C11F1;
	Wed, 10 Sep 2025 07:00:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4A1DF99C;
	Wed, 10 Sep 2025 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487642; cv=none; b=mn1Rl9ey71i3Jp6PIG3KR2oMyxxohYdO3noiLfnpw4V7mz7XVHf+3s6VN9zQNY5VYAMwlL8mu3kez0494m4Mh/QNp8s1vl9lUEbqKQDikQQ1/ESnWgrzQiYPKTUCDMxQVt+TPU8PdzC4tmFzKNbcERZMM1d2bXA23e/OEgh5+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487642; c=relaxed/simple;
	bh=O5vcD4Ldjc71ve0d02RfmDHc6hlfFFueKhpbZB+vRrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WToCNDB6gbWmayAglbszjUULBzYCEYzh3lsqldJERpuBkGwyE/PyBUy5VGh83UEebqMiUoNxNXYqAd8VxdOi2z057TEQxK8VSmSe1U7FVJue/mwsKTFjfA9AL3Fy9fTcpAiqQaYRi2wdC7C+052zBjI+1eE77ciKMGLcrc5SSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4cMBFy3BPqz1r5hQ;
	Wed, 10 Sep 2025 08:52:38 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4cMBFy0d40z1qqlS;
	Wed, 10 Sep 2025 08:52:38 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id r6oSkNIfIRpU; Wed, 10 Sep 2025 08:52:28 +0200 (CEST)
X-Auth-Info: GsbNNI76Sv79L7YvGPmcrwtzn4oM1W/t9R3+pP9F4xssEftMcVyEECTVPJd+4YJQ
Received: from igel.home (aftr-82-135-83-103.dynamic.mnet-online.de [82.135.83.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 10 Sep 2025 08:52:28 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 1C52A2C1920; Wed, 10 Sep 2025 08:52:28 +0200 (CEST)
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
In-Reply-To: <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> (Finn
	Thain's message of "Wed, 10 Sep 2025 10:07:04 +1000 (AEST)")
References: <20250909145243.17119-1-lance.yang@linux.dev>
	<yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
	<99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
Date: Wed, 10 Sep 2025 08:52:28 +0200
Message-ID: <875xdqsssz.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sep 10 2025, Finn Thain wrote:

> Linux is probably the only non-trivial program that could be feasibly 
> rebuilt with -malign-int without ill effect (i.e. without breaking 
> userland)

No, you can't.  It would change the layout of basic user-level
structures, breaking the syscall ABI.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

