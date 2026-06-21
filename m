Return-Path: <stable+bounces-267540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EHB8MYjjN2oOVQcAu9opvQ
	(envelope-from <stable+bounces-267540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:13:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFED6AADD0
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:13:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I5CfqH6g;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267540-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267540-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9A1300DDDD
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20ED28C84A;
	Sun, 21 Jun 2026 13:13:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1E1519B4;
	Sun, 21 Jun 2026 13:13:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782047602; cv=none; b=H6WTkRZlI12eDoXZ7wX89u/3gL2OZA3V3zooCnobpeLh+8VK77a5HS22q7D10/NtFKwVOfGPDmjfbt1+VKQUuV9xkiP90UC5eL2vwGeMZNJjkVAWQSIniLD1ToTzQVKw4yhprJMwZFq/GT2GF+awyrz2k4wyLS2tEyREYFWDxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782047602; c=relaxed/simple;
	bh=Zu7CANSEEIBm1+sX7/ph355b3PEMOEcFZPbvnRk/40o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mr2E7VSf4EOiZATa4mQ0nRF7M3M6hu3EBytt7YMvUm8NSqE2OlGXAMTX9Er1KybokTp4rblUjHwyQztvMxHZCoDkFSJNH8n06xmlcaYoIN3FwtcsyH/tvUF9fuoQWNO33TIUiULmhmRbbRntRDcXve2Noka+MkmhRDqGVjjEDp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5CfqH6g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40C91F000E9;
	Sun, 21 Jun 2026 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782047601;
	bh=dzuTGsXHWnUFFlf4w6v0xDSvKV+lTAJBsA0LpxaiREM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5CfqH6gPdXXucwP6yOGU4artKH2QLhVG0qGr/JwlXZc4DSn0XQajzUomOB9brj6m
	 UgrCst2nHkoNdmOhbATdqCjhaIKUTJPZ/isy2ymJRAvmujj1jIeXp5y1k4A+z/ikY+
	 ppaFj71DqvYSWPBDpUET/WOi68CjCvtSGOabTH+ivznSH4hNmZt2dM4oNsuip23zVm
	 eSs6KJT1cv9JHcRZ3o07pJDk0sSkGA6r8r46MNZcYQBexvsUuBgio1Q5DCifTBc1e3
	 zUJn9sSjHQnLZ/wz3tyr04dd0yjom5s+foVfZj8FZ9XFmyMw9qrBEVMsr5XW4Db6RR
	 DV4CjQn8QyV5g==
From: Danilo Krummrich <dakr@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: lyude@redhat.com,
	dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/acr: fix missing nvkm_done() in error path of nvkm_acr_oneinit()
Date: Sun, 21 Jun 2026 15:13:10 +0200
Message-ID: <20260621131310.5004-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606155606.77593-1-vulab@iscas.ac.cn>
References: <20260606155606.77593-1-vulab@iscas.ac.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:lyude@redhat.com,m:dakr@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:nouveau@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267540-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gitlab.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DFED6AADD0

On Sat,  6 Jun 2026 15:56:06 +0000, Wentao Liang wrote:
> [PATCH] drm/nouveau/acr: fix missing nvkm_done() in error path of nvkm_acr_oneinit()

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] drm/nouveau/acr: fix missing nvkm_done() in error path of nvkm_acr_oneinit()
      commit: c3027973f692

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.

