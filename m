Return-Path: <stable+bounces-155298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE65FAE35C6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1D93AEF5D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC0D1DF96F;
	Mon, 23 Jun 2025 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sWCJPBXn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7561DF742
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660519; cv=none; b=MfvY3q07b7k0otOgbUreqR0UE4mCMUSqTw9rACuqsTGgGoGQgghQ0/M93/P5v50Utf5B4Ep5++Ls0smSq7vjPNOINNcyecV7GYq8mOC6wUtEoPKhL0VkhT8vqxDN0u2l8hpeuORXhwUrsjChEf46V8YaTZALygODtdWWqbj3cOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660519; c=relaxed/simple;
	bh=2rtIfjLbFbPA2G0w28NdUH7UcYtxVj+rETXA5PGuuJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkOylocmDBNDOSyWgiXLuAR2nUmXOl0bG0ubJB9ALU1+KhmQtTXY/hDtl7CWWm62HK5V8ccdF8xEqr3wrE5MhIYHNm4+uv4G7t5BTqGhYU2lhPU/dSs3wMt9BkPjnuzO5qVhxF319SRyZ1BUWr4Z2sQc7ULwc0nituWVa/3QbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sWCJPBXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01630C4CEED;
	Mon, 23 Jun 2025 06:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750660517;
	bh=2rtIfjLbFbPA2G0w28NdUH7UcYtxVj+rETXA5PGuuJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWCJPBXnZGLj/OrkGO2jShi3dC2hC546HGz3OXMwpXXR5keGfVOrPoAGBtzcxcNnc
	 dMvhWurwJioJ0xSMz1+VdZ3Gq0WuxSHbeNKDWf4JOR6CkOkgHmtdKHuynYUj3pejwQ
	 MX98aPyMX8nsTFEjsa/JaCJQZue/7S4l6dqSclDM=
Date: Mon, 23 Jun 2025 08:35:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: stable@vger.kernel.org
Subject: Re: stable patch 42fac18 missing from linux-6.6
Message-ID: <2025062334-circular-tiring-0359@gregkh>
References: <CAOcd+r0Rg6JGMjwZnCran8s+dbqZ+VyUcgP_u7EucKEXZasOdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcd+r0Rg6JGMjwZnCran8s+dbqZ+VyUcgP_u7EucKEXZasOdg@mail.gmail.com>

On Sun, Jun 15, 2025 at 06:36:44PM +0300, Alex Lyakas wrote:
> Greetings,
> 
> The following patch [1]:
> "42fac18 btrfs: check delayed refs when we're checking if a ref exists"
> has been marked as
> "CC: stable@vger.kernel.org # 5.4+"
> but I do not see that it has been backported to linux-6.6.y branch.
> 
> Can this patch be picked up in the next version of linux-6.6 please?

It does not apply cleanly there at all, which is why we did not apply it
already.  How did you test this change works in this tree?

If you want it here, great, can you provide a backported and tested
version?

thanks,

greg k-h

