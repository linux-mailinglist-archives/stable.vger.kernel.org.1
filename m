Return-Path: <stable+bounces-83036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA63995006
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1461C24918
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D0618C333;
	Tue,  8 Oct 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="YbPX0ehB"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE51DE885
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394255; cv=none; b=h7zrdYm0q8p3IvvECIdBGhJ5yYrKS0nqzXrWAOSoaZP5aPKoNxlht4Y+Y4rtEfr74oDF8Ne2rKgx/qyTpVDs09BIWJyUvHTyRe3pSmj66CpBVjHqDKKuMSqYvrKBR42NP4z2bXnJVvYMEQt8QkM2DsUoBqBFbeFzOW8/7JX5NQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394255; c=relaxed/simple;
	bh=vF11pzvR5dwQyWu0VtUt60c+6/yDKn7Ny1ltqg50KiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eXIa4gGFpB+JY3ULDGptlad/M9f8z+xXuvpnrui5nrY0CthoNUf2gyZBKdEMSTBaD+WNKpNUuYO/cd1ZwPpc6W1wx8K53QsQvgHGZjy+QKWrbIf+1Vu1XSO8hiJvhmhjuEbEGBufZ5pLfISNFVueFYcwv56eTq5vQxzjZczvejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=YbPX0ehB; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 61528A07D0;
	Tue,  8 Oct 2024 15:30:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=tB9EDnGwWTC12u9P8tpr
	ADElod0ztB5FhqWHXJ1bkcw=; b=YbPX0ehBCQVpB2hkDGBgOS7ypIFFBFq130jX
	Xr7SU5vxAsvzzdt+4GRNeg/NEB4sr6qUVDNkrRC95Facxi9CHHNXUZkNxJHfsdtT
	i7xtIEqn2G+GQjtQ6z7UXqqZbVeOYCFQYUZUXWxiaDWLBmV7PW1AO6woyiGMFXut
	aRnlQUxG6+xby30WTQe31N1C03v8D20AwStqFlTL6Ze1rBf0DNoEkoBp6vPyyUV9
	H2iVnmKovX8LeFuI4z1X3AHP+NedqAEUARPhP63WLz7juPxySUwfITxfOpKu/kOF
	p9jJlvb8X89LOI0vcycLt2ty4Ks+H1f0qFB0U7TXxtWAKuVeDynYkOqmKRrb9dFh
	GkQPeVeoNj0Ntm3rUI2UGzfcIv++TGP82Oj1+Xtj7S4Dy9NxvODjb4+L7pUqxhYN
	jy+63jLikfA3maT1PusVuOptDf1tatfjBDrQuEa7aOKRg7FwhxyDTYqhNzgK5KmX
	ikZJpq3xfGM6fn3bZez6RBUblZCrLb+zKyLulSM0ihmXXmGYAssq9C0OTyzvWBDy
	wY7ZAovebJo7iP0996K02elYcqgbuSVP+Irc9vgjhZT2PpoihkV39BqsCvPE96QV
	6VLtg6gRzFoZixfuXXjt3nWOQxOZ3M/cGRTyPW4zbtP5PAa9qU9gU5o9BU1l6EA6
	qWIPnzc=
Message-ID: <1af647ce-69e4-4f86-b0a5-6ac76ec25d12@prolan.hu>
Date: Tue, 8 Oct 2024 15:30:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 028/386] net: fec: Restart PPS after link state change
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Sasha Levin
	<sashal@kernel.org>, Wei Fang <wei.fang@nxp.com>
References: <20241008115629.309157387@linuxfoundation.org>
 <20241008115630.584472371@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241008115630.584472371@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855657D61

Hi!

On 2024. 10. 08. 14:04, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Csókás, Bence <csokas.bence@prolan.hu>
> 
> [ Upstream commit a1477dc87dc4996dcf65a4893d4e2c3a6b593002 ]
> 
> On link state change, the controller gets reset,
> causing PPS to drop out. Re-enable PPS if it was
> enabled before the controller reset.
> 
> Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> Link: https://patch.msgid.link/20240924093705.2897329-1-csokas.bence@prolan.hu
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

There is a patch waiting to be merged that Fixes: this commit.

Link: 
https://lore.kernel.org/netdev/20241008061153.1977930-1-wei.fang@nxp.com/

Bence


