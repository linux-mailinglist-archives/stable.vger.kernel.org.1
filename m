Return-Path: <stable+bounces-236991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LuiBc8i3WkYaQkAu9opvQ
	(envelope-from <stable+bounces-236991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:07:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 525223F0C90
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72A5B31D3890
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADC830DD3C;
	Mon, 13 Apr 2026 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DbzqdpeL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306B30DEB5;
	Mon, 13 Apr 2026 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098311; cv=none; b=S16M4lf34tfUc1e6SNADq3/ArBqL4viFmQ41MaLPRNwiMh0BrcRBeXJ8YLPis89/gkLIgkV0i9+T336nEd6de/0ECb0APCRapzLvHO6hARAK4c6dox/tSbG87Z0EWIBi6WAOuv4C7n4RnrSPL3yrBChdfm1u35XB51bcpLp8sEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098311; c=relaxed/simple;
	bh=4NZ9K7BeQhUTNEoiCj8nojtg7gsHLBbS/Q0+NiujwQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOuQWroZrNEAB78S0TTRTW+yJy259oMIz8kD/t63iYoazKG/Dwh7fFKxF3oXZFc+m+efhUS+jPGL0HADiNszeXQNAc1faRoMDz8ZEoKtXADJBq0ffHmy6EE3go+wy4Kb5AQAPmrYxAU5aiQHbkKiAfKZfHt7+VxBg6dSLACkC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DbzqdpeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA02C2BCAF;
	Mon, 13 Apr 2026 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098310;
	bh=4NZ9K7BeQhUTNEoiCj8nojtg7gsHLBbS/Q0+NiujwQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbzqdpeLlB4VoowRd1DFR0OPOb9iSmeC2WmwWAOm7URGJFFFiNZHYqQ+4sYwMgMuq
	 Y74dH1k8WQDnmv2OUrNbMaf0k+sRJnmZrIYQ8OYAd4AxxIxBf2UF6HYAsjlu8gH5qR
	 kZbhiyum7Wl1z4lIgLZ9O3LGc6gFbmS0xWBpAQA8=
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
Subject: [PATCH 5.15 443/570] drm/ioc32: stop speculation on the drm_compat_ioctl path
Date: Mon, 13 Apr 2026 17:59:34 +0200
Message-ID: <20260413155847.066119422@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236991-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ffwll.ch:email]
X-Rspamd-Queue-Id: 525223F0C90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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



