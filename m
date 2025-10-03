Return-Path: <stable+bounces-183297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F49ABB79DD
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4366848770E
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5531B2D3EE0;
	Fri,  3 Oct 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="VrCAewWI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJbP2dU1"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5AC2D595F;
	Fri,  3 Oct 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510450; cv=none; b=qW4Hq4vpiWC3cuaE9o0DIKku8SZX2y2CcvuN2BFyJkFeLemNYK0s9KPxFXFkqvQikjatN7KY2dU7KoqKIfwGosBtDqCiRt5aUXJ3/Ric5aNboBlpp1r2j2EsQiP/9HinScnKXeciLJp4G8HxKsn2QaSDDmHivwT6MBi97jWToL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510450; c=relaxed/simple;
	bh=35W1zDtcABYboWRTHG7RpMOvL/GDkuxlmUL/WfSWIgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSQAkIH3ug2lR5bd0WT44QD/dJWa4+mtMNtHTo6BQz+tOsMKC8ozTeIyaET77qaXoAI+JqLbe9sIvttHItdnH/J4cCZI6WxG5LV1f3tKbh4LikOEGuDRq9edzwrPjNdunAdkZgz8zhijFLNajICpnvwKNnZ/dtxNlExm4CXuAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=VrCAewWI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJbP2dU1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 12A22EC0278;
	Fri,  3 Oct 2025 12:54:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 03 Oct 2025 12:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1759510447; x=
	1759596847; bh=UB3IKnHmzh/QmKgOFKGx8BLdmDHf57NxnecnD+p+sRM=; b=V
	rCAewWI7sbJvCIV/zpcnz6A0CPYZVWfFX0Dtm6UVGY6RT/28Zy15ntNNBSsAtIPl
	4AeS0Pk+Ho+rYuDaaB5Hw8Klh46ivi7sHEvbAweBb3JCb/miDh0XneQcuqst6+iP
	DHK0uh+ii8tWQ/XnmCSykrps7XG21DgZeTLz9ukgJ1iOPBrHGnVuXlbxVeSYLsbZ
	cL13AnQ6Yg47zxCMlkQh0NMH4W2OUmvwFnwM0klqG7+4HdB4gezArrTeuYAxGz7V
	ME2GJ/yA/ViRO3iBOMsBiX8P2RbCtCRrrX2Qx4yOchMwc9QS9uxG0tWIxDzVxn0Q
	O8zpttlCxiJljP2WsmAzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759510447; x=1759596847; bh=UB3IKnHmzh/QmKgOFKGx8BLdmDHf57Nxnec
	nD+p+sRM=; b=HJbP2dU1gXqvJr5xZP81JrdPktlFylwZz2QyJKBRAemfB/Na89d
	4uMVsS2+JGsNIkxPYS3qPWpObEW7BZQXNk4si7jgrgb9bykcr+01O03QRuqBfSJk
	CKQ8zCWLG+5Y2L+/ZLXa7Le/UG2trAbGxDTUfJWUGjohNBewZmIkyf2BCHIxtdXh
	0ANiyZFPCCOwowLLBasMsHF8QE2PFo2kMVAU56I/zlJiufJMFrFy6TFIrjofQ7Ut
	6RU6mi1hsO08c8503/6rxQumSpu9sifWbOGYmYQkn1ixDCM91gcAXS8PGP13xoNz
	BqTB4K8OU8Q1vL3G52i84bNpPZ/X7E70A7Q==
X-ME-Sender: <xms:rv_faFkZNxLNHovlWnH8scAJa2PWTnxJ1De0JAA0q7L9aLqcfUCvYA>
    <xme:rv_faAtAKu-en65NOEO7BkuNQHdBMf6MQBzHZGG0KjclxEQVQMuT6VcOpAm_QwXFg
    Zx2rLQp6oXp7ScDUrxq6SM9lzxfjSCyn_CiVZDFn9KYh_0ZTmDuQPY>
X-ME-Received: <xmr:rv_faI8tg7UcRWHdUwZK2xxEpbyuHG-Aoi_-i5wT2AV8GfwOMyOIoUzLIigZ6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeegfeehleevvdetffeluefftdffledvgfetheegieevtefgfefhieej
    heevkeeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtoheprghk
    phhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvih
    gusehrvgguhhgrthdrtghomhdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghs
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrg
    gtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthht
    oheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepmhhhohgtkhhosehsuhhsvgdrtghomh
X-ME-Proxy: <xmx:rv_faByXTQ1ZqOnit033VWk75CST6ABfR9loiaIoWbPuFpuXKuy8cA>
    <xmx:rv_faA9UJCxiG9y9w1PnGVOf5eT3OU6WtAlopeGsVXDnqtRL7jpSag>
    <xmx:rv_faGKKq0HBVamEfVeUQIwJnZ-ReAXqkZuIfxAYkacd9LeUusHHww>
    <xmx:rv_faF-zBsHiJgoOLgY1OhO2oG1y8aGMOmT1NLku6yIyYrzyoB4Qsw>
    <xmx:r__faD9bJJNmCWQHGcetociynY8R-hhTryjqnWWVIeTPovy_N6OmJ88c>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 12:54:05 -0400 (EDT)
Date: Fri, 3 Oct 2025 17:54:03 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Amir Goldstein <amir73il@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
Message-ID: <uqijoyhj6m33aslecgbovhujpjgql2zllw4ahfpm5jfqkcsjut@yemuevv2pjrm>
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
 <nf7khbu44jzcmyx7wz3ala6ukc2iimf4vej7ffgnezpiosvxal@celav5yumfgw>
 <76cd6212-c85f-4337-99cf-67824c3abee7@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76cd6212-c85f-4337-99cf-67824c3abee7@arm.com>

On Fri, Oct 03, 2025 at 05:36:23PM +0100, Ryan Roberts wrote:
> On 03/10/2025 17:00, Kiryl Shutsemau wrote:
> > On Fri, Oct 03, 2025 at 04:52:36PM +0100, Ryan Roberts wrote:
> >> fsnotify_mmap_perm() requires a byte offset for the file about to be
> >> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offset.
> >> Previously the conversion was done incorrectly so let's fix it, being
> >> careful not to overflow on 32-bit platforms.
> >>
> >> Discovered during code review.
> > 
> > Heh. Just submitted fix for the same issue:
> > 
> > https://lore.kernel.org/all/20251003155804.1571242-1-kirill@shutemov.name/T/#u
> > 
> 
> Ha... great minds...
> 
> I notice that for your version you're just doing "pgoff << PAGE_SHIFT" without
> casting pgoff.
> 
> I'm not sure if that is safe?
> 
> pgoff is unsigned long (so 32 bits on 32 bit systems). loff_t is unsigned long
> long (so always 64 bits). So is it possible that you shift off the end of 32
> bits and lose those bits without a cast to loff_t first?
> 
> TBH my knowledge of the exact rules is shaky...

I think you are right. Missing cast in my patch might be problematic on
32-bit machines.

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

