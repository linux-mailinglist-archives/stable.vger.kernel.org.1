Return-Path: <stable+bounces-247020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIgAHO7JBGp2OwIAu9opvQ
	(envelope-from <stable+bounces-247020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:58:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92E539705
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02D3030254EB
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50043AE6E2;
	Wed, 13 May 2026 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWD9NxQF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8F34E766
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698428; cv=none; b=A4E2id82zFxq4Rb2J1UwpiYi4Ph5ZJRxeKKMjopLYb1KSPtUUdz6rVU942vh3jNJtWLxL3l6hIxUaW1Io3AIEdyXBX/SW3KVJjeI0WleKva5hKL4Lut3GoAwCG5P9q52tZIaDDOAN5I489/UK5t86jR3cK+W/TaF8Y/dR+bAkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698428; c=relaxed/simple;
	bh=1T+8gtW07YW1Q2hsQQ/eNWlwxVUQfk7M7+0pK1hZj3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdwF8qKLcbm+lYtnriG/9F9Y1hfuQN6ZRyIWSlqxCl8JsfXiWSKmsgYrHArKHe9FIKG5cYDxjfpJydRGyuUq1mv/nmQ35XtZFqQnvkOAgNnHd5OqO7ypc5zIAlfC8eJhbL9rLyOESHXR0cZxTtWeTBc3kRhF4T3z3kMFf/Yzq7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWD9NxQF; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-132cccd3d77so256c88.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778698426; x=1779303226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5FAcCWafjYrA9kZBinQj9N8tnqNIZ+FA0Q4wW5bFp4=;
        b=VWD9NxQFCsyA9hcIS6JG4iRpp7PM/W4tt91y5AVVsks2+9qQJnoOFbd0ma5GziAbzW
         SbADfBLwXwqOQ1/Tk9V1fITuPNeAknHrjNfsBQvabvjMfkEb0iH7SPRUKiMcqeVnauvd
         N1Pv0RYRa6u5LTooLk07KfXRLWcbKQEp8xDq30nnJd6AtezBzc3XtbT/2O431zujaefQ
         M8+3HDf1RVMoAunCa/fMitDnQPPBVo1mVn5t1JxVIIIRNAA0q8w4TYcFDkmil4Xo/wOX
         U3DyCmFwVNhx6auPAHvTKGsCbBK1sYdA2DfaUjWD/d1vZ5FpJ2OBBERNIQVGHPEbJVVd
         Tfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698426; x=1779303226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5FAcCWafjYrA9kZBinQj9N8tnqNIZ+FA0Q4wW5bFp4=;
        b=Wx8Z7v6in1W3suWsYox0CwsAIwpBuXs/vhtz0TjB/if3EjZ//rxfVGFyKzyCCO2NXF
         D5S9bVkJBc7EG3q+qp5Qtw7GXfG2ZJ16pgydAl8mgH6q+aFzrN/3034DtyDK6XaAtqcB
         ADg69JpPnOf/A5apgR56eRA0JXYWZWEV4zlCTZfwrg/tm8mzE+LgmgTdsboV44Qa9won
         vL/IvmuEySy+r2Gh+lov8ljnMouk287gSbjKH5B59995vfZaxuEnDd8a/61b/3NXuDqY
         h3vy8gAJodQoSI0RhSeB5SRs417udjXLDFPwHDS/Q3p6Bat2z+mssBHHNO31vUQGpE3C
         PgNA==
X-Forwarded-Encrypted: i=1; AFNElJ+yr/z+NDxevjg4DIF7DCfY5YkIQrNpgn6TrUJuz9EhWwh/v8awo3EJtPABOtEKAgEO+cI7QKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRrIyx4KhESZBtfBkncOsyAiHaLzRJVKiB+9xC9zoQHuLK55w
	i/UOn+vx/VG6ljMSXM9bZXqe5BnmAP6DFbvOCaczdVJETs+9mvKA7ttV/Rb4fhSk5w==
X-Gm-Gg: Acq92OGC0uk8jV92tSVNqZzQZTaZ8XDzU+IG0cV0Cg/6Jw4sB6nPnbac0HvnNKcypzS
	5ePHAytCsgxW3ar92beWRkoyEybtc1Bsf7jpjj4SX3fR+LhZyBwHvnw2Yv2J9O+CvsnMgDx45t9
	JR6ltHMe9hJXIXDISXwzELKi0okzPjx1RJaRjIV7R6RE+FWm9kE0sCz5PGTOf2L1pDL4g4JyK/V
	+4I07CqNkYqdPTrDmnCNSJY4d9WVf1AVwIRS9D1U1AUvR8/uXcvWN/H+eXUovDfpz2rjRDF83Tc
	T8+79c6SmUZN0sig7o3PAZRzEKfMfbgUO1q2Fr4wTY5OZTeRt3HdXj+jsxXTU+dzRl7Vsr7kCS5
	CZBDH+Fx6UTY8+PPCqd6KOprQ59xJnJffDPCH6BLKh9Xg696UF9TP24hKxXVCOqoQXJsg8ldd68
	Qsd8EoNbG3g6Gp5f98LfELvy7GxeP3Jsq+dmasgbsOug4jPGlpy1u20sW2uDVYV47g2sQ0fEcof
	UREEJ+Q
X-Received: by 2002:a05:7022:f9c:b0:130:c9cc:2919 with SMTP id a92af1059eb24-134cc1108bbmr38022c88.19.1778698425009;
        Wed, 13 May 2026 11:53:45 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8884752ccsm22785382eec.17.2026.05.13.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:53:44 -0700 (PDT)
Date: Wed, 13 May 2026 18:53:40 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 5/5] iommupt: Fix the end_index calculation in
 __map_range_leaf()
Message-ID: <agTHzU3KYofnszp4@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <5-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 1A92E539705
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
	TAGGED_FROM(0.00)[bounces-247020-lists,stable=lfdr.de];
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

On Tue, May 12, 2026 at 01:46:17PM -0300, Jason Gunthorpe wrote:
>Sashiko noticed a mismatch of units in this math: num_leaves is
>actually the number of leaf *entries* (so a 16-item contiguous leaf
>is one num_leaves), while index is in items. The mismatch in maths
>causes __map_range_leaf() to exit early instead of efficiently
>filling a larger range of contiguous PTEs.
>
>The early exit is caught by the functions above and then
>__map_range_leaf() is re-invoked, so there is no functional issue.
>
>Correct the misuse of units by adjusting num_leaves with the leaf
>size and avoid the performance cost of looping externally.
>
>There are also some mismatched types for num_leaves; simplify
>things to remove the duplicated calculations.
>
>Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/generic_pt/iommu_pt.h | 20 +++++++++++++-------
> 1 file changed, 13 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>index 4877b05291c9d4..dc91fb4e2f61cb 100644
>--- a/drivers/iommu/generic_pt/iommu_pt.h
>+++ b/drivers/iommu/generic_pt/iommu_pt.h
>@@ -534,10 +534,12 @@ static int __map_range_leaf(struct pt_range *range, void *arg,
> 	struct pt_state pts = pt_init(range, level, table);
> 	struct pt_iommu_map_args *map = arg;
> 	unsigned int leaf_pgsize_lg2 = map->leaf_pgsize_lg2;
>+	unsigned int leaves_avail;
> 	unsigned int start_index;
> 	pt_oaddr_t oa = map->oa;
>-	unsigned int num_leaves;
>+	pt_vaddr_t num_leaves;
> 	unsigned int orig_end;
>+	unsigned int step_lg2;
> 	pt_vaddr_t last_va;
> 	unsigned int step;
> 	bool need_contig;
>@@ -546,21 +548,25 @@ static int __map_range_leaf(struct pt_range *range, void *arg,
> 	PT_WARN_ON(map->leaf_level != level);
> 	PT_WARN_ON(!pt_can_have_leaf(&pts));
>
>-	step = log2_to_int_t(unsigned int,
>-			     leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts));
>-	need_contig = leaf_pgsize_lg2 != pt_table_item_lg2sz(&pts);
>+	step_lg2 = leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts);
>+	step = log2_to_int_t(unsigned int, step_lg2);
>+	need_contig = step_lg2 != 0;
>
> 	_pt_iter_first(&pts);
> 	start_index = pts.index;
> 	orig_end = pts.end_index;
>-	if (pts.index + map->num_leaves < pts.end_index) {
>+	leaves_avail =
>+		log2_div_t(unsigned int, pts.end_index - pts.index, step_lg2);
>+	if (map->num_leaves <= leaves_avail) {
> 		/* Need to stop in the middle of the table to change sizes */
>-		pts.end_index = pts.index + map->num_leaves;
>+		pts.end_index = pts.index + log2_mul(map->num_leaves, step_lg2);
> 		num_leaves = 0;
> 	} else {
>-		num_leaves = map->num_leaves - (pts.end_index - pts.index);
>+		num_leaves = map->num_leaves - leaves_avail;
> 	}
>
>+	PT_WARN_ON(
>+		log2_mod_t(unsigned int, pts.end_index - pts.index, step_lg2));
> 	do {
> 		pts.type = pt_load_entry_raw(&pts);
> 		if (pts.type != PT_ENTRY_EMPTY || need_contig) {
>-- 
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami

