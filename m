Return-Path: <stable+bounces-197631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB46BC93143
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 21:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633C83A47B7
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FEA29BD8C;
	Fri, 28 Nov 2025 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="zNpc2ppi"
X-Original-To: stable@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E51DF247;
	Fri, 28 Nov 2025 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764360422; cv=none; b=oJHr0Np8ncCbQNad9h1Eq2+W2noiRKGssbomEbcVnO/lRPwKctAuNVl1DB8+3u+rhEsfHDSmZmPQIt0j3pnd1jCaWgf1Uc9q6AdE98CXQlRGMfxRcwYHR4kKBtItz+ueAThbXhrtcyAgKWIHM9eqpDBV/rrUWctC+YCC4MJGkWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764360422; c=relaxed/simple;
	bh=qGNzLEmb2symNIdXq9Iwos9nQfPWO9v6NM0mYWw7o7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDcPlElcLkw5WY55x/YTYYx975ShyHGMlw1okEUpiJox0z5nXBDzjuCKdl1euJNSg5aatSmCSaduhd4XL6fUb7hLk4obDdxGFYJHumfCOYv5a/w5IaKcDsEd/RxWDRT0k9UAy5vAY8eesm07J4lyK7qwTAhjBOdDg3JLL4hD32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=zNpc2ppi; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vP4k4-00Gpyj-OB; Fri, 28 Nov 2025 21:06:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=I7BKHMMwUpeKqB5xaGT84hYRuLD6WsDJzoIupwwd274=; b=zNpc2ppiFbE8HAUSsP3h0mDNR2
	+xhP5lUEAi0dFJEQP4P3q9uidnbzJ3jAHcw2wBP/eepBZceUoBmQVbYOOQjHenIWpqRsv7Z/G/OD1
	y6HIaFodhiMBBh9bRwTnlj8jJpavXf4qbG4NCyBaCEFn/z0CqV/OaoG2WKgMdi+OFUIrDXghEAZpE
	XcVBaeLwSY2NqSo9hIINS43xVYcYsapWPdEr76n5YqkVbUHrPyDCWIsc+FPId6WpdBZGaSPcuJUgF
	1LMPJrHZEGhT3FCMWDC5I472lwU5JhsUeLEfjuwqt4DSnPB8uG3VVHJ3SzfHXJ81AQnH2qN32PRoy
	1UsLy19g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vP4k3-0005bH-8G; Fri, 28 Nov 2025 21:06:55 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vP4jr-001NQf-1y; Fri, 28 Nov 2025 21:06:43 +0100
Date: Fri, 28 Nov 2025 20:06:34 +0000
From: david laight <david.laight@runbox.com>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max6620) Add locking to avoid TOCTOU
Message-ID: <20251128200135.26000eed@pumpkin>
In-Reply-To: <CALbr=LbzgLK7Y-e3TTpusXGZEq4+DJJ=mbVMP=M3gt6XDGNUGA@mail.gmail.com>
References: <20251128124351.3778-1-hanguidong02@gmail.com>
	<f5a0e99d-306a-4367-8283-b5790a74dfcb@roeck-us.net>
	<CALbr=LbzgLK7Y-e3TTpusXGZEq4+DJJ=mbVMP=M3gt6XDGNUGA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Nov 2025 01:59:51 +0800
Gui-Dong Han <hanguidong02@gmail.com> wrote:

...
> In our previous discussion, you also suggested adding a note to
> submitting-patches.rst about "avoiding calculations in macros" to
> explicitly explain the risk of race conditions. Is this something you
> would still like to see added? If so, I would be happy to prepare a
> patch.

The real problem with #defines evaluating their parameters more than
once is just side effects of the expansion.
Even if the current users just pass a simple variable, you never
really know what is going to happen in the future.

There is also a secondary issue of pre-processor output 'bloat'.
This happens when large #define expansions get nested.
With the current headers FIELD_PREP(GENMASK(8, 5), val) expands to
about 18kB [1] (even though it is just (val >> 5) & 15).
I think one of your #defines get passed one of those - and then expands
it several times. As well as the massive line, the compiler may well
generate the code multiple times.
(CSE will normally stop foo->bar[x] being executed multiple times).

[1] Nothing like the 30MB that triple nested min() generated for a while.

	David

