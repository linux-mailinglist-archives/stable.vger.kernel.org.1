Return-Path: <stable+bounces-172896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F88B34F7C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 01:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D99C3ACE1D
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 23:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76829D272;
	Mon, 25 Aug 2025 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6zcJcAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D341514E4;
	Mon, 25 Aug 2025 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756163029; cv=none; b=MaTG9BEhDFwSXBwRpFfWiPVrkfzqf6vVkw09MQFupdCxc2iZXyMpiOLKyWQ2nwDntwzYFQ9arJ90ivdDVoUp2AavwusddmzizVP/l4BN44EmyOqjurM4t2EskvCqlRg+7eXFql5SgBgjRPGwEVfOofUf/w1YM7knFxs94XeGoAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756163029; c=relaxed/simple;
	bh=7gT0JNJbr5Q0kWxKOwnJhXf0aVlLtH+bU3E1wQdwLCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfCFlaTmd24aq3Zg2ALe3UEHE4kz+vwl5sXItOLBaM4FmU6Gw38TmzFw3bpFq4BNtdDAjYPcFdxzdrBtcLbWmuMMA3zeGLflJWASaMqY47UWCmUzUwu1n/NjrSihTdAzqrYGUBNgcALADSTo/aztEGWTIGQalcaHcSfjyw0D1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6zcJcAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924B2C4CEED;
	Mon, 25 Aug 2025 23:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756163028;
	bh=7gT0JNJbr5Q0kWxKOwnJhXf0aVlLtH+bU3E1wQdwLCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X6zcJcAav7WVd8ZXHbhR26z5nBq2gLGVOBwuQIiAQD2guQ37sAS0AZ+vllVupG1Jn
	 S4CWE5SJXKEAxq7ncXMbsdYgp4lGZDwAVgr5DOcfebJFPeFbLSziOD52eXQEIueFYZ
	 OmL0u+pgvmTgMWA8eDxkaqpiMetIVI7QmzOIrvLlQt70/ca71AMXGlLC1BvocOFN0D
	 9rXeg0JbP1nXfRXLreUK5JH01r7PhZUsrGGovTDB7+GZWfag/CqEC2dwXS20Z2pK14
	 5T1Cwk3tFSsR2qN3RG4ggFRRp7vnBFunaG+ZbBpJbxGadc4dcCe00y9V1XbOVBb4+r
	 1ExuNYUOWTU1w==
Date: Mon, 25 Aug 2025 16:03:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?5Za15YWs5a2Q?= <miaogongzi0227@gmail.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, Greg KH
 <gregkh@linuxfoundation.org>, regressions@lists.linux.dev,
 edumazet@google.com, sashal@kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [REGRESSION] IPv6 RA default router advertisement fails after
 kernel 6.12.42 updates
Message-ID: <20250825160347.7569b3c3@kernel.org>
In-Reply-To: <CACBcRwK8wUbJ_S=z4QQg_CGfVWQaMd6HktdNCRkfG22Ypgg63w@mail.gmail.com>
References: <CACBcRwK8wUbJ_S=z4QQg_CGfVWQaMd6HktdNCRkfG22Ypgg63w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Aug 2025 07:14:12 +0800 =E5=96=B5=E5=85=AC=E5=AD=90 wrote:
> While testing Linux kernel 6.12.42 on OpenWrt, we observed a
> regression in IPv6 Router Advertisement (RA) handling for the default
> router.

IIUC this is fixed:
https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.com

