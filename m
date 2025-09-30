Return-Path: <stable+bounces-182025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F388DBAB93F
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 07:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6552D1925904
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 05:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED028B400;
	Tue, 30 Sep 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="LsYxfqX+"
X-Original-To: stable@vger.kernel.org
Received: from mail-108-mta101.mxroute.com (mail-108-mta101.mxroute.com [136.175.108.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B52882B7
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211493; cv=none; b=Qx3K4r4wrNvFTSCxnFnjUBaDZw+zKyuvC4DAIce6bSobcevFZtwkbvwYh/t951Ulp3DlZ7LPAeCv1QAtSLBCJgrn+dkckJOkLfnRXScrwuklvR5Pfso3ZfVPy7IQT+NDlbReZ4ZuXCYtOG4y+kgB1LwRkgMunvh7Qz/QacUmELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211493; c=relaxed/simple;
	bh=kpQ8m1r9WsaQRTfb3mvBz37kYspPRr26oZ0VIk79zO0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sHjiy3h/aSUo4IsWKVEwxjtJ7PK04vMLrPzCj4F7pFPTh09jluVJ5hjzwwnO2WjyIZ21Z2e/uNoKCs11UuyotUg5HfFBw0ULPVQQuaGtMC7F//kh2a2rVKojBwJhOZ/dd2Q9gNgeT6i4AowAk+dGqUQotCDqU/CvJXzMuyPHVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=LsYxfqX+; arc=none smtp.client-ip=136.175.108.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta101.mxroute.com (ZoneMTA) with ESMTPSA id 19999284be5000c244.008
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 30 Sep 2025 05:46:18 +0000
X-Zone-Loop: ca14cce1618f8529b6add585c79f58d64529b65f71c9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:Content-Type:References:In-Reply-To:
	Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gUtR5fYZV2rNyiv6PpzTdc7VzKFWiIJdpqFAx5fRTus=; b=LsYxfqX+DHmPACBm1jbfP6yS+p
	7VlZv0L5MAztyjmon7MSu5rhEVKDnzeKKpK9/GIERAIiFWWgIS82CjY8rrGUK3AcRBKfQkTJguJ+B
	Zf+mBZ/O5QQ0f04rrpHLRGoCg1wvIFOahYag7Yv3gWe9TXuvNNjqaC+m5Ig3T09zA9GYVO0vzcazp
	RITtyLleYtdDyoTOMgiJNWwz17yXTFF++XI9Gs0tHo5u3vZVz1G+23QS//DyYvx9Ib6QpbVtltUpU
	NllNOaR9shrazWGEyHw2fFhJMzIfzDzqPS6Q2AGOadhmI/aAq9P3H17p0kKGkGlfe4luo2W3D72Ed
	OPwHLBEA==;
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Sep 2025 13:46:17 +0800
From: Bo Sun <bo@mboxify.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, sgoutham@marvell.com,
 gakula@marvell.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] octeontx2-vf: fix bitmap leak
In-Reply-To: <20250929185359.52e3f120@kernel.org>
References: <20250927071505.915905-1-bo@mboxify.com>
 <20250927071505.915905-2-bo@mboxify.com> <aNpbZkQZxa3HkrJj@horms.kernel.org>
 <0bb6cec0e6bcf22a43bfff4b0813b201@mboxify.com>
 <20250929185359.52e3f120@kernel.org>
Message-ID: <cc8461fadd0ced4e7f4ec33334d5aee7@mboxify.com>
X-Sender: bo@mboxify.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com

On 2025-09-30 09:53, Jakub Kicinski wrote:
> On Mon, 29 Sep 2025 22:49:54 +0800 Bo Sun wrote:
>> I’ll resend v2 for the net tree with the correct subject prefix.
> 
> Since you promised a v2 - could you also make sure you CC the people
> who signed off on the bad change? get_maintainer will point them out.
> Unless you know their address will bounce, in which case please mention
> that in the cover letter.

Sure, I’ll CC all sign-off authors and everyone get_maintainer lists in 
v2.

