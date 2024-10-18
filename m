Return-Path: <stable+bounces-86808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB9D9A3B76
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 12:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20B0285922
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FDB1D54FD;
	Fri, 18 Oct 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v9zLPRP2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C69168C3F
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247212; cv=none; b=aiOB1lChXY4aOweF31w/Xpoa1whjjWeA0gjsyxz0NgNzi9M6xd6iYGzr2zkj4cBxaoIWiNTibnAcUBDEeIPAsSnXtwYTBApS9qzlTCdxbCrf/+yGmohy6JKt1+PEiRcw9koXjGqbAYIDgfZCCpmFWJHoq7Cg8syXUtYE+/lCV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247212; c=relaxed/simple;
	bh=TEpjWy8ZL3lZ99fbZ882WvtPjHn0gEdqbWSdaOjRM3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsPq7PsaXzrdPTfvjA5C0zmXqG9sVvi0moPIT0Vt9RPQIFatKUNMxcZcqFQMRDSmln2R6RlvbYDJ/1OGVE0F6zaZmNKbpV2I6r3xE3xedYkfn1oGA95qAnIkiml3YE4sXYWxaXrZ49n5w6TFdrdLkVA3SF6c7veE+byiKddoxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v9zLPRP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B10FC4CEC3;
	Fri, 18 Oct 2024 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729247211;
	bh=TEpjWy8ZL3lZ99fbZ882WvtPjHn0gEdqbWSdaOjRM3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v9zLPRP20v9stmn3K5k1BELV7qhp2RX82LCrHULgCDaBn1TbSnbfrL+RiYea5fBG9
	 YBYukHzeelPZ1EVlHQizeKgxTAAYIXFPqHU8g8oCz+5oJxWmKF/Jg9IUW4X19kAP7L
	 NJ9owzTuLCkTlJlFZ3E3Wmg+zK1eDnPXZQMwOi68=
Date: Fri, 18 Oct 2024 12:26:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: stable@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mikhail V . Gavrilov" <mikhail.v.gavrilov@gmail.com>,
	Richard Weiyang <richard.weiyang@gmail.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Bert Karwatzki <spasswolf@web.de>, Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 6.1.y] maple_tree: correct tree corruption on spanning
 store
Message-ID: <2024101841-cardiac-volley-af18@gregkh>
References: <2024101840-army-handstand-92f8@gregkh>
 <20241018093347.95848-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018093347.95848-1-lorenzo.stoakes@oracle.com>

On Fri, Oct 18, 2024 at 10:33:47AM +0100, Lorenzo Stoakes wrote:
> Patch series "maple_tree: correct tree corruption on spanning store", v3.

Now queued up, thanks.

greg k-h

