Return-Path: <stable+bounces-211781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHP1AXO6eGmasgEAu9opvQ
	(envelope-from <stable+bounces-211781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:15:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5288794BAD
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1F99302BDFA
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C88035295F;
	Tue, 27 Jan 2026 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kxxt.dev header.i=@kxxt.dev header.b="ZODZwldz"
X-Original-To: stable@vger.kernel.org
Received: from mail.kxxt.dev (mail.kxxt.dev [74.48.220.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A8221ADC7;
	Tue, 27 Jan 2026 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.48.220.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519723; cv=none; b=tLqYzqFuTRH1P/xw6xYjTXG5KQTYQqn4+m2B2c34QfkCmncu/yNIZSiXWnXtye6ejwVLBDtoqIS2yMgsG7RVKe1TFoiT8bco0zaI3t8E8PVFEvPIKEB1PSXaEZV5sPT8t8/uk8sJytXVo8G40/7Wg+E4VwLnvn5qZyDyOkxZLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519723; c=relaxed/simple;
	bh=mFButoGHQZcrOyrgWBvTDZrcCDzB5RoEFmjHO/hbw1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFTfsxDqhP1lIE11kY8BR+3xcA7gdebO5fPFd/zSMg0yTAM40ky/tabAdCzHXBcwzCc4weK+TN+GasYa+8mFalNAtcYcPnxTAapvGJdDo8rQQo7JJaz+bZJ/geGHDoRArUDq6wARc1xE2zIm+CZlGZEDJHWmWVIJn/9B47KRIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kxxt.dev; spf=pass smtp.mailfrom=kxxt.dev; dkim=pass (1024-bit key) header.d=kxxt.dev header.i=@kxxt.dev header.b=ZODZwldz; arc=none smtp.client-ip=74.48.220.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kxxt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kxxt.dev
Message-ID: <b07a1e07-9265-4b77-9665-0bfae9b506d3@kxxt.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kxxt.dev; s=mail;
	t=1769519392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTbWecwoErc7fpelSZ8kiImPL5MfmGQxCTtL9RFgpUc=;
	b=ZODZwldzPkeme8lmvl0AHh2DB5PSVZ/Fbs7CTXIcpCmm7FQlRU8SwK0dBYocITFfpoiF0W
	KVS0yUe4KBh3nz/Al2Qx5wCuGoJHgbC7Tdsn4vEFELLKqxXIJE2Cdkb2dC0nSo5ERU5kei
	5YTtjtxLqOHP/3w3Tn7fhHiUU4C4v1E=
Date: Tue, 27 Jan 2026 21:09:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] scripts: generate_rust_analyzer.py: avoid FD leak
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boris-Chengbiao Zhou <bobo1239@web.de>,
 Kees Cook <kees@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Daniel Almeida <daniel.almeida@collabora.com>, Fiona Behrens <me@kloenk.dev>
References: <20260122-rust-analyzer-fd-leak-v1-1-945577813b20@kernel.org>
 <CANiq72=+2s48M5imZ7tZj-0SN==f_mLmw_2cWfQYKtBhD1ROCA@mail.gmail.com>
Content-Language: en-US
From: Levi Zim <i@kxxt.dev>
In-Reply-To: <CANiq72=+2s48M5imZ7tZj-0SN==f_mLmw_2cWfQYKtBhD1ROCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kxxt.dev,reject];
	R_DKIM_ALLOW(-0.20)[kxxt.dev:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211781-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,web.de,vger.kernel.org,collabora.com,kloenk.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@kxxt.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kxxt.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[python.org:url,kxxt.dev:mid,kxxt.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5288794BAD
X-Rspamd-Action: no action


On 1/26/26 10:09 AM, Miguel Ojeda wrote:
> On Thu, Jan 22, 2026 at 5:44 PM Tamir Duberstein <tamird@kernel.org> wrote:
>>
>> Use a context manager to avoid leaking file descriptors.
> 
> This may have been intentionally written like that for simplicity,
> since I think CPython closes them immediately in practice even if it
> does not guarantee it (and I think the kernel may be assuming CPython
> given the version requirement?).

Path.read_text from pathlib would be a better choice for keeping the simplicity
while ensuring the file is closed.

https://docs.python.org/3/library/pathlib.html#pathlib.Path.read_text

Best regards,
Levi
 
> Nevertheless, it is better to be explicit and proper, but it is not
> urgent, so I would say let's put this in rust-analyzer after the merge
> window even if you end up considering it a fix.
> 
> Like in the other one, I don't see the Tested-by from Daniel, so I
> would suggest taking the chance to double-check that meanwhile too.
> 
> Thanks!
> 
> Cheers,
> Miguel
> 


