Return-Path: <stable+bounces-260001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VaAWAiTuH2pEsgAAu9opvQ
	(envelope-from <stable+bounces-260001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:04:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F63635FA5
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:04:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=CSwxv78H;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260001-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260001-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EEAB30D1305
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453336AB44;
	Wed,  3 Jun 2026 09:00:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608DA335BBB
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:00:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477237; cv=none; b=SHfpyjEMiiTzjflUVDvSpyoWkjB/Z6gfnRklkWapSfOlMEd9jelSTg+PiLkQG0qP3ROcpeTvWHjViMqVq5ZDR5brUQ+inc0mFjn67dbBtJ1PHEY8AdNSiF/IAehn8bnQRbs4fFhnw9pvzHvozCxYFmhMl42frAiBVIgzurx06/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477237; c=relaxed/simple;
	bh=I90kIma1baGqh9XocN4JuQiwZ+33rK0xtVuCfEweGOw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oXXWYjOOHfnZmlsyUd9/bQRwf6d9yKYhzpRjFbf0lPrcs3Tf+EwYU2i3A7Yjv2xCEW1U0e1WOICYM75skuiEfIQJS89efSFRyRihCE353ri17eAupeVE5806wO3JFNyujUfv9ers2qE3e5K8dTMbenfuGeZRmnIzmhvOIlYGv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CSwxv78H; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6F850C62216;
	Wed,  3 Jun 2026 09:00:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E2B05FD24;
	Wed,  3 Jun 2026 09:00:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 819EC10888413;
	Wed,  3 Jun 2026 11:00:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780477229; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7Ps8c5Pf/q4KonzIzGtVuavWdKey0/RYtJqxkkHgYGE=;
	b=CSwxv78HfY6ST3O/alIYSifZe4N40KbAE3LXpQ8APQkvfgfR5BVLlrC38t4B4jPnspJhyu
	ZWmjvNYZ0991xzLE6T7ZEH3iRx/7FeW1n0vk5dZ0/SQD8C+bXUF6iVVs10bAPG5vKp92/C
	9YiEhDWbQQm+aKS1vyEiskHx1Of7JEB0F/ge9Qnd3LUZYGHqYi6Dk+uJzdn/2D0torHUP9
	UFUJiEq+CTvXezu+z1HGsRO9jNjLWAUDKrJ+FX0KAAgCgSGy98xMLaZgn2tHwy29iAWm7E
	cTDyMhBvO+8+2ggTqEyDQ9ikNQmvkBAwqiFPbWgBEAF0GBNaTmOFTxFOH7tg2g==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH 0/3] drm/i915: Fix double cleanup in error paths
Date: Wed, 03 Jun 2026 10:59:51 +0200
Message-Id: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAftH2oC/yXM3wpAMBQH4FdZ59pqtiy8iqSZg+NitCGlvbvh8
 uv354aAnjBAzW7weFKg1SXkGQM7GzchpyEZpJBaaKH4SFdHVV7wwqqhtKLSWhpI9c1jyr6rpv0
 djn5Bu797iPEBpzmSw2wAAAA=
X-Change-ID: 20260603-fix_i915-5c3d8c09662a
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@redhat.com>, 
 Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Kory Maincent <kory.maincent@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.0
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,chris-wilson.co.uk,anholt.net,redhat.com,virtuousgeek.org];
	FORGED_RECIPIENTS(0.00)[m:jani.nikula@linux.intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:tursulin@ursulin.net,m:airlied@gmail.com,m:simona@ffwll.ch,m:chris@chris-wilson.co.uk,m:eric@anholt.net,m:airlied@redhat.com,m:jbarnes@virtuousgeek.org,m:thomas.petazzoni@bootlin.com,m:louis.chauvet@bootlin.com,m:markyacoub@google.com,m:seanpaul@google.com,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:simona.vetter@ffwll.ch,m:kory.maincent@bootlin.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kory.maincent@bootlin.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260001-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:from_mime,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58F63635FA5

Several error paths in the i915 driver incorrectly invoke cleanup
functions multiple times, potentially causing double-free errors.
This series corrects these paths to ensure cleanup is performed
only once.

Testing note: Only the DisplayPort fix has been hardware tested due
to lack of available hardware for the other components.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (3):
      drm/i915/display/intel_sdvo: Fix double connector destroy in error paths
      drm/i915/display/intel_lvds: Drop redundant manual cleanup on init failure
      drm/i915/display/intel_dp: Drop redundant intel_dp_aux_fini() on init failure

 drivers/gpu/drm/i915/display/intel_dp.c   |  4 +---
 drivers/gpu/drm/i915/display/intel_lvds.c | 14 ++++----------
 drivers/gpu/drm/i915/display/intel_sdvo.c | 16 ++++------------
 3 files changed, 9 insertions(+), 25 deletions(-)
---
base-commit: e1696f1fc99dc0ff761a012230587b23dec064fb
change-id: 20260603-fix_i915-5c3d8c09662a

Best regards,
--  
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


