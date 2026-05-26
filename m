Return-Path: <stable+bounces-254321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA7DLXWFFWoSWQcAu9opvQ
	(envelope-from <stable+bounces-254321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:35:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C2F5D4F03
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F1063028652
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6D53E0734;
	Tue, 26 May 2026 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBpmCATl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDC3E0C55;
	Tue, 26 May 2026 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795314; cv=none; b=nPgd0OK6v9lLTVqQyypttIe2H5LeUqUmUnUmdxjl1fgggDERr2wosjbjAizS7xZXrhJlPVrbEhCtECKFtzauC4ohh3uSSo89QoDh4iUaGGPaDhCsLu00cD4n4kAWk1GG2DdKHnOQ77D9DBYYGZYSamSPATY8p+LkTOsHOoZOXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795314; c=relaxed/simple;
	bh=2H3H3vnC2GwG0fDzZ6w637YY6pI9aFKfjn1RibsbrmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ia5i4acpCQYzPSX2x70KB5zhTdua5sF+uDMux8riPGlLV8zT4dAuUFzpRBoubYcApPtWQhFSLdYRsjBqnwXmS/uoIsHwjDJ/LmFpV0wuauya3Lk9LxqjRu7UICzIml6r+/QRaKqsWWA5x+emY9CJuOp3yEPyNv38dRbPWUAFKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBpmCATl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E051F000E9;
	Tue, 26 May 2026 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779795313;
	bh=XAFFB/ti5ppyZh8MzLYmcCCCoGstaLaSac5HP7Oym30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NBpmCATlSk82CG+IjXD3NxX/P+FXuwztclyQ9bxhPOji4foWcNghs5hT2Nif2/BhN
	 5LEbXKSPAZC8waxhBCtNJLow5qzi0h+zq2ky3HGiRnWgexPmgC65RRbZyiONGuhcf+
	 9PrVGuEp9e2MzpI7Cd39vB+TCS06sWLD1wReWMXQU1jCDaDiL0c5jAaDCf53KlbpX0
	 YxM04pnnwhkrboup/wJQVcU/MYdsTzDUbiQ8ynKgbg4vFq8RRQDBGMboKR8yXugEkZ
	 QYFNgFkyBI4jle9UBwq+82qnyYVMGKdIGq5jfTQDHbee43MdA4vSWQvHHMSQUonmEs
	 E+WqatJb0KqQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	louis.chauvet@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	w15303746062@163.com
Subject: Re: [PATCH 6.18.y 0/5] drm/vkms: Backport generic vblank timer to fix ABBA deadlock
Date: Tue, 26 May 2026 07:35:05 -0400
Message-ID: <20260525231000.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525131610.608273-1-w15303746062@163.com>
References: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com> <20260525131610.608273-1-w15303746062@163.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254321-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,linux.intel.com,bootlin.com,lists.freedesktop.org,vger.kernel.org,stu.xidian.edu.cn,163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 32C2F5D4F03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 6.18.y 0/5] drm/vkms: Backport generic vblank timer to fix ABBA deadlock
>
> 1/5 drm/vblank: Add vblank timer (74afeb812850)
> 2/5 drm/vblank: Add CRTC helpers for simple use cases (d54dbb5963bd)
> 3/5 drm/vkms: Convert to DRM's vblank timer (02e2681ffe1a)
> 4/5 drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks() (79ae8510b5b8)
> 5/5 drm/vblank: Fix kernel docs for vblank timer (3946d3ba9934)

Thanks for putting this together.

Looking at the five commits:

  - 1/5 (74afeb812850) is the one that actually fixes the ABBA
    deadlock you observed under Syzkaller; it adds the generic vblank
    timer that replaces the open-coded vkms hrtimer path.

  - 2/5 (d54dbb5963bd) adds new CRTC helpers for "simple use cases".
    No Fixes:/Cc:stable, no described bug.

  - 3/5 (02e2681ffe1a) is a refactor that converts vkms to the new
    helpers. No Fixes:/Cc:stable, no described bug.

  - 4/5 (79ae8510b5b8) is a v7.1-rc1 timeout bump that depends on 1/5.
    It is not yet in any released stable, so applying it to 6.18.y
    would put it on an LTS before any LTS contains it.

  - 5/5 (3946d3ba9934) is a doc fix for 1/5.

Per stable-kernel-rules, what I need to queue is the minimum set that
fixes the bug. Could you explain, per patch, why 2/5..5/5 are required
to make 1/5 work / are required to actually fix the deadlock? If only
1/5 is needed, please resend just that one with your Signed-off-by
added (the carried patches today only have Thomas's S-o-b, which
breaks the chain of custody on a stable submission).

--
Thanks,
Sasha

