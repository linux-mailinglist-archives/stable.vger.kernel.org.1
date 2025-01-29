Return-Path: <stable+bounces-111116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00578A21C80
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AF188338A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9F11B6525;
	Wed, 29 Jan 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qvgLM2nP"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9301DDC01;
	Wed, 29 Jan 2025 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151576; cv=none; b=CYGVlzbnM7khgVjsZ+tEL8fYidn+E+QRLLrh7Cz+cKaXI4FMEUB6MSfstSAxGaeFwzCT+9iYnp0pR2/Xb5anHiHTNkMLCWGNy0BxOytBqjmQlYCxgtMKEmZgLb+cGq0GtPyBzbCZlk8fPInRQAWjnTBd1n800R7CtTmxAQXGh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151576; c=relaxed/simple;
	bh=Nah9gR8YWyBgMejEwVs1oS4XKejJoSRLe5HKZRKTEho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sh2/RB6TAL+DftGeK9ZdMsJrJxpE+BWj1ueyOsl1bkMKNSE3KdYWRQkoNysplxxjrVMg6GTLV43DTk0DziX15lvTJRBI0mePjJZ8RFlCZq4d9B+fPW1hEfiM5v6PeN1nxPxLC97EWh0YhOpETGk9RtkJtp1z/hAGddmm8q9vpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qvgLM2nP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Nah9gR8YWyBgMejEwVs1oS4XKejJoSRLe5HKZRKTEho=;
	t=1738151575; x=1739361175; b=qvgLM2nPf6X+pqDLDguqlEDHJZXcSnOxqw3tFH+TQDei1H+
	7HyhOTF1dYZfbh/Vgc7Vabn59oMJ2S1nZSxqyt64YUFfwlnfn9UqZWHpgn4zTv2b0c9E8gFMw6ftj
	/OEEK1cjgQKuWb8SYawQoqgA9vWKs2uxGryEdO+JWq2LakgJXZRs0zLZhKg2jfC7ZBBkYigUhR9wH
	DQhJGFvAzN9fXhKhWmL6eR6uWh+QULN4muk6YpPF3IfX6CwlhkLEOAy9U661ck7JvlNhC+TclatNN
	C/GFQ4Bzvhu1BcK5PGx/NcNC9ESZ7F7g4/y4W9eBedUqnLHjzX07uPt9HtSfGy4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1td6cm-0000000Dyg9-1t6N;
	Wed, 29 Jan 2025 12:52:52 +0100
Message-ID: <309ce213d10e4004a5b6a3c23a44490e4da9578a.camel@sipsolutions.net>
Subject: Re: [PATCH 6.1] wifi: iwlwifi: assume known PNVM power table size
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 29 Jan 2025 12:52:51 +0100
In-Reply-To: <c3861593-7905-421b-8833-989e6a4e3c3c@yandex.ru>
References: <20250129103120.1985802-1-dmantipov@yandex.ru>
	 <1bc323264d3118434fa748efa59ed4da9dba6157.camel@sipsolutions.net>
	 <c3861593-7905-421b-8833-989e6a4e3c3c@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-01-29 at 14:50 +0300, Dmitry Antipov wrote:
> On 1/29/25 1:48 PM, Johannes Berg wrote:
>=20
> > I don't see that there's uninitialized use of 'len'. Maybe some static
> > checkers aren't seeing through this, but the code is fine:
> >=20
> > If iwl_pnvm_get_from_fs() is successful, then 'len' is initialized. If
> > it fails, we goto skip_parse.
> >=20

[... reordering too ...]

> Am I missing something?

You missed this:

> > There, if trans->reduce_power_loaded is false, 'len' again is either
> > initialized or we go to skip_reduce_power and never use 'len'.
> >=20
> > If trans->reduce_power_loaded is true, then we get to
> > iwl_trans_pcie_ctx_info_gen3_set_reduce_power() which doesn't use 'len'
> > in this case.


johannes

