Return-Path: <stable+bounces-98181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C0F9E2F2F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 23:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB17B2CD3C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914CA1EF08E;
	Tue,  3 Dec 2024 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="j+DuX1Zp"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E541362;
	Tue,  3 Dec 2024 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264613; cv=none; b=SVm7ZL6xvP4aG9TapRFLN8JA9gIKyyj5TAMM9u0ZozeIPWfTt5SOSWcuDhmwiOHJwVkyR6FzUK3w+jcZv7QfXzfjEumoKuYBV7yUCjMFgxvFefzkI9+sbgx9AJ9F+vAUn3GBhdfWhKCLNzbiVIO4J9Huj2XXtjAw6IuiU308Ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264613; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=IdMnE+Jl28L8q/OKvV+X/sp1UEue6Z+4M2kQC9q0T5eAtJDqR/OrebtBEVAb7rmWqdsrMRa197ufAjo1Ts4gefgz7vTq2e74S1Ji7VVtci7xzq6SvQRqFYPU42ht5qKaY13QjecPRfYZGBFfkLubpUEU2jcRX5rw8Q9snKZ8aO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=j+DuX1Zp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733264608; x=1733869408; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j+DuX1ZpuhSuR3eEpH15Lpv1eX3PFm53yqifuu+TdYr5iCNdXy2JwPLZzUwRKb+a
	 qLFdofznQe3DZDbeGxv15+/C45ga7xG8HNJyuIcXAqlAKPXtLfc1x++gE1N7NHg1j
	 UeuY7vX3D1HJ+TXu9IAlxizB6LDcW8GqqoRH9MfGiu8zoCqkZaj9BOhPUskDTja7R
	 okJLy+PPbrol0Pi1ZtLgJoST+HETVqS+lwsWa0tnEz3q21reBkw6M/CHjPZcOrXk5
	 dMb+q2A/kKnf6I/wqHhZ5aB7WcPqulK/tXEbzXNibsZRVUR+9mz+junS/Zhsswb/h
	 iaetVzQeOH2Tn/0uwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.32.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2Jt-1tvnsH0Fgf-00esql; Tue, 03
 Dec 2024 23:23:28 +0100
Message-ID: <c8c20fe0-1d10-4f00-b4f6-01932d38a41b@gmx.de>
Date: Tue, 3 Dec 2024 23:23:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.12 000/826] 6.12.2-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3XMzNL3KjUZEutgbuwbhDYaztaawt+swW0YxplPfznPqgn0sCWW
 1rJj28AHbAl2bmg0B6yguNgPMy5f+qEzwq/NbiVaRLtH4RgjMi170y3OE6LqtM0AYHgUR1T
 3WNqzTMyPElBQeXSbdAPhks2LefrvJh8Oe79HAPV681J9kw+d7aSqSg8x5ormBY4FeIUt9X
 VcM0TfI0u31cSP0VYdRgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b6LEmvoS6WQ=;IEBbLBYx9djby7S+zR1zeUMCxGn
 QkanmoQrMeRGIsIRBY0xeG3syt5+lKHVWb4vcy+jYGRujpei6E40F1QNZobRgtbaim/L2sEtQ
 A8nUsTZvlonTFI4aDk5AKgnIDRr6l2pR6vAcT591AdDO1OOJBdk5Zgy3cXmAzXuLRUlCeVJ9K
 cTupTVMqTrIOg/lfPD+XH4w+hf0b8vv5yoemgcC6nFfSeLSUn959tppwFB732zJQ47sWsMdgd
 dVnZFOjQtGEYC8Zgk3dMWvGH+46Vd/QTuj5nnaDSfP2N0xMYQJH2PNy7GXxMi+FiG+/y5inPk
 jsL77u0dNjfP2aqUcUscOseCSiPTLBzlYy/6P/PzHN+2amgCBxtJIVMwZHMtvbuyYKnNhs9Gb
 jsgaX8ZUhCGEhw0ItIMA8hUX/V8hHqBAVNWmSLrWxzIHtAs5oO/ogbcGxZj6uW9AOXiQJCqla
 FzIIHh96mjq7S14OUU7PzRIgV4ZzA/NUYWbvhUnLUpBrfbf8yoTIJ7+r7x6qVYPrpGnzw7H+t
 N/0GO1aNqM/7s+sVeN1gGrW3cx5vZnOR9un8LC3RgBzPAKTPQiFbW2w3HckElyyDxJz5ZDNNs
 5cxuA+wtEBkK4N0jiocBkk9ohKwLitFZ8GfhikZJG50nviqwwg/6pZkXdvxzkC1eJsSQK0xvV
 /xgcwGhVnrQN0BY3GPIjH5prMjPlC5qzf1cZ5YioEB4oOT8BWfUP8JSAysHNqKvNZdBujrgHP
 rtFeVip85WDWHjWJ9m5U/e3Wy18SyRW9MsQN046qO+1yPp9byaSKcDmqZ89Wt9D/30b2Iin4q
 twopUJsnlBqbY/z5XgKuEC8ikfyOX177X2am1uYvCaVLShzzjMPbv/PblslknmHcXOvxRW704
 q5s1+ZYaZJ4Hh8UtPIoRFjvzBMkxH0kSck6JoSVLQaIlJ3eIB9qkkK+g4vlyFSetym3i7cPih
 EDnZFAQtMxzYkoyCPr6zma5lPSqCw8N/T2brApgb720qSZSoQ1L8OHmh2QvI7KnUYBkSOF6Gl
 lZga16na0pOWlgOI97mecgO1jL4fJg2htpWCpRiBEom88FwV+Du41/d95RCT+PxrTh3e78dIT
 zQcJtB+h8=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

