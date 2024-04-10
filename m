Return-Path: <stable+bounces-37962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC189F1B6
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 14:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED800283145
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22350155395;
	Wed, 10 Apr 2024 12:09:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F315B0EC
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750974; cv=none; b=n18sz2z8fF73Rm3sZP4JQlq1GqaTYG4/8bSigZCiQ3ekq+kuHkqAMoycUxH3iTtAUfd352pjFswXMZh/qyrF/3vHM6BZltkFvgsFO5pNgZlfJysMnZL+6qV7lDtprASI7AxIToMjRSbimtzJbzYPxOcTgkFS9w+4Fjp1yqEupnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750974; c=relaxed/simple;
	bh=tCvoF8I8qj7yKu7BTlDzzKJj23DloLcfEv/AlDMUkOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/KoVGUZhz93l5cbyEvcyhDlr3RwxaSJGcW/6OZCHvTz+ZfVUmAZyNQdyNg2WiunQRvCjtPyEzB85RDD6r6Fy8yx+rmtO17F/1aCv+gIcpOXT3R+Q5ZsPx/apv1EBUao23bVSOnC7Jb4PIJdM+novncBPGr9K+/01ieS9XHjygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB142350C3;
	Wed, 10 Apr 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CDCA13A94;
	Wed, 10 Apr 2024 12:09:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8IVEHXqBFmY8BQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 12:09:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	jani.nikula@linux.intel.com,
	airlied@redhat.com,
	sean@poorly.run
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Robert Tarasov <tutankhamen@chromium.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] drm/udl: Remove DRM_CONNECTOR_POLL_HPD
Date: Wed, 10 Apr 2024 14:07:50 +0200
Message-ID: <20240410120928.26487-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410120928.26487-1-tzimmermann@suse.de>
References: <20240410120928.26487-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: BB142350C3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

DisplayLink devices do not generate hotplug events. Remove the poll
flag DRM_CONNECTOR_POLL_HPD, as it may not be specified together with
DRM_CONNECTOR_POLL_CONNECT or DRM_CONNECTOR_POLL_DISCONNECT.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: afdfc4c6f55f ("drm/udl: Fixed problem with UDL adpater reconnection")
Cc: Robert Tarasov <tutankhamen@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.15+
---
 drivers/gpu/drm/udl/udl_modeset.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 7702359c90c22..751da3a294c44 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -527,8 +527,7 @@ struct drm_connector *udl_connector_init(struct drm_device *dev)
 
 	drm_connector_helper_add(connector, &udl_connector_helper_funcs);
 
-	connector->polled = DRM_CONNECTOR_POLL_HPD |
-			    DRM_CONNECTOR_POLL_CONNECT |
+	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
 			    DRM_CONNECTOR_POLL_DISCONNECT;
 
 	return connector;
-- 
2.44.0


