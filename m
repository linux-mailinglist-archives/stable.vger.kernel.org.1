Return-Path: <stable+bounces-114889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29457A3084A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9117E1889BA7
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876A11F3FC1;
	Tue, 11 Feb 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bkKvMxuO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416041F03D9
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269046; cv=none; b=mx+qGhuOHKcYCogbmmOP873xgQlepl7EhdfnqlupwzDZbuOR8kuO7iELljufCPAg7jKntSZKTIm0I4HtRyHUF+sJwrO2rYo78g9q1+qbdjsi0JNFoq5NDaZCBJZYvoXmVHGrOZmEBNZDrNpXq0zdb7q9RCvhPPYY7pt0JaOOkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269046; c=relaxed/simple;
	bh=gS/Mu+GVEiRw8nkUNDu6xbuE+6+Bj2mOPnLT6I3kGVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhHScVq9yhxgbKA9wVUoPSpPIXrV9QFkdp0gtO9WXeoN6JhO45+zyggpGqEciqAimfhYNhJNSp2d/h+mhd2fy23paJ7RiM5lrmNlX85YZPRulEfAjxCDny35CbEVILJFqK7G6B+uLhPH5wZcPyfoYu6oO9RA152WQHVlHaZsLSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bkKvMxuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA19C4CEDD;
	Tue, 11 Feb 2025 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739269045;
	bh=gS/Mu+GVEiRw8nkUNDu6xbuE+6+Bj2mOPnLT6I3kGVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkKvMxuOMmiu7TykVuVdU9LwhU7JrCSllSW7FBY1IA6kd6dJABM7eL/b9qXW3r1Wh
	 sJ3SBpfztxAA/mXHIM703E8pe68Sm9gHo1golABdU4uZ5EszW0GrYt9z8eXRc5ofTr
	 UcVIfgfSKfGFALKQUZyAXwyZh55hjXquDyeGqh0A=
Date: Tue, 11 Feb 2025 11:17:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: stable@vger.kernel.org, Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH stable-6.6 2/3] io_uring: fix io_req_prep_async with
 provided buffers
Message-ID: <2025021107-unsaid-crudely-3435@gregkh>
References: <cover.1738772087.git.asml.silence@gmail.com>
 <43e7344807e915edf9e7834275d1ff6e96bd376f.1738772087.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e7344807e915edf9e7834275d1ff6e96bd376f.1738772087.git.asml.silence@gmail.com>

On Mon, Feb 10, 2025 at 03:21:37PM +0000, Pavel Begunkov wrote:
> [ upstream commit d63b0e8a628e62ca85a0f7915230186bb92f8bb4 ]

Nope, wrong git id :(

Can you redo this series with the right one?

thanks,

greg k-h

