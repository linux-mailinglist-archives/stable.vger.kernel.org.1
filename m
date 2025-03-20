Return-Path: <stable+bounces-125648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60329A6A68F
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 13:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5168A3803
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403151EEE9;
	Thu, 20 Mar 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Myzyte2f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D269C487A5
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475398; cv=none; b=aZXZ9oi1n30vsAokfZU7qDbUBFUyJlkji5SGJpvCiYbW6UL1zLNewS8PT2r6X9vBa4cIcGg8+8Nqv/VEJ3dKFm88CzQNcg19jymG9lXrAlz4nkCAoo2aKVWSYMshTvUqtMpkCwWWkyTyQKdUVy25wHVsLHfkzDakH5FhIEE97ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475398; c=relaxed/simple;
	bh=wlBDLf+cDw55AlWjZNEfMuWi0VW9PjNOtIsGDs6j8FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUzvUjivTS1cGh+eh3rG/7waens/QiRiBckIPpdlUyuVZB6xb4+yu4XCZIRbCfrccjEU/d8leox/cOmaBOPiovaFY/wQUf4O9JWQsGBsy/kSduKujM441U3wWHv0OEMbbEVXXEdKFCGXBRkc2X8ri1sAUbSSmzp9MVP8W8sKuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Myzyte2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C7DC4CEE3;
	Thu, 20 Mar 2025 12:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742475397;
	bh=wlBDLf+cDw55AlWjZNEfMuWi0VW9PjNOtIsGDs6j8FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Myzyte2fJh9Y22MUplYACQM1XZIGfXr5K/Xm2jkoEWFMWuhqrIkiR7eNBWDMgFzj8
	 8/+VwMQMKnFJRjVt4CeNnr7cJVyNNG6d+tGTFjxEI9JdPorLhEy4/w3C0oJkj/RuQv
	 UWvtMBbva15bmRK1V1JHpWDC4Bmmv6DlV1HtqOHY=
Date: Thu, 20 Mar 2025 05:55:17 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: philm@manjaro.org, stable@vger.kernel.org
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
Message-ID: <2025032007-symptom-zero-8b17@gregkh>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
 <20250320112806.332385-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320112806.332385-1-laura.nao@collabora.com>

On Thu, Mar 20, 2025 at 12:28:06PM +0100, Laura Nao wrote:
> Hello,
> 
> On Fri, 14 Mar 2025 16:19:13 +0700, Philip Müller wrote:
> > On 14/3/25 12:39, Greg Kroah-Hartman wrote:
> >> Can you bisect down to the offending commit?
> >> 
> >> And I think I saw kernelci hit this as well, but I don't have an answer
> >> for it...
> >
> > The same kernel compiles fine with the older toolchain. No changes were 
> > made to config nor patch-set when we tried to recompile the 5.10.234 
> > kernel with the newer toolchain. 5.10.235 fails similar to 5.10.234 on 
> > the same toolchain.
> >
> > So maybe a commit is missing, which is present in either 5.4 or 5.15 series.
> 
> KernelCI is now reporting a pass on the stable-rc build (5.10.236-rc1),
> though I was not able to spot exactly what fixed this.

That's good to know, thanks!

