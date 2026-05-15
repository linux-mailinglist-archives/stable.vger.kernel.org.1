Return-Path: <stable+bounces-247584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KNpFlDiBmrVogIAu9opvQ
	(envelope-from <stable+bounces-247584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:07:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A714654C04F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4EF83128D6E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03210407562;
	Fri, 15 May 2026 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JcT4UhYi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C540629A
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834324; cv=none; b=ZT0bWbTcZKB8RRmJ1GwrQpdwyRNSOHd40HBNarzdZPaQrpCu61xy+HzWdwsOzziG7Ea6ZKzMGxNIm8L8aQa2gNKKRnXMQBQLkGHiS+rSfszpO71j1dTcIgtnrLP7wcDKnHWVLW2sagto/3jKZJjjVw+/31/4dK4W1UQXWyePA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834324; c=relaxed/simple;
	bh=PBHqWakhd/CftYr/5H3pegdK5/sjMf+SC0wM7gx2Nz4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=az44kdyyQfxusuOIppM2g0bOczG9lVy8Z+BmzmZsWKGO/d5RCErnoNDNCr6uFaFuW6G55XDTP6hAZtPYu/cPueBwdVKJSWu8cUEKAfM1Iu5XbdrHeZgZLWejMoUbQUkLwoMLu1nrPP8aObWMND1BPLqGnL4eRCJp1vNPEvpi0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JcT4UhYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91E8C2BCB8;
	Fri, 15 May 2026 08:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834324;
	bh=PBHqWakhd/CftYr/5H3pegdK5/sjMf+SC0wM7gx2Nz4=;
	h=Subject:To:Cc:From:Date:From;
	b=JcT4UhYixLWrIDNxCnVd44V77vNYZBSzfw6Cdh4NsyHbAkD9YH8TvOwXOZ8ksV+jp
	 3wLiGWDGkrPERHdvv35sjwE2QL/NfBUqIE7379yCDVpVOP1rDp8D89mggfZDUGxdgC
	 my4XvGk11erAVjmNh+hY+nGB9ukhelj7npebkw5E=
Subject: FAILED: patch "[PATCH] drm/udl: Increase GET_URB_TIMEOUT" failed to apply to 6.1-stable tree
To: oushixiong@kylinos.cn,stable@vger.kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:38:32 +0200
Message-ID: <2026051532-turtle-murmuring-1de6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A714654C04F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247584-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ac2c996675755c725a0065dbe3e2ebffded9080b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051532-turtle-murmuring-1de6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ac2c996675755c725a0065dbe3e2ebffded9080b Mon Sep 17 00:00:00 2001
From: Shixiong Ou <oushixiong@kylinos.cn>
Date: Fri, 24 Apr 2026 20:44:27 +0800
Subject: [PATCH] drm/udl: Increase GET_URB_TIMEOUT

[WHY]
A situation has occurred where udl_handle_damage() executed successfully
and the kernel log appears normal, but the display fails to show any output.
This is because the call to udl_get_urb() in udl_crtc_helper_atomic_enable()
failed without generating any error message.

[HOW]
1. Increase timeout of getting urb.
2. Add error messages when calling udl_get_urb() failed in
udl_crtc_helper_atomic_enable().

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v3.4+
Link: https://patch.msgid.link/20260424124427.657-1-oushixiong1025@163.com

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 08a0e9480d70..17950fe3a0ec 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -285,13 +285,12 @@ static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
 	return unode->urb;
 }
 
-#define GET_URB_TIMEOUT	HZ
 struct urb *udl_get_urb(struct udl_device *udl)
 {
 	struct urb *urb;
 
 	spin_lock_irq(&udl->urbs.lock);
-	urb = udl_get_urb_locked(udl, GET_URB_TIMEOUT);
+	urb = udl_get_urb_locked(udl, HZ * 2);
 	spin_unlock_irq(&udl->urbs.lock);
 	return urb;
 }
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 231e829bd709..1ca073a4ecb2 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -21,6 +21,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
@@ -342,8 +343,10 @@ static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atom
 		return;
 
 	urb = udl_get_urb(udl);
-	if (!urb)
+	if (!urb) {
+		drm_err_ratelimited(dev, "get urb failed when enabling crtc\n");
 		goto out;
+	}
 
 	buf = (char *)urb->transfer_buffer;
 	buf = udl_vidreg_lock(buf);


