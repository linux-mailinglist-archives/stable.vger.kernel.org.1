Return-Path: <stable+bounces-50144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C112903854
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 12:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDBC1F235B6
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC48A176ADA;
	Tue, 11 Jun 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="rXRkaTcZ"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9574FE57E;
	Tue, 11 Jun 2024 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100251; cv=none; b=uRlDoGu9NgotTPcOET9udlxOgsT0IFevl/p98MUhLmnzDbF5dQ8/NAGjJBJTC3fvdVVrCktw28vs9Qyc/1gfubaQKH49Qo3RrjpELyW9hKehtGy9xmWE4IrD/w7RfHBRhQvvrmV3mlcopnjSLggRDDp+Rb5Ox1vD8rzq43lh2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100251; c=relaxed/simple;
	bh=JA7fXFhBWz5d5wW447BlTNhXkv4g8AwEj63/2sbOFMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCPRPXn4O+SNVSTT21p0QfkW9dq6+r/Dx7LP2Dds/Z1hB9MP/u0KrmkbFuVSjTwhCE36k7Sjp0uitEKiTSqo9oahg3OHdyi+SyQTUEZQJz8ul5FxNlpnsv4GZiRA7mn60abjy+50PY0RJGkyWgYTopxXBGLqEE4s/8wabiTXUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=rXRkaTcZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=8F6YXkkTIEjh5AQeJ7ZK4LQi7I7Eu2h8Jzf6YsyQf/0=;
	t=1718100249; x=1718532249; b=rXRkaTcZPOJUYzIJwxf9+VWg3iHcmHyuUn2Jx+zMo2jwwgX
	DJ8jZibLZWQmsUquEgXP4/xGrSD3RhMgoBTXuCKRiE/2bylWs2CT3qzMxZwI4NJykKe/zyBRQ2gbQ
	/iGtTqBm9mfpBUZSXcrT7T4ZgsejHIKRLWhA8cS44ZmJhB4u+O8+F9wf5kJxv5GhnzxItKcSXhpwy
	2ec8xbGoeyTq3848kk86tYWozi4+wzS10SLGadAyJzVw6GN0n+aF1NcS4g9s9+BEL2J+djCY/EpXM
	jbLvkel9JNmfTN/SmQjUr8vGuSxwRndh73mmI76fIKa+Mt4UYLYE/cmUcWufrlvQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sGyMJ-0003Iy-Cp; Tue, 11 Jun 2024 12:04:07 +0200
Message-ID: <0936a091-7a3a-40d7-8b87-837aed43966b@leemhuis.info>
Date: Tue, 11 Jun 2024 12:04:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Segfault running a binary in a compressed folder
To: Giovanni Santini <giovannisantini93@yahoo.it>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, ntfs3@lists.linux.dev,
 almaz.alexandrovich@paragon-software.com, LKML <linux-kernel@vger.kernel.org>
References: <08d7de3c-d695-4b0c-aa5d-5b5c355007f8.ref@yahoo.it>
 <08d7de3c-d695-4b0c-aa5d-5b5c355007f8@yahoo.it>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <08d7de3c-d695-4b0c-aa5d-5b5c355007f8@yahoo.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718100249;5fbf9e90;
X-HE-SMSGID: 1sGyMJ-0003Iy-Cp

On 11.06.24 11:19, Giovanni Santini wrote:
> 
> I am writing to report the issue mentioned in the subject.
> 
> Essentially, when running an executable from a compressed folder in an
> NTFS partition mounted via ntfs3 I get a segfault.
> 
> The error line I get in dmesg is:
> 
> ntfs3: nvme0n1p5: ino=c3754, "hello" mmap(write) compressed not supported
> 
> I've attached a terminal script where I show my source, Makefile and how
> the error appears.

You CCed the regression and the stable list, but that looks odd, as you
don't even mention which kernel version you used (or which worked).
Could you clarify? And ideally state if mainline (e.g. 6.10-rc3) is
affected as well, as the answer to the question "who is obliged to look
into this" depends on it.

Ciao, Thorsten

