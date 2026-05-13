Return-Path: <stable+bounces-246941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO/eCOWsBGoRNAIAu9opvQ
	(envelope-from <stable+bounces-246941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:55:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AD6537825
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0AAE30D6AD7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D3C4D98EF;
	Wed, 13 May 2026 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGkIRoyi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60B288C96
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690745; cv=none; b=W9UlcKM/Gh1B03oeH4RHVyFxyKMbWYfuuF+GLaoyLl3ucj1WDkk7DDe18PVhECWUGwh36tpotmtX83QjbIE4qjfSVpdqlsHoeJtj30d+BW5dMaVGxkyuwGuhd0LTlG/yq4242pKncif6uqs87zuRLG6BXFjd43XqroUUVwz2qWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690745; c=relaxed/simple;
	bh=G6dCLo5SpKgCvE1TFsg41MaLaUN6BhTG3vfdETy4VBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhw+gardKPu83lcPFYhwUo5r4FC5lgnm1XJSxV3a+FYIwj31E7hO/g0bIZhT9mUIOH7RxTjvKUUQvljxZXMI7DqEAImYTQk2AyAoDEaYQwc/ud1VcXK1+kBUFfubHGprAY8eWV5xApBeiDQ41QiKtN5yjOUucitYxdnTj6vFN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGkIRoyi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so8765ad.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778690743; x=1779295543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6dCLo5SpKgCvE1TFsg41MaLaUN6BhTG3vfdETy4VBU=;
        b=SGkIRoyifeVgLUN/ynwtEvUcsLApo7D8Ez1Ag43KnubdjM++j4jF3Dd1OalHRl4l8U
         32K9nW+AvVo7utmQBR3lX5A4n4RTZWefEUEfUj5T5GhsOKW5TfGobBSbQD0iQb7n5MdF
         EXq+591MSvNsA2eXmpXQWfq3zpAHIt9hIeLKSHrwAUHeYzuP2qS2lnAMBc6IwiDJ5vzD
         NRtdmvwIO1TXNHYM1cTIJzsJ05NbY1LW0of3vO453TF3NrAZQtbj+m3OZgRKVTZzmFOU
         0BW/oLrzXAg1MC4oUjT1k7oVXspeVWMZ8jCIt9AXVJlViuDoSyfJZtgLETiGLi0WUH+U
         T1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690743; x=1779295543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6dCLo5SpKgCvE1TFsg41MaLaUN6BhTG3vfdETy4VBU=;
        b=bN2v5onyoEIqqyCbFibijM+cb6xLXFviZuX3gGauJybzDuOdhLEKoXTIvA+eWH6Bwi
         9Q5cIx1MZFYSOcOZPLxHPfeLMbKAPT8UVcv58S3RgTLvTWcWGIecDFeKSk0vSk9l5n9N
         jkPcRUJRGykqbJ7bP2xtNWCW8Lxpk5dBxfzLtJ/LBEr1S2huDGrBYd2w56BMv5horOUA
         eUs9YeQnWhp6M8tCTyfInfz0BpMBfFz5bg07yVb4vLzhJ083lVcpqTAmbo89G5y0z1yo
         KhAeTk0PRts9cBCQIvCpr9YSU3fYJS6Ji8EWuY49qTWSeMRr07SXi9VfHYYN9N+9sBpz
         Wt5w==
X-Forwarded-Encrypted: i=1; AFNElJ8gplPirPbUsYsgwkYuS+HetDgMctIGgBlcs/A0+4+xB+vv3wzt0j/n8M4u1Dna4M/pBR2HAfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZ69wiR88SpBUTo2/4IcTbbksnFSjiL2avrrLflaKlj4bTTTr
	azGgb+6MRr2IJLCB+KR58tmQDOG8n6o++M1ipp/5Z0hPDkmh1WAsm7dtSSo0mGqqaQ==
X-Gm-Gg: Acq92OGjlpl6plcE2Oim5cKnZiEeVDAqaZt/bn9tlzkjNPZyp87PeGDvGCkFUugLOKE
	l7drcrH2q0cPKk3PdS2IJAVlmKv5TkeeRIkSWR9uzF1mXDsGg9p/r7CbfppFzqphKDaw/CWTCsr
	yFdDGlYKrFdLedWrlE5UBTYX/xpoG/G1dWPRBJFLZf5Jg1mfwZh9fpKXdvn4F4UaK13inhaePzX
	eUBRBISeTre0CJprXjbJqN0ZE00P4qKwwCJlTFnpH0ERQR8Etp7ZuIY6lzyBi8y/7F8MWssXd4z
	zb53WJ7tMOcpIi6xU1qkZZGJwo4RNbH6cnTqT/aCsf7qG+Jy/v6ag7yHKZ+yAwhg6XmY/Q2Fr4T
	EYAEpn6eUKEZxCGA8xVn4t/6FnazHsJxtV2OWyCHUVIsNuSVnKIOQOllo7XYJdpRFD2zAHQ3L+c
	3AL3XMzUjyFiQryeDIS2pNVOdaMj5FDL3xtm9gYvC21RLEmJ2hqf0jvbzmUDUljjh0cH/MAA==
X-Received: by 2002:a17:903:3848:b0:2ba:dfa:328d with SMTP id d9443c01a7336-2bd2c0a2bd2mr3497385ad.1.1778690742233;
        Wed, 13 May 2026 09:45:42 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267735e3fsm14858749a12.31.2026.05.13.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:45:41 -0700 (PDT)
Date: Wed, 13 May 2026 16:45:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 2/5] iommu: Fix up map/unmap debugging for iommupt
 domains
Message-ID: <agSqlM18kAJiC8-U@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <2-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 95AD6537825
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246941-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:14PM -0300, Jason Gunthorpe wrote:
>Sashiko noticed a few issues in this path, and a few more were
>found on review. Tidy them up further. These are intertwined
>because the debug code depends on some of the WARN_ONs to function
>right:
>
>Lift into iommu_map_nosync():
>- The might_sleep_if()
>- 0 pgsize_bitmap WARN_ON
>- Promote the illegal domain->type to a WARN_ON
>- WARN_ON for illegal gfp flags
>
>Then remove the return 0 since it is now safe to call
>iommu_debug_map().
>
>Lift into __iommu_unmap():
>- 0 pgsize_bitmap WARN_ON
>- Promote the illegal domain->type to a WARN_ON
>- iommu_debug_unmap_begin()
>
>This now pairs with the unconditional iommu_debug_map() on the
>mapping side. Thus iommu debugging now works for iommupt along
>with some of the other debugging features.
>
>Fixes: 99fb8afa16ad ("iommupt: Directly call iommupt's unmap_range()")
>Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/iommu.c | 43 ++++++++++++++++++++++---------------------
> 1 file changed, 22 insertions(+), 21 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

