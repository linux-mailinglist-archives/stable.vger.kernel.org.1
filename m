Return-Path: <stable+bounces-111085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290AAA21921
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADCD16390A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C619C543;
	Wed, 29 Jan 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L0Szo1OP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01448183CA6;
	Wed, 29 Jan 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738139805; cv=none; b=sbM9fIiWb8fMsoN2FIFwiqVTK6mAekuu4HwY7WVW9WJXwzqmOZpbp8XTad5adCQxphLaXpBL31YCswAGIou5IIEK0K4RHWeqLgROcaNCehEUVLzAN1fyXgXd1GQjbcGC9c0A2ss5WFrhpnWgw8sSlOxmOVa5ccjpzNZCQRWeXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738139805; c=relaxed/simple;
	bh=VW2r6/JfcXBwlJAM+bj3qoZydV8ADfVuANDZWaGlq1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OomyTjFjWqALN+9A+nJC0N61zhZpTa9bYq70rK1qZ+iYW0/WgMhNIUR4RRa73JkhTbG+I0zE8T2xIb+7ZhxraJRJ+btscK8IDZVxrgrXVnOyFVpt3nfbKwkDtJ1aCL0XNgRdbvhu6GlW3K6wiYpXDdv6k85YmLMBnptxikXsDlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L0Szo1OP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FABC4CED3;
	Wed, 29 Jan 2025 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738139804;
	bh=VW2r6/JfcXBwlJAM+bj3qoZydV8ADfVuANDZWaGlq1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0Szo1OP12RiVurJQJGyYYgqz6jPTKmhBt+YSI0rGbppuJQsW0C73y5fq1TtdVjv/
	 2/Jiy69mXaiswLMODjxzA/Ztcwsldv26K2UY920wT3S6CPdVh7lu21ptcTlJrqdeqt
	 b1rezmUmtUpPfyx6LBojtI0hxPdT+u8aG50sNHXU=
Date: Wed, 29 Jan 2025 09:35:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: Konrad Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"jgross@suse.com" <jgross@suse.com>,
	"sstabellini@kernel.org" <sstabellini@kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org
Subject: Re: v5.4.289 failed to boot with error megasas_build_io_fusion 3219
 sge_count (-12) is out of range
Message-ID: <2025012919-series-chaps-856e@gregkh>
References: <7dc143fa-4a48-440b-b624-ac57a361ac74@oracle.com>
 <9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com>

On Wed, Jan 29, 2025 at 02:03:51PM +0530, Harshvardhan Jha wrote:
> Hi All,
> 
> +stable
> 
> There seems to be some formatting issues in my log output. I have
> attached it as a file.

Confused, what are you wanting us to do here in the stable tree?

thanks,

greg k-h

