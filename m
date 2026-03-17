Return-Path: <stable+bounces-226035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF4/CkhpuWmZDwIAu9opvQ
	(envelope-from <stable+bounces-226035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:46:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCDE2AC404
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBBB730804F5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A094C27FB0E;
	Tue, 17 Mar 2026 14:36:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8A3E5560;
	Tue, 17 Mar 2026 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758219; cv=none; b=inkkr/CdbKybYx6K2aCZoCrItXMWXQrPDp77Awi5WssJLJTptWagb70ZCZ/nvZZfE52r4ijTe7botQSmck62Ink0cKNbN2JMpluIXWZy/XW0I9LOLGkD0kUMluKAD7dwzHjWk0TMGxfhvkKallrZlZa1aedDGOI51yx/V/M3QR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758219; c=relaxed/simple;
	bh=B78I22qlOSMlm3znuSGlssbuIuirdHTXlq/YUV/eu9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfVhUIm5Ls4RhCAk60+u4BrVNt2ybSmBw1WnUT2ENYXjr7FatSHifgFgtwGmjA/zbAnT3yIq8Znu1ht6o3SkEZHAij07CkyFyoOvjuhEFZr/bA8c9STeqa90U2MWpMwYF46MUwxbrC1/XmsLjpqCqNe3Eufya5EBPCoDa/CZM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7989B68BEB; Tue, 17 Mar 2026 15:36:52 +0100 (CET)
Date: Tue, 17 Mar 2026 15:36:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, robin.murphy@arm.com,
	martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
	ahuang12@lenovo.com, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ionut_n2001@yahoo.com,
	sunlightlinux@gmail.com
Subject: Re: [PATCH v1 0/2] dma: fix dma_opt_mapping_size() returning bogus
 value when no backend hint exists
Message-ID: <20260317143651.GA5186@lst.de>
References: <20260316203956.64515-1-ionut.nechita@windriver.com> <8b7706a0-41be-44a2-8247-ebbc33fee937@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7706a0-41be-44a2-8247-ebbc33fee937@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226035-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[windriver.com,samsung.com,kernel.org,kernel.dk,lst.de,grimberg.me,arm.com,oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.909];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: BFCDE2AC404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 09:11:59AM +0000, John Garry wrote:
> For SAS controllers, don't we limit shost->opt_sectors at 
> shost->max_sectors, and then in sd_revalidate_disk() this value is ignored 
> as sdkp->opt_xfer_blocks would be smaller, right?

That assumes opt_xfer_blocks is actually set.  It's an optional and
relatively recent SCSI feature.  So don't expect crappy SSDs or
RAID controllers faking up SCSI in shitty firmware to actually set
it.


