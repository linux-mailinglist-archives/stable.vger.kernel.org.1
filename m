Return-Path: <stable+bounces-177621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EB4B421CA
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 15:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511431A81BAB
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16423093DF;
	Wed,  3 Sep 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="IIzGHzfC"
X-Original-To: stable@vger.kernel.org
Received: from zdiv.net (zdiv.net [46.226.106.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941663043BD
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.106.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906446; cv=none; b=gJ9GvbFu57Gn4SR7XN8J2UlIzfOEQlKXD9H3Jb+hs8cZXkWuzYuozVDP2Oz9R91b6IkS9e30u0H2GzNaghxoL3R/UZL7uLXln/V9JxsockJDV6KhggshOwsyagMjJDfmyV3hbeD9zWANnrdYYUy/Iny4xLIQLO+E16XPYjYQjmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906446; c=relaxed/simple;
	bh=QnjkmYqu/1Je2O6m6fzVTKlJEs++2r7mQWuQXxIDZDM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aBz4w8WgIEHWf1CwZcdL1AvvFy8ons/Vwo9Nj0So6hbLMsIRAl4WVCzYmssyBJUdGU9+2yi5VguuvUqM2nDWS+fOswZ2y9Wzwcpgg59fpr5466eabOkKeKZNhPdEdHxl9rQMqalufGfoxWIvknY2HzghnLBs81gUvlodevls5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=IIzGHzfC; arc=none smtp.client-ip=46.226.106.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=24;
	t=1756906443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=buwyaVC2eaieCu74ufQFtz+GGdBgZ65djZAMVk/mlGw=;
	b=IIzGHzfC8SYVeEIINcrCYa6ycWqBr64tvC55sy6OCIxRvc82Qsv61q5rrDqFXTJMtaV4iD
	82ghOt6xyDUp3LEc9BOv6HUtd1/vZLX6p+JfjURj1HZPlubKb6N+DI8uNtEOn8TFCAwNyS
	C/7M82U1M037rEw5Eeyw30J6QuXsRrCzMxtgO7KVLAusO0ap2Ssvx2YgJIt4+jpZd3bz4r
	S6toJIZSSE1bpBJl9eU3IrVBWOTYSDaqjxngw68RskeGKYQ2lE4j8zGUq2Uun5fWXK11O3
	pNe7DAEB+zcidzaLvvNcJnOaa9gTs+h/oTOXRCiuWYHX1yxl7xhoE97QQ4DUKg==
Received: from localhost (<unknown> [2a01:e0a:12:d860:c963:9436:23d3:76c9])
	by zdiv.net (OpenSMTPD) with ESMTPSA id 25779594 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Sep 2025 15:34:02 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Sep 2025 15:34:02 +0200
Message-Id: <DCJ7CTIZJNOG.1RTW7M8MG9UG0@zdiv.net>
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH 6.12 00/95] 6.12.45-rc1 review
From: "Jules Maselbas" <jmaselbas@zdiv.net>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.21.0
References: <20250902131939.601201881@linuxfoundation.org>
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>

Hi Greg,

Yesterday i experienced an issue with the amdgpu driver on v6.12.44, dmesg =
saying:
    [drm:amdgpu_job_submit [amdgpu]] *ERROR* Trying to push to a killed ent=
ity

which causes the kernel to freeze/hang, not cool.

I think this issue is fixed by this commit [1]: aa5fc4362fac ("drm/amdgpu: =
fix task hang from failed job submission during process kill")
it has a Fixes for the commit: 71598a5a7797 ("drm/amdgpu: Avoid extra evict=
-restore process.")
which is in the v6.12.44 tree (but not in v6.12.43)

I am currently on v6.16.4 which include the fix above and i no longer have =
the issue.

It would be great to include the fix in the v6.12.45 release.

I am not subscribed to this mailing-list, please add me in CC in your reply=
.

Cheers,
Jules

some additional info:
CPU: AMD Ryzen 7 7735HS with Radeon Graphics
GPU: [AMD/ATI] Rembrandt [Radeon 680M] (rev 0a)

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Daa5fc4362fac9351557eb27c745579159a2e4520


