Return-Path: <stable+bounces-33721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8DD891F46
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D591F3068B
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDEA13F45C;
	Fri, 29 Mar 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kImYKaAJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC313CF85
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717779; cv=none; b=iLF+76uM8pYQFzORMjSDb/sPJQtH8d4+1AOMXV3JBLhnxY1AWTm+3zmdXidrmGFOfl7AHhoYXr2fTkhUTvg2LbxGt69lJQ2EgdmRdsb4E6KeBtxEtUZeIhoQI8KD3Sfjw54l21cyNHE2QGYcG8dialaiENYc9nr57CQu6/nOjeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717779; c=relaxed/simple;
	bh=4mWqeSPQtQWtqghEcG6Lgk3PGKYrcucpu5cdW3uJH+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmzEevjIBtPnh6Sinn/P7u7kTmghNUpNNL4kRSczn0rLTltvaLCxcS92ejyjHxFuHLg7fANQ9HWokjSYzZvs5xDOHwm2pmaKsq9ri5C6Kxd2iMB4muBBZHEs4nSJxHgAV0Emrt9teHluWB35r+xvdvWWlVWdU8hG3zIedfh5UcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kImYKaAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15098C433C7;
	Fri, 29 Mar 2024 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711717778;
	bh=4mWqeSPQtQWtqghEcG6Lgk3PGKYrcucpu5cdW3uJH+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kImYKaAJ0T4JHVViX9RGReYi2P/vo4wZfyQAOziCtYH/xUeQJ0GC9AUznyxozBOSi
	 bh7HN2R2KVkgjjttiHP1x4tIU6vIHmrfUavZnSH28hM9guwSBW7z3TGivVgQeaJlSL
	 37CabHnSxwJo1sxqtHeZD8pR+pRwHFd1EQsHfLzg=
Date: Fri, 29 Mar 2024 14:09:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: kan.liang@linux.intel.com
Cc: stable@vger.kernel.org, andrew.brown@intel.com,
	dave.hansen@linux.intel.com, Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH stable 6.6 and 6.7 2/2] perf top: Uniform the event name
 for the hybrid machine
Message-ID: <2024032918-spruce-sapling-c829@gregkh>
References: <20240308151239.2414774-1-kan.liang@linux.intel.com>
 <20240308151239.2414774-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308151239.2414774-2-kan.liang@linux.intel.com>

On Fri, Mar 08, 2024 at 07:12:39AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> [The patch set is to fix the perf top failure on all Intel hybrid
> machines. Without the patch, the default perf top command is broken.
> 
> I have verified that the patches on both stable 6.6 and 6.7. They can
> be applied to stable 6.6 and 6.7 tree without any modification as well.
> 
> Please consider to apply them to stable 6.6 and 6.7. Thanks]

Already in the 6.6.23 and 6.7.11 releases.

thanks,

greg k-h

