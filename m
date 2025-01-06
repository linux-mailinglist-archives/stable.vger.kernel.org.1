Return-Path: <stable+bounces-106796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BF9A02234
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123BB16255A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1A1DA62E;
	Mon,  6 Jan 2025 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZxcvPboP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE691D9339;
	Mon,  6 Jan 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157102; cv=none; b=mCBJDa21rmTPPfcY+ScjzShra+E/13IlX9E7cEbXAi4p4xJL0Z9Z6qqJhg0l0uO1uiU2Iq+hsrcCWMu3kSDfE2CFlxWl4gD0J82FfM/BKKnxZGtH1GIDqBFohjljldErClDdMcTylyEpa1g5XsokckWayjW3YXc4XNUttNms2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157102; c=relaxed/simple;
	bh=fzcLp2bnWjeBDEyfS2XXkaDgi/8QMRYU6A6YyrFG2a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUAdleToJGqk2lP8QN+Ap3EW/lRymtQCSq8qMz3Vg5XptTtTYH4vzTWKKNzeINaRxLnm2fJrlLVmbfWFfCPWw930i4ufB21tu0qJKwhuRYAj+I7vgAss9qR4PStZ2wtggw87m5f7y3DASrpbV9y7Bld+5LIz4JfFuakjZG15MTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZxcvPboP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C91FC4CED2;
	Mon,  6 Jan 2025 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736157101;
	bh=fzcLp2bnWjeBDEyfS2XXkaDgi/8QMRYU6A6YyrFG2a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxcvPboPxlZF7R90OW+mcnvmKgZ/R9NRG6Md8I6/+TNpNft3MATqDF5ZDldy5u2tR
	 nXemFfunyHuRvAt+BcGAnu9Yq1HI1XeBcQAXw4GXSvWB3LkCQabY3c/ZE4exTs4KyC
	 p2pNg0oqfwflRiNyt0Q5TieYowF3jPd7ipfU8NPk=
Date: Mon, 6 Jan 2025 10:51:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: wujing <realwujing@qq.com>
Cc: sasha.levin@linux.microsoft.com, mingo@redhat.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	wujing <realwujing@gmail.com>,
	QiLiang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH] sched/fair: Correct CPU selection from isolated domain
Message-ID: <2025010654-underpay-habitant-fb9e@gregkh>
References: <tencent_160A5B6C838FD9A915A67E67914350EB1806@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_160A5B6C838FD9A915A67E67914350EB1806@qq.com>

On Mon, Jan 06, 2025 at 05:26:34PM +0800, wujing wrote:
> From: wujing <realwujing@gmail.com>
> 
> We encountered an issue where the kernel thread `ksmd` runs on the PMD
> dedicated isolated core, leading to high latency in OVS packets.
> 
> Upon analysis, we discovered that this is caused by the current
> select_idle_smt() function not taking the sched_domain mask into account.
> 
> Kernel version: linux-4.19.y

You do know that 4.19.y is long end-of-life and totally insecure and
nothing that you should be using in anything, right?  Please move to a
more modern kernel version.

good luck!

greg k-h

