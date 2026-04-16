Return-Path: <stable+bounces-238345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PZTBswj4WkBpgAAu9opvQ
	(envelope-from <stable+bounces-238345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:00:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990F413698
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C079B3096202
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4B29E11D;
	Thu, 16 Apr 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpwYdJD4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DD1DC198;
	Thu, 16 Apr 2026 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362194; cv=none; b=XMZGHe6TXEV2O03mpTcHp9PdbbNEVWksZWWoaSty6DDQKYMFJWlsppgVAXUyQ0u8tMGfz8BClAabSUQH6AkqVC/W7lJAvMzVw5IHa8OMPhSUpaHKPZDGgyONV7Zi9IHRjlh+UB35ChkHU/T6Az4S0wFbrpch6o48S3FEJWkujBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362194; c=relaxed/simple;
	bh=KdcGpKLRC6bvMX3dEy0yvIMgE+RyJc8GyiO/VJk+TWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATQ2o5ev2PIM2Tn9lNi4YNZhXwY9jBJF9ljTrPyPqOV9NnvJ9fG4GRUfi/Jw3N1E8km9TjB3G477jk7pLZyF+1D7v9RvBTWeIXiTc6RbfbB+bTSS9Ro4soqne2O69j6o0UpUyUwus1O47s0O9ipCdZavxxcdATQRigkYI0x8qBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpwYdJD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDF8C2BCAF;
	Thu, 16 Apr 2026 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362194;
	bh=KdcGpKLRC6bvMX3dEy0yvIMgE+RyJc8GyiO/VJk+TWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpwYdJD4zJSsuKgCwaO4W38faG5WN3rCxb5YzNk/+cyzkQHrxPbNgql5bVKXQ/RkB
	 sxmn4vWrEVANNBT//EIW/CBi4LvzQgrzDuC5DVU4Y2zW+DPkKEOCYDEPlxJdLXfmpQ
	 EAhPL4uatR/7FepuRH7PCh3icZ5uMu6hazdzWV113gW45FR6fr9d/Z4X5iBOzRx0mj
	 JymfFdg+V0XUqrTdbpM1B+D2ewN2oFOZlYKY6q9UYXsMk2KyG1BOsDjpFrvaxZ9RYg
	 b6Unq7K+QmmhlDyNDCW69Rwqg2/pwO8XJCOhZhHyOjJ/Rw8Kz34Q5Rg4MtQ8kC8VrM
	 cpnbRE8/AxUgw==
Date: Thu, 16 Apr 2026 07:56:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Prevent RB-tree corruption in
 scx_bpf_task_set_dsq_vtime()
Message-ID: <aeEi0X4Fn70bUgva@slm.duckdns.org>
References: <20260415193459.933175-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415193459.933175-1-yphbchou0911@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238345-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,manifault.com,nvidia.com,igalia.com,ccns.ncku.edu.tw,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9990F413698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 03:32:44AM +0800, Cheng-Yang Chou wrote:
> scx_bpf_task_set_dsq_vtime() allows modifying a task's dsq_vtime without
> checking if it is already enqueued on SCX_DSQ_PRIQ. Since dsq_vtime is
> the rb-tree sorting key, mutating it in-place violates the BST invariant
> and corrupts the tree structure.
> 
> In ops.dispatch():
> 	p = scx_bpf_dsq_peek(PRIO_DSQ); // Get a task already in the DSQ
> 	if (p) {
> 		// This illegally returns %true
> 		scx_bpf_task_set_dsq_vtime(p, 0xFFFFFFFFFFFFFFFF);
> 	}
> 
> Fix this by adding a check for the SCX_TASK_DSQ_ON_PRIQ flag. Disallow
> vtime modification and trigger scx_error() if the task is already queued
> on a priority DSQ.

If the user updates the vtime after inserting, the tree looks wrong but it
won't cause crashes or anything. Later insertions might get confused in
terms of ordering but it's a rather obvious user-shotting-their-own-foot, so
I'm more inclined to leave it as-is.

Thanks.

-- 
tejun

