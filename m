Return-Path: <stable+bounces-179084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391C9B4FE27
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45E31B2302A
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B433469EC;
	Tue,  9 Sep 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SZn8Wgvj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A4345731
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425852; cv=none; b=OsJS4NdLiNkSoA+dFQrn7KaL92yW8WQmY6E1c/pp/vuF1Ib69FWdg3GE0xCqTxhKNu1IniOhjGny30Xqa8fzy41chs9tAqSAXBYLMRX+INdcpKyStSCI2vnPoUBzsqLui5BUqn724nXuJQorNnQT77sE22QazQ2yR9U601GVUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425852; c=relaxed/simple;
	bh=dPXiKTwGidWwCU6mMaOwAs6wtdQoBJp4Fh/RORtGMgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBuIxezuIYMOVoyNhLGRsREhQ/eWSGtI07LPszdaHStH9ZyGWY0xfN49XEk3+y0YxQfRRIg75vEFydqJ77MZgHq0tGbse6yhoo7VpQG84NHrIAlMMOE+LGc/ZVQxOkG+k0E9MPODFVgL317FdgralomDFFHgDvTOX1TmktvMKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SZn8Wgvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C36C4CEF4;
	Tue,  9 Sep 2025 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757425852;
	bh=dPXiKTwGidWwCU6mMaOwAs6wtdQoBJp4Fh/RORtGMgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZn8WgvjtHj/PDNbbKTPEia2sRcmL9S7YBbQ4O0fhqfToiCOEiCVT1kQubg5kAEhM
	 h4kMsxwrhcrlz4+Y7FwiUopIgb2DpTwIzwBvUaea01UU5OspfaTa1OkNC0+EB+e5kg
	 6XaE5dRXwtnkG4jW/Eybotb4GNwg0Q4HvfX0YhRk=
Date: Tue, 9 Sep 2025 15:50:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	bibo mao <maobibo@loongson.cn>, Borislav Betkov <bp@alien8.de>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dev Jain <dev.jain@arm.com>, Dmitriy Vyukov <dvyukov@google.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jane Chu <jane.chu@oracle.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Joerg Roedel <joro@8bytes.org>, John Hubbard <jhubbard@nvidia.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH 6.12.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Message-ID: <2025090921-jargon-quilt-224f@gregkh>
References: <2025090602-bullwhip-runner-63fe@gregkh>
 <20250908010931.5757-1-harry.yoo@oracle.com>
 <aL7OmhMtdLTGiVSp@hyeyoo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL7OmhMtdLTGiVSp@hyeyoo>

On Mon, Sep 08, 2025 at 09:39:54PM +0900, Harry Yoo wrote:
> Please don't apply this, I made a mistake while backporting.
> (Thanks to Pedro for catching it!)
> 
> I'll resend the backport for v6.12, v6.6, v6.1, and v5.15 tomorrow.

I do not see a v6.12 backport, did I miss it?

And what is the git id of this commit in Linus's tree?

thanks,

greg k-h

