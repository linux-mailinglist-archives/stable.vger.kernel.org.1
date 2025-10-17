Return-Path: <stable+bounces-187702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F00ABEBCDB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E72154ED862
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 21:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F6A330B14;
	Fri, 17 Oct 2025 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzC5oklI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911825332E;
	Fri, 17 Oct 2025 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736333; cv=none; b=reDLZrSMsvITi4ccNx1IUo9nrWdVkNGwCJtuhXk8Lv5lbGlTbOKYXtH5alkQkiGsOc7Bn4VKkQfpBV5NiXnCvV2h0U2J7+t6dcl6K/ZNRCo/UfH2SKbjDKrP0UDuyCsgnw0hmogcNWEnnNHP6DP1hgjYAEM5hTC5seomhTEZKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736333; c=relaxed/simple;
	bh=Odeizf/oCDJOM6bTVntC153p2KG2/dg8ZKXwZIkgwpk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=gbQ8jkn9Yup99hXCv2XgzBHEfb1Cm2RPOMK7hWh8fOcQYR9Z/QJgb5VqVumJYUZK5lhxU8RrfVfpThQFuNRcXU8jf6qvMhUMiZ5s9SZ2QboGlmv2Z5D9zeEHGDCGp1e0Lbmv0ggjiMSuZ+UyNZbnk21Iu9+P6TxHJeKGZrKs3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzC5oklI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01670C4CEE7;
	Fri, 17 Oct 2025 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736332;
	bh=Odeizf/oCDJOM6bTVntC153p2KG2/dg8ZKXwZIkgwpk=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=UzC5oklIlqc4d2lCZwUFQmkxjXN35pj6h5apDGvzBtO0eIY8CH0nV7lyUkKnJxYcg
	 P4DCMzdrzp/xH1ktvhrrTP1T9wEVR+JLepI50SW5o5EUS92vOAV8Uv9T7qOdLwgpYV
	 vwq9ldGbjIwCmgikycf09897bljCfyBdm9is0UmRWCQ5LfSGWxp2gAp+rWVUxQS5Y8
	 L7dfktssHVMXNiJtmagZ64M2JprDBJ4pb7/1CZvAofNaRDzio7rowlTmlvzeahTAau
	 YCzuDBPkK0gAOV14sJUo6DAFZ6cLPVVr+QGW+zICIMZlJtCpEMcmg2R/blBW+tcxG8
	 7OsDKl4AHsRMQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 23:25:27 +0200
Message-Id: <DDKWXQ40ESK6.1RXQB3T43788@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: device: fix device context of Device::parent()
References: <20251016133251.31018-1-dakr@kernel.org>
In-Reply-To: <20251016133251.31018-1-dakr@kernel.org>

On Thu Oct 16, 2025 at 3:31 PM CEST, Danilo Krummrich wrote:
> Regardless of the DeviceContext of a device, we can't give any
> guarantees about the DeviceContext of its parent device.
>
> This is very subtle, since it's only caused by a simple typo, i.e.
>
> 	 Self::from_raw(parent)
>
> which preserves the DeviceContext in this case, vs.
>
> 	 Device::from_raw(parent)
>
> which discards the DeviceContext.
>
> (I should have noticed it doing the correct thing in auxiliary::Device
> subsequently, but somehow missed it.)
>
> Hence, fix both Device::parent() and auxiliary::Device::parent().
>
> Cc: stable@vger.kernel.org
> Fixes: a4c9f71e3440 ("rust: device: implement Device::parent()")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-linus, thanks!

