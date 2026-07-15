Return-Path: <stable+bounces-274935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EL0UKr2HV2qAWQAAu9opvQ
	(envelope-from <stable+bounces-274935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 15:14:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F182775E898
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 15:14:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=geanix.com header.s=protonmail3 header.b=WtBkCRrf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274935-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274935-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=geanix.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2893304B9A9
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48558420498;
	Wed, 15 Jul 2026 13:10:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56458420492
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 13:10:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121051; cv=none; b=X6EXREXL8l7CZ3a26kA0v5evu07FZQmeIzaaKi+iJRmhcYY+9dRDKnE3TxZaxFR6zKNJOeA2MJcTdqL6TKaHeVm3mZ4Sm8fGVaZRICXmGIXYldTpKp3II65kRXZvn5HYsP+bE4cZshlm1UfaRG/66nLjvqAoOSnoxKRzk7uGSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121051; c=relaxed/simple;
	bh=WcNy8O4O9bQxkht4n0NcJM/yMIueXNQAgArqQj+MtEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fDxU4j+a7gux7HP9gtr7sz+W1IwGMtBZFLGT+7REFXLLAvhZp+WMkPVvBdtCKF8xUbt40uEq+1ALTRj1BKU38czQ3KKF+WLTtvhgB/am+5qZXGIJCTMq+QhhwQFF07xd4OL5rGEHgWZTHH5ug/f8OIHIT1Ib65/WkZL1NEI1OVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WtBkCRrf; arc=none smtp.client-ip=185.70.43.172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784121045; x=1784380245;
	bh=Sgz64eBHHq6rGPJcYzXSIl/9hS6fZrrjKKEshm3RTKM=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WtBkCRrflJM4Jx4pxo42/3TKgOzPAt0RWQxfWcTvaR55AkpNSH0nbNQi1Oy9yI1rv
	 5wab/prRst/wXdF7Z+y6ewULViP1i1uOiEGBTssSxs7gU+Zt4uyM97hFPQ50v9XSBS
	 XTUIlOdoabcIA73SNfdpg0CZda+hiJjhZ8mX/D/ZLcwOe3KMw53kQngbELy1WfCU/p
	 3rCNPd4yWSNDuaJnzfoD8LV34AQ8fZkBsO8ZWybW9MIX/btx4+6GPR45X/IA/xEMEO
	 to7U3L6oWQazjgqOLhOOCRDJbgUJRtlZs4A4Pp/nkdoDY8+mK0A6kAnQx6dAYH08nj
	 pX0KbTsuxSn0Q==
X-Pm-Submission-Id: 4h0c422Z6Hz1DFF5
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v2 0/3] drm/bridge: ti-sn65dsi83: Various fixes
Date: Wed, 15 Jul 2026 15:10:30 +0200
Message-Id: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NTQ6CMBBGr0JmbU1bBKor72FY0HaEMbGQDhIM4
 e4WjDuXL9/PW4AxEjJcsgUiTsTUhwT6kIHrmtCiIJ8YtNSlrJQUIwkOZeGZTC7uNCML5aVB2bi
 ysjmk4RBxD9LuVn+ZX/aBbtyetkZHPPbxvVsntfV+AvVPMCkhhTcF2iI/aXs21xabQPPR9U+o1
 3X9AB6qclzHAAAA
X-Change-ID: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784121041; l=2057;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=WcNy8O4O9bQxkht4n0NcJM/yMIueXNQAgArqQj+MtEE=;
 b=rIIUHcCBuLRWQQHBYe6XMBSX/TUT1nC0qLrhZu/URcwnXOpT8oTmYfZfURb2iPCEAD78nZk0c
 Y2PK6P4Yj1cC4dbazDMXcuY1L/n7F5HAvMchm6o5OiDldNHa4XBlPpn
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Spamd-Result: default: False [8.34 / 15.00];
	URL_OBFUSCATED_TEXT(9.00)[type=word_dot,url=http://trailing.in,orig=n to dbg for two messages in sn65dsi83_parse_dt];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[geanix.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[geanix.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:andrzej.hajda@intel.com,m:neil.armstrong@linaro.org,m:rfoss@kernel.org,m:Laurent.pinchart@ideasonboard.com,m:jonas@kwiboo.se,m:jernej.skrabec@gmail.com,m:luca.ceresoli@bootlin.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:linusw@kernel.org,m:frieder.schrempf@kontron.de,m:marex@denx.de,m:esben@geanix.com,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,bootlin.com,linux.intel.com,suse.de,ffwll.ch,kontron.de,denx.de];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER(0.00)[esben@geanix.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[geanix.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[esben@geanix.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274935-lists,stable=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F182775E898
X-Rspamd-Action: add header
X-Spam: Yes

This small series adds support for using SN65DSI84 in single-link mode with
output to LVDS channel B, and provides a fix for a PLL locking issue.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v2:
- Fix error handling in sn65dsi83_atomic_enable() to ensure
  drm_brige_exit() is always called on exit.
- Change logging level from warn to dbg for two messages in
  sn65dsi83_parse_dt().
- Removed trailing dot in comment lines.
- Added patch with fix so that DRM bridge critical section is exited on
  error in sn65dsi83_reset_work().
- Added Fixes and Cc: stable tags to the premature PLL patch.
- Re-ordered patch so fixes comes first.
- Link to v1: https://patch.msgid.link/20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Linus Walleij <linusw@kernel.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (3):
      drm/bridge: ti-sn65dsi83: Fix problem with premature PLL locking
      drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()
      drm/bridge: ti-sn65dsi83: Support LVDS Channel B on SN65DSI84

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 68 ++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 28 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3

Best regards,
--  
Esben Haabendal <esben@geanix.com>


