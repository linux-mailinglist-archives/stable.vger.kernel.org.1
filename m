Return-Path: <stable+bounces-246985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJI8EI+7BGrFNQIAu9opvQ
	(envelope-from <stable+bounces-246985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:57:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 938ED53871B
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12767310D80B
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41744DD6C2;
	Wed, 13 May 2026 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTkaB+F5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951334DC553
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694518; cv=none; b=NsPAnd1J17nudm+HFHJNSYzCaGdTD6dUJ6goMRQbXUah+pZ/SO8z7NaJDOgeY+97F1qNFzO96s28Uelmm1vnPkaAGLMaVh1LbLq66zlg9z/ynSslE6+HHxU5K7BB4xusWWXxYib4gKPdkgpLfttaX8hvlbtqtYdKBewBAH5jVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694518; c=relaxed/simple;
	bh=4XTXWoeBGoxsSNoPRmhV9IH/BD3AGgF+Q6dkrFYVktM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtcSSiZZSsgWB+0CKG5d6zcevL4RvZOFo31mX/4E0qI84fHlxxmVPdizEGNMBAKcj417ZjFeNBZiNlsnWg8V4K1oBH5peXVk8uDwet+nVx+SOC3Sy9BGT9Fs/432OtS3YTrIcSfS3H7tkXogJkaeiLfiqSrMETh3FrTOT26cMTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTkaB+F5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba180a022dso4445ad.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778694517; x=1779299317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxDXIXDykFSIYFprkEjbA73LH9dL5dkUsPQlXSJlaIw=;
        b=YTkaB+F5HP696WA6SIXkNRghNwCZyKOQRkNy+ieDxfGMybBNh4CSbpM8O1g98wNYet
         zk1896Q4nXe4xHXP1IC+OxL0bHkx57ZOa5MHGV05TvAt4rUG3Xkk0SIhW9BaQFtI/iuw
         W2rTOtG1uRUFXmafjVey21dh0rI2zeo3ImyrSsVnZXjfVPwQNnSOsMzlxeDxMESQVWZS
         OBwRiN1uJfhLocyeT6NTZrPTNFyUyzFSFLWPEF8NRyupK/WGK9AbWHpBPa9gF/h3LfK7
         dX1OAUF4tzGwBxGkEs3G7LOCrPAfylZkhw+BELqoWj8uSrzCfroM4ajIdESYIOssh6iu
         ItkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694517; x=1779299317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxDXIXDykFSIYFprkEjbA73LH9dL5dkUsPQlXSJlaIw=;
        b=d04lUGYhI4/awSzvfHyJw0HsgUzbGKgQ8NMOM27+CzKfqo5GTH+fYeoo+v21Qwt3Nf
         DIU3lqM7d9vKLInuo4k/Ac6w4GQMbunLpFl9SzImvPUhD3tQX4YSS++Peh1W128y6Wdf
         fqiZnMDUDrsZrS52BTduaB0B/2+RQGmntgGYsrlBdhu9bspgFaFsbuk/hJ8WZYWwb+xR
         s6+Npsio1/0PvxG2vT7JzOUt5AAPiIuvPMHbAoDBR54qpGxedettlpaTRn8b9tpmC4Ql
         U/JXlyoCgWXr+L4vOVSlH8coAt/hNJA5fQDAUDz6jbEETiIhb1hDLLO/MY7/H5eQjShc
         Aelw==
X-Forwarded-Encrypted: i=1; AFNElJ/ISJIGXKKdL7Iti5dlYcprbNLVFUltxjxftlVRDaqw2dDddxBvyCJDmucVMQ5RWiGSiLQdpa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVJWAMLB060CxMmWF5mSX5DQ4M/T3gU+eN/jJyQQDpCrwxmfc
	E0mhAbIB9uKsFI7786NR4IAI71CGmznBP7A7gV0+I7seyfToZAZQdz5NSPVAeBC1sA==
X-Gm-Gg: Acq92OGeKb1/W35BMAVy36M3jnSCH6fF3d/s0vSX8yUCLSmHAwOK8odSoKeecpZppDG
	7IlHBIBdNi+I2dtrTB+kV1bmwcer7JXAl4cAEIfj6lgmWvZXg/Iz1einpu4itTCoGMYrMLjC5tc
	8PdWuGOp1M5QFuYTNxADFgzADP6rSan6FqOuDWU+bvmNP6RspfEfpjgLEdLuqb1Uir5eEYvGe6C
	TKMZNMuDW0KjLidEoL8lkHjAl8bHckWMfmAyUjzDayH9iHKxBweogIMypVcNGVVoU9hOnsbOVI5
	4uw+bwhUIz3S0TaC+34M9LKm/upYgaikfDEKPcwdu9Q0psZ1Q8baemALAOoD78UUHJ9R9BLBGQI
	bTgz+J6Fr9oD+wWDw2CtQh6RWseo91Em5y4axEel+QAZQJXMfE9/12aI3uRa8qcTzOQ8vSfZkGK
	SWX1PsMJb1bwTGFgvKpYaE21HJiUy8FZYUvMAYp+TaHtYsDb23ddMSgAkAGTAWmRlHU4G5
X-Received: by 2002:a17:903:2a8d:b0:2ba:67f6:643a with SMTP id d9443c01a7336-2bd568fd5d4mr144045ad.11.1778694516241;
        Wed, 13 May 2026 10:48:36 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ebesm178951275ad.43.2026.05.13.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:48:35 -0700 (PDT)
Date: Wed, 13 May 2026 17:48:29 +0000
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
Subject: Re: [PATCH rc 4/5] iommupt: Check for missing PAGE_SIZE in the
 pgsize_bitmap
Message-ID: <agS5bRPHjB1h22BP@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 938ED53871B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246985-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:16PM -0300, Jason Gunthorpe wrote:
> Sashiko pointed out that the driver could drop PAGE_SIZE from the
> pgsize_bitmap. That is technically allowed but nothing does it, and
> such an iommu_domain would not be used with the DMA API today.
> 
> Still, it is against the design and it is trivial to fix up. Lift
> the PT_WARN_ON to the if branch and just skip the fast path.
> 
> Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks

