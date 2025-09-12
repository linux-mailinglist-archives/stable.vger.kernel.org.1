Return-Path: <stable+bounces-179386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FABB55409
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 17:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DDDA0377E
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D22264C7;
	Fri, 12 Sep 2025 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vYHl0HmB"
X-Original-To: stable@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64821D3F5;
	Fri, 12 Sep 2025 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692029; cv=none; b=dmFz1U2GbvaLZSYGBv8OBbU4QgKaRPBHOFbpy1wY5PS/4742OqedmoPgaFjh609ZEk/h7s97PqBKiiueDSmIn6DH56E3hWb3HiV5uUYZwebJM6gdZvkAfmcirVWKAA7kryBq1Cp+NIcr2Oi+RawqpG+RfZoY+VYwmMSD1LfLu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692029; c=relaxed/simple;
	bh=KV9fPRdJJi11XK23xc1n6iiyjQO6SEMZD22HfaRPNi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hB6iNPmGPgnz1Bbaqe681hFcw1gLexw3ufMpORCjXWuZH7chs6x3+CrTe0EwNMJ83vKdp2Hj7L7FQ/FzvYu8d2tnXeuOgeaGYQ0PEa/HMRGC1O8DA6JB5XV02Nka78I/wj073GK7Xz8We+o/Efb3Ixvkk3U0igfV7nxoTlvj6Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vYHl0HmB; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cNf1k6d6Dzm174p;
	Fri, 12 Sep 2025 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757692023; x=1760284024; bh=KV9fPRdJJi11XK23xc1n6iiy
	jQO6SEMZD22HfaRPNi4=; b=vYHl0HmBmRwdAYGZeNrHzYRpEIUS0QF8lpuHG5u2
	SECQVYGByIz595cOUy2X3nMVeQP4wA0ceSv08Xk5Sb7tm++MKSlGz7ig9CPXPHWq
	bHgT6wsc3bf0gkEb21vvcq7gDnzqGv27qrDOiMypzP6u2SMpgyxELctcQ1sPcSb5
	pDPRnA2Fb0K8+fL6d5EdS78YcLLKIdtB5/s/dofO6tz8vmPGaOfGMDbZPZiJBzW9
	zyvzxybwV2PV4/OWkhlocwTVXKVvdIuuLWhvh/2paB92zak2OOudhWKOGeZ/qP8K
	x/a+YHwVhnhAlyK+KEocWp0fdIUqUZqU1NkVRRd+MS857Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Aa2NVnjuFGVG; Fri, 12 Sep 2025 15:47:03 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cNf1N3BLwzm174V;
	Fri, 12 Sep 2025 15:46:47 +0000 (UTC)
Message-ID: <39fa7ce5-1d58-456f-a58a-907aaa59c9ab@acm.org>
Date: Fri, 12 Sep 2025 08:46:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4 5.10.y] overflow: Allow mixed type arguments in
 overflow macros
To: Eliav Farber <farbere@amazon.com>, luc.vanoostenryck@gmail.com,
 rostedt@goodmis.org, mingo@redhat.com, natechancellor@gmail.com,
 ndesaulniers@google.com, keescook@chromium.org, sashal@kernel.org,
 akpm@linux-foundation.org, ojeda@kernel.org, elver@google.com,
 gregkh@linuxfoundation.org, kbusch@kernel.org, sj@kernel.org,
 leon@kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-sparse@vger.kernel.org, clang-built-linux@googlegroups.com,
 stable@vger.kernel.org
Cc: jonnyc@amazon.com
References: <20250912153040.26691-1-farbere@amazon.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250912153040.26691-1-farbere@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 8:30 AM, Eliav Farber wrote:
> BarteVan Assche (1):

Please spell my name correctly in future emails.

Thanks,

Bart.

