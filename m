Return-Path: <stable+bounces-246934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCtIJvSpBGqRMgIAu9opvQ
	(envelope-from <stable+bounces-246934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:42:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C90D537494
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BDA13041840
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EE04C9560;
	Wed, 13 May 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUYnU44M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1A4C8FE9
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689986; cv=none; b=pz8cCIHRUt+IEO9exJuRzHQZurXIcCle4kR5vvRHVt9JssSP4ISMy8qjmM5Se6zx94QVRivaFTI280M6PGbOgxaHMhHnft+/gMLFd759taVMg/Jod1Yw2nyZ4VxQd28YaLBrS0QG6XVOfaF9MLtWZrC4DqDhMG9JctsLaJB+c4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689986; c=relaxed/simple;
	bh=U5Kuz70QEO8JeRgxdQNiCHjSIXGmXUdHdcBBicOilso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shVIWyfsmmf3keLYtYaHvWTh+w3nnREdbK7sisdeCha3lob1OcMahnPjQLOSDncDmItxazDYp3miLvOyG8UXRotJKPe6E1V8UdAQKL8+0rK/EQIEtQHXm/Rurl4cF+FO+YIMXxY7sAZtd0uag1i0dBIuZt8nmIza09cX8iNyWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUYnU44M; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b46da8c48eso2135ad.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778689984; x=1779294784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rPH9gxZhv9eNRRFpkdtU8/gFnPfL9onDepZYNNx2xcE=;
        b=OUYnU44M0ajzQRaDcvdihkX/+JZRe7rl9HKfdkIcPdQsoLfY58YLm+QNOQwNmImK5H
         Vb6Hql8ReE+7FBe+I8MgivjXc3bJFImQDoRlwwozyaiCgMc3GxtRp6avRoLkfPthbrWt
         exQrO75aHlBCIltC1K4jUwTtnAm8peSCtGY62ueT+WRYBBMZA7VFEyk6BeHh64ixQp//
         bkZYcZE2SENsHEofwXZLvYU/tpGmN1rDzDtqLJjv56hxZvCTqwmbHZJfcWbR78iLhyoe
         QtZuKKHRELI+Ctc6kS86jnVtzhXIANiwlS6LcfQL3N7aX0RcXonaTqJmDEZ85TtswyUT
         kUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689984; x=1779294784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPH9gxZhv9eNRRFpkdtU8/gFnPfL9onDepZYNNx2xcE=;
        b=POn8YVSQqtT3lSMYgpFAGLdgCfntt1PnRaj+lzeP2Ckenyhkf8yE8SMy/AldyRy4A8
         cAiZrSMY4GS1hcgA+EL2WY0wMnk/i5BsDXQKv633kIV+85+f+YSsVrs1VT9OS8GVzHlU
         miBgljCccBG1L6HgAvDiyVY8/r7CsIhNF4tbbRn6kA8ebhOIEnX0trIuS6UbkqL9drLc
         eppUQ+SYlEHxifJ/LraAU5wlKasfoy5/tkGkCZC7FxXzlNOafRjgATv30Nc4nSQQfgiU
         RI5lkRVfOhCd2fwnatiZZn43yQFJK3YE89SJimw+HZeWJ+zjBMlgO9ETG0hxxtncRTm8
         Livw==
X-Forwarded-Encrypted: i=1; AFNElJ/XlUzBSj5xtJ6XkQpmI++BovLL/qeMsDAZaZMWzLAdC/Uqb/Y1WL5kT2u0CoiXcSdiIWD1qb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+OhaGEd4uwraAgMROD0S7+c/w1TrzO4IDXbQ043xyxGbYEoYx
	u6CSP+PDiIbCqdc5uLGJ8QeIr1ZviwPbmM5o66eCTsO8QY3wHA8WltD4FGH1xnJXUA==
X-Gm-Gg: Acq92OGpNV5XmAPSggnD+uw1XFmo9EZUaiMD/rptT0QRWtHGpHbFxKbJqfCjqCeXyVA
	0A8eNIZwC3ifoiOA9wKhHdZD1VGF2R9AVbHOzdLhgAFSfLGUZiwLCNw4bxUx0MrXBt+ZG04AZIx
	CHS0i0D4FI+u+1R114yUuWsQ08jCMsq6oPqvDCw8viZEYJ7IKjJVZeZol1tnwwH79IPj350h1t5
	06yRIQCpawhnZ/mMi1iBCcsGNiDhWFt1aYUHpWeETIPoMfpkehdzvFhpr1HebHBDTrmPE5Q6nF+
	Q+BJw7yDu35ZXv7Qr2wd2C/K8K7bUIsFx01t77YLI73fb6uwfxGY/kibHU6H3McWpFZI9fiBbXj
	il2lTu3Qe4QHVmyLA0jUvNTJtBRUkIPBxVOGbsRAjXyTk3QfjqXX7lWz0+rb9m42SX6d0woaFmY
	SS8cXVsk3LUcW+Ro/Ojw0lmDSvHjI4Dp6FfZgucAhuwpnO/7J2vWVd172PQf2EWlf7m+TNbQ==
X-Received: by 2002:a17:903:2a90:b0:2ba:3b89:c3a5 with SMTP id d9443c01a7336-2bd267913fcmr3711475ad.12.1778689983184;
        Wed, 13 May 2026 09:33:03 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2700dsm175960195ad.2.2026.05.13.09.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:33:02 -0700 (PDT)
Date: Wed, 13 May 2026 16:32:59 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 1/5] iommu: Fix loss of errno on map failure for
 classic ops
Message-ID: <agSnspdMHD8Y0F-8@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <1-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 3C90D537494
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
	TAGGED_FROM(0.00)[bounces-246934-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:13PM -0300, Jason Gunthorpe wrote:
>A typo, likely from a rebase, inverted the condition and caused
>errors to be lost. Fix it to be "if (ret)".
>
>This was breaking iommu_create_device_direct_mappings() on drivers
>that don't use iommupt and don't fully set up their domain in
>alloc_pages() (i.e., SMMUv2). In this case the first call of
>iommu_create_device_direct_mappings() should fail due to the
>incompletely initialized domain. Since it wrongly returns success,
>the second call to iommu_create_device_direct_mappings() doesn't
>happen and IOMMU_RESV_DIRECT is never set up.
>
>Cc: stable@vger.kernel.org
>Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
>Reported-by: Josua Mayer <josua@solid-run.com>
>Closes: https://lore.kernel.org/all/321c2e57-6a17-4aef-ba42-d2ebd577e472@solid-run.com/
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index 61c12ba782066a..6e53cfad5dc001 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -2669,7 +2669,7 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
> 		return 0;
> 	}
> 	ret = __iommu_map_domain_pgtbl(domain, iova, paddr, size, prot, gfp);
>-	if (!ret)
>+	if (ret)
> 		return ret;
>
> 	trace_map(iova, paddr, size);
>-- 
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

