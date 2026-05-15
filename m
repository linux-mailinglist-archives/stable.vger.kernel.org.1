Return-Path: <stable+bounces-248808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AHZJtNUB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:16:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C39D554B36
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F4983169E86
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF4C3D6CB9;
	Fri, 15 May 2026 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbL3XjRq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514493EFFB8;
	Fri, 15 May 2026 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862684; cv=none; b=e9eS4YdY2LdiFSToqBs/Oai2vLp1Iw+RBVTCG8IsWW6dIdBFwERjHOdP4zYkVye/HmIahBU1cx5xFhQmR6Zly85sPzeo6CFu18tDnq8KYud/46viz66yI+jhR26EG/8P2d8cYrovWtRV5CmNznc/YT+ERuJ1PCVhhkkhKR0fF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862684; c=relaxed/simple;
	bh=bZGZfngjR124pi1T4mYk8JWXN7131gKCCxxg2j8OdSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOd0KDuxB+CcVtt6K3cIhsz363VVC1GQRywCI5fEKi1N9ONmxPJjnsovpswE0/wyzC4UgW5baoARwRsmfohh5IMOrHcQjOfQCit/QrdcRlNfsFaJ81qUgrJZYUdT6kvpjkt1o4H3SMGRim3kA0182X8X+ruVhsXGj15FkwuzX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbL3XjRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1A0C2BCB0;
	Fri, 15 May 2026 16:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862684;
	bh=bZGZfngjR124pi1T4mYk8JWXN7131gKCCxxg2j8OdSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wbL3XjRqE0npDpWJR74vXRp34zB+g77dIk7CvfkaOGR/x0i0Xb2gzX6lzRb3XKtri
	 4roZLvbIhAgmODa2SkXv8nSwGHwHVD9y+Kd3B26pU5FmlJqabTlg2LcrYENepAq0Rw
	 MNG9/fVEmjFtetCDD7HXembFhZ19fxzneDHnNYso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH 7.0 144/201] drm/gem: Fix inconsistent plane dimension calculation in drm_gem_fb_init_with_funcs()
Date: Fri, 15 May 2026 17:49:22 +0200
Message-ID: <20260515154701.687059466@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6C39D554B36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248808-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.de,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ashutosh Desai <ashutoshdesai993@gmail.com>

commit 3d4c2268bd7243c3780fe32bf24ff876da272acf upstream.

drm_gem_fb_init_with_funcs() computes sub-sampled plane dimensions
using plain integer division:

  unsigned int width  = mode_cmd->width  / (i ? info->hsub : 1);
  unsigned int height = mode_cmd->height / (i ? info->vsub : 1);

However, the ioctl-level framebuffer_check() in drm_framebuffer.c uses
drm_format_info_plane_width/height() which round up dimensions via
DIV_ROUND_UP(). This inconsistency corrupts the subsequent GEM object
size check for certain pixel format and dimension combinations.

For example, with NV12 (vsub=2) and a 1-pixel-tall framebuffer the
GEM size validation path sees height=0 instead of height=1. The
expression (height - 1) then wraps to UINT_MAX as an unsigned int,
causing min_size to overflow and wrap back to a small value. A tiny
GEM object therefore passes the size guard, yet when the GPU accesses
the chroma plane it will read or write memory beyond the object's
bounds.

Fix by replacing the open-coded divisions with drm_format_info_plane_width()
and drm_format_info_plane_height(), which use DIV_ROUND_UP() and match
the calculation already used in framebuffer_check().

Fixes: 4c3dbb2c312c ("drm: Add GEM backed framebuffer library")
Cc: stable@vger.kernel.org # v4.14+
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patch.msgid.link/20260420013637.457751-1-ashutoshdesai993@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_gem_framebuffer_helper.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -172,8 +172,8 @@ int drm_gem_fb_init_with_funcs(struct dr
 	}
 
 	for (i = 0; i < info->num_planes; i++) {
-		unsigned int width = mode_cmd->width / (i ? info->hsub : 1);
-		unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
+		unsigned int width = drm_format_info_plane_width(info, mode_cmd->width, i);
+		unsigned int height = drm_format_info_plane_height(info, mode_cmd->height, i);
 		unsigned int min_size;
 
 		objs[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);



