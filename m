Return-Path: <stable+bounces-271085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9mtlLp+XRmryZQsAu9opvQ
	(envelope-from <stable+bounces-271085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:53:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7DC6FAB6C
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:53:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=eGUYsDd+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271085-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271085-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E3C7305B011
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2158D3A5430;
	Thu,  2 Jul 2026 16:43:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB75434107D;
	Thu,  2 Jul 2026 16:43:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010630; cv=none; b=FNuNn6hyCW4YiZGj58aWY8X9McHVYmhuz0eeeyfPeUxKOQl3gYO0t4pPHRhoMH4ayOJbzQQaW6p4cT6nN5Gn2NZ47jPv3R01ZPQDyNIbpAj9payfdZbMzeWoPDKlVFaTox7OmNmn95oyxmt74Gb1nn7ZucTcyHmgZSixg7yM25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010630; c=relaxed/simple;
	bh=fwprHNEhCWjOl+whDHL2/wNidYAVJeBBVj9DTvKUdVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5OQiwlV+yKa1Iy45aIcNHyZej2xpdBU+StZZBXaL4558lMxvXM0t/S9DVWoWVZE55ercQydXv+xPz/A4iWnMBHWxzp6fVl6+8fGloEHjVW6NqX/UKsc2rMf+n1CFCDthvjIeeOtHBbhBqmy73+r24G0SKKsO9NmL2PVkQorwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eGUYsDd+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4BF1F000E9;
	Thu,  2 Jul 2026 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010629;
	bh=/07RTFSguWiRhQdiUDHEBsVlbH26Iad7eYIM7O+HLoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eGUYsDd+rocQb4iie+pPix6I3Zv3t/AVIxiujSF8WeM6uVlEojC7XbHu20r1BTK07
	 39ZeJec4K2Sric9dSaMvbpWbR+BQwDYHGqqbVWby7eVbs7Gg2YmkAeOigrI0RpnzqS
	 cfXzFhBXcxSPupU7RXhCT8LSyIWQbNfoh3APc/QI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tuo Li <islituo@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.12 182/204] fbdev: modedb: fix a possible UAF in fb_find_mode()
Date: Thu,  2 Jul 2026 18:20:39 +0200
Message-ID: <20260702155122.471742354@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271085-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:islituo@gmail.com,m:deller@gmx.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,gmx.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F7DC6FAB6C

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tuo Li <islituo@gmail.com>

commit 85b6256469cebdac395e7447147e06b2e151014f upstream.

If mode_option is NULL, it is assigned from mode_option_buf:

  if (!mode_option) {
    fb_get_options(NULL, &mode_option_buf);
    mode_option = mode_option_buf;
  }

Later, name is assigned from mode_option:

  const char *name = mode_option;

However, mode_option_buf is freed before name is no longer used:

  kfree(mode_option_buf);

while name is still accessed by:

  if ((name_matches(db[i], name, namelen) ||

Since name aliases mode_option_buf, this may result in a
use-after-free.

Fix this by extending the lifetime of mode_option_buf until the end of the
function by using scope-based resource management for cleanup.

Signed-off-by: Tuo Li <islituo@gmail.com>
Cc: stable@vger.kernel.org # v6.5+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/modedb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -625,7 +625,7 @@ int fb_find_mode(struct fb_var_screeninf
 		 const struct fb_videomode *default_mode,
 		 unsigned int default_bpp)
 {
-	char *mode_option_buf = NULL;
+	char *mode_option_buf __free(kfree) = NULL;
 	int i;
 
 	/* Set up defaults */
@@ -723,7 +723,6 @@ int fb_find_mode(struct fb_var_screeninf
 			res_specified = 1;
 		}
 done:
-		kfree(mode_option_buf);
 		if (cvt) {
 			struct fb_videomode cvt_mode;
 			int ret;



