Return-Path: <stable+bounces-234186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH8sG06c1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:19:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4573C0704
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7697305930D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0F7385513;
	Wed,  8 Apr 2026 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UIEQ4nOe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46EB67E;
	Wed,  8 Apr 2026 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672206; cv=none; b=gsKn/YJxv+KwLJvj3NvYFYVzZmNUX9yd6KwKi9An+YWhg89CljrI+LXfuJoUlO4XTNwKL5b536l1vbS16ZSKsvuDTsXyq1L8sS0aRT1kIS1/gFMY5expaLVD2LVDS4MnOhHHjJngWfh0f2/cW/8RfumDWg85hwCbzJ25K8DdbQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672206; c=relaxed/simple;
	bh=tyuTz1tQ7hy3JxhMcekNghInZSShjyRr1qUJpWlwtLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq2sD8gI/os+R3zSbm6JR3QeFNamZhYUlSyuTVOKFIMGuvdLz4hqPs7+09An/9GFAxzDZNHZ7QHovnOmTU3TpQzcz7Cf/7xEveM4EBRfW1d6tvIjvXkns6jz40fsWvE9fXDTrIcA72zRoioI1Zk39GlkaWypxKAnYZNuqjbo8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UIEQ4nOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66D0C19421;
	Wed,  8 Apr 2026 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672206;
	bh=tyuTz1tQ7hy3JxhMcekNghInZSShjyRr1qUJpWlwtLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIEQ4nOewZ8M7bI1pdr4fvQJ8o/r+ZDjxAy3V9XYZlB8U2Pp1EHG6aAykHSR/J030
	 nXp1yeR7S1jFk+2qi7wGUPyUqkzrlpBD3mrJT7yzbh4nhYaO3imwindHkKIDX/035E
	 U4Rbt2W159LdQaPgsKVOUuMI8ilGe9OgSnp5ki3c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	stable <stable@kernel.org>
Subject: [PATCH 6.1 198/312] drm/ioc32: stop speculation on the drm_compat_ioctl path
Date: Wed,  8 Apr 2026 20:01:55 +0200
Message-ID: <20260408175941.153948085@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-234186-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,ffwll.ch:email]
X-Rspamd-Queue-Id: 8C4573C0704
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit f8995c2df519f382525ca4bc90553ad2ec611067 upstream.

The drm compat ioctl path takes a user controlled pointer, and then
dereferences it into a table of function pointers, the signature method
of spectre problems.  Fix this up by calling array_index_nospec() on the
index to the function pointer list.

Fixes: 505b5240329b ("drm/ioctl: Fix Spectre v1 vulnerabilities")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Simona Vetter <simona@ffwll.ch>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patch.msgid.link/2026032451-playing-rummage-8fa2@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_ioc32.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/drm_ioc32.c
+++ b/drivers/gpu/drm/drm_ioc32.c
@@ -28,6 +28,7 @@
  * IN THE SOFTWARE.
  */
 #include <linux/compat.h>
+#include <linux/nospec.h>
 #include <linux/ratelimit.h>
 #include <linux/export.h>
 
@@ -982,6 +983,7 @@ long drm_compat_ioctl(struct file *filp,
 	if (nr >= ARRAY_SIZE(drm_compat_ioctls))
 		return drm_ioctl(filp, cmd, arg);
 
+	nr = array_index_nospec(nr, ARRAY_SIZE(drm_compat_ioctls));
 	fn = drm_compat_ioctls[nr].fn;
 	if (!fn)
 		return drm_ioctl(filp, cmd, arg);



