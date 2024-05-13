Return-Path: <stable+bounces-43745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC48C488E
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 22:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA4F1C214B4
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 20:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8E80BE3;
	Mon, 13 May 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Pp9ClIVQ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426C31DA24
	for <stable@vger.kernel.org>; Mon, 13 May 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633847; cv=none; b=dPgyF4Y6BNemoi3dyo2H1gr59zdT36PL1Na7ON5i0eAXN4AMpoaT6+JZFBR9JbEFy5XuIcjQwLbgbGBurmThzQ0+keXxEx/b5XgQ9EbJ0dcG0P+VE1dOkjLWG2DSXWFviEuO1AbliJ1lm9CiaaRNiRGTtc+YLTBab5IB9chgRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633847; c=relaxed/simple;
	bh=OdaUMpvJC4qw6Sd6UQHgJsCRM1OgLUgoObtDmD+845Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtInrsNYh5vvufY+hMHPGzQUU3tIYWgMPVjUNttMZ5FdW+T2jLbPqIj0Ou2kE1+Oi3DgWiqwKjCc6R8sWw84yGyCR4MFMS12OQYrwoP8ZGnVyi1N2+lDy3C2zRsPnI7N3GezlQ8OdZ7P2pDJ3ZZl8hZpnlGfYYU8idZNuX4Rh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Pp9ClIVQ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lfe+OWdjNzWkgj4KIbXXDFhWBB8bEKk07UfsUVVhSOg=; b=Pp9ClIVQpuKBLqpxFfH4kEgiZg
	NmAcidWb5muATME01utRgoCps6ftVGnSQwtCIA4k5s1g0op3slluDekla63X/GWHGeelBAWQcVH+u
	1jz4oMSsIcpVBTwZVwidJd0S9VH8zHjB42yzjKD3Cyz8srhL8Ulh4Ev79OTli9Pg70fpT0t9TgGsX
	W+UknI4zO/xMpEIQFdpTHWsYVWV/vUwRDM1fLiFR8PRFCXJsQAcPY82k0YcIv0YJJayBpYdavpE3c
	7WVMtWvcXRscD089/0dxAfZwRCSLlexKV1wBHSdvdJJ7OSzKgfIxq9CbyLFgPwfm7BcFjZJoTqWKf
	7YF20lyA==;
Received: from [179.232.147.2] (helo=[192.168.0.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1s6cjY-007hKS-PI; Mon, 13 May 2024 22:57:21 +0200
Message-ID: <355bbe14-ed7e-e5a2-12cc-d14d49f0639e@igalia.com>
Date: Mon, 13 May 2024 17:57:16 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.4.y] ext4: fix bug_on in __es_tree_search
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, kernel@gpiccoli.net,
 kernel-dev@igalia.com
References: <20240511211306.895465-1-gpiccoli@igalia.com>
 <fc7a7af9-b8b9-5fa5-288d-f04d1d7a6437@igalia.com>
 <2024051303-footpath-scraggly-823c@gregkh>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <2024051303-footpath-scraggly-823c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/05/2024 17:54, Greg KH wrote:
> 
> Having a forwarded patch doesn't really help, can we get the real
> backport please?
> 
> thanks,
> 
> greg k-h
> 

OK sure, I understand you want me to resend, so I'll do it right now =)
Cheers,

Guilherme

