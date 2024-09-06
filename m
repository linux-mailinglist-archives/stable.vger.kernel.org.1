Return-Path: <stable+bounces-73771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2641496F1DF
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 12:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DC7B22197
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102291C8709;
	Fri,  6 Sep 2024 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="alkqdXpc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515981745
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619727; cv=none; b=iRXfr9/4h9e4YIfuthYwlwMK2chNmYrRxz2N2GBCPGU19SikfCQO+z6SJZMpK7QRssBY2g2BxeF53+GNXBz/JbA0U8Fzwgmm3LZc9aMN1Wg5NsZsM/Fd6nwaX906+R7wjmaY+1j+jaakmRkJwzmfXhVK7zaZYsSg2sDJvo1TQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619727; c=relaxed/simple;
	bh=wnxk5mnYyoJlS61pSw6x8BSqgI+os4CUyhjRFs6FTGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNlosgw27enSlpLmQWgQZ+fg7aSlz9tjz8aWHoPGDsseajws1jSy7p7+FWkFntXLFfF/Cxa/WnIKK5XNS7LT7SObB8y7eqoZvHyi7MwGOOpQn3X4aWS5pGA+K6j3RIXMVFi7ileIYhNtH1i+UAXtBr15zQpj5tFZrdaMBL3Nh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=alkqdXpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA464C4CEC4;
	Fri,  6 Sep 2024 10:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725619726;
	bh=wnxk5mnYyoJlS61pSw6x8BSqgI+os4CUyhjRFs6FTGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alkqdXpc3QOEROZ7n5ProkQc9OmdwlEcXxtC79TiGX7XM6PDtPsgDHhzwHz10GmoF
	 xvXpI9icnp6rwMVQXgrRDcb4d4vLgKfFRTGttMiJrcGKjaKOLKEszngkybO1v/PlE6
	 WzMB6Knahi4+8Po0tTtfGkDBvtIie+QGtKXR/7Rs=
Date: Fri, 6 Sep 2024 12:48:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Cc: stable@vger.kernel.org, smfrench@gmail.com, nspmangalore@gmail.com,
	bharathsm.hsk@gmail.com, lsahlber@redhat.com,
	Bharath SM <bharathsm@microsoft.com>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>
Subject: Re: [5.15 Backport] cifs: Check the lease context if we actually got
 a lease
Message-ID: <2024090644-capacity-shadiness-c25e@gregkh>
References: <20240906102040.28993-1-meetakshisetiyaoss@gmail.com>
 <2024090630-crushing-eskimo-af87@gregkh>
 <CAFTVevVJq6m74GgPzAqTT1AQeiNt2tr3DfQL2tJmfM2wj=SgNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTVevVJq6m74GgPzAqTT1AQeiNt2tr3DfQL2tJmfM2wj=SgNg@mail.gmail.com>

On Fri, Sep 06, 2024 at 04:07:59PM +0530, Meetakshi Setiya wrote:
> Upstream commit 66d45ca1350a3bb8d5f4db8879ccad3ed492337a
> 
> Yes, you are right, it would be good to backport to 6.1 as well.
> Please let me know if you need anything from me.

I need a working backport for 6.1.y before we can take this one.  Oh
wait, it's already in 6.1.16, a long time ago.

This will be fine, thanks.

greg k-h

