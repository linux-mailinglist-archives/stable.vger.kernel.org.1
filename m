Return-Path: <stable+bounces-67526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1223950B5A
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9BF1F23FD5
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A01A08DC;
	Tue, 13 Aug 2024 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BgoOLK1Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a8F4VYMi"
X-Original-To: stable@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB5170A18
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569951; cv=none; b=JMjXnVMFmTST8B6fMQU5rDxpNYv5S9H0wIimgUQxf5Er287rvypw7OVPbP8L6vaCsDAXAb9Cwf5ybe0vsiYtEwoOMMn/2IOxXiBo5coGf/Vcm0404P+HkqpQH6hESkQ724vctwwpUZiyum8JlG8ZV9/h4gu/CTCnwyWsr/g7UgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569951; c=relaxed/simple;
	bh=9Py57A0kVNxPv00PLdYoD0mVdIR6E0lGlXnvbi41SZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki4n8E05yosJyCbTOCOr8cjPJGsR8zLEu+8GxDjwtt9WlwworBMFdAYMjgpT04wa1xaHcbvUYgL47jbLln3PDqHSMz5xhWTXYN06f9K+d2ydKYA5BIPNkSFXwu/zKU/r4CE3lmaCtabY15XdXf7ZLV2DPdLotejjmAxhjiWAsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=BgoOLK1Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a8F4VYMi; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 177A1138DD43;
	Tue, 13 Aug 2024 13:25:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 13:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723569948; x=1723656348; bh=rTrE7LjtC+
	RK+UUekm1xghciNwpu6bAl4jO0gST0Rco=; b=BgoOLK1QMOlPAwQQr/C6zsNXzg
	Jkp2ezHAsZml3S+ZN4xyf7m+3o/e8eODzTLPUJoHR5HWc/W0KsJaTjF6i4pt1sLb
	rMDyTIJURsCpVd4ZVwSbZYcAqbK0aZBKBncNASuMHnW7FIX9Ug8xtSnGeVxKYoZ0
	DSAf9xQRiqZCQPHrwjQL6xVyzMXCDG/L+0t9Z/dalP6dygqHtKIVQhTFfhWKTH82
	dx9WM0BUmqmDoJMv9KXcxQ/2fDFB5mTWKEZsV7YBqzmsLnrPrBf9ZNEK/9aOxHXP
	CFvaJhCVhu4OHCEWY3q/BngNfBvd6lJdCp8VSux0hT15/sqvTA914DdcMksQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723569948; x=1723656348; bh=rTrE7LjtC+RK+UUekm1xghciNwpu
	6bAl4jO0gST0Rco=; b=a8F4VYMin1tlJI8k3ginLvadbCS+lyyFjRmlFTmtsFyY
	DEw+SD0EFkZTlCT//fkuDqObMR65HPFWr5TEKZ+Sa0wgxvkTL0SSjaSStlEGxWTF
	E5titBkInyZuR47E2hXE8gHNTR6TXIRQSw9nWpLTWO606AfAJ2Qa1GphHmmZ6n4f
	9RfbbR94WUUDLjdSqVp9fPElX211eEHMWC7TnAPXC+iM0VZNZYYGnGmBVS/fb0MR
	I7k+UsUmRGl16PVuog0WpNgPP7hgEBuMG33rbDtrvMtPVTMV0aDqvPPrKIKGe8oh
	wAWwn/5BCCRNl93nMGEYlkDBzeIbGWPOtF7kBHdLLw==
X-ME-Sender: <xms:G5e7ZlQ3g_86c7Q0ob2ywywKh634_9hHfkTi7dZInlOyg2j0ivZLig>
    <xme:G5e7Zuwi-s97S8IpNfBufkTb3gqMYBedxup8SchMHMx0xoKRO6to7cxFVj2dSp15N
    wwrSl-kW0OTZA>
X-ME-Received: <xmr:G5e7Zq0-0Rmpu9R-CPNw5aJFQ9BUEUkGQOAnNfveYNViHFwbLu2hWCHmo3N02sWaSqE-bW6PfBFkDf9fgntpJQlSeBLP673Xeuxh2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeelieetveeifeetleefheevgedvteevhefghfdvjeffvdelvefhffeg
    ffffjeelgfenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgr
    hhdrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrnhguihdrshhhhihtiheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphht
    thhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrg
    hnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhsrdhprdifihhlshho
    nheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehjohhonhgrshdrlhgrhh
    htihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrthhthhgv
    fidrrghulhgusehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhoughrihhgohdrvhhivh
    hisehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghvihhtthes
    ihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:G5e7ZtCJxg5i10wG5LQyPpvdBwYOcB4nVK3gR4OXvkyE2hZdQeifdw>
    <xmx:HJe7ZuhRXVJLSScyyIFv6CA3g3DEYsFUj7bGqyDe-G80xYZ59mlZ2A>
    <xmx:HJe7ZhrsGBwWI55HvynREL3_e_DKVaHeEfSm0JPQc_y2dqRR4cvjoQ>
    <xmx:HJe7Zph0UQGrwdME1xbvfTH8bq8c2gbclfSoiwi3gPJwRLoy2C-6Xg>
    <xmx:HJe7ZlTQAgkxa8-YN_3-ttEGTH-1M_uCLnO3V2m5_51IwISYWJPfVmaR>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 13:25:47 -0400 (EDT)
Date: Tue, 13 Aug 2024 19:25:46 +0200
From: Greg KH <greg@kroah.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <Jonathan.cavitt@intel.com>
Subject: Re: [PATCH 4.19.y v2] drm/i915/gem: Fix Virtual Memory mapping
 boundaries calculation
Message-ID: <2024081335-rentable-silica-014d@gregkh>
References: <2024081222-process-suspect-d983@gregkh>
 <20240813170930.75663-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813170930.75663-1-andi.shyti@linux.intel.com>

On Tue, Aug 13, 2024 at 07:09:30PM +0200, Andi Shyti wrote:
> Commit 8bdd9ef7e9b1b2a73e394712b72b22055e0e26c3 upstream.
> 
> Calculating the size of the mapped area as the lesser value
> between the requested size and the actual size does not consider
> the partial mapping offset. This can cause page fault access.
> 
> Fix the calculation of the starting and ending addresses, the
> total size is now deduced from the difference between the end and
> start addresses.
> 
> Additionally, the calculations have been rewritten in a clearer
> and more understandable form.
> 
> Fixes: c58305af1835 ("drm/i915: Use remap_io_mapping() to prefault all PTE in a single pass")
> Reported-by: Jann Horn <jannh@google.com>
> Co-developed-by: Chris Wilson <chris.p.wilson@linux.intel.com>
> Signed-off-by: Chris Wilson <chris.p.wilson@linux.intel.com>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: <stable@vger.kernel.org> # v4.9+
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Jonathan Cavitt <Jonathan.cavitt@intel.com>
> [Joonas: Add Requires: tag]
> Requires: 60a2066c5005 ("drm/i915/gem: Adjust vma offset for framebuffer mmap offset")
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20240802083850.103694-3-andi.shyti@linux.intel.com
> (cherry picked from commit 97b6784753da06d9d40232328efc5c5367e53417)
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
> Hi,
> 
> sorry for sending this v2 after I submitted a patch with a
> compilation error. It slipped off a variable (obj_offset) that
> was removed for kernel 4.19.

Much better, now queued up, thanks!

greg k-h

