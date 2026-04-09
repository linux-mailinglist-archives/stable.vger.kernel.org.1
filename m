Return-Path: <stable+bounces-235310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMlgLglD12ksMAgAu9opvQ
	(envelope-from <stable+bounces-235310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:11:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BDC3C679D
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 674D6300EC4F
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB830B509;
	Thu,  9 Apr 2026 06:11:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA51F30A9
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775715067; cv=none; b=dBQcT+OqXxnuBqE7NNQiAiyCofrXEz3cMA4JXqZ6YVtiqneW1uKtMraQaieH1GB6GBC5tykEUs8x8qBxOftahXKsonyq068WEMzm35KuaU8RwxBPdBPa7JUpoIMjW/3mJI9GYHDKAL5cr+XRH9qp40XsglECa3h+Ih5Inng2RiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775715067; c=relaxed/simple;
	bh=Yac+vgwEJ+/Q9p4QVzOehjqBUY/Qn+uH5PGagusJgmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAUOUF0PAIoQnZ64i9Ix+8x9cJ0n3qQvcOl/MKK1rSe9uC6zYiPHAnWVkiAjppINeKBWKn0IFoUg0bdYbyfadGY+UGDFyB+Vf3KJ6qz/KgFyEc4d7iZ/nm8G/cQ9V/HGYPUYmKaH75PqHhjA9aPIsyI0xjY2ZJj6GrCI753rYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B06A68D07; Thu,  9 Apr 2026 08:11:03 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:11:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: skumar47@syr.edu, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kbusch@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix race between ICReq handling and queue
 teardown
Message-ID: <20260409061101.GB6470@lst.de>
References: <20260408075131.6221-1-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408075131.6221-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-235310-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 40BDC3C679D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 12:51:31AM -0700, Chaitanya Kulkarni wrote:
> +		/* Tell nvmet_tcp_socket_error() teardown is already in progress. */

Overly long line.

Otherwise looks good.

