Return-Path: <stable+bounces-53684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECF790E2AD
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 07:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD881F240BF
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 05:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB155897;
	Wed, 19 Jun 2024 05:27:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D128EC;
	Wed, 19 Jun 2024 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774869; cv=none; b=NYHtjfPTeXGYV/VKIDM6tZ3DnX7rYg/kU+RCEKQAqxoTQ4ofvOk8ae3v2Yw0r5n6cFlQ4KjzZzi9bBQYzN/Rb0jyMqIRKwaNVLJtwMOMOBScyrCcBVQ05Bdi0Rs1rNEjeGvXNy1nI7eR3yPLzHzlmqoExFVLY0cwzhWA1kMwKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774869; c=relaxed/simple;
	bh=kkEqZtZR7xNjtuiZSsVd09OlMcoEBydwvSMLSnlou90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea/e19CoXFfbmoO+Yyma4Ym0nENWgtkvoKlrP5Z84v3VVR2D9DigvYY8PGUnnWBsx6FjgctMfb5iIwnCSY+v92755mmMelQEum3piq+7otNXs0cl/A6WYLcmiSRhmvudRRVrxb1HwS3p0f1LiXq0EpaFhKTaeg+lhkDb19p8Ws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F89068B05; Wed, 19 Jun 2024 07:27:41 +0200 (CEST)
Date: Wed, 19 Jun 2024 07:27:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, anna@kernel.org, chrisl@kernel.org,
	hanchuanhua@oppo.com, hch@lst.de, jlayton@kernel.org,
	linux-cifs@vger.kernel.org, neilb@suse.de, ryan.roberts@arm.com,
	sfrench@samba.org, stable@vger.kernel.org, trondmy@kernel.org,
	v-songbaohua@oppo.com, ying.huang@intel.com,
	Matthew Wilcox <willy@infradead.org>,
	Martin Wege <martin.l.wege@gmail.com>
Subject: Re: [PATCH v2] nfs: drop the incorrect assertion in nfs_swap_rw()
Message-ID: <20240619052740.GA29159@lst.de>
References: <20240618065647.21791-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618065647.21791-1-21cnbao@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 18, 2024 at 06:56:47PM +1200, Barry Song wrote:
> Fixes: 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS swap-space")
> Reported-by: Christoph Hellwig <hch@lst.de>

> Signed-off-by: Christoph Hellwig <hch@lst.de>

A reported-by for the credited patch author doesn't make sense.


