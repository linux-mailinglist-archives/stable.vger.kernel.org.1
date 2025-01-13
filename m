Return-Path: <stable+bounces-108454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F98BA0BB86
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42E03AE3C0
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090420AF68;
	Mon, 13 Jan 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NSg1ku+Q"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8C1FBBD7;
	Mon, 13 Jan 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780734; cv=none; b=T3RBaQK32Xssukb6pNNgNIO7j6lzLBiyWPWYriIecW7tGqFw9nCbaS3h/66aBwslhXD1YMtgwuhO4DQkl6gUMh5ceCLrAtJft/UtNf6GkLoEHj23nEFewdZI/pogUAK8pkvZSy0afxOwO+qkqQALKKN/uKb7Cwb373LCJ30kA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780734; c=relaxed/simple;
	bh=6rOEWBkihHbRpd128V83W8FUKozCcOrkHDOjVTu8F1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F53FxxfbRkevN12wxaSC7jgo0lKUy3Gk5LLcWc4QgesKYMXM6WQ9dwwKTBMvn0lBzkkRSLjHcbPm0fZrDAQCB7liMaj3OywEzPsLWDD4MFJEk6cHtgTCdR3fSj2A/UXMBoFcsVzPnCWmkJ20IyD66qGCzC5Lhbk8wScEyTaBTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NSg1ku+Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Dbv1CCyDElJe44oWgOdccSic+gr6nYYxWITNu1o4Qt0=;
	t=1736780732; x=1737990332; b=NSg1ku+QeROnfSdtZ3Qg1GFKsl+sAuXkp+gpfkarIb/7Zo0
	DHiXo9OyBBzL1sBl9AEoX24sTL0EgeoM63CT6NIPFMjL46uXl1O8q56AaOSowog+3RO73gQ35+pf/
	26nMujCnoxGjDcOkVi9t1T2bBvrfjPM77ON6fVeDZe9Z4adPkg+9wthNZtEUoL+5dxdnsf4sE3Ib7
	fCL1B8EAcHvh7XSZ9nWDYXDJzfN+Ui1rGB8cDHuuq8vG27DQpshDeYlP3RaVJv6rcoe6Qm6kbhmRt
	984WLhqqoybZ4zOdulmsW/OrtaFjNIup3u2e/Fxb7F9KOhArgGez7GYzKAYdlGWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tXM0O-0000000DeQe-2KvE;
	Mon, 13 Jan 2025 16:05:28 +0100
Message-ID: <a6bd38c58f2f7685eac53844f2336432503c328e.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix interger overflow in
 hwmp_route_info_get()
From: Johannes Berg <johannes@sipsolutions.net>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: Julan Hsu <julanhsu@google.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	 <lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>
Date: Mon, 13 Jan 2025 16:05:27 +0100
In-Reply-To: <20241226074737.3737062-1-Ilia.Gavrilov@infotecs.ru>
References: <20241226074737.3737062-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-12-26 at 07:47 +0000, Gavrilov Ilia wrote:
> Since the new_metric and last_hop_metric variables can reach
> the MAX_METRIC(0xffffffff) value, an integer overflow may occur
> when multiplying them by 10/9. It can lead to incorrect behavior.
>=20
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
>=20
> -					      mult_frac(new_metric, 10, 9) :
> +					      mult_frac((u64)new_metric, 10, 9) :
>=20

As you would expect, this doesn't build on 32-bit.

johannnes

