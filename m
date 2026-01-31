Return-Path: <stable+bounces-212951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJlLGho2fmnUWQIAu9opvQ
	(envelope-from <stable+bounces-212951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 18:04:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DCBC31CB
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 18:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 599093023510
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84F733ADA7;
	Sat, 31 Jan 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE0JQVSS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974E2BE03C;
	Sat, 31 Jan 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879058; cv=none; b=jpoY9ELhF+zMdFtN2UsGjmRXgq+TvwZIYnH4BEzZlVZ5FrX5juErajHpnAqIufuYE/MxBpODJJvZuzDUmdY969vEYWwoT547ZqoPU0bsu3SHgqQ3b9iGG1k8SWDDOywibiZzZs7If3TE1QIE0BC07mWJtTLTmlDkgdpQch6RJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879058; c=relaxed/simple;
	bh=jlB+kwgAkIlez8BwqL0u7DAQRDxGufRgMdv36ayWNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEAfrtbtwpLixv7yCJSGn70xXGLxAK2AJ33323Reje27XOUwvxFjqi/EFdF7FykeWzyHQMDI+sHwZb/2JglriUYfNlrwW/Qu5dTEfRh0/wS0s6VYoqOuoIfwa9/MOokqfCSYCUZbIHqO6ttYr535YAk44Ei2pqXoZz+pksvNSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE0JQVSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB34C4CEF1;
	Sat, 31 Jan 2026 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769879058;
	bh=jlB+kwgAkIlez8BwqL0u7DAQRDxGufRgMdv36ayWNTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UE0JQVSSKsR+FHNS9aJMBffynYkJ5BWSTLJ46OZLUAHAhpWn27ofvGip4cxeIMGKj
	 9oC/Hi40wsz8xTIhzDCV2G+fQaTEP7r7H3qdqN/feqlGZrC6HQ0Cc337DSLado1B1U
	 n3IxUgATe8WZAl0l7yKkpgfHfKRGoDwoRC0ktKgUbN0t2F7vUCeKxgI9Iw0ZElCBzp
	 Eys3GZf3nE1ZN50UrhYyy+sgV8orTP4hZfZytlZe0YpWZddw1IehNelsxlKRktvtOk
	 Xu/BGuwWKmgeFRK42QjqjecYd1hPYcbkSsOL679RHB0ZPPGOY0ghwSKX6iXK0bSlYL
	 Z+/6SgWFzSw7A==
Date: Sat, 31 Jan 2026 17:04:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix odr switch when turning
 buffer off
Message-ID: <20260131170409.328060fd@jic23-huawei>
In-Reply-To: <20260130-inv-icm42600-fix-odr-change-when-turning-buffer-off-v1-1-f76fc3604bdc@tdk.com>
References: <20260130-inv-icm42600-fix-odr-change-when-turning-buffer-off-v1-1-f76fc3604bdc@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212951-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,jean-baptiste.maneyrol.tdk.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tdk.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3DCBC31CB
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 17:10:23 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> ODR switch is done in 2 steps when FIFO is on : change the ODR register
> value and acknowledge change when reading the FIFO ODR change flag.
> When we are switching odr and turning buffer off just afterward, we are
> losing the FIFO ODR change flag and ODR switch is blocked.
> 
> Fix the issue by force applying any waiting ODR change when turning
> buffer off.
> 
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Cc: stable@vger.kernel.org
Applied to my local tree for now. I'll rebase on something sensible in next
few weeks then push it out.

Thanks,

Jonathan

