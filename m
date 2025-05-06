Return-Path: <stable+bounces-141808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA16AAC473
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72F83A7DEA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA527F746;
	Tue,  6 May 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cQS7wEU9"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5127CCF8;
	Tue,  6 May 2025 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535450; cv=none; b=HPtfBwL2323AzaaDbRh0iSZm5FB/w35RAHe+xFqa3Rg5Yzvg9BTP0oFdBtwGQs8BBRuHm1XVSEH5grLZBNqiOHFd27+TNI2Ka2h8CttgNMfvqJvx+Ai5e2DJ/MtwE2euL81FRlcNbvW4s1oO7Cf5XHvUmAwgb5nobS6OvjIusWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535450; c=relaxed/simple;
	bh=/L3XmGtIFiX4tt8EhNWg/6q8giENo8uNABzOmE6p9Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO6ya2Bh7b2A/QewO5mo1sWcc8oQWU8T6/CchO2sO3CbI/JLOpVRGB9afECsAi2zp7yGEidr3MlWaVj0KDCcov99tYtXYq3/1jd4O6T0UB3BCGPtia3tn/pQkWzMpH2edxbzkO8PyOOZgN+rInEmHJng9dpwXjf/lkOxdHIy9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cQS7wEU9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5D44140E01CF;
	Tue,  6 May 2025 12:44:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IO4qrzcWMvLz; Tue,  6 May 2025 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746535441; bh=TFyszQGGGUYfm+QSJHfXCz5fY/1+jCioiDVt/Dv5Q4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQS7wEU9mIfZcYeeTVXir7XqDSAbf09vKGa8OGtv07ROB7VbHtVIfkdJry5/k8tsO
	 OIuizKwYG5KfNghBfcxeOodY5hkGWG4Tt+2t8iuEIiMIoovhmWwxpv3pS/HTswSmwU
	 npT018lwFz3Z8dEnWn7EjvY84sz3W3A35NCVSf61SKVHh915lauam9TeGeZWlOIdwL
	 IUJDZI9yE8gsxoUGwWu69Y18yumO0SQyxvdMQiCeq5BoCbgVJA37B9Y2vPOPS0JW0q
	 ijo2SoNOB7UNt7tQELSjfXNmyyUVRQ9/Ve8+QoTeHm6nOyukjCkI3UFJurQgoWU3Cf
	 PmLUOmxoioKJrmP5jg2gYJxCzOryFHaCzrt1CbvNiSKyhFPR3AmYB2iBHvk5KnG9pt
	 mQ6LkwyDl7FSWLvYyxXCAIXpJ2im+9+SSBpmrEcaFbo7kKpC+HEjJCrQ1kkbpDulrn
	 F94YYRjM7v0FmqvCpKYhDVzFa61KY7YB9ydbmCBqn/v+3RX6oTNxcETsJMQUdDNm5p
	 mjqS3muNhLxBtVMMiFL7rk31uGWE17rrzqZ+KscBEReS4MDCP7z4yczsRgdYutFdm6
	 BsrJ8mF6EvpTiIwiR1KDF4QuvFZovDHgd0wAKiiNYETYZ56D1V6TBHT77b5oSaes8g
	 Sa6Lr/9lmzGYeZv2VA2ob8h0=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5D8640E0173;
	Tue,  6 May 2025 12:43:46 +0000 (UTC)
Date: Tue, 6 May 2025 14:43:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	tglx@linutronix.de, david@redhat.com, ast@kernel.org,
	linux-mm@kvack.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_alloc: Fix race condition in unaccepted
 memory handling
Message-ID: <20250506124341.GDaBoD_cYkXsnTmRdj@fat_crate.local>
References: <20250506112509.905147-1-kirill.shutemov@linux.intel.com>
 <20250506112509.905147-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506112509.905147-3-kirill.shutemov@linux.intel.com>

On Tue, May 06, 2025 at 02:25:09PM +0300, Kirill A. Shutemov wrote:
> The page allocator tracks the number of zones that have unaccepted
> memory using static_branch_enc/dec() and uses that static branch in hot
> paths to determine if it needs to deal with unaccepted memory.
> 
> Borisal and Thomas pointed out that the tracking is racy operations on

Boris or Borislav would be nice.

> static_branch are not serialized against adding/removing unaccepted pages
> to/from the zone.

Also, that sentence needs massaging.

> The effect of this static_branch optimization is only visible on
> microbenchmark.
> 
> Instead of adding more complexity around it, remove it altogether.

Yah, good idea.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> Link: https://lore.kernel.org/all/20250506092445.GBaBnVXXyvnazly6iF@fat_crate.local
> Reported-by: Borislav Petkov <bp@alien8.de>

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx for the quick fix.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

