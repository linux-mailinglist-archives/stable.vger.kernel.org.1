Return-Path: <stable+bounces-35668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801E28963A7
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 06:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E641C2291A
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 04:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9B45033;
	Wed,  3 Apr 2024 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ir77Ox59"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7D1E880;
	Wed,  3 Apr 2024 04:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712119928; cv=none; b=cMmFUMB/Mcx5nX/nmlg3KC68c0Cx6B5gutNdWqpkIcr3D4gCN3BxCFPJeS2HjCiq4IlTu0yWr1oFdvS2ixspZrgcgCPtJDcVZsgyAVUB+pQf3AvCYsNzKaptz7MFkgpg+8UAyXgr/IyxsBRiAGsvsFsHYBj1r8Kvh+Z+lIlv5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712119928; c=relaxed/simple;
	bh=HjWz+wrhQZWOxkhtG2eQHIwiIQec0U5IjvCE6DtPmXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLk7G/VPm8OsIGdlY3Bafn0fpefQoPdQ8k00P2rFVMENYQemZhfhCYnFnU3Hcs50JDW2K4FbSKl2Y+lRQeRvFD3aoRsAl12YiEN8FMpzLj0Smhdmr005W2hYKq/dB/bhWTJoIpiOHR1VfRYZONo8iXOR7yNq7tpa3c72+/0tWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ir77Ox59; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=cumeZPLijOws/f3XrvSs/sKDGxSA1biY6ym0h1mUbdU=;
	t=1712119926; x=1712551926; b=ir77Ox590+NgwbNQ/Ls0mRyB4o6+PjqCZVLG/DRKN2Aarq4
	DpXzWOnNsmvxLjaAHEK2Rjy6xt8JGDdDNC8/ojEkZ6L0g534i2b349sMLcGurZvfowZcNn/HefrGQ
	aIzSYYO5n4en4IOwFpS18GFaxM+Os8/jLxdVfCkutdykvTtb3wRgmRJKbYnpGilfO8WmcCoBZiXBk
	Z64nti3iGQ5Yh+2FZ1x/Lw7jzfZjrvzTjFy437MkSWQJDCDA5RjMBn1K1/66hTpMvSsId6Eb+mCnc
	6BRpaR4tCVSSSiC8vDXDhvv9usrWqsLpFvvMMpsp40137OWOdWY6SJwkSaVWUJ1w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rrsbU-0001fp-Mf; Wed, 03 Apr 2024 06:52:04 +0200
Message-ID: <2ad93b57-8fdc-476e-83b7-2c0af1cfd41d@leemhuis.info>
Date: Wed, 3 Apr 2024 06:52:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.7.11: Fails to hibernate - work queues still busy
To: Martin Steigerwald <martin@lichtvoll.de>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
References: <13486453.uLZWGnKmhe@lichtvoll.de>
 <4912750.31r3eYUQgx@lichtvoll.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <4912750.31r3eYUQgx@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712119926;a1a2ae22;
X-HE-SMSGID: 1rrsbU-0001fp-Mf

On 02.04.24 22:03, Martin Steigerwald wrote:
> Martin Steigerwald - 02.04.24, 21:29:50 CEST:
> 
> As written I am willing to bisect this 6.7.9 versus 6.7.11 issue,

The last 6.7.y release is under review, so that likely is not worth it,
unless you are lucky and that way find the change that broke things in 6.8.

> but not
> 6.8.1 versus some 6.7 issues cause I do not want to risk filesystem
> corruption on a production machine by bisecting between stable and rc1.

As mentioned in the other mail just send: I don't think it's that risky
as you make it sound.

Ciao, Thorsten

