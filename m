Return-Path: <stable+bounces-259749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPRYOWWZHmoAlQkAu9opvQ
	(envelope-from <stable+bounces-259749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 10:50:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A35A462AE0A
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE8BE300BCBF
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FDA36E489;
	Tue,  2 Jun 2026 08:46:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98033D4E9
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390008; cv=none; b=PPsQgHCjbdtaq8RZSSUwYz/1bEQxetlZ3dyxUJWSJs28/oywcW8xWo8kLAN+6XPU0qsvJmNis5VxhKe4kCjNV7H05KbRNlqfjcEIbxXQsnOsliXdKTpGCzUY8Xf7eXdOFydT5Ml45cFL13KErvNmHi+g4IONcpXPValdz/xRxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390008; c=relaxed/simple;
	bh=cBOt05zGzbEU1xLn+LgzyMbXoyfoUi9iDiE7os8XVZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxQwgRuZrfd/hS8rBS4D/fty9Z2xSFEM0sV5KGki0MNhaNy1Cd3xOjA0ypGoCP70zrPC6Ty5E8Apmq8P3fB00huV2sCSO/lXqcw0rXWSZfqaslnpyL4elRr67p1Y1o5Jmm6vE5uQX/azEPEn15NEJwwl2Ib29ZZkU2SxgD2m244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500cd665649150e3ae5.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:cd66:5649:150e:3ae5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8107B1C6BB3;
	Tue,  2 Jun 2026 10:46:46 +0200 (CEST)
Date: Tue, 2 Jun 2026 10:46:45 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Weinan Liu <wnliu@google.com>
Cc: iommu@lists.linux.dev, jgg@nvidia.com, suravee.suthikulpanit@amd.com, 
	will@kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	robin.murphy@arm.com, vasant.hegde@amd.com, santosh.shukla@amd.com, chrisl@kernel.org, 
	josef@toxicpanda.com
Subject: Re: [PATCH v2 0/1] Don't split flush for amd_iommu_domain_flush_all()
Message-ID: <ah6YY7OlNFCxVmOD@8bytes.org>
References: <20260528223147.750229-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528223147.750229-1-wnliu@google.com>
X-Spamd-Result: default: False [-0.69 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259749-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[8bytes.org: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joro@8bytes.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,8bytes.org:mid]
X-Rspamd-Queue-Id: A35A462AE0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 10:31:46PM +0000, Weinan Liu wrote:
> Weinan Liu (1):
>   iommu/amd: Don't split flush for amd_iommu_domain_flush_all()
> 
>  drivers/iommu/amd/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

