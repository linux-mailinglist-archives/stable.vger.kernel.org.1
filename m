Return-Path: <stable+bounces-254010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D6OJJnqEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:10:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E73685C24B4
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0EE13011848
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9535B632;
	Sun, 24 May 2026 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8RjBp9T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7E27A12F;
	Sun, 24 May 2026 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624564; cv=none; b=mXnmb4f8Czy8qW0Uyx7wnTKNEfblZ/wDFkwuygt/crxeS0UVwe0QTjrwtP6dX4W7fbHHJJPesK5iWIUdp/0aIRalVf99p/1r6cru7IThvyyjoy4lw6bwk/mYK1nJYcyUPrmDMHuJJnKN/8zY5CEg+t4hkuyYEPzWIPiMKLlrAsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624564; c=relaxed/simple;
	bh=Fyo3h8bdk6TYJP262Df1/1BLKcyCrsLPLFcND4zSlSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e35vbcW6zCe86rVacQfABbuO4DFzARh8Jd7hEE6/hK/rbr2eHQ5gRd/rXdfCBgsVpaBAespm8Zv7ync5PFESYNoRYfitz2dnNy/R3bW/F8ZRoiCemuqa/7IB32UzK8VDzsuoxF/e2z/BgwF/4dDcM4EdxnzZuvZeAPwI6IkRUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8RjBp9T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76661F000E9;
	Sun, 24 May 2026 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624563;
	bh=5pApOR5X2I9xTZ0qfUnZk2+FffulHCxsGQPx04hfQ40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B8RjBp9TdKSsU8okMPeQs85051n+ltVhUBuRSaOfnIvooL5w9convLxSTrYhZ6sFq
	 oB9aJ/71e8X14KcwCY7Mg+rNnqjU3x8u5gC+GaejDYEyfX7naVARdUmPWoLwkkA4sB
	 9TlRXUPMNb17sMyXtiDV7oXcu/09dmmxDdcv6OFpBe1ilJvbRfSBJJ0+jihF49m3XB
	 7WDAvgDuUKLOEkT3k5CBspGJJ63ChtWVkDKx5a+cwhTxcMCw/zSBys4FAKA3+ffBOx
	 LWmFzkDGdk9ziT3qfbP9CV06ZyC6SyY91nkQjBT3WpDO7Sf/BxlGHhR/pzWP+DDzEt
	 B/gvMaidu7HIw==
From: Sasha Levin <sashal@kernel.org>
To: Lukas Beckmann <lbckmnn@mailbox.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Mike Galbraith <efault@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 6.12.y 0/3] backport missing dependencies of d66792919d4f
Date: Sun, 24 May 2026 08:09:19 -0400
Message-ID: <20260524-stable-item004-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522213120.1205100-1-lbckmnn@mailbox.org>
References: <20260522213120.1205100-1-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,gmx.de,infradead.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-254010-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E73685C24B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Commit d66792919d4f ("sched/deadline: Use revised wakeup rule for
> dl_server") in the 6.12.y stable tree (upstream commit 14a857056466)
> depends on three upstream commits that were not backported:
>
>   commit cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
>   commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
>   commit a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")

Thanks for tracking this down. Before I queue this, the series is
missing two more follow-up fixes that both carry "Fixes: cccb45d7c429"
and that are needed for the dl_server logic to behave correctly:

  4717432dfd99 ("sched/deadline: Fix dl_server_stopped()")
  bb4700adc3ab ("sched/deadline: Always stop dl-server before changing parameters")

Without 4717432dfd99 the dl_server_stopped() check is inverted (it
returns the wrong polarity after cccb45d7c429), and without
bb4700adc3ab the per-rq running_bw accounting can get out of sync when
dl-server parameters change while it is still active.

Could you send a v2 that includes both follow-ups on top of the
existing three? Then this should be safe to apply as a whole.

-- 
Thanks,
Sasha

