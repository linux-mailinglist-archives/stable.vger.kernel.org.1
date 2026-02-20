Return-Path: <stable+bounces-217525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g01EAnHAl2kE8AIAu9opvQ
	(envelope-from <stable+bounces-217525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 03:01:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B401642F5
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 03:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A47CB30066A6
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 02:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77C2192FA;
	Fri, 20 Feb 2026 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="mjyjRX+C"
X-Original-To: stable@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1671B4F09;
	Fri, 20 Feb 2026 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771552878; cv=none; b=FYBaPdKONaw2J5PwN+zrWFGYkIjtjoCZwnBUqGayOyEVW225ww/l7yN1wpTAzkwrA2v3SVKoD9y1VRLUhlbppuXU3IIhZwxu9aQHEfjWZmQZ8BRYYVHdY7BueD4bZXH+4XDwZxn7yCq091YQFNB7uI/Q2Rg4/EuP092WueTjfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771552878; c=relaxed/simple;
	bh=SjreZxgEDQkHyx/PVpEMXYPGrJ3PNf+PWShj9NzXTh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aby6wfVZ6M/gmWXLakHVmQaYfoiSo9G3eORbVQtiSvX8D17jNiPdJWm6u/qVdNsqvKgWxgFBGuzMVfq5znkkz98aiykUxAm2ZRkbUYSDvv3D3TMtsPdKiqhB8QdfX0GmQRZj403v/aMdfKVzVOsGLj0I4er1EnVinCdifygJof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=mjyjRX+C; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1771552371; bh=RYwp0qZ5OBGtM9HrbXRS6kYseYlEG8GcG1ORozzm0g4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=mjyjRX+Cua51tGFyXHC1OTRWnaddm5edNZvLywYtsAvMjH/zPW9wZZO8g/4Wh61XX
	 rJCNlAopb+5kzhHg6+Ian7yRJQByLSyr+3wpHZd/AZrQFj4eJCy9+KpOYj2wM6zPUB
	 z7Deb/AZw391I+l6k3CJUOATlyeTWbKe5n6Ck8PoOZUSqJApkhbzoEie7W1XHe5zNv
	 O9wB+dAZ9COPQHFeKAvqxSSFN+us0XPOWJLppcIx2h6zABCYvJke09DsKWxkCBAafA
	 N//0fic7MDUlN0u8Gk/jBqaw30hXS2LjbojWpL4zmT188HBcNZuj3OKscnnEsqA+PQ
	 OQ2ntCoawM1xg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4fHCtq63Cvz1xys;
	Fri, 20 Feb 2026 02:52:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 80.131.192.251
Received: from thorium.fritz.box (p5083c0fb.dip0.t-ipconnect.de [80.131.192.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1857JzXgnV/WGEwzfBXodhxR1lbFMiZ02g=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4fHCtm4YLsz1xyp;
	Fri, 20 Feb 2026 02:52:48 +0100 (CET)
From: Ferdinand Schober <ferdinand.schober@fau.de>
To: linux-kernel@vger.kernel.org
Cc: ashok.raj@intel.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	sanjay.k.kumar@intel.com,
	stable@vger.kernel.org,
	will@kernel.org,
	yi.l.liu@intel.com,
	Ferdinand Schober <ferdinand.schober@fau.de>
Subject: Re: [PATCH v3] iommu/vt-d: Avoid superfluous IOTLB tracking in lazy mode
Date: Fri, 20 Feb 2026 02:52:39 +0100
Message-ID: <20260220015239.375598-1-ferdinand.schober@fau.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20230209175330.1783556-1-jacob.jun.pan@linux.intel.com>
References: <20230209175330.1783556-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fau.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[fau.de:s=fau-2021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217525-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[ferdinand.schober@fau.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[fau.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fau.de:mid,fau.de:dkim]
X-Rspamd-Queue-Id: 79B401642F5
X-Rspamd-Action: no action


Hi,

I've stumbled upon this patch trying to figure out how lazy invalidation is implemented in intel IOMMUs.
The patch suggests that lazy invalidation is active whenever iotlb_gather.queued is set.

However, the only place in which gather.queued is written seems to be in dma-iommu.c:

-- drivers/iommu/dma-iommu.c
 820:	iotlb_gather.queued = READ_ONCE(cookie->fq_domain);
2038:	iotlb_gather.queued = free_iova && READ_ONCE(cookie->fq_domain);


Both of these depend on fq_domain but fq_domain is always NULL for intel iommus,
since iommu/intel/iommu.c reports IOMMU_CAP_DEFERRED_FLUSH:

-- drivers/iommu/dma-iommu.c:708
	if (domain->type == IOMMU_DOMAIN_DMA_FQ &&
	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dma_init_fq(domain)))
		domain->type = IOMMU_DOMAIN_DMA;


(Above line numbers are from Kernel 6.17).

So I'm not sure, this commit does what it should?
Please let me know what I'm missing here.

Best Regards,
Ferdinand Schober





