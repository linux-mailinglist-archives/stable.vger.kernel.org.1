Return-Path: <stable+bounces-104004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8142C9F0A95
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2841882312
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD2D1D88D0;
	Fri, 13 Dec 2024 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7M5kUlu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BB1CEAD6
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088476; cv=none; b=UCkiDUKS4b+MBsz3dhrfPBG8MFsK7Nyy2OfFOwa4neEDNFW89CRBYe6mlyhcR6oPQCrFzSuNM5snrx4+vsLtDX07UAPUEf2xIHj+vmDj9Z40V0YKsR8WbnUqTtrgPQH8knQ02h1Ci7vNdIEmrcwP2IKTLQBGO5HFdrjKJBZ4xS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088476; c=relaxed/simple;
	bh=K15J6u69x4YivTrtdFSNgp7oYY1XJ1tXJiK8YA56sWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6DbEMU8SWavlfVbr2v7DQDNSrNTctQ1rF6LWTZScx6kLqa/bomoz/APYe3FMDay/jnSeWJ0FuWsG+sl5A1nfYESuNhdwpeDJ9p41ByTGpkLKdcRG2Vri1H0+PULen20vBNLsANK0SkFuthF6fftB/e7J5qA9OPVJ7S2DLH455E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7M5kUlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29925C4CED4;
	Fri, 13 Dec 2024 11:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088474;
	bh=K15J6u69x4YivTrtdFSNgp7oYY1XJ1tXJiK8YA56sWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7M5kUluiuWNrlDD2QNsbXpW9pXQ/y13vsFEQgxtZgBIzFfcZhoYky6U92ZPVFFiO
	 qHGOx/cGLdRYnhcPzjxIrqObBCegYCKl1gDJcMNd3Rlrv6v2I2JKWmLQ+Vm2NovTAX
	 jAnh4OeuTm1XJHnGq+AfHdbN4qbUGX/c7xrqvRNc=
Date: Fri, 13 Dec 2024 12:14:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: stable@vger.kernel.org, mschmidt@redhat.com, selvin.xavier@broadcom.com,
	leon@kernel.org
Subject: Re: [PATCH V3][5.15.y] bnxt_re: avoid shift undefined behavior in
 bnxt_qplib_alloc_init_hwq
Message-ID: <2024121325-gossip-subsystem-1014@gregkh>
References: <20241213034620.2897953-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213034620.2897953-1-guocai.he.cn@windriver.com>

On Fri, Dec 13, 2024 at 11:46:20AM +0800, guocai.he.cn@windriver.com wrote:
> From: Michal Schmidt <mschmidt@redhat.com>
> 
> commit 78cfd17142ef70599d6409cbd709d94b3da58659 upstream.
> 


Now deleted, please see:
        https://lore.kernel.org/r/2024121322-conjuror-gap-b542@gregkh
for what you all need to do, TOGETHER, to get this fixed and so that I
can accept patches from your company in the future.

thanks,

greg k-h

