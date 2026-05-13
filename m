Return-Path: <stable+bounces-246990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AVkIFu9BGoBNgIAu9opvQ
	(envelope-from <stable+bounces-246990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:05:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F403653890C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72289311B2E1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC064D2EF5;
	Wed, 13 May 2026 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QuTr1DNY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C343637A
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695102; cv=none; b=ur4v1jt3s6GxKRZjhOokHbtqDyRYTTy3jyPBH0QddW59n7OBqdQcgRVjshJzpp21rXvQGn3pEEvUBKZrNjQI3x7luMlwAEKwAik+LdyZzWynVDo/VFDvom4Q6n3lQWICSFcxdg19CQtqI3KakOE++CDB4PGjSHHvWPdsXtVGeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695102; c=relaxed/simple;
	bh=MzXdRwxMA2kEQ6q1Wsb/dOQftZjJ4Cbj6XE+Lz3pOxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX0MHXNuYuW0yskba6DCXOKlcZ2bqpPCjluvlP5ConQcivVsqyPt+hIBCM4ivpPJ8mirRiKH4py1B2rEfdKFH8CcAmRV1f6iOfVDAULduoER6tV8+7WPkSjC0oliPXsGTjJ80mowUpCkNmFzNbverjd+edYC2i80F1dxEMPAG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QuTr1DNY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so525ad.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778695100; x=1779299900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3fT1aVwPbo1hAx2uAtxA0S4rzdrTURQ0V1Kv0JH3lw=;
        b=QuTr1DNYyLV+wj5Hh+bCh5/xDk8Y7kLGAHPZqFqx3qCxMeDRyOkkFLr8jSLoKHj6jw
         S33kW7AQsvWZY7qXQ0iGKEnZmwSoxJocJgKDBZ+HDuS9g7fR+PnSSuCEc/DNfi74Sy5T
         koAZEChdDTMcyyPysjmhdzppS7trTw044g0Ja2jDh0ZZerFGnlP1xsV01WbEMggvVb/U
         MbNwEWY6H6FKXLJ9DIesVCEpOWSMmrmxo64EXNVeT5FN6sPxqD7aw6vHqRDbTpsQzEzh
         6vE9XT0rf004c4yTHCZoYcWb29O8N1K/x9y1GufuwdNl8y6e3x8PP4WrcAHjy1bnDb2y
         xeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778695100; x=1779299900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3fT1aVwPbo1hAx2uAtxA0S4rzdrTURQ0V1Kv0JH3lw=;
        b=r8rGD69+ZyntEVM9fbPsv3wkMJ3eX5TTfA0nKC1LoGgkiH9Qh3uc3OjyhhVwlrlwQy
         UaPQfx7Pi7oQ7rRYSGki8+GVcx4M8HViTycrhJxBrihWSBg0rVyIqrnOuaJSBboNg3C4
         gFN8FehWZlJ2IRFPfh8lvuoyJjWm/cawJ/G/BodCPyfUngH/LiRXiBtijWUo76p3SjP4
         sgjf4kLhU8MgDfpDMU4i9e8O1lLf5JqRfZoPNZuIqdp+jsjjT05HY7cB03Q93z10nbtD
         TZojgtnZd0kfLLapB1EEeraDC8AM1IrJp2UQyg6DgPAESHaXUcmbn3BRTlqBBpnu+h5+
         tBNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9z0fkVHOn6Vt74hBAXPpriHm+wMApVpMlPTiHvVKRnSXMJ6EhoCWrBQWPeQVh6Y37uhnDVHhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7i0bmtM/LfyxHEK46Ym+ZFT+qHkqtq4YqmU1AofaeBtp7e82
	EIwaY7PhNckO1+nkmGTUttCUESgwGLGf/b8VH7HR11fbLR+aNa/x9UFfF7bPnOBp6g==
X-Gm-Gg: Acq92OEo7/pG9TE/EfB9Z/X25qPS3Zd5EVZmsZNxJmztIJ49E1SbHo95RHsIgVcf0s+
	py+kdvi9wFZTfPKVjQMmFTDGRE9Vk1yrDq/rJS1yEg41yj8EZHwx9G9t6UJE4Fu3qyXsb2FTsdt
	VqNYIdYCxVuxG7tDQ1o6mnKFPEic3A7bewpc5A/eJI0kvjk5PmxvCXTcRy58ucI0Zcs4lwCuVDJ
	DODEkJL+ShllPznQn4GA1vFW0LyPApXUzMaF4L4R75irFjQf+WqaEvz7JagKzlwizCAkzUyR/WI
	+jhrl0y61+36/yIViWHRmjADDhsHuwJvcaN2VgQ0t4aAyPRRiQ6aJgzlPwKWkQOhkv6WoegO+Wg
	RvGZOPsxl6bpsAW2Om6cv7vLRZUU+8QWLuXCcYAC2UWHUh1jUVuUv+C1brB3MyWTUV3mZyQ4dnU
	YPH54IaN5eyERVIrbqqyHKLOWxVPx5JVvOg6bg5TxHClgoYm9lJWU9cwQSRRPmg7jZsZq5
X-Received: by 2002:a17:902:db09:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2bd568f44a7mr187755ad.17.1778695099515;
        Wed, 13 May 2026 10:58:19 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267735eccsm15998141a12.32.2026.05.13.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:58:18 -0700 (PDT)
Date: Wed, 13 May 2026 17:58:11 +0000
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
Subject: Re: [PATCH rc 5/5] iommupt: Fix the end_index calculation in
 __map_range_leaf()
Message-ID: <agS7swDV8-REdbaU@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <5-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: F403653890C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246990-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:17PM -0300, Jason Gunthorpe wrote:
> Sashiko noticed a mismatch of units in this math: num_leaves is
> actually the number of leaf *entries* (so a 16-item contiguous leaf
> is one num_leaves), while index is in items. The mismatch in maths
> causes __map_range_leaf() to exit early instead of efficiently
> filling a larger range of contiguous PTEs.
> 
> The early exit is caught by the functions above and then
> __map_range_leaf() is re-invoked, so there is no functional issue.
> 
> Correct the misuse of units by adjusting num_leaves with the leaf
> size and avoid the performance cost of looping externally.
> 
> There are also some mismatched types for num_leaves; simplify
> things to remove the duplicated calculations.
> 
> Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

This is an important catch! It means that today, we were redundantly
re-walking the upper page table levels.

Reviewd-by: Pranjal Shrivastava <praan@google.com>

Thanks!

