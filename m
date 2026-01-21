Return-Path: <stable+bounces-210782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLlZMpoMcWmPcQAAu9opvQ
	(envelope-from <stable+bounces-210782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:27:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E0E5A858
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C384C60F7C0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B039C47D950;
	Wed, 21 Jan 2026 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIhOD8Rf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620213ED13B
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008911; cv=none; b=PktVr+tJV7CgZXaVKIR7XDijosRzJiZTkjXpAW7uEVKF7Aygx3zzpp29e517D2fAM3u2QKWTEk0y9A4aDgnL3Yp2cpnSI3ZMONp/FT44jQejcHR/tLT5rIs0QRT857Pp5eGLw+2Ffso5hIOf2PPPGvSLzkiIbDV+m7DBdUx162g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008911; c=relaxed/simple;
	bh=kRjbRHjdPxS6Mw0bVKQtAyZ9K5hinrud5WAp7cWw5n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwD+8DlajG3b11NYhjwVJ4+k60Ceq9vT1U/SIbRrQZZJwf05OX3lTJxwSpQmX8CL6R+MRP6uHKdGdfEtSVATTWlIar6LRUvvaEJ0VyL/8xADzxK4DSUjjmAhy8Tq59kv/4HTwQ16j/+QAqzf5V2/baFxb1fm6G8glGFPtz/c0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIhOD8Rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3976C116D0;
	Wed, 21 Jan 2026 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769008911;
	bh=kRjbRHjdPxS6Mw0bVKQtAyZ9K5hinrud5WAp7cWw5n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIhOD8RfK+29+3ggyLqsej8EsyIekrzF5jsIgBHUwN1oS8wZ/RC7sulTP/Xj8Rlrh
	 QhFB9K2kbBGJIx10GAWJv9k1So6bziUYNbeLVb6rtJqz1lD+qIN32v2Gu3V8JLsdts
	 oBgyxwI4W/qmmrnblykrX/xT3H7cP+QYO3FWbN7EPac0GOxj6tzSBDze7hj1nMgbH/
	 KUC9vlqcZPo394FGAUj5ghYDhVAn9utia6fJdafYL2XCuJ/k2xMp0GIRqvCtlCoEtT
	 qL54AdC1IepB7bC0xnBlxe1PUXuwruT61hNtlD2cyXxrk9LomgyttvDtdZmZ48A6o9
	 qrTeHbIVy2kcg==
Date: Wed, 21 Jan 2026 08:21:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Dmitry Bogdanov <d.bogdanov@yadro.com>, stable@vger.kernel.org,
	Guangwu Zhang <guazhang@redhat.com>
Subject: Re: [PATCH] nvmet: fix race in nvmet_bio_done() leading to NULL
 pointer dereference
Message-ID: <aXDvDHaAU8cUGlZf@kbusch-mbp>
References: <20260121093854.1705806-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121093854.1705806-1-ming.lei@redhat.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210782-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 72E0E5A858
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 05:38:54PM +0800, Ming Lei wrote:
> There is a race condition in nvmet_bio_done() that can cause a NULL
> pointer dereference in blk_cgroup_bio_start():
> 
> 1. nvmet_bio_done() is called when a bio completes
> 2. nvmet_req_complete() is called, which invokes req->ops->queue_response(req)
> 3. The queue_response callback can re-queue and re-submit the same request
> 4. The re-submission reuses the same inline_bio from nvmet_req
> 5. Meanwhile, nvmet_req_bio_put() (called after nvmet_req_complete)
>    invokes bio_uninit() for inline_bio, which sets bio->bi_blkg to NULL
> 6. The re-submitted bio enters submit_bio_noacct_nocheck()
> 7. blk_cgroup_bio_start() dereferences bio->bi_blkg, causing a crash:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000028
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:blk_cgroup_bio_start+0x10/0xd0
>   Call Trace:
>    submit_bio_noacct_nocheck+0x44/0x250
>    nvmet_bdev_execute_rw+0x254/0x370 [nvmet]
>    process_one_work+0x193/0x3c0
>    worker_thread+0x281/0x3a0
> 
> Fix this by reordering nvmet_bio_done() to call nvmet_req_bio_put()
> BEFORE nvmet_req_complete(). This ensures the bio is cleaned up before
> the request can be re-submitted, preventing the race condition.

Thanks, applied to nvme-6.19.

