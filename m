Return-Path: <stable+bounces-86797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D759A39A0
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 11:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1270282695
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311841917C7;
	Fri, 18 Oct 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zZhIyXVz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD11188CC6
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242770; cv=none; b=YgyQE0i7IvJaXPEugzmSDlljNnHGcbRDfABMkzr2QRMsvC6OxJEg6oVpIcick9TZZctjmE0hQvS05Qd4UYtEmvXlr9nbHxLo03Uw54tax1opT/CxxMBztQzdeONh8Rfnppz2/x0SzV+tI21rmizfFqriatBHKfozV8uZlFAbxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242770; c=relaxed/simple;
	bh=jQAS2ohEJtNXR5NeRHMTzKrJz0W/AtthpmYMtjAYRkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6jv3xmIJl2eg9062VMGYDp+zddH3JLrhKB9FCk4FwNtudCYpycKaUmMYUb7M0X2Nr10XdZLfeCcgXt7+KqcpGTIv9gQ/WgFuMz2n0zbAYAqs2ZR6Z6vKnwgBwXeSM9SeAdWgdKaATG5plSkk5UImdyXPZDNxnJrkbkrb+32n8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zZhIyXVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FDCC4CEC3;
	Fri, 18 Oct 2024 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729242769;
	bh=jQAS2ohEJtNXR5NeRHMTzKrJz0W/AtthpmYMtjAYRkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zZhIyXVzKW4+XJVoFoI6KdbUVzSUbyq9BIHe4vxkWJbyagRjGmoQEbbPboYSe3N2A
	 nkQD75EjlrVHGoI5EBmFW7+MeSTvC1Xr1urpYSibKRuZbmV2wCbBEpGz39RjMRnBSC
	 qZX3UhfKGNmqw/ztBVHk3I3cImroYTRtBMnniO24=
Date: Fri, 18 Oct 2024 11:12:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: stable@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mikhail V . Gavrilov" <mikhail.v.gavrilov@gmail.com>,
	Richard Weiyang <richard.weiyang@gmail.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Bert Karwatzki <spasswolf@web.de>, Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 6.6.y] maple_tree: correct tree corruption on spanning
 store
Message-ID: <2024101833-granular-rupture-45b5@gregkh>
References: <2024101818-ducky-dallying-2814@gregkh>
 <20241018085338.51275-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018085338.51275-1-lorenzo.stoakes@oracle.com>

On Fri, Oct 18, 2024 at 09:53:38AM +0100, Lorenzo Stoakes wrote:
> Patch series "maple_tree: correct tree corruption on spanning store", v3.

<snip>

now queued up, thanks,

greg k-h

