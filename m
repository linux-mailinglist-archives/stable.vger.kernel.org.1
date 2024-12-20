Return-Path: <stable+bounces-105394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 408DF9F8D15
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 08:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265F67A34D7
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872F19DF47;
	Fri, 20 Dec 2024 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J5Nxcrqo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84449175D29;
	Fri, 20 Dec 2024 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734678603; cv=none; b=GNkkg6pPA2xQQeoFvbYsZFnRT5EVdH+Ai07FMA+d32F2PRAUPQrbTtoVeoHky+BIXipWjhibCyBL56TT53MnTcMfQf3w9x3J811sxIPGa5Mu1qiPn24gV2VFgrpM333M/5pgScgjhRPKkXvcMFta08/xv/s9iY12+WDKflFnZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734678603; c=relaxed/simple;
	bh=+Qa20dpz1k2c9j6vQ8UiCWd2lz481p5oFDkSS/B0hoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF5IWThFRilCk9Lh33pOY95oKkomQa/RpmPgDyfbdHyuf452Hr4Vl7mBnW5hoei8ps/byKYgmKhjwaDIAVqLYIDRywm6iODzOt49NmSZ3cXajUAEt4J0dZrv4MKelHOXig4ymi6bW01Ysia3S+vjjT3aWYOmfK1zXiu/JFHkUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J5Nxcrqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF46C4CECD;
	Fri, 20 Dec 2024 07:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734678603;
	bh=+Qa20dpz1k2c9j6vQ8UiCWd2lz481p5oFDkSS/B0hoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5NxcrqoUXs+GvMI+39Hg4JYtrYykJ4MertG5+Rp/4KqLmsmqf3i0g4Bsg2psaayn
	 igOHH0/xTMHnNuP4BeyO7QiLqh6oFhaVbzHRCb6Vi0c3m/A23xtwctJ6ymZ22lJkse
	 fa0qX/sqE5IeGXO3xSvmqLCOUx6IMHrMB7vA3Taw=
Date: Fri, 20 Dec 2024 08:09:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Cc: linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Anthony PERARD <anthony.perard@vates.tech>,
	Michal Orzel <michal.orzel@amd.com>, Julien Grall <julien@xen.org>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 1/1] lib: Remove dead code
Message-ID: <2024122042-guidable-overhand-b8a9@gregkh>
References: <20241219092615.644642-1-ariel.otilibili-anieli@eurecom.fr>
 <20241219224645.749233-1-ariel.otilibili-anieli@eurecom.fr>
 <20241219224645.749233-2-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219224645.749233-2-ariel.otilibili-anieli@eurecom.fr>

On Thu, Dec 19, 2024 at 11:45:01PM +0100, Ariel Otilibili wrote:
> This is a follow up from a discussion in Xen:
> 
> The if-statement tests `res` is non-zero; meaning the case zero is never reached.
> 
> Link: https://lore.kernel.org/all/7587b503-b2ca-4476-8dc9-e9683d4ca5f0@suse.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> --
> Cc: stable@vger.kernel.org

Why is "removing dead code" a stable kernel thing?

confused,

greg k-h

