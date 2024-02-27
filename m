Return-Path: <stable+bounces-25255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A78486988E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F747B30C73
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5041420DC;
	Tue, 27 Feb 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cBIG+Dzp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133A13B29B
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044292; cv=none; b=t5OKAhvqo9U5U5ljJUQdWqdxpBV7IDf7F3BPjxgiqXhwHFtGRKoiukIPNMHR/Or+FsURatynA+0LvW5Ntzd32XdwxT1nFdlQu71p7pJPxlc8FCUf0h7uFNqGzLSqtBgDZFyqVX1cW4UXgCM/zoULkrauN+34qqqc9P6SfWyIXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044292; c=relaxed/simple;
	bh=5cVuEAGxUnNBCp9YXWKrEWckBQYMl7EBw7ySs6hG/yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwEgtHvkjP/0g9NkYcUqvJTFMZGSIFJhIz/TFzFd1RInvaCOPI3trYnKAw9QsfVMVVF8G7ntHQf1qpNQyXAutnVSUE/2moPI0iylt5DPAmekbHd/wprMkYiEqS54bk2PLRQlOYcbdip/Fd7vrziAZvUtq5/zsqq5MWf87ihKO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cBIG+Dzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FE7C433F1;
	Tue, 27 Feb 2024 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709044292;
	bh=5cVuEAGxUnNBCp9YXWKrEWckBQYMl7EBw7ySs6hG/yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBIG+DzpUegEw3VeuPUCwAkf5xeJW6Ja0SOnrOu+h0PzrTo5g9aPEcfZLdi7soVhT
	 TEInMgV8iFvzMdxBj+1eSSG3TtEO2LNUmH0RuXMo4iAoYBmEudESY4frfMiwyXZUNo
	 X3wdsTlDxYCPHtv3E3l2g/l78fzKQmDNzDMur94o=
Date: Tue, 27 Feb 2024 14:32:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, guro@fb.com, hannes@cmpxchg.org,
	hughd@google.com, shakeelb@google.com,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] memcg: fix use-after-free in
 uncharge_batch" failed to apply to 5.4-stable tree
Message-ID: <2024022704-overjoyed-display-b5cb@gregkh>
References: <2024022759-crave-busily-bef7@gregkh>
 <Zd3jqLMSktEpZPM4@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd3jqLMSktEpZPM4@tiehlicka>

On Tue, Feb 27, 2024 at 02:29:12PM +0100, Michal Hocko wrote:
> Why is this applied to 5.4?
> $ git describe-ver 1a3e1f40962c
> v5.9-rc1~97^2~97
> 
> I do not see 1a3e1f40962c in 5.4 stable tree. What am I missing?

It is queued up for this next round of releases in the 5.4.y and 4.19.y
trees.

thanks,

greg k-h

