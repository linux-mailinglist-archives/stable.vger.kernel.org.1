Return-Path: <stable+bounces-247356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EI9GFqvBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:30:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F2F5498D3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3BDF30219AC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533333893D;
	Fri, 15 May 2026 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="5znACS2i"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566172773C3
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778822997; cv=none; b=XDJb5VPK15yp6s1d+b6COC+ktqr7MYw7Dms6W93fwY61DubNifWzk9Y6tMOXdg4S1U6UCwXl4pva7XVNuBMpFf5BkLcPWiWRDByjebEXwj0YqnbIqvPIT/PDAqHzu0+3l9ZCxB44oZn72BNKMbN5zkqtbFF6m4i3rBHIiQPyI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778822997; c=relaxed/simple;
	bh=5QBKM7gsl9HnnVZ9ndHvviXb+hikBiR6z0o719FuAiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu7MHZyICe2TtDogzvNOPCkcX2giRpZ3aNoCAB9rHyTa6HeqQtfkVt/qrEhoEDxbuCIRw+VmEhOgxcwEn1HIw9Ouwdz4aT4WP7O7NK5mDLD6yw/ZAbUvAiyTfjohfm8JQoAj7nM7mrl8+OdKzr29Jy9iVKgqh/8W9YZo1UJkyb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=5znACS2i; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5EA371C3CD6;
	Fri, 15 May 2026 07:29:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778822988;
	bh=5QBKM7gsl9HnnVZ9ndHvviXb+hikBiR6z0o719FuAiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5znACS2iT2zYHYtRWAsoErcu4zenVdtJPmZyw4cQX0wFbLuZVMgCIL1yfZyOT+5RO
	 H8prQxV3Nl0rKFfoNQONUL2/LmX4grU/RXUW+TvpEU3uAGxRmA5nfA5sWqhGKBGS+e
	 Rv9ojbM46GPfwvpKHv1y+vDKUuoCg52EYjyrynWQI8qoC8b4aGVpkrXP2CUETP6GO0
	 klrUsVHRheSCU/2+eHkeYEsGbEp09sL5ZyTfPqSXkhxNHyxoxz3qA8Afp9o1vcb19l
	 2GdbYKwjMBGNBXalSk0lzy8472Rpn2DF4xbkJjW/Ll5pyHTWinV8Aqzee/ZdNNC9IG
	 rwK7V1ILsANpw==
Date: Fri, 15 May 2026 07:29:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joerg.roedel@amd.com>, 
	Josua Mayer <josua@solid-run.com>, Kevin Tian <kevin.tian@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 0/5] Fix some iommupt mistakes from Sashiko
Message-ID: <as2elpzwtlir6zqvgs2f3ahd4fmg4owdquldeiy4fufrxvp36q@yji7xglqxcjm>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: C9F2F5498D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[8bytes.org:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[8bytes.org: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247356-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joro@8bytes.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[8bytes.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:12PM -0300, Jason Gunthorpe wrote:
> Josua found there was an errant !ret, so I ran the original series through
> Sashiko, which found some other interesting things, a few miskates were
> made while rebasing across the iommu_debug_map() series, and a few other
> interesting remarks.
> 
> Jason Gunthorpe (5):
>   iommu: Fix loss of errno on map failure for classic ops
>   iommu: Fix up map/unmap debugging for iommupt domains
>   iommu: Handle unmap error when iommu_debug is enabled
>   iommupt: Check for missing PAGE_SIZE in the pgsize_bitmap
>   iommupt: Fix the end_index calculation in __map_range_leaf()
> 
>  drivers/iommu/generic_pt/iommu_pt.h | 24 +++++----
>  drivers/iommu/iommu.c               | 82 +++++++++++++----------------
>  2 files changed, 51 insertions(+), 55 deletions(-)

Applied, thanks Jason.

