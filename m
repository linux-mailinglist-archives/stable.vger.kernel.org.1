Return-Path: <stable+bounces-230579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F/vsNxr/xWk/FAUAu9opvQ
	(envelope-from <stable+bounces-230579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 04:52:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565B33EED5
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 04:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B712301FCA4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB57343D75;
	Fri, 27 Mar 2026 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJsUPkFX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C31A9FAA;
	Fri, 27 Mar 2026 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583572; cv=none; b=fz1rjKrTOBfJ0bfC3PFcCM3ZU/l86fImlJFHAhFHbm3+9eTykmhkbvZUuKys7FcUQgDFu8TgmXf8v9vLsGBYDpYwMA+AV5/L8AUjEkEw1zmJNKaxHZ4t4v62rctFnEZpZJecniuyaaWZXns92ySAtRktuRTTfZ2/j3FoViB6GMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583572; c=relaxed/simple;
	bh=wVs7w3jdxXfOD1RlM9zy+o9MlvWJ3DIZG90l7SC8t+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp5Wk7HDKF4rqR9ebQ8Gqd3zlNefEUiGC/5ggjp+hFvWesWhEFtLveVEqLqrryW4/PVLKm/lrq1p7r70B3JIWid22O9WUjNRJXdNxMfkTIMjdRmtTwlKit3XNl0AgWmZD/xLMafrYVTMf7LaWxSkvrQPESZsencoL8STfETCwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJsUPkFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFB9C19423;
	Fri, 27 Mar 2026 03:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774583572;
	bh=wVs7w3jdxXfOD1RlM9zy+o9MlvWJ3DIZG90l7SC8t+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJsUPkFXIjMKbMuUhuV0IJjXQQROMInRb+ewrGDGpmI+hCI2hHd9rGhhamPJARZ27
	 94NDDsc5EuO3P0vx9qChUGsmOYFYV+nKIjmS1HE0PE9ftLmzytBftW7Y0bT1GoNs9I
	 mhK/p7RNI07MVnXf1uqOfYI+crZvyN+A+r96K0dkWYoV2yoyW4egCEnVe/3LkVOBbz
	 UpZ1JmKQnTTf4EQH59hjTneOYBch3xEtE3d6LNWvADJy/xjRxxu1ikFi2K6sEeCix3
	 icyeF2lGJ1eSei4l6FLZEH+eKNVvdQyxSyFRZLBgL6pdOY1wSn56B9Bbr8fMYLVGG5
	 VysA9nC3aF7Rg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
Date: Thu, 26 Mar 2026 20:52:49 -0700
Message-ID: <20260327035250.67961-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327004952.58266-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230579-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5565B33EED5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 17:49:51 -0700 SeongJae Park <sj@kernel.org> wrote:

> When kdamond_fn() main loop is finished, the function cancels all
> remaining damon_call() requests and unset the damon_ctx->kdamond so that
> API callers can show the context is terminated.  damon_call() adds the
> caller's request to the queue first.  After that, it shows if the
> kdamond of the damon_ctx is still running (damon_ctx->kdamond is set).
> Only if the kdamond is running, damon_call() starts waiting for the
> kdamond's handling of the newly added request.
> 
> The damon_call() requests registration and damon_ctx->kdamond unset are
> protected by different mutexes, though.  Hence, damon_call() could race
> with damon_ctx->kdamond unset, and result in deadlocks.
> 
> For example, let's suppose kdamond successfully finished the
> damon_call() requests cancelling.  Right after that, damon_call() is
> called for the context.  It registers the new request, and shows the
> context is still running, because damon_ctx->kdamond unset is not yet
> done.  Hence the damon_call() caller starts waiting for the handling of
> the request.  However, the kdamond is already on the termination steps,
> so it never handles the new request.  As a result, the damon_call()
> caller threads infinitely waits.
> 
> Fix this by introducing another damon_ctx field, namely
> call_controls_obsolete.  It is protected by the
> damon_ctx->call_controls_lock, which protects damon_call() registration.
> Initialize (unset) it in kdamond_init_ctx()

In this veersion, I updated the initialization to be done in kdamond_fn()
before the damon_started completion.  But I forgot updating the above sentence.
I will make the update in the next version.


Thanks,
SJ

[...]

