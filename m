Return-Path: <stable+bounces-104005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B16D69F0AA1
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AD21883FCC
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1891E1DD86E;
	Fri, 13 Dec 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x4WNkFpL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6141DAC95
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088485; cv=none; b=skQDF7nAHiQ4MnXZkW1Gg6RH8OSHJihzd6LM7M+JZqMuO7c3GJOQoRBpiJuJpA5DnjEwxCQB8oLvbk7XiFG0LFulqtUhUipY7l2ReF+x4WWRHRo0/UzNAKncGFX9oLNZMWSD0pPpMyrbe7jRo2NCy7iEARtzd87+W//GT3uoYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088485; c=relaxed/simple;
	bh=wZ+ZTYnUtM3ijosftuyizpQsfJhHZ0nhoFsIM03fYRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h73/MaYWYwLBFjNk3ggG3ZtuRhnh4hp/h8g//odKFPrJ4WD5sBVHrtYSsF6EjPTmMElmByQxggidX+yNZoTJiEQr23kjicKQxhJ1WlTO12Ul9Zwv98VrBm2DRelvAdYcQaWtJO3ggJsYpFXPsXY03U4EDIcL+vsz4nNii6bL6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x4WNkFpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C40C4CED0;
	Fri, 13 Dec 2024 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088485;
	bh=wZ+ZTYnUtM3ijosftuyizpQsfJhHZ0nhoFsIM03fYRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x4WNkFpLU8kbIGjhHH348MWHQ+vwcvh9MQlFIKWe9/fHWCY0WDjdm4og/Nt0vQI1I
	 YZMW2/LeGCovqXuv7idUEghNCR0WDeyBLitjrfSoL2u11B/f6Xn8eq1/i0ieZCtdzT
	 z4To9VZ+RxLJmbc9RUTNfvFwf2/EqYwPDg2sYMQE=
Date: Fri, 13 Dec 2024 12:14:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: stable@vger.kernel.org, mschmidt@redhat.com, selvin.xavier@broadcom.com,
	leon@kernel.org
Subject: Re: [PATCH V3][5.15.y] bnxt_re: avoid shift undefined behavior in
 bnxt_qplib_alloc_init_hwq
Message-ID: <2024121338-effective-mortified-7f38@gregkh>
References: <20241213081415.3363559-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213081415.3363559-1-guocai.he.cn@windriver.com>

On Fri, Dec 13, 2024 at 04:14:15PM +0800, guocai.he.cn@windriver.com wrote:
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

