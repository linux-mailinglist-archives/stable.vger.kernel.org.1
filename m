Return-Path: <stable+bounces-206352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD51D049DC
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58553296F48
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2053B8BB5;
	Thu,  8 Jan 2026 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlmxKosd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C643A9639
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880193; cv=none; b=gVMz68oGY2V2Pto07e6O4fd8AjMuU8MKK+w6C2AhaT/CePasrBWao1KJBSzq6YxwwxtYspOOHrvU5d4+9Y6Lf2yNK+RAe1LXDVKNdxvRqWDh32yFRNw+rm80xYLRE2kd4TG74MIQad/DoJRjC0jEFf9HybOKCahqGHJ1QjwnUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880193; c=relaxed/simple;
	bh=dj9sdbT2lsAp2DCg/kTXsKPF6jUNVjpQUi6zVaIKlmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmW7WBPMTahMbX7V5J/ZBpcanuf/Of89ozyBAQAZOTn+av0oKfx9myymXCZPxvG2LvjSnR/0DE5woGy9qvbSSDMVrpTKhq5s4Y7dyRSgSffs9pTF6taemObS9qO8fY6JvXgTetutx3mx0QKTx9RPZBUpQQK17IxjPI7RL5eturM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlmxKosd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4562C116C6;
	Thu,  8 Jan 2026 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767880192;
	bh=dj9sdbT2lsAp2DCg/kTXsKPF6jUNVjpQUi6zVaIKlmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlmxKosdoSD2BMW7CRXjNHaYi6ZPeRcYJOMUl4VZABpXysEoYKX97rQd57D+aj8BY
	 CLvR5h+k6xyV0c9dSFubpPhPjryEVDIIu3PL+Df9bzPxwupJLdXlBjWaIIhE3EC/SS
	 ebKLVPvqVBq7tb1kswBfIOmZclHpjssFR084TgaA=
Date: Thu, 8 Jan 2026 14:49:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: stable@vger.kernel.org, Liam.Howlett@oracle.com,
	akpm@linux-foundation.org, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
	hughd@google.com, jane.chu@oracle.com, jannh@google.com,
	kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
	ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com
Subject: Re: [PATCH V2 5.4.y 0/2] Fix bad pmd due to race between
 change_prot_numa() and THP migration
Message-ID: <2026010836-abdomen-drilling-6326@gregkh>
References: <20260107032559.589977-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107032559.589977-1-harry.yoo@oracle.com>

On Wed, Jan 07, 2026 at 12:25:57PM +0900, Harry Yoo wrote:
> V1 -> V2:
>   - Because `pmd_val` variable broke ppc builds due to its name,
>     renamed it to `_pmd`. see [1].
>     [1] https://lore.kernel.org/stable/aS7lPZPYuChOTdXU@hyeyoo
> 
>   - Added David Hildenbrand's Acked-by [2], thanks a lot!
>     [2] https://lore.kernel.org/linux-mm/ac8d7137-3819-4a75-9dd3-fb3d2259ebe4@kernel.org/
> 
> # TL;DR
> 
> previous discussion: https://lore.kernel.org/linux-mm/20250921232709.1608699-1-harry.yoo@oracle.com/

5.4.y is end-of-life, sorry.


