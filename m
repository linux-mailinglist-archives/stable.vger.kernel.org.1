Return-Path: <stable+bounces-40570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D098AE3A3
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E9B1C2266E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 11:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660D7C6DF;
	Tue, 23 Apr 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GLtvpLnT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5697520B33
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870904; cv=none; b=jWq8sGEa6OQd1W3Pq8Pq8tK0m0LGiT9pTPwiz1NxtDuH4DjZjMGkRlPPU9lJrPVWC7Yre4UcoE/8k0BbDyCS0qBbQ9Jh85aD6zuf3lSQQHEjQffrRJXxm8mraovf419HAA2J+6hMODEvW/25pULtQEpgSL/xjYV5xsjIzxVNNC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870904; c=relaxed/simple;
	bh=bPL+oCeitGa5hmP62KTox2nIQWpeAtWMdG4vlVtdjLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1T99OFtD1fs/81wxxjoK4Wh5MpXLwT7VJECZRBVontTDEhd7aA2NvflBntoMjlSNbuiqXQj+6vfR6WlEh/xoW3sbGGb6Rgq38oO8TNXzRFk+SQNNdsdphnATx7k6e2nlk4sKBB+U8oivJpoJaNVJq3hupo26/iGFspWBpuwUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GLtvpLnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D417AC3277B;
	Tue, 23 Apr 2024 11:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713870903;
	bh=bPL+oCeitGa5hmP62KTox2nIQWpeAtWMdG4vlVtdjLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLtvpLnTtb2oWze1wdXeqlVYuuEh27vE4ZjkybtpDTGlEBwtzSvL/QbQrySJppxMc
	 8/XKMW/oc5bwzY7oVSs3KxCRoee27MP/wsfyGT1kKvD0yu2HMwWTPOLVHPCwu1J7/g
	 Q68cHy55owvvDNMR2EK/QC74Stx4ZHEvEdd8Pg0o=
Date: Tue, 23 Apr 2024 13:14:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: imran.f.khan@oracle.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v4.14, v4.19, v5.4, v5.10, v5.15] igb: free up irq
 resources in device shutdown path.
Message-ID: <2024042321-mutt-roman-d8a2@gregkh>
References: <20240312150713.3231723-1-imran.f.khan@oracle.com>
 <2024032918-shortlist-product-cce8@gregkh>
 <28752189-6c59-4977-abda-2ea90577573f@oracle.com>
 <2024042347-establish-maggot-6543@gregkh>
 <def9e0ce-2998-4fe9-a4c8-151ed442e541@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def9e0ce-2998-4fe9-a4c8-151ed442e541@oracle.com>

On Tue, Apr 23, 2024 at 09:49:00AM +1000, imran.f.khan@oracle.com wrote:
> Hello Greg,
> Thanks for confirming and I am sorry for the confusion. I was referring to
> kABI (Kernel Application binary Interface) which is a set of in-kernel symbols
> used by drivers and other modules.
> We (Oracle Linux) try to keep it unchanged so that external third party
> kernel modules or drivers work without needing recompilation.

That is your business decision to do so, the community has no such crazy
restriction at all.

But the comunity does ask that you not top-post email replies, so
perhaps fix up your email client? :)

thanks,

greg k-h

