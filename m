Return-Path: <stable+bounces-105619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2869FAE50
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF2E188356C
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CE11A8F68;
	Mon, 23 Dec 2024 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pfdR5twt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C51A0721
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734957388; cv=none; b=jjA4piVECzxSg2Tc1rlnhD0TOPUtvWj8DH85s6VP9ud7sZ69WcKkqrhU6QmSRZbwSe936ekJMw6lpzuGVpv4UnX48HolwSjl4Te6yeR4BrYG9df+fXfDD+O1vDvkAQhIF5W0V4oX1RH+Mjw2QXFXCChWPMceebkn6NtjkpemdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734957388; c=relaxed/simple;
	bh=kY/fQbZrrkBRk5NL5yWz0t9NHRHqJAX6MPE7WYQUSIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZGNd1Xm6sK5K/+PZSEx1i/WojfeL/7tLk2ZyKXw+6sNb9rWb68DvTQtEmIM/eszcCr05boidd2pW+4R+eIFfO52K1NpM+a5DjmS/g6SVdTDTZU0mA60pSIV1d6fk60i9FbmzsRFrr7So591SZjC4GcGiupIeIpMhnZSigwnEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pfdR5twt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A95C4CED3;
	Mon, 23 Dec 2024 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734957388;
	bh=kY/fQbZrrkBRk5NL5yWz0t9NHRHqJAX6MPE7WYQUSIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfdR5twtI7Pus7DbxOFQKTdDEKYKaGPzYpvOIaDQswtSQkNFCf5xvFjhO0ehgXTZc
	 vYkflonrxJ1lXr4OOpXkRleE8pNQqShfQZoBufAhjmXaRvPWrnpiI0WK5sXadIGH49
	 kCIlwG1LZdIqz1YYGHkzpIRb5wbwjCZwSx5BhNoM=
Date: Mon, 23 Dec 2024 13:36:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: 6.6-stable backports
Message-ID: <2024122314-jujitsu-modulator-9333@gregkh>
References: <164c752f-ae4d-48a5-a11d-1d7462f817cb@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164c752f-ae4d-48a5-a11d-1d7462f817cb@kernel.dk>

On Thu, Dec 19, 2024 at 11:34:58AM -0700, Jens Axboe wrote:
> Hi,
> 
> Can you guys queue up these patches for 6.6-stable?

Both sets now queued up, thanks!

greg k-h

