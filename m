Return-Path: <stable+bounces-273492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dBkbC9OMU2o2bwMAu9opvQ
	(envelope-from <stable+bounces-273492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 14:47:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3B744B62
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 14:47:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=tuxdeAGO;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273492-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273492-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9897B300E277
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C6E3AA4EF;
	Sun, 12 Jul 2026 12:47:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DB51A724C
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 12:47:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783860431; cv=none; b=U2c5sFG8rZRjC449Vced7vnxecrGAU1Gq5lWpSs8pWlHQbaOtKYkOwNu861lVzuQpGUnEtPSWM2MQq3GpZ50w7bYfKwYXxTKeXQyBNQEyeuYCBW0+mgszPOFt722yE/wjOwhwC7aJ+4RnzqOPK5rJX5xwsp6qHlwPbYcLj4io5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783860431; c=relaxed/simple;
	bh=G6YgrJJIeaUz6k98Nm7aOEgiM7tjDBbtGbTUjrGpc8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ97x4apSR1m9KeKetaBGyIVoCD5ICeJbj1tg+JERDCKLNtCSb1RN6puiBrtVm3E27ogt5VMQkJZEZJNQOsqTX+r00GrfaME3p7X4/xa7qz/Qq60HTusesTBX+NiGt5E9H95MA3VaIRJv1CK0J+qs8jYHnb0bZEF9FiwOMqtzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tuxdeAGO; arc=none smtp.client-ip=209.85.222.176
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92eafc94c9cso133475185a.0
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783860429; x=1784465229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pm9nW7teOFNiy7UMYUIullioRRBzDlnrKfEE2/bnUaY=;
        b=tuxdeAGOnlgDSvzZK3ZaZ0gAhiehxf8fu5YkHB+Kx/zrwqeBL2PJra7BZC71jGMdMZ
         6y6T4khsOer6z5lAOUOUb7bNtRwct4hGCloVRcbvjiNeUrWvF2ZvkyLxG+ZKjnU+x43Y
         2LUSK5R/AZlM2CYgGvqkGv0XeOMsg/nvUMTWRrkqGXE8tvTYDHkJpTWbXCIpKo7lMi7z
         sApNRllqrPmLOEHWxHljurdYYv8ren1gVdI/vNgetkQ18l9a6ZmRYUzb6EaLDpQgpQVB
         /PNf+vBJGuHguGL/v++M6JzKa3vhldn+/QaqPOxh1trQgE+zEMP/67OlqGp8fZBvulnV
         vh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783860429; x=1784465229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pm9nW7teOFNiy7UMYUIullioRRBzDlnrKfEE2/bnUaY=;
        b=IeiLAue6R8JCGZq1ZLGnWw0EcJQngPetPHjqCSUnvIKIUrMX1bEv9s/03PX3n4Xwcv
         vB7jqT26/ykm+FHXVV0VlxFVGnEAXNVi3p6PVTxgCjiOFTYxMW5zSHom0PZkuc5KHzpp
         FhPqdzB41EZ8zDKFT/6mk47CfsvkaDh5lH5Js+E2b5LtquHdkCInOShnpQD6SAIUO60h
         tD1mjEac8/aePNN6noAKct1BmN0okq1C0sbagL7jkg0qx8n9LF5IcApGKF08DPiIsirV
         Ng9jHF570RnUTMRvtPceJ5qVXN5iGbrndgRAoAZUeAjHuS6xt+9rO6zOW1Z9eDZ6gvu4
         GEUA==
X-Forwarded-Encrypted: i=1; AHgh+RrsPAVwugxZfA6EcWFoh2yX3nJYoNXztwertVlphZ+PcdH4qn7OnOPIeziKUfxZ00pyok+yNZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF9wJt6IZ086j5CbCoHst/lL1AUnvLh4eGKPsrltTWwaeUVP2K
	5qTStX71HD2eU/8jjxNq1iPFloq1wzliyskkYPwl2uc60f7kPf+tD1vL/cZcl3BxuNk=
X-Gm-Gg: AfdE7cmP+WMbsFUgqwefVAyhfYPkaLRSZO9lnFRRIFsRhTfNxTXrqIU6/mavkoNgew/
	01BltTVCc3QowUgu/CyX7iN5IQRLaDLRWlNxxa/tp3mQug2MCbHAe9iD0W7JPDsd24K94y0qlm2
	IpSZSVzwfv/rc4gNVFIENLJxiHKz5Yup+Y6uEQlYxO9ttidUJAWANjSjshnhjJcfFZviWSZ1X2q
	QpX8O0gb/fcb+fvu7xvYaysid3Fi9v0HTGQBS471vkPXxTa8+2XK7Bvje5l5Npbm3P7/C5VwNUQ
	R/ckZOvYHKhqV2S4YfiDdWsHdEmrI2fGe341js+DWWLLSWtUV4fztQjPfceD5TL//GRHms/TI9k
	NQtYsZPxr3Uza9Jerfzh2a57hrAk4IGtXnyiQQuqmIzePAYPPqfYTBpy4sjeAWC/kL8tb+HVxCP
	6ah3SrbAdTHVr1TClYejPIhUDZBDiIQZeZj+JdFvTytqtZpFw7qCSz6LVV5eAvpddpng16Gl0J3
	kHF+Vs=
X-Received: by 2002:a05:620a:318f:b0:92e:c117:5edf with SMTP id af79cd13be357-92ef2c40a92mr592338785a.75.1783860428981;
        Sun, 12 Jul 2026 05:47:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm833767185a.28.2026.07.12.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:47:08 -0700 (PDT)
Date: Sun, 12 Jul 2026 08:47:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
	balbirs@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, byungchul@sk.com, david@kernel.org,
	dev.jain@arm.com, jannh@google.com, joshua.hahnjy@gmail.com,
	lance.yang@linux.dev, liam@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
	matthew.brost@intel.com, npache@redhat.com, rakie.kim@sk.com,
	ryan.roberts@arm.com, vbabka@kernel.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm/huge_memory: skip device-private PMDs in
 madvise_free_huge_pmd
Message-ID: <alOMx1NkL1jeabg3@gourry-fedora-PF4VCD3F>
References: <20260710105557.1987433-1-usama.arif@linux.dev>
 <20260710105557.1987433-4-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710105557.1987433-4-usama.arif@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273492-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:balbirs@nvidia.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:byungchul@sk.com,m:david@kernel.org,m:dev.jain@arm.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:matthew.brost@intel.com,m:npache@redhat.com,m:rakie.kim@sk.com,m:ryan.roberts@arm.com,m:vbabka@kernel.org,m:ying.huang@linux.alibaba.com,m:ziy@nvidia.com,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,kernel.org,linux.alibaba.com,sk.com,arm.com,google.com,gmail.com,linux.dev,infradead.org,vger.kernel.org,kvack.org,intel.com,redhat.com,cmpxchg.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gourry.net:from_mime,gourry.net:email,gourry.net:dkim,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CF3B744B62

On Fri, Jul 10, 2026 at 03:55:23AM -0700, Usama Arif wrote:
> 
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Balbir Singh <balbirs@nvidia.com>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c0892cc533a9..7ae21b006b68 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2297,8 +2297,8 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		goto out;
>  
>  	if (unlikely(!pmd_present(orig_pmd))) {
> -		VM_BUG_ON(thp_migration_supported() &&
> -				  !pmd_is_migration_entry(orig_pmd));
> +		VM_WARN_ON_ONCE(!pmd_is_migration_entry(orig_pmd) &&
> +				!pmd_is_device_private_entry(orig_pmd));

I just realized, are there softleaf entries we wouldn't want to WARN on?
If not, should all three of these patches just be something like
pmd_is_softleaf()?

x_is_softleaf() does not exist, just curious if it should, and not
worth holding up the patch.

~Gregory

