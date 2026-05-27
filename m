Return-Path: <stable+bounces-254618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMEuIIsSF2pf3QcAu9opvQ
	(envelope-from <stable+bounces-254618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:49:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C85E72D4
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4EC9312C92D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E94743636D;
	Wed, 27 May 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQJRZ2oy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC642EEA4;
	Wed, 27 May 2026 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896508; cv=none; b=erdVYOjYTAqFzZHbIN1DjX4j1NSdRWF1v0qlUAfTKbzNAv1ZeDYYNA47eF2u3YXBGgof/Znobtl7JtuYU+8at7N3Lgrah7pmjj4b16otHkVNVJIJq6iLFBKLOQzwCtxo+W5jgViHUbl8APi+dPNVLjzUXwANuE0Fmxarcfz2UME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896508; c=relaxed/simple;
	bh=+QvikxJWU4RKkU9CfpOYUEbdvLG+ZZRZFmAxtdmOohg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxxukmP11Isb/qk9AN/j6kafkOWUUitBnuKgTIo3yNxnuMFEHcwD6uT8T5dx++JsVVPAVlekqbBw+ovWuECln5pmzob9xZbpVsuPG+X1ODQeMIOdlK5sOFdxABxhJ/vvWnr7s4HjKif/C65fgevcz+jkrNGMdydAXrKOjHllJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQJRZ2oy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617C61F000E9;
	Wed, 27 May 2026 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896506;
	bh=sqjCjeZHrmiswZMkLzOZmen5SdH45oBHZzIwkf4OipM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YQJRZ2oy2oTZ8hbKO/wmJJOisEfzi5H/mHK9aKikfVSaQ7QCNdYeoQD/2ylqxtFO1
	 FCsly6FILsu9balidKhsNmBwh40WNTqd5urRRmAMy74Dn3zoUNGxN4FMp6L/N/dSFP
	 31tU/NcaGXAoc7JkvKF2s/YD8jA/3CHtvkBVOTRiPMdw9Jtyv4t1Wu/lqKnhIv9eTM
	 nKGXb/7EevCmBC88kpbRyHOC5ZSeVoZ1xvPeQ0pBLPM/ILtowkXVIi//qI48aRNNIl
	 8a1iDAbsSZkr9rC20TmnFMez7WDP+9vsoqhYW9ab1pmEH47L5ygDlzf+fELVXnGJn6
	 IUfly1BamrgAQ==
Date: Wed, 27 May 2026 09:41:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: target: rdma: fix ndev refcount leak on queue
 connect
Message-ID: <ahcQuBUf70pBZcdg@kbusch-mbp>
References: <20260527084544.864221-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527084544.864221-1-vulab@iscas.ac.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254618-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 152C85E72D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 08:45:44AM +0000, Wentao Liang wrote:
> nvmet_rdma_queue_connect() calls nvmet_rdma_find_get_device() which
> acquires a reference on the returned ndev via kref_get(). On the path
> where the host queue backlog is exceeded and the function returns
> NVME_SC_CONNECT_CTRL_BUSY, reference of ndev is not released, leaking
> the kref.
> 
> Fix this by adding a goto to the existing put_device label before the
> early return.

Thanks, applied to nvme-7.2.

