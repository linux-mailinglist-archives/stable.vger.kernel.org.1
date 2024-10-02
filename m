Return-Path: <stable+bounces-78607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8407598D0A3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 11:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7E01F2339B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 09:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC931E411D;
	Wed,  2 Oct 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RSE4ozNb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194801E201E
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863190; cv=none; b=JE2BI1AtjFCk7qZjMsxpV+KWtHJzP/y2a+DRfpgtsxEb5ZAaR3dnYrx5BphG9Bzl4rwPf5eHYRR0yXRtWakZLXMHC44T6KhzUbdV3+iAsnbbSkKD7oeVcNihLJetvwyRvlFycUsN8YIa+lan6nv2ke9GNKEmI9o2aUpoWYAkc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863190; c=relaxed/simple;
	bh=1hTCDS1aDE0Vt2GvOCVQhCoDDSQHMwpow15VqwrCdUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVpjslIOUvpNSaGVMAIviYEgqZaboILHldF/JAU61gsPWK54n5pxyp+8jD3d2uAOFSd/+rp8zc4ZSXyo0rBgc7sbzAhnxgAncAJ60MyJt+Src06Wd0sDdFuujrMvD3MG6g/FxC56Po+Lf9WCRPcvNm3d9KCmGl/OSbDzne4FYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RSE4ozNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D8DC4CEC5;
	Wed,  2 Oct 2024 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727863189;
	bh=1hTCDS1aDE0Vt2GvOCVQhCoDDSQHMwpow15VqwrCdUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSE4ozNb/EZMz0kpj9KIs6TGm1wl+ZUmoWGthZ63ZK0wzaMtstI5CGdbUAZNKNh3x
	 GDg9rhVoARdwxpRneESKo69WaKSy6VXj4y3raq/FMtlj6gpkOhe8kCmKE03CFFBxDB
	 VSS8nbjs3BuwK1giMpS0/4YMG7M34JgjGTMhEsaI=
Date: Wed, 2 Oct 2024 11:59:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org, Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Abhishek Rawal <rawal.abhishek92@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y 1/2] icmp: Add counters for rate limits
Message-ID: <2024100238-distract-stimulus-ecc3@gregkh>
References: <2024100127-uninsured-onyx-f79a@gregkh>
 <20241001150404.2176005-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001150404.2176005-1-edumazet@google.com>

On Tue, Oct 01, 2024 at 03:04:03PM +0000, Eric Dumazet wrote:
> From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> 
> commit d0941130c93515411c8d66fc22bdae407b509a6d upstream.
> 

Both now queued up, thanks.

greg k-h

