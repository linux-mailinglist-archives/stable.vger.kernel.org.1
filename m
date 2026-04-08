Return-Path: <stable+bounces-235273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOu7MQGt1mncHAgAu9opvQ
	(envelope-from <stable+bounces-235273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:31:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 320A33C3213
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78F043060D54
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD83DA7D4;
	Wed,  8 Apr 2026 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFGXE3AL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65D3DA7CD
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775676142; cv=none; b=q+GqbT+GYosovqATMLBl7eZt0SNvrigh+89bcPogq/6TRl4/kSn6hR6aTLynX8tn5O/hoaygduTnXCq4RGK2WUXkBCnQcWAUOu7+iYHfhKEMCTkvsQA6s2CQ4LvdzwWmcLXSSUZrC3pRaopKos4Ins16CsRX5rTsDNM4nAmHrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775676142; c=relaxed/simple;
	bh=GtoDxUV7jx4Q+glcVA7o4x3DItfhn1Pj/U50pTxFP7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOPm7UHZLQDLEsyvx4VArFe2cmOUR09TfCJZbNhllNRFNP2oQcvhIx0RrYjwDrHDXy1FYVonTg43rjSWhWl+WNJ7xtXDzgaBUZLFmmj/otjer6d0K1uGCDk5wa7VKSQAnP2ZKENJ18W9gkop6iO8i+nsWmzYMCuN9aVpDY2sxBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFGXE3AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776B5C19421;
	Wed,  8 Apr 2026 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775676141;
	bh=GtoDxUV7jx4Q+glcVA7o4x3DItfhn1Pj/U50pTxFP7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFGXE3AL6wXIi7lveJ8KhF+h44fH/6NFbjQWJrcaPSpI8P+xLb9f8+P+cr6iD/XbL
	 D2LvSO8izzn/UycXDenTf+6zzO5Ma1wLon55R9uVqQDrjeDlbjRMvJA5M6b35nPoBQ
	 cO/0WJSfFe07SSB2RTQz5n4VTkRDuLhbfGQSu/gAJ0Az8go53JPzM8M3G9xpjQsHKX
	 iCtb3y08W34ynT0eehQj9J+2nmEIhOUIyq6aJmLx+OjxxDb00Pa1h82tWwbVojh4EV
	 lGAJTE6Ldd1hJ89oG4gVBEAtNNLNITnVKoI4sBit2NLQKJgDHnKnvuQZFE7HwUddcY
	 lhQEYv7kzQ55g==
Date: Wed, 8 Apr 2026 13:22:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: skumar47@syr.edu, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix race between ICReq handling and queue
 teardown
Message-ID: <adaq6xNK0Vy7pWW4@kbusch-mbp>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235273-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 320A33C3213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 12:51:31AM -0700, Chaitanya Kulkarni wrote:
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.
> 
> If an NVMe/TCP host sends an Initialization Connection Request
> (ICReq) and immediately closes the connection, target-side teardown
> may start in softirq context before io_work drains the already
> buffered ICReq. In that case, nvmet_tcp_schedule_release_queue()
> sets queue->state to NVMET_TCP_Q_DISCONNECTING and drops the queue
> reference under state_lock.
> 
> If io_work later processes that ICReq, nvmet_tcp_handle_icreq() can
> still overwrite the state back to NVMET_TCP_Q_LIVE. That defeats the
> DISCONNECTING-state guard in nvmet_tcp_schedule_release_queue() and
> allows a later socket state change to re-enter teardown and issue a
> second kref_put() on an already released queue.
> 
> The ICResp send failure path has the same problem. If teardown has
> already moved the queue to DISCONNECTING, a send error can still
> overwrite the state with NVMET_TCP_Q_FAILED, again reopening the
> window for a second teardown path to drop the queue reference.
> 
> Fix this by serializing both post-send state transitions with
> state_lock and bailing out if teardown has already started.

This looks okay to me. Will give this a couple days then queue it up if
no issues reported.

