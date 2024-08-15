Return-Path: <stable+bounces-67750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E005952AF5
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2A71F21024
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB117623F;
	Thu, 15 Aug 2024 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jzXakVZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874113D530;
	Thu, 15 Aug 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710517; cv=none; b=oKFGUxKYGglFov3asf9BdWXTCQXr4qcvfAaCAyymvjcZBGGmfWOR1HnxQa6VTAupkmjCgvNLb4fOPvisAZZvEeE+QgQTpfHq5Nvtd/icJdt4iv+BdeGqneY59utNvNt8k7zyZmON+bbzs7Cd6Vop+GJ31sbHtnyg5S6bZVFFmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710517; c=relaxed/simple;
	bh=ectaGmtwe2usyyRD76wS8T5EFZCo60gy4CyKqumdi4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhcqPvTeiXlBI9VWjsM0KTZnIQlPVDp5IQYuRCCkOq09TFaC01Tec0zij0uY1Mje9Ar3RriyjTsGXDbmimJWujdCSyg2dlvMVA+N86mIygpvpNGUqUlNlGkT/rspXVCzyxG63KA+X9sukMXc5UfxcI30GiNE2deyv5wzS3pwjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jzXakVZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC32C32786;
	Thu, 15 Aug 2024 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710517;
	bh=ectaGmtwe2usyyRD76wS8T5EFZCo60gy4CyKqumdi4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzXakVZfSZ5jiGVjCFkNxpkQlyeet6ZTmK0w2edM9OfQFsgUDkWclZyYg4XOl3Rf5
	 +8LWP1glETrSohv7sFfIU0yKp14arYX4hKNkQOiH12J4iWxH9nPKIz6ETwG+N3+q4v
	 MmSCVjyZGjsEm05LXoMWqnUjWUUjm2Zos85yiZ64=
Date: Thu, 15 Aug 2024 10:28:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: sashal@kernel.org, yangge1116@126.com, hch@infradead.org,
	david@redhat.com, peterx@redhat.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v2 v6.9-stable PATCH] mm: gup: stop abusing try_grab_folio
Message-ID: <2024081524-lying-decrease-e010@gregkh>
References: <20240812181238.1882310-1-yang@os.amperecomputing.com>
 <20240812181238.1882310-2-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812181238.1882310-2-yang@os.amperecomputing.com>

On Mon, Aug 12, 2024 at 11:12:38AM -0700, Yang Shi wrote:
> commit f442fa6141379a20b48ae3efabee827a3d260787 upstream
> 
> A kernel warning was reported when pinning folio in CMA memory when
> launching SEV virtual machine.  The splat looks like:

6.9 is end-of-life, sorry.

