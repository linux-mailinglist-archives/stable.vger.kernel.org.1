Return-Path: <stable+bounces-111090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A74A21963
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708457A2998
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774D11A8F68;
	Wed, 29 Jan 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QZgZiXRb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC572D627;
	Wed, 29 Jan 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140599; cv=none; b=FHlAgmhXOQH0WHVZ7fcd6hOU8V+w5O17RoRn7xA+tdxdGtan/EggrKVPEXiLZTKICyi362PcItG6Ogr58yniGUDQ4kC8A/sbIRqVBuTHUAauNxWc9shOTO5wke6IMoRKJZGakP6PGBDEB17Fc16H53xB5psAzCHWDcXK9hVxuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140599; c=relaxed/simple;
	bh=GhtbiGXAup2zSnK0rTNOp5a0088ODKNAXoLr5CdWgrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYCAP0mUosnhYqK67+k459R6yIDl/Yf9ScmDOsmeJ6y6fxd3qU+t2kqR34362P6jPmVsI0G8cM+bvcsHYWnPRVbMRK0fnpD/+WrBLWme7zMDQhGwra9ahCbUXrzi4pkpMYwAKBdn0gylv+L00WyfTGJxfFSgBs0qIKdvwqkVDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QZgZiXRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D271C4CED3;
	Wed, 29 Jan 2025 08:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738140598;
	bh=GhtbiGXAup2zSnK0rTNOp5a0088ODKNAXoLr5CdWgrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZgZiXRb8ap7vkF6yA3fGyQ+a/CORYegw0QExaxrp3QikHRLBEFtCRYB4a3SwePop
	 nWbU5xcupYn/XEUHd7N67uhsd58DvR6ngNJ/RJJZuRGJSoAdqUT8vFzsZxA8mkHGnq
	 HJ1tu7EgMVeJwWwF8qYF/7LqnjjzJ+toAcKVtnIw=
Date: Wed, 29 Jan 2025 09:48:58 +0100
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
Message-ID: <2025012936-finalize-ducktail-c524@gregkh>
References: <7dc143fa-4a48-440b-b624-ac57a361ac74@oracle.com>
 <9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com>
 <2025012919-series-chaps-856e@gregkh>
 <8eb33b38-23e1-4e43-8952-3f2b05660236@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb33b38-23e1-4e43-8952-3f2b05660236@oracle.com>

On Wed, Jan 29, 2025 at 02:13:34PM +0530, Harshvardhan Jha wrote:
> Hi there,
> 
> On 29/01/25 2:05 PM, Greg KH wrote:
> > On Wed, Jan 29, 2025 at 02:03:51PM +0530, Harshvardhan Jha wrote:
> >> Hi All,
> >>
> >> +stable
> >>
> >> There seems to be some formatting issues in my log output. I have
> >> attached it as a file.
> > Confused, what are you wanting us to do here in the stable tree?
> >
> > thanks,
> >
> > greg k-h
> 
> Since, this is reproducible on 5.4.y I have added stable. The culprit
> commit which upon getting reverted fixes this issue is also present in
> 5.4.y stable.

What culprit commit?  I see no information here :(

Remember, top-posting is evil...

