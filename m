Return-Path: <stable+bounces-114890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147AA30850
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4510D3A28C3
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F211F3FC2;
	Tue, 11 Feb 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNgx6J+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859226BDA9
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269114; cv=none; b=IXdOf86UUtT0PSf7w4YnBPqCOJ9mOfdurg0K5Uognli/RrRy7O8F5xXpjzw+Iax05bwgRpx09e5M85H+zhTHMbdny7A8mUhWyK4L1BPn/BWUEExzMFua9ftynsjD9EKasWya1PLEwswkV1hGmEkk1oFmqlDusJK41MhqFaQsStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269114; c=relaxed/simple;
	bh=nWPgAUOIJvuOYD6HZUpqr/cs1GiR3Y4YaeGmIhGdTsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2F/WhzXQR+uY8xCVLDW5cZu43XkxlDBwtg9rB7dWGAeHdOS28+dvpDh8ILHnjANLiaa997rwm1n8tnKJUt8qBE4YBPiF3v1J1OOERSYPKlbnHIEO1jrJFQzeXIrCZf6rofycWtYaFhsMIYIN7WHePKBioAyXxXOMZfvXNg+u2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNgx6J+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2787AC4CEDD;
	Tue, 11 Feb 2025 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739269113;
	bh=nWPgAUOIJvuOYD6HZUpqr/cs1GiR3Y4YaeGmIhGdTsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNgx6J+ZBJd0OAMIIIXB22HHLVppJutggZjErMAlNmTlO1hgPncO52X3fOgaiLR3n
	 kTBBE92rEcRlVzY2LjaaR7fSt7sNXT8+tSvUBxtmfozGxPluDP3aU5/w0yG9PtlF5d
	 3VtYx/wv+ldJFEYTWkFIpfC0RBMrLhPct/YIW0sc=
Date: Tue, 11 Feb 2025 11:18:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: stable@vger.kernel.org, Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH stable-6.6 0/3] provided buffer recycling fixes
Message-ID: <2025021100-demote-graph-fdeb@gregkh>
References: <cover.1738772087.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1738772087.git.asml.silence@gmail.com>

On Mon, Feb 10, 2025 at 03:21:35PM +0000, Pavel Begunkov wrote:
> Fixes for the provided buffers for not allowing kbufs to cross a single
> execution section. Upstream had most of it already fixed by chance,
> which is why all 3 patches refer to a single upstream commit.

Ah.  Ok, that makes more sense, nevermind, I should have read patch 0/X
first...

I'll drop the upstream commit reference here as it's just confusing.

thanks,

greg k-h

