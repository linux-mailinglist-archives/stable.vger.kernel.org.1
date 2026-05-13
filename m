Return-Path: <stable+bounces-246984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOn5LUG5BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:47:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA95538464
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDCC230088AD
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698224C9559;
	Wed, 13 May 2026 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuI0D8BT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA424DC54B
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694463; cv=none; b=iiq9TVWV/LrmXcySDUIKODkhXTCtWcHYLH1tQCMBC3mVEtP8fafKUve53Pqg7Oaf7gLjTbJ2ZuDIV4/Yz/zOO1SW2TG2nKzJXnkqplPrE/c/G3LkxBIX97jvFr3ki6NUBehs1Z79vdtxsr1NQYYfvXjAC4/EPh6E5L62QI9ILfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694463; c=relaxed/simple;
	bh=/d7ugw8j3llT+i0xpw6oKwmdDsEr5lQSNXVbHHx7Bbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwbUMMnMpH9xorI8LyOJ7VX3woPMsjH5vCeQYG7qn9Pc3ApCXQlVYN+/0tuSlrNxZbxE9ZFbU2qnl84DfyclLEL746WxsXaBgpqNKTOUCBYfIig4UJI+/BvAkJokjZuBeiXx1uZdCRlVjf+HvZhJcDM9a1VFDKNIicvuero/THc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EuI0D8BT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b46da8c48eso4595ad.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778694460; x=1779299260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UD9g7VTOeXYFNZR2QR68/VBGy1DjrVre8yBvcooH1jI=;
        b=EuI0D8BToYAS/I6HIKlYInu2b17+NZ9TrapWqUu7Sl8pXtx1yKw+9p2OyGhY6jpfWc
         wOmF5H5vkzLjlw8LAsOIQtlethTyE4LQXH2armdgNDjI9LsIF4f3wjWmQc9rIby9QS8A
         +v3lkQX5fOfMrBTP0phPLV6GOCH6P/YwDRFLKXdnCbDtUnbyFPWB+wCeGRMEYdprtRiZ
         xJQ0DtXiLLpBZplrhJcwDZz/b1DB/5nkidmwoBXjkqc7l4gfEi5HOdsCkfOlciqNeok3
         Vz5MWhVWxBPrjTkIzKrk9f2xcONFImjsGXp4sHdBmGLNhzl4Quv8r11M9vZxAyjvXsFy
         9a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694460; x=1779299260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UD9g7VTOeXYFNZR2QR68/VBGy1DjrVre8yBvcooH1jI=;
        b=qE5c86Nq/meXbfeMrsnVZ7luxJpIey6cwPb8wQGMTwanJIq5oE5SRqFnTcENyr+kke
         bZ7iEJeiO9BjdxblZIDuNTfOAggncgg8gk+V9RMfHw/eRGZkWpInjNDhc0cZhjlUb0FZ
         Xq5gWc9CXZ30Aa+egB490viVrSjy4iekV4Xlc05t+ok0cfTXw025SlF2q0X1wjt+Hxdn
         UI3HBC7eKb0VD+PH/va9TmP+/+e8tvfgOnLF4C6zBj087kbn19nIerVTVgYcS02f9Blx
         hTgUJXeVqULEbOyaYzQkjUScti1c7RHQCUPIlQo7q509cpelIq6P4cl2RA74W+kp2OX2
         0wEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/N902mwfXJh6Zhc6p3BGRhByAUTtUAPK2JAr5S0UekQ2bVCKnJ/9Y/bRVVqO75EGiwRD+pJUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYNk0SPvBF1eyzivkJybChjnLZPLWFpulQ1sG+4QzxDognHrJ1
	TmjBoMORTrF3TzzAhSQ1j7I9xTZj/poPuhUgq01q7EaDtR7woTpsAXhbRZBbrWXtLQ==
X-Gm-Gg: Acq92OEOwhC6+s4YlTGj5L7zThX4FinamfxPJS5LfbuT9K6byCEwPmM6mHWRbmYiGEo
	LmhexDNu8NVoG8OFKAgkFJJFGGzJyk3YF7Q2p9Y+tiy6HN+Il0Auq11TncR/e1jvRXsfqYiIcMV
	2ldRiJDA0gzHl+6cE2D0b7BfIsJn/eWzvyREaVUS+Q8C3ze5YPviTxJEQGtTdXL5mK6DbAJ/aRY
	Zy2Ira/Cgl+uHj4/G4VL3FL7jutDZnAO45VDGZ9VkE4Zmjlfo7cumqCeVbSZoLBdOcvwaBja/kJ
	m6CF+Mx/PHzT2LAjAhxMj799GHSE7pi6xU9A33kfpx/BT9sK10DURQcMMOUPRfCKtt29tKXGzQR
	YIrIIpCnqB0IhwaZhIspfrwo7FXckbrM5Mw8VfN0+/T4v4b6MuUtiLanGJ9wS9Ska+98Zu4cvvh
	0Zg43yzaL6mIDBrGgJjHu68t/XK7WFLs1qxPB5noi9NCA7axYeGa+9/DYmPxGlESOpPqTc
X-Received: by 2002:a17:902:db09:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2bd568f44a7mr144265ad.17.1778694460069;
        Wed, 13 May 2026 10:47:40 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cc8bsm117708b3a.55.2026.05.13.10.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:47:39 -0700 (PDT)
Date: Wed, 13 May 2026 17:47:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Josua Mayer <josua@solid-run.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 3/5] iommu: Handle unmap error when iommu_debug is
 enabled
Message-ID: <agS5NHNCAwmTesf2@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 2DA95538464
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246984-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:15PM -0300, Jason Gunthorpe wrote:
> Sashiko noticed a latent bug where the map error flow called iommu_unmap()
> which calls iommu_debug_unmap_begin()/iommu_debug_unmap_end() however
> since this is an error path the map flow never actually established the
> original iommu_debug_map() it will malfunction.
> 
> Lift the unmap error handling into iommu_map_nosync() and reorder it so
> the trace_map()/iommu_debug_map() records the partial mapping and then
> immediately unmaps it. This avoid creating the unbalanced tracking and
> provides saner tracing instead of a unmap unmatched to any map.
> 
> Fixes: ccc21213f013 ("iommu: Add calls for IOMMU_DEBUG_PAGEALLOC")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

