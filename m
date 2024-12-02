Return-Path: <stable+bounces-95932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AA79DFBA6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7605FB22399
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822C61F9428;
	Mon,  2 Dec 2024 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ByANwPdG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D91F8AEA
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127008; cv=none; b=LABXZNXKksCnE7gEEMT6V2yTmq7TycBp2Tu1iSSnHwE+Y/xylfdPrZGTuNrVyzbu3spN7c/oECtvGNRah4dD46ydf7mJnoD7/1abDKXLDyyKuNnaLP1WxehSXtVMfofm/QugeI7d7WeP36+qlQozvmJSxgV4GGIMTdBFrt1K6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127008; c=relaxed/simple;
	bh=g9VQZDjYXHiJNOmUiYncop2dBcdXSakULUFSHQ8rNHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7w0+gXJMXtDJgYLVcLMW8177sE0kWhQPcfcRljZFixoipzbejqrO5aDL16wU5BOjVG/oYth5yWhYVO7NbnanVdg+zMxGnX0JuRJtcgxqYZhSmTZPbZAywLPO0mQ2G/1QzZQuEzQDbERatDNzGlvaPn5z6o0bc0ZvtknGPFvPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ByANwPdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275C9C4CED2;
	Mon,  2 Dec 2024 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733127007;
	bh=g9VQZDjYXHiJNOmUiYncop2dBcdXSakULUFSHQ8rNHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByANwPdGvOWdvhR8QtFWlQWv+bBJqcbxV6LILLYoYeD9XPkxLSOmvxi0LEZycKsaI
	 uuWyXDT2yGsLXxyzziTZXqQ74DZMVRUX6zFdSTf9hnHufL+W7t0ZSXD9pF88z0SAcJ
	 8ToW1sD/NHGCwT3EAGO36H2u/APrHqS2t7v3TpjM=
Date: Mon, 2 Dec 2024 09:10:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Rosenberg <drosen@google.com>
Cc: stable <stable@vger.kernel.org>,
	Android Kernel Team <kernel-team@android.com>
Subject: Re: f2fs: fix fiemap failure issue when page size is 16KB
Message-ID: <2024120257-denatured-attest-97e0@gregkh>
References: <CA+PiJmShthadiM2ciL_NMU-K=jXEZUB0EztcdnKnFWOz3OfOVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PiJmShthadiM2ciL_NMU-K=jXEZUB0EztcdnKnFWOz3OfOVw@mail.gmail.com>

On Tue, Nov 26, 2024 at 05:06:08PM -0800, Daniel Rosenberg wrote:
> Commit a7a7c1d423a6 ("f2fs: fix fiemap failure issue when page size is 16KB")
> It resolves an infinite loop in fiemap when using 16k f2fs filesystems.
> 
> Please apply to stable 6.7-6.12

Now queued up, thanks.

greg k-h

