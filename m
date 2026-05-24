Return-Path: <stable+bounces-254012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH4SONDqEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:10:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 586AF5C24DA
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2C5E301E59D
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC18352C52;
	Sun, 24 May 2026 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWvyNaMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18750276;
	Sun, 24 May 2026 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624576; cv=none; b=Z1JYGh1OMsixYEV+0l15Q7lJZvdMqswqAHHasfUtvYCF3J2n8GwnIsRLFy6xE+FVO6rFW5m7bggZ1R3muW+6GchXLxXk67RvLYG7a6GiV5psEs8B0pCczlDM9Va2w7pyigfQiTS6BNHKYZOXQMOuJOv8qZnqDGsCtF2OYeuuNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624576; c=relaxed/simple;
	bh=JYLca4n8uqZO9kcR5Hs/dt+SiHjgiTMVx0T3+SlFIHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ds61iEFpU90AVhg1TfragwvV3xGwrZb3TPy9Bmy8zmIytnvbB7WBsveC5t9e3Q2rYs7jElzO+wTQe5l9NKl/jy24SURH2hoVvSGTV1exFXfHt0ihZHWRqEQUu45cOEPJ4MaFoD7/leY25xEQYELpD18HQlWktp22QUM6xxAsCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWvyNaMn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7D81F000E9;
	Sun, 24 May 2026 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624575;
	bh=x0pitH5PkhGEQgtkB/Mc6awN6Q5lzEr649KS/2bWQtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EWvyNaMnxKQfxBoEvQW0soT9eIVljDvikuHOkfNGrCSQs4GYJnSjZV8ObfDZh7pNI
	 GedWm5w8JB+rdEnxu/1lib8xvE7k7ZmN4NRZ0dO8m/SBhC6t9xX8txS2/cnPia0YLU
	 +OHd7/3HumRldSuduO4uWhGwUwNJ1PEn8hGFyvMGFUNC9jhAvHFS4KsOllyzEQ9Kk5
	 U79PCWzZF2g2s41HR4SyaOb/8ZpN8AfHrdnoPxL+IWZKuNLekPmNH3BYu+Vt2YF3qH
	 ahtG/kE97YrG+bGu31uCXusSKcHnmN1pDk42GQ8vApko+iZODpBYXL96a8kKyT0h8E
	 cNMcSTQxCvi8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Brajesh Gupta <brajesh.gupta@imgtec.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alessio Belle <alessio.belle@imgtec.com>
Subject: Re: [PATCH 6.12.y] drm/imagination: Synchronize interrupts before suspending the GPU
Date: Sun, 24 May 2026 08:09:28 -0400
Message-ID: <20260524-stable-item014-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522-sync-irqs-6-12-v1-1-b0ecc9675078@imgtec.com>
References: <20260522-sync-irqs-6-12-v1-1-b0ecc9675078@imgtec.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254012-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,imgtec.com,lists.freedesktop.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imgtec.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 586AF5C24DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> commit 2d7f05cddf4c268cc36256a2476946041dbdd36d upstream.
>
> The runtime PM suspend callback doesn't know whether the IRQ handler is
> in progress on a different CPU core and doesn't wait for it to finish.
> [...]
> This version of the patch contains only the part of the upstream commit
> that applies to 6.12; the rest was a revert of code added in 6.16.

The diff itself is fine and the synchronize_irq() portion is exactly
what we want on 6.12.y. However, the backport drops several trailers
from the upstream commit that we'd like to preserve verbatim on
stable:

  - Reviewed-by: Matt Coster <matt.coster@imgtec.com>
  - Link: https://patch.msgid.link/... (the upstream Link: trailer)
  - Signed-off-by: Matthew Brost (the upstream maintainer SoB that
    landed the patch upstream)

The upstream Fixes: tag also lists two entries:

  Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware ...")
  Fixes: 96822d38ff57 ("drm/imagination: Implement Rogue safety event IRQs")

Your backport keeps only the first. I agree the second Fixes: refers
to code that doesn't exist on 6.12, but please keep it in the commit
message anyway so the trailers match upstream verbatim; stable
convention is to preserve the upstream trailer block unchanged.

Could you send a v2 with the upstream trailers (Reviewed-by, Link,
SoB, both Fixes:) restored?

-- 
Thanks,
Sasha

