Return-Path: <stable+bounces-109374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C1FA1514B
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD27C7A0411
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002391FF609;
	Fri, 17 Jan 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qflaEYCQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318327466
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123001; cv=none; b=OzWnOYnN6M7HRlSBZa9buFLKKbiHXbZhOxTzkNb8h2XRLbn/wQj+A0ThrkXuLRcA92sgHPDzxzFTMqVbbZ2TIfXIycCnTR8nTHs+gCo5WwCzDW3bBjf894Rp0cLgAcUnEfFHNdaf7vZBx9eMZY+GEtupoJrG1bJOz65zMqv0zlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123001; c=relaxed/simple;
	bh=yGLNXFnPrlE648R3AzCBWZNXAhpXV2RpJx/hKRPiex4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOpg8PQkF5uuv1PFtVh1ypb9NfwaSuprvZuvKUciZd1xWQ0Beod5Wrqbo26gnt07kQab8twYWuYtb0n5KXc3nsk9Omb4zPyON2rKe4hzVYAp0+iGdHbThy2xZEGCrV40P/5l3hjMM7Qny44IkqQ+dGrox/JS7CzC0CvhGIBd4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qflaEYCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DA6C4CEDD;
	Fri, 17 Jan 2025 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737123001;
	bh=yGLNXFnPrlE648R3AzCBWZNXAhpXV2RpJx/hKRPiex4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qflaEYCQ3wQd0VntWcbn6vzFcTO49WNUP37JYHg5VoHmDE7G1Ic0a+ONDKyotAdRm
	 FsCPoLCYKHYWM5EbmhMxVPtiN8KwqkovwYExqldMoUxpdurt7YnwqoUB43AxG5th73
	 Wgqujau5BJKkniS4d6P2QPQt2fjmys98dJBRhhaA=
Date: Fri, 17 Jan 2025 15:09:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Terry Tritton <terry.tritton@linaro.org>
Cc: stable <stable@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Verkamp <dverkamp@chromium.org>
Subject: Re: [REGRESSION] Cuttlefish boot issue on lts branches
Message-ID: <2025011710-chug-hefty-2fd6@gregkh>
References: <CABeuJB2PdWVaP_8EUe34CJwoVRLuU8tMi6kVkWok5EAxwpiEHw@mail.gmail.com>
 <2025011740-driller-rendering-e85d@gregkh>
 <CABeuJB3xEQfgx1TiKyxREQjTJ6jh=xt=N7bTQoKgjAN1Xoa5WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeuJB3xEQfgx1TiKyxREQjTJ6jh=xt=N7bTQoKgjAN1Xoa5WA@mail.gmail.com>

On Fri, Jan 17, 2025 at 01:34:14PM +0000, Terry Tritton wrote:
> Thanks Greg,
> whats the best way to do that?
> Do you need a patch for each lts branch affected or just one based on stable?

One for each branch please, as the git ids for the commit is different
on each one, right?

Look at commit acddb8762014 ("Revert "rcu-tasks: Fix access non-existent
percpu rtpcp variable in rcu_tasks_need_gpcb()"") for an idea of how to
write the header.

thanks,

greg k-h

