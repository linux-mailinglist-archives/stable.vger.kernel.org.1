Return-Path: <stable+bounces-73072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1CD96C0A4
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1331C25174
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B53B1DC04C;
	Wed,  4 Sep 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rQIF2etM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311EA1DB955;
	Wed,  4 Sep 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460317; cv=none; b=scUcTqSmeUfVNrkaJhAPMADHHWk3A5RViMBMDMBaLlUlc2GKf16U1mJY2RoV+Z5PRtrrkC7m+kyd2xvi4OffkGMarOYcrG1YfXkq1BuqrLhykzXTeuQIInM4FYIkofaWXk3gJbSdJSZGjn3k3xDppfnpS0rqUZkj+rSUjk3NJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460317; c=relaxed/simple;
	bh=M39b2p+bQQK6HHUPEVY8Ctx/lSrzpdx8OG/iv04+qco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRbBQQRVEEUf9kptnO4aTELg4zBTm6gTjNrQoXFnjphxXYGsnRTI8MGABAsHJQ166hsRdojwnact5FmX3kheJXWV4gPB2XkTNlH4mgnGjGAihW5LjV7j/r8ZrolxNBne8kMDR4LPu/mw1O/fbGwoGwlUXCsG+Srd7Po5bz3v0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rQIF2etM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5133AC4CEC2;
	Wed,  4 Sep 2024 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460316;
	bh=M39b2p+bQQK6HHUPEVY8Ctx/lSrzpdx8OG/iv04+qco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQIF2etMS9GiBdahrG9XjZoaF7gbHzJUd4kMFG2NmuwsMS9ugDPJRJlm7+Z+sIyly
	 vOOhjsc7vQA+oe8DB6QoISm7LCqogQmeC0sOcCECOtTJy22xB74P6b9akeGt6POc6i
	 grA7djU12fXlvJkW+1EYbxXXXa8mMtcr/MtFP9Nk=
Date: Wed, 4 Sep 2024 16:31:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y 1/2] mptcp: pm: reuse ID 0 after delete and re-add
Message-ID: <2024090450-engross-unpeeled-a74d@gregkh>
References: <20240904105721.4075460-2-matttbe@kernel.org>
 <20240904110306.4082410-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110306.4082410-5-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:03:08PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 8b8ed1b429f8fa7ebd5632555e7b047bc0620075 upstream.
> 

Applied

