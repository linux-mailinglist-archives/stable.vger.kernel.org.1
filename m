Return-Path: <stable+bounces-235308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OIaJchC12ksMAgAu9opvQ
	(envelope-from <stable+bounces-235308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:10:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 283783C6767
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C7F43011C53
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E2530AABE;
	Thu,  9 Apr 2026 06:10:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9B27FB37
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775715013; cv=none; b=DCQvrb6gWRLZ+wdeAEzu3vxl+HvvmGSlWMxGtc3vebAoui88nAXq9UZd1VCUOLrTdWwd+CYrNS93HewdskC30epdzOsNn93wokvpfEP3rUUG6TxhXwr6HqaN8VcxjKBPIY7H3j9EH0xtklYpnRTLadunAUduThBEE31lAMz1Bgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775715013; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8FE9xCWMQCAHj3k5FSTpRM2i6CGkbjCvneTjQTJW6meL4NUT0K9nlEo42k+WQiNBzcjfFsXC0ZnFUZO2pPk/Gp+P9+k+OiHK1r4aZH0jrE2BvrjVAP5xT7TeEKVvLZrTtYJqwS8oAz0kaviSn0svndZ/Y7tWqxgwi5HOZtvFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF1E068CFE; Thu,  9 Apr 2026 08:10:09 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:10:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: sagi@grimberg.me, roys@lightbitslabs.com, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: avoid recursive nvmet-wq flush in
 nvmet_ctrl_free
Message-ID: <20260409061009.GA6470@lst.de>
References: <20260409005647.112289-1-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409005647.112289-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.995];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235308-lists,stable=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 283783C6767
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


