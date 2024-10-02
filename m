Return-Path: <stable+bounces-78656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDFE98D3A3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09C21C213A8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ACD1CFED5;
	Wed,  2 Oct 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJsokmLd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6E198E7F;
	Wed,  2 Oct 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873427; cv=none; b=J1srXmHFAjnBXFEqKQJehMqVN2E1+2GnaC2EdxF40rKo3aGTG81C4DY4xRXiC/ZE4+GmLTAj6RCCPEYaW3bF7Zz4+aj3t/0DQMQHItqGdKkiVJ+hmh25D5VR4tpLrORVMtYfkrG6s4TIizPqAn1gyATgvFY1Ijk59OxzejjzA20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873427; c=relaxed/simple;
	bh=ZP6iU0+XXTwNnr1/rsTPeTQJYxV77KUf6PQbAlnRV94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXreXfMeKf5w93kPha6nYxoCTrxIATNhTgVYJ0lWH2oTbVH/EEaZkhAWX/Fp0NuqrwWr1VlaXjDByzj4fcXbJkfpMdpjPycSJ+sYfgP+0UZuA/TrkF3NyJeGe1t4NTnySLeLFZd8mql+oIRBr1o0fcTfD8fJcgeTbNoZ91HzNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJsokmLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAB1C4CEC5;
	Wed,  2 Oct 2024 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727873426;
	bh=ZP6iU0+XXTwNnr1/rsTPeTQJYxV77KUf6PQbAlnRV94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eJsokmLd3XvYb9RXezw/AGZ53ee8niKZ39mzlnKC+QBFAIts5GDKNlazcsdbzFjHZ
	 7K3qYWadD701kbQu66sy8wBIUY/0vjnGvExJl1fr94ez9B5tsUCaSzSqC+5K0EZUEy
	 zUQTf916ZnxXFIdwy4gQXdRUu5WPtIOS97nFI2xoK4YX5L966XcvZBElWqV9rIiXkB
	 /hBO66q2QgifVpUfV4e77aJlhK2/RaxPANphJ9YtDLC9dn2CXqTu0xBQMibIk0fq55
	 E4aV4hGV+MJccvj6S2HbWflrGFJcnmzitgVnp3PCSmiauYX+sEx5ToewDSMBVz1L4E
	 5pZboEli/ikQA==
Date: Wed, 2 Oct 2024 05:50:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Sascha Hauer
 <s.hauer@pengutronix.de>, borisp@nvidia.com, john.fastabend@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 054/139] net: tls: wait for async completion
 on last message
Message-ID: <20241002055025.5d9ee0a4@kernel.org>
In-Reply-To: <20240925121137.1307574-54-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
	<20240925121137.1307574-54-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Sep 2024 08:07:54 -0400 Sasha Levin wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> [ Upstream commit 54001d0f2fdbc7852136a00f3e6fc395a9547ae5 ]
> 
> When asynchronous encryption is used KTLS sends out the final data at
> proto->close time. This becomes problematic when the task calling
> close() receives a signal. In this case it can happen that
> tcp_sendmsg_locked() called at close time returns -ERESTARTSYS and the
> final data is not sent.
> 
> The described situation happens when KTLS is used in conjunction with
> io_uring, as io_uring uses task_work_add() to add work to the current
> userspace task. A discussion of the problem along with a reproducer can
> be found in [1] and [2]
> 
> Fix this by waiting for the asynchronous encryption to be completed on
> the final message. With this there is no data left to be sent at close
> time.

I wouldn't backport this, it may cause perf regressions.

