Return-Path: <stable+bounces-71528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2431E964B70
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F09D1C22C85
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853BF1B654B;
	Thu, 29 Aug 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t7YCnS4V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564D1B0132
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948231; cv=none; b=SPM6cunXh1eiRgcBjmcgMqOErzyyvUPcfcddiq5+cmD7mTmM8tf/T2iFEEggkaQ8coL7QjDfMHTUZ/sCZy/mn3AgAO4aWmGr+LwVUEgQ61DwdBNoxxPv14zM81rjkuvmty9xr3dUsyRuy3eq+/1cexdfqQAMRQXkWv5nW7FrnvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948231; c=relaxed/simple;
	bh=g8OXW2UHu3pCVa+RN5o6wfZXlqJ5yavDWtenu43cgkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN4EYKc1kuRlv0JZ3CHI12DqHPhmvH395wM5231qUPCgHbf+l768qhF25Jggw7FQvEeygR9kc/gp94GIrG93rOwsx5qwQXz/lHcy4xajQRfX9u2CI1FNTULlX9O8gfy8ffQWkNI0K4tpgsjn/YV2qk7k85IcuR33ditYaUg3/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t7YCnS4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC94C4CEC1;
	Thu, 29 Aug 2024 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724948230;
	bh=g8OXW2UHu3pCVa+RN5o6wfZXlqJ5yavDWtenu43cgkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7YCnS4VfptUaoladW1LGF7lkZMf2Hcyrjabv7XQeMaOgT/ys/ZB0vHgT+M2jO9F6
	 3UIU1cVfUmqeGJb4XGsSz3IXConpXBSGUiJb/ld4/EvEgDW8sU+GaYJLscjIfvthAk
	 xGX2aPe1RU1O3mZ/XB0/zKYl8O9wvnaBfUhzbKgo=
Date: Thu, 29 Aug 2024 18:17:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 4.19 1/6] ovl: check permission to open real file
Message-ID: <2024082904-unmarked-audacity-34dd@gregkh>
References: <20240829151732.14930-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829151732.14930-1-hsimeliere.opensource@witekio.com>

On Thu, Aug 29, 2024 at 05:17:00PM +0200, hsimeliere.opensource@witekio.com wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
> 
> commit 05acefb4872dae89e772729efb194af754c877e8 upstream.

<snip>

For obvious reasons we can not take a backport to an older kernel tree
and not all newer ones as well, otherwise you would upgrade and have a
regression.  I think it says that in the documentation as well
somewhere...

Please create patch series for all currently maintained kernel trees if
you wish to have stuff like this merged, and resend them.

thanks,

greg k-h

