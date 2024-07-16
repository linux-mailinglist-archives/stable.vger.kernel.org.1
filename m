Return-Path: <stable+bounces-60174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C84932DB6
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A101F21CF7
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D84D19B3EE;
	Tue, 16 Jul 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZKBPPRbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BA17CA0E;
	Tue, 16 Jul 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146104; cv=none; b=mhvZ0XzD93A9kwNK+siIcNZgbKrBCV7Q4ABtqE5gDHAcXTCB7ouLUmDqteh+UXmIZ1L6VizbQJy1cJwvEf55XeXVL0bSbxXl8pUsbVHnaKlk3M8+XC3YmBPyCWqpteJgr+u4HdZxDf5tuvh5plpD5WBf+++DrG3td5PKfydGvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146104; c=relaxed/simple;
	bh=Y18D0jcdh1B1n8qWaD7D6QQ4JJ8PkV0QUwy/a2UX8Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BG2794b8175OwEd8cIoFkq12p8Tk3KE8sBtwrYgG4Echqgu5LWKwcPBWyudXBghE+qtDjlsaB5lPvwAzsKRWpb9nSSNMZc68mqTeHdJEVYjQT5yhILEOgd56MLyUqinMv6m68wOkop7ump+FzcwTTsadP9GDc2pIPLZ5ukH1Bhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZKBPPRbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2E7C116B1;
	Tue, 16 Jul 2024 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721146104;
	bh=Y18D0jcdh1B1n8qWaD7D6QQ4JJ8PkV0QUwy/a2UX8Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKBPPRbYNrhIABNcgCcOEznF53u510xksFu1KW6G8vAzcgSmIdMsYWv1EreNXtH2+
	 mYlNCcwoLpmwP/DsbAi3HG/OpgypGRHNla1X92qqGMminY85SY1vpaXtCWF036YHI+
	 piU6I9CIF/zVcsII0qGhzvIk/GtwB1gMjw99WNJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Lyude Paul <lyude@redhat.com>
Subject: [PATCH 5.15 056/144] drm/nouveau: fix null pointer dereference in nouveau_connector_get_modes
Date: Tue, 16 Jul 2024 17:32:05 +0200
Message-ID: <20240716152754.701268846@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
References: <20240716152752.524497140@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 80bec6825b19d95ccdfd3393cf8ec15ff2a749b4 upstream.

In nouveau_connector_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode, which will lead to a possible NULL pointer
dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.

Cc: stable@vger.kernel.org
Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240627074204.3023776-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -979,6 +979,9 @@ nouveau_connector_get_modes(struct drm_c
 		struct drm_display_mode *mode;
 
 		mode = drm_mode_duplicate(dev, nv_connector->native_mode);
+		if (!mode)
+			return 0;
+
 		drm_mode_probed_add(connector, mode);
 		ret = 1;
 	}



