Return-Path: <stable+bounces-60780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EA293A145
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43223281E66
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5702A1534E1;
	Tue, 23 Jul 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gVHMLtvn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144D14EC4D;
	Tue, 23 Jul 2024 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741043; cv=none; b=Z6Mqw2ImGGk4aOvJM05/+D2bdXdXYHGwtHH9rETvoRnAyJ0/aqynR9G4TyBKaL7PEAOc66A6e0wal5gmVxJMZSuO75ax/PtaQ3Ap+FBHhlwjCsZvpBXU2f6S1zvqiEdZ+pA7pqKwLXC3KEQmhMl6I8uaVzNg4E9kJMM5ZjfYWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741043; c=relaxed/simple;
	bh=YG8Pr79ZJkF2fkapRCjNK/u75cfR4iJbVjP5FBbEM+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgAfH6+5ZlBJCmbDfWpsrLNTz3rufjMPI4mHkf7+K5YngVh/rpfcpanFQpOSvRA4nGu8IOogW5rj35Evon4Lbz9oy6XtkXcw3NrVBl6l1P61llKdGa4hmTYR3SQFQhzQud0hxf5FV2U3dQboVyF80QpBPrqnjO/GALOF/iqgU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gVHMLtvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0BBC4AF0A;
	Tue, 23 Jul 2024 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721741042;
	bh=YG8Pr79ZJkF2fkapRCjNK/u75cfR4iJbVjP5FBbEM+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVHMLtvne3IBpkKUOSyQjSQnDequ+bldjVX6yjuM0slsVDVJVvnPX64ihKtuCmZwE
	 Imx40av0uBolpXXiZGGmtR7C0pNxJLhTbnLu2IPXzzHv/Tgpnw/BQ595XdgObaDqHJ
	 lBIwUQu2rO1JzZL2MJSCotA55vavEbUv0viZoMqs=
Date: Tue, 23 Jul 2024 15:23:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: akpm@linux-foundation.org, cl@linux.com, david@redhat.com,
	oliver.sang@intel.com, paulmck@kernel.org, peterx@redhat.com,
	riel@surriel.com, vivek.kasireddy@intel.com, willy@infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [v6.9-stable PATCH] mm: page_ref: remove folio_try_get_rcu()
Message-ID: <2024072344-patrol-musky-7acd@gregkh>
References: <20240716184901.1454546-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716184901.1454546-1-yang@os.amperecomputing.com>

On Tue, Jul 16, 2024 at 11:49:01AM -0700, Yang Shi wrote:
> commit fa2690af573dfefb47ba6eef888797a64b6b5f3c upstream
> 
> The below bug was reported on a non-SMP kernel:

Both now queued up, thanks.

greg k-h

