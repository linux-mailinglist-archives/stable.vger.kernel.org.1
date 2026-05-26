Return-Path: <stable+bounces-254364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BpMGQOjFWprWwcAu9opvQ
	(envelope-from <stable+bounces-254364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:41:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EB65D6B30
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68A4930588A8
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F323F99FD;
	Tue, 26 May 2026 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUIsbkv0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC52E228D;
	Tue, 26 May 2026 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802710; cv=none; b=VPOZnsi+UoSz9EpppVSdMkTWl4Ac4bRHgu4ztOapF9U8sGusgkhKL4EnPfpa3H1eWX/uhrhxuOcENpDAoQp1/0XrCODs5UVKLHYqL1A7fCqg+3tZrbqGLstIpqrxUvaQUnZYnpUrdUic5sRcKpNEp6YLpwMQHCgaxL7dGda3ygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802710; c=relaxed/simple;
	bh=vKz5RZlttolPlcTrAJ8O4+rZ3qKUebuZ/Twv/fPfQIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzoeoCMNLwXhN+CuPq1UsOHE6HSptCXbt9j4mG4DQjUcXSZJIX7bEA95K/yB/VxQkY+MQE4RcLQwHhv9NRZMLsJO6Yv2KTgxadL+4iESugLNojuwzRqzBoXX1HUM8J2/KE2Up7CERQvuBcMFckZq1RiyQOebnxa98FLY6PYh3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUIsbkv0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63201F00A3A;
	Tue, 26 May 2026 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802708;
	bh=EfEdhpcWaQ+cqO6OvMWvbO+XOKtHBGALpHmzVeivkXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HUIsbkv0Qw9I/pdXvHMGfgWu/u7aOoKd3zlCn9ndERNYqYSY9Z8EMd8Hrs7JEqHBi
	 OWCcHDVsEB5hLaYGUlJiKvDyLudXcSEfIPO0/7xusL1gFOdHmaxhLdV1pdxgLrL92f
	 pGHuKAX0zPG0ZU3+x3gRi2NqOaqaPUZ6yHrp1vB2uFTANy9rXX5VgXzaGVRNbn2PPc
	 kFyNmsOiy1RzCDX/9E8c6foVlnKXfePd0Pa5VgjML2T6G9sZMQP5/m32C+xJZRX6Lg
	 UuZhc9YWZK8TZS79PSyN9ETy+2RV1YiNUeowJ+ymnZKm6dhyMGE0YGA21T8D1sNeAy
	 LjvTSafsmnqbQ==
From: Sasha Levin <sashal@kernel.org>
To: Alessio Belle <alessio.belle@imgtec.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Brajesh Gupta <brajesh.gupta@imgtec.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y v2] drm/imagination: Synchronize interrupts before suspending the GPU
Date: Tue, 26 May 2026 09:38:18 -0400
Message-ID: <20260526140000.agent5-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526-sync-irqs-6-12-v2-1-b4306e95194d@imgtec.com>
References: <20260526-sync-irqs-6-12-v2-1-b4306e95194d@imgtec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254364-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,imgtec.com,lists.freedesktop.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 40EB65D6B30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 09:13:07AM +0100, Alessio Belle wrote:
> This version of the patch contains only the part of the upstream commit
> that applies to 6.12; the rest was a revert of code added in 6.16.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

