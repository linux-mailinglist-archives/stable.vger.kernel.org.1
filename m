Return-Path: <stable+bounces-85093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C799DE45
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 08:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BB2B209E1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D3189F5E;
	Tue, 15 Oct 2024 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Uxg7dj01"
X-Original-To: stable@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A3189B9B;
	Tue, 15 Oct 2024 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973687; cv=none; b=PkNKwFB9jv51w5vbqg8+2GyZInsds8vdBk1LWfPiQvGML/1Fhhd7Qmu/wuzsgeGZtDmFsnlr0J/pL2rDfG5J7qNP2U/umzlsyVbABX9L/oSJn+Ny8j4XIlbqO2j9LtBudel3wHnr/FS/9vTHbCuSQpjxHdYF94QvTp35Jek2kr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973687; c=relaxed/simple;
	bh=ZdkCjF3tQbsg2KVxwh1SgcNMxgO6Ws/OTCX8Atf20v0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rwa3gYhGHhFwl1nSuA6YAVgLBtRhd9w6tytNR8MN2x+ZXGFpiXcTcxvnzhHq2OJAxbRqS+aUI7CjfgxPnwOTSQ79b3OYb8o4+wMmXWdGZ3YZcztMnlHc4T8HXtk9S4jPHB18286LQ7yxeW6qmvYoVMFdPs1Cd2dcX2FqrmXsH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Uxg7dj01; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F10B32080B;
	Tue, 15 Oct 2024 08:27:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6smyEAcTErHB; Tue, 15 Oct 2024 08:27:55 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3ABC3201E5;
	Tue, 15 Oct 2024 08:27:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3ABC3201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728973675;
	bh=S9LYNGHcizZ23zBSIsj0dP1Vk9wlrYERCPTc+BcbmTk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Uxg7dj01+MqRP4V8Lz6nGNT84aDtrqfZce1kdke0Suyn9Pf7FaXb2/I3T8TEbmYVR
	 1gzERTPWhFKO8e9RBCrgmDEQDPSnYRf0IBqoJKEL4heYa1PscPrEs47mWOWlcFY3Y7
	 ucf8PTSZ2jrXZP+2pQtC6vHl93j/SF0zadM2FWzieWBj5XYNrJtkO66UCWIvtl3j/g
	 H5bh0m4PXQ7mlBYEY6K57oWsbvzoEnWSK2q6o1StwCWoWhr2Z0Q0GooOoKlD2l6w+D
	 WyUBMpSJ+WYnm4S1bgQvLqNVdqswBd8ky+mXJUKDJ2blVQA8/UeQc4TKcmIdxQCrJw
	 b+XxtD0KIDUwQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 08:27:55 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 08:27:54 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 79DC23181044; Tue, 15 Oct 2024 08:27:54 +0200 (CEST)
Date: Tue, 15 Oct 2024 08:27:54 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Petr Vaganov <p.vaganov@ideco.ru>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Stephan Mueller
	<smueller@chronox.de>, Antony Antony <antony.antony@secunet.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>, Boris Tonofa
	<b.tonofa@ideco.ru>
Subject: Re: [PATCH ipsec v3] xfrm: fix one more kernel-infoleak in algo
 dumping
Message-ID: <Zw4Lak7LOwfW32NJ@gauss3.secunet.de>
References: <20241008090259.20785-1-p.vaganov@ideco.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241008090259.20785-1-p.vaganov@ideco.ru>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Oct 08, 2024 at 02:02:58PM +0500, Petr Vaganov wrote:
> During fuzz testing, the following issue was discovered:
> 
> BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x598/0x2a30

...

> 
> Bytes 328-379 of 732 are uninitialized
> Memory access of size 732 starts at ffff88800e18e000
> Data copied to user address 00007ff30f48aff0
> 
> CPU: 2 PID: 18167 Comm: syz-executor.0 Not tainted 6.8.11 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> 
> Fixes copying of xfrm algorithms where some random
> data of the structure fields can end up in userspace.
> Padding in structures may be filled with random (possibly sensitve)
> data and should never be given directly to user-space.
> 
> A similar issue was resolved in the commit
> 8222d5910dae ("xfrm: Zero padding when dumping algos and encap")
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: c7a5899eb26e ("xfrm: redact SA secret with lockdown confidentiality")
> Cc: stable@vger.kernel.org
> Co-developed-by: Boris Tonofa <b.tonofa@ideco.ru>
> Signed-off-by: Boris Tonofa <b.tonofa@ideco.ru>
> Signed-off-by: Petr Vaganov <p.vaganov@ideco.ru>

Applied, thanks a lot!

