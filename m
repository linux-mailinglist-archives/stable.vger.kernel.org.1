Return-Path: <stable+bounces-19763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024A28535A6
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AA11C21263
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1045F547;
	Tue, 13 Feb 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jZAj1BB+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF955F47E
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840391; cv=none; b=gdv+B/IagL0nf5i++G/Tvg49uEmhxOeNiooVCoWZIQYDYj1NEAIvHnPTSz1dHkzlrimzOCTPdnC+Q1V46t6V+5fhPnO4kP/8eniAnmvr3J2eutmZ2LLprev2dWl3PLGV9QnmsRaS613f5wu2vdvBCPGCkt7ZulQqP9cSF7gUZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840391; c=relaxed/simple;
	bh=dbFZrZJainKhYObaJRlJGaKtrwa4JczWScRLSFcsbho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1zjhS3Zps2AgbJb+sEn20tFN+TQCzZyY1eFRSyRWviK3aFwDQMPKj1YwytHu9CoHNdxbu5aEGZPZ5AzM0hHE4UGQ4wi5dO9F37BTkVciszbukDejpAlBY8J79DSA2dM5tr1FHrDlJHFfRjDBmRNRvj1FfbA8Ogxpi7Y8fRwfh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jZAj1BB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0176AC43390;
	Tue, 13 Feb 2024 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707840391;
	bh=dbFZrZJainKhYObaJRlJGaKtrwa4JczWScRLSFcsbho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZAj1BB+GEc6DN7wQwfMMC6YYxsASw8hdwJQnpSzvkNQ5mKPW4UDKKyRRolzuFC7P
	 HQfXtGA5Uyc0+N6eCx2GFik5zig9HZj90EumyYoRW5PkFZByD9bQxPwEXaSnjKWlo8
	 Tzq/XjibNwWQU4NOiQqg6S5uNTXL96ALQiiATXjs=
Date: Tue, 13 Feb 2024 17:06:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: 6.1-stable backport
Message-ID: <2024021322-creamer-lance-9cdd@gregkh>
References: <853b6529-3af3-458a-9985-294fb63ea2ea@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <853b6529-3af3-458a-9985-294fb63ea2ea@kernel.dk>

On Tue, Feb 13, 2024 at 08:22:41AM -0700, Jens Axboe wrote:
> Hi,
> 
> Can you cherry pick commit 33391eecd631 to 6.1-stable? Looks like we
> never got that one marked appropriately. For full reference:
> 
> commit 33391eecd63158536fb5257fee5be3a3bdc30e3c
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri Jan 20 07:51:07 2023 -0700
> 
>     block: treat poll queue enter similarly to timeouts

Now queued up, thanks.

greg k-h

