Return-Path: <stable+bounces-245603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBoHOq87A2oq2AEAu9opvQ
	(envelope-from <stable+bounces-245603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:39:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE8522BBE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8121231BF643
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4A399888;
	Tue, 12 May 2026 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cfkNOxMF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58C39934E
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593550; cv=none; b=ODreyXPH2TcEELqUaK4nYUw6aFTvH0LMWJDr7AWmFOFcD5wpm4gt9C3e6bqlLz+tUog7bUq4HhAKmLKspMoWforqv/fzK0Wdsapq/gKsDWtC0Ta17xJlTuFfi684mzpGobIXNJFr0qCFB1Bdi15X/dNHk2Ua+h7yZE9j+Y9uE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593550; c=relaxed/simple;
	bh=1JxJPJGvWbM34bP8SYI3KpX2yfs7D5q5bRV9cRZXanc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DnpYG31P8itlO/CSZy+cwwq/Kdkze/x5kiPB3QiasI5ZotL5nTHerO6UNS0yUvmy3SnezwJf/yo/MmuAA5XRvL/mCdZefBaFJ4F5yhve3LAL4H2bqsya/1fsvSieyitzCHTevrkv6tbAsY0wxFKxDnAgUuKHkSyuJf+P57IXEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cfkNOxMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CB7C2BCB0;
	Tue, 12 May 2026 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778593549;
	bh=1JxJPJGvWbM34bP8SYI3KpX2yfs7D5q5bRV9cRZXanc=;
	h=Subject:To:Cc:From:Date:From;
	b=cfkNOxMF6EqMPWL1KFFoIYnwnj/W7oKypA6R1zcVTSBU8vA14KX0D7eoOah7W5BLQ
	 6pdZg1GDN9SAKrjxsgiqcGgnagbiFGcgxuIHCOUY8mL7IcaRyVolgJfGf8nIMJhGBa
	 4jTVCybPIgGxxy+cAETC/ZVlSdvrmLRH1S5uAeKo=
Subject: FAILED: patch "[PATCH] fbcon: Avoid OOB font access if console rotation fails" failed to apply to 5.15-stable tree
To: tzimmermann@suse.de,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:45:42 +0200
Message-ID: <2026051242-filling-volatile-696b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7BCE8522BBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245603-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[suse.de,gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,suse.de:email,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e4ef723d8975a2694cc90733a6b888a5e2841842
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051242-filling-volatile-696b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e4ef723d8975a2694cc90733a6b888a5e2841842 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 7 Apr 2026 11:23:12 +0200
Subject: [PATCH] fbcon: Avoid OOB font access if console rotation fails

Clear the font buffer if the reallocation during console rotation fails
in fbcon_rotate_font(). The putcs implementations for the rotated buffer
will return early in this case. See [1] for an example.

Currently, fbcon_rotate_font() keeps the old buffer, which is too small
for the rotated font. Printing to the rotated console with a high-enough
character code will overflow the font buffer.

v2:
- fix typos in commit message

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org # v2.6.15+
Link: https://elixir.bootlin.com/linux/v6.19/source/drivers/video/fbdev/core/fbcon_ccw.c#L144 # [1]
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 1562a8f20b4f..5348f6c6f57c 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -46,6 +46,10 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		info->fbops->fb_sync(info);
 
 	if (par->fd_size < d_cellsize * len) {
+		kfree(par->fontbuffer);
+		par->fontbuffer = NULL;
+		par->fd_size = 0;
+
 		dst = kmalloc_array(len, d_cellsize, GFP_KERNEL);
 
 		if (dst == NULL) {
@@ -54,7 +58,6 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		}
 
 		par->fd_size = d_cellsize * len;
-		kfree(par->fontbuffer);
 		par->fontbuffer = dst;
 	}
 


