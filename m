Return-Path: <stable+bounces-69715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DFD9587CE
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 15:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F1283531
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C6918C91C;
	Tue, 20 Aug 2024 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XMj+YQII"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119EB18E35F
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160252; cv=none; b=Pvp+hv7sIhS9U8hCLYfleas9Dv1Q0Q/WgY4CeG/ljxGdR7H4pkdZudTfFKMEP//iQ/S545VcrKnXjkVwzDr/TPF4sbzrymID1Hnhzu07m62Eeq1gbVQ29nexBLbYfqAs7Q+F5R8V5pZVfV0XNnFKYgHbxLftf/TnsyPPChkIPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160252; c=relaxed/simple;
	bh=K9O9m+y8EKlXF/k1wFDFoEeI2ygkh5hOkILdMDP4Mrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO4HfiaWgdJqVtSS1q8e9eMccw/vg0SWQpPMM68Qum/GIYWvDnwvWGywISI5AzRncu4dtfbgR5ZkDJBIPLkHJiYNv7qnfGtXuV63i6hQKJUmqImq+D2OeVGWdgWdXpBBKrizMb2OmMp9ekZ6r6Qo4ctg1VL8/vj9EWmvi0pLBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XMj+YQII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF31C4AF0F;
	Tue, 20 Aug 2024 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724160251;
	bh=K9O9m+y8EKlXF/k1wFDFoEeI2ygkh5hOkILdMDP4Mrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMj+YQII7PR64gH9FSaBpj0SKZGiHlHW882feHeROQCSU8XrrOBHxuyR3xEgLd0xw
	 R+9B83TDcizBglSkp8N6PA3sXuKeL8GAcjnFZWnRlUvB06jjDobdu61lYA2Sg1+2RF
	 rbT9oiWiazSllYrTcNNgQKSH9rpJ9bTZdLAXVTBU=
Date: Tue, 20 Aug 2024 21:24:08 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>
Cc: stable@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>
Subject: Re: "s390/dasd: Remove DMA alignment" for stable
Message-ID: <2024082014-riverbed-glutton-ae33@gregkh>
References: <dd70606a-8121-4631-a799-86400e9a3c8f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd70606a-8121-4631-a799-86400e9a3c8f@linux.ibm.com>

On Tue, Aug 20, 2024 at 11:41:18AM +0200, Jan Höppner wrote:
> Hi,
> 
> the stable tag was missing for the following commit:
> commit 2a07bb64d801 ("s390/dasd: Remove DMA alignment")
> 
> The change needs to be applied for kernel 6.0+ essentially reverting
> bc792884b76f ("s390/dasd: Establish DMA alignment").
> 
> The patch fixes filesystem errors especially for XFS when DASD devices are formatted
> with a blocksize smaller than 4096 bytes.
> 
> The commit 2a07bb64d801 ("s390/dasd: Remove DMA alignment") should apply cleanly for
> kernel 6.9+. There was a refactoring happening at the time with the following two commits
> (just for context, not required as prereqs!):
> commit 0127a47f58c6 ("dasd: move queue setup to common code")
> commit fde07a4d74e3 ("dasd: use the atomic queue limits API")
> 
> For everything before 6.9 a simple git revert for commit bc792884b76f
> ("s390/dasd: Establish DMA alignment") should work just fine.
> 
> If you run into any conflicts, need separate patches, or have any questions,
> please let me know.

Can you please send the revert commit?  That makes it much simpler for
us to apply instead of relying on us to take the time doing it (hint, I
don't have time this week as I'm at a conference...)

thanks,

greg k-h

