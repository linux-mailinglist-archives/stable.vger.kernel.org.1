Return-Path: <stable+bounces-267543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SqdHBLboN2oOVgcAu9opvQ
	(envelope-from <stable+bounces-267543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:35:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A766AAEF3
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:35:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Bu2rVS70;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267543-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267543-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D9DD3005E9F
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D249367B83;
	Sun, 21 Jun 2026 13:35:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20149367B60;
	Sun, 21 Jun 2026 13:35:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048947; cv=none; b=Lzda5aXR6SDTZdbvjDH/p96ibtazN6oW7NiW9lSbp5kk54015BQiV8x/aQI5CpCpr4D5rBM2xMT+pHGgnWAMBmcRjnyRfaZe8MDCPQqIV2HgRqm2Y/zl7PcBnrPkhghJ4JsLwqCJn1yT20LIbkEZ7abHVw4hQD2UKRjTYa2wOBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048947; c=relaxed/simple;
	bh=qkdi1Mm8r1WfQULAuRFFlID6RChvcSoXS79Zjkno9xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkgwzY9Z01kqG8cgHcJYFY0ttAoMDjlfDlHaP0I48a48fwLzv6MZQCvbspSzda9SFrEdFqkVPpkuFfqa/w2ia8qpx0ApcrFkaaoG89EkSVXpBYh3XA4Ws5UZsqjC3CZXFQ6C7XtJJQPwsDOAPOogYlEZ/Z8scb63wXEqlHb4lP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu2rVS70; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BA21F000E9;
	Sun, 21 Jun 2026 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782048945;
	bh=a4xYOjXUmeXKiNZBk3/FakjN1MIv8fVkL9//J3Rm4VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bu2rVS70AE7q0539unYUHl8ifOUfopApEuWITF2YFKX/a5/N4RVtP8oWqL7eYPmYw
	 TqdGOGPfZBNulrQ1ib7GFqcsrsGUWsbG75npEstvkHMakn511zcy6TD011HDsw3vJb
	 dDs+wdBeBv9OEjTeb467IMmtMraySDY/xJde7APVgFS/u9D9wL//WJ3vD5Pke1nI6o
	 B6ppi5lZQZpDdKiJE2gnU/114gmX+wIgh4nzbjFKtvX3FeSAkSOvFo5V7kDPeOsStv
	 rivSYD3yw0MfpUq0aMV3Ma7guyFGC5owFXfgsSQv1o0Wp/QhDXiEGTq0uzTB4Ufpil
	 +8R8q8AQVt8Gg==
From: Danilo Krummrich <dakr@kernel.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: fix reversed error cleanup order in ucopy functions
Date: Sun, 21 Jun 2026 15:35:35 +0200
Message-ID: <20260621133535.5892-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SYBPR01MB7881484D91A6F80271415F71AF1A2@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881484D91A6F80271415F71AF1A2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:moonafterrain@outlook.com,m:lyude@redhat.com,m:dakr@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:airlied@redhat.com,m:dri-devel@lists.freedesktop.org,m:nouveau@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267543-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65A766AAEF3

On Wed, 10 Jun 2026 18:01:28 +0800, Junrui Luo wrote:
> [PATCH] drm/nouveau: fix reversed error cleanup order in ucopy functions

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] drm/nouveau: fix reversed error cleanup order in ucopy functions
      commit: ab99ead646b1

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.

