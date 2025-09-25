Return-Path: <stable+bounces-181669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF1EB9DA29
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6ED1BC3FE0
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 06:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28EB2F1FCA;
	Thu, 25 Sep 2025 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pmqEJCmn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53C2F0C7F
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781802; cv=none; b=ZhXKNFaxKIFoC0s0NfCQuzZEAAWDNL23bS+3gR7MQP/w+CqasJPEO1mVM/AYpNE5GzK8Ap9eMHMSxjvUEcAza3LhG0Yg1ea5JKRhsDgvG1j/cMse8YrCLvKvr5xZlQ/G7PAB9TRmoA7lu3oc5l/mkXYHP/WyIMw386g9fhMmlss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781802; c=relaxed/simple;
	bh=pzOt5PQjKJRg/zZoSWSFj8c2cUPObBR0Q+nmaSD8WLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNZjoEaMorZPPevwxGZuX0t2OZlIXKzj2ZhvmU3yTEKQsdvOlqpvu2yhMbdCCGQ1oemku/huRkFI45x5htyxbVjUNdFDU4O5vfU5oxHNPpe+VEttq/NdUfrSva4APACSn9j6zL87bbzJfSQZSJmWeWdWbJpw2tWkKmKqVXJ6U8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pmqEJCmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AF9C113D0;
	Thu, 25 Sep 2025 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758781801;
	bh=pzOt5PQjKJRg/zZoSWSFj8c2cUPObBR0Q+nmaSD8WLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmqEJCmnBi4TWztWS6kTTyWWfrnogpSwi9Jhl7U7PtlY5H6HiCjNTUhlsUVa3Mr8I
	 m+8cz09cIarmfqzIcRpJAx6iyvPR9gT7vdO09O+mIzpA7zrqvBjCjhgaVk4T0Jx1vC
	 j1pa/NCoZBDNoBXDl5E8hUHVBtBQsD8R/n0qxfZ4=
Date: Thu, 25 Sep 2025 08:29:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: sashal@kernel.org,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	stable@vger.kernel.org
Subject: Re: Confirmation on EOL for Linux 5.4 Stable Kernel
Message-ID: <2025092524-tree-reproach-7e99@gregkh>
References: <7502ef4f-a911-4c08-bdfc-eb17183e668e@oracle.com>
 <df5cf0f2-55c6-4786-b129-0a84101a5801@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df5cf0f2-55c6-4786-b129-0a84101a5801@oracle.com>

On Wed, Sep 24, 2025 at 04:01:08PM -0400, Joseph Salisbury wrote:
> 
> 
> On 9/24/25 13:41, Joseph Salisbury wrote:
> > Hi Greg/Sasha,
> > 
> > I am reaching out to confirm the projected EOL for the Linux 5.4 stable
> > kernel.
> > 
> > According to the information listed on kernel.org [0], the EOL is
> > currently slated for December 2025. We are using this projection for
> > planning, so we would be grateful if you could confirm it is still
> > accurate.
> > 
> > Thank you very much for your time and for all the work you do in
> > maintaining the stable kernel releases!
> > 
> > Thanks,
> > 
> > Joe Salisbury
> > 
> > 
> > [0] https://www.kernel.org/category/releases.html
> 
> Sorry, I forgot to CC stable for the wider audience.  Doing that now.

Yes, 5.4 will be going end-of-life in December.  Right now, with the
5.4.299 kernel release, I count 1419 unfixed CVEs in that release, which
does NOT include the known CPU vulnerabilities that are not fixed in
that branch as well (kernel.org does not assign CPU bug CVEs).

So if I were to just go off of that number, I would think that this was
already an "unsupported" kernel tree, and would never recommend anyone
use it for anything that is exposed to untrusted users.

Anyway, I understand that's not the business model you all are in, and I
wish you the best of luck maintaining that beast for longer periods of
time.  Hopefully people are throwing large buckets of cash at you to do
so :)

thanks,

greg k-h

