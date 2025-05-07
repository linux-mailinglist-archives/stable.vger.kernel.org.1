Return-Path: <stable+bounces-142012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B38B5AADB84
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2EE1BC6C32
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54961F419B;
	Wed,  7 May 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msA1Jj9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A2149C64;
	Wed,  7 May 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610519; cv=none; b=Mwdb3Nph9nTSg35uKxARNQyWsLrxMDY0/4wpAorGPcf/fkrc18EQk6+HCXxyIdkSgZgmsjUSunUw0Y8aZ1SPPYgOKYDt8VHPIXrqML1I2+N/1XLtoGfceq51/F+ihwFcYbR8AQ2tF7fCA7gmooo0D2McuW7c4G/LBs6dSrpHyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610519; c=relaxed/simple;
	bh=KPQIxMcD5vuVM6Zvy46HdiBIPWC6t2t2Dx2Q1XLY+Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPOrAyjYDxGSXkl6cbXMdR3gXiENIQ+IzRyQBFF3dqJnCcEO99757+ghL4Xofk+73ECuj7me8nd+ivI7W+cYZGzNlWEidqUrOqQbSn6fzeKpyrbWxYHKpcGwIXbC6JMyyDx5F2vO5T3b/UTS6bvz/RpCfrDRBeyEPHihKcaIZo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msA1Jj9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A26C4CEE7;
	Wed,  7 May 2025 09:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746610518;
	bh=KPQIxMcD5vuVM6Zvy46HdiBIPWC6t2t2Dx2Q1XLY+Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msA1Jj9IBN81u8QZpdlvDGewj2skG+WA+OONkaBLKxO2jEdz/xoZL28SEulhm0yDl
	 Onzcs2qlwAYmtaxdZh2eNzW2osMmlqbr+G+abnLqHBayLCapSMNGPOzdgN/Hqi95Hq
	 0685pxbcOlOhj00nAgEpwzfFhznIDKJfsTCr2MCg=
Date: Wed, 7 May 2025 11:35:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Helge Deller <deller@kernel.org>
Cc: stable@vger.kernel.org, Pranjal Shrivastava <praan@google.com>,
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH] parisc stable patch for kernel v6.13
Message-ID: <2025050758-scorn-kilometer-b1d0@gregkh>
References: <aBkZ0v05A44yjoqc@carbonx1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBkZ0v05A44yjoqc@carbonx1>

On Mon, May 05, 2025 at 10:04:34PM +0200, Helge Deller wrote:
> Hi Greg,
> 
> below is a backport for upstream patch 
> fd87b7783802 ("net: Fix the devmem sock opts and msgs for parisc").
> 
> This upstream patch does not apply cleanly against v6.13, and
> backporting all intermediate changes are too big, so I created this
> trivial standalone patch instead.
> 
> Can you please add the patch below to the stable queue for v6.13?

6.13.y is long end-of-life, sorry, no new patches being added there.

greg k-h

