Return-Path: <stable+bounces-273818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ksWMbLsVGpRhQAAu9opvQ
	(envelope-from <stable+bounces-273818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:48:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 539B874BDD5
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:48:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sL49E9W6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273818-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273818-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD6C730333C6
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0E342DFE8;
	Mon, 13 Jul 2026 13:46:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C243078E
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:46:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950398; cv=none; b=XoTsOHQPrILyA9lbm4L2f/zF2TuLzsSSOqxAbSh/Qs9BVar4i0Cca5nz5OeDwTApS4VNs1cx3y1vo/6bj/nmmn2kr59oH5WHgyRmUzvDaddA2jDPmGisVBgjbwRmI1QSpoqoRZdgtzam7VNoeL9l75iVzYaxewORMXSFVVUs8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950398; c=relaxed/simple;
	bh=hbpStMtUaWCRRAmfipr3B+uPCepzzhlJJMZnuPdVDvw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MO69mtEao1rotEdXM7YMohqwxL5wL0FH1YeTW9FewtFROwX70+UgvIcDufiVaGEHkrU8JUDkgr6ZbjclcVMdNTp/vGs/JxFsX1BKMEuhe0fDb1wRS1xtpnLzJ8mbXFZc+8GF8mwtTYMwc4ixekeh2sWKF4RlgKovlH+bpSUwya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sL49E9W6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9931F000E9;
	Mon, 13 Jul 2026 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950397;
	bh=xXddyrhIaAT/peecIg9VkeNHkr4CLjq2ZwM4npKGKIc=;
	h=Subject:To:Cc:From:Date;
	b=sL49E9W6MqtenbK/rPyaXj4ol0be7XMov3LYHq8n84G9su462CNCG6c0vKBikCxTN
	 G7HW6IFp1mshIhV2bPlIOk9hD0W/0hG97ziFBVWRAYy0xnW8gUNIUR/0KPlkVbe4Wq
	 4YbmW7zvmQ+yHRE+gkO+WwV4ijZ649ol34yAo8Rk=
Subject: FAILED: patch "[PATCH] media: nxp: imx8-isi: Fix use-after-free on remove" failed to apply to 6.18-stable tree
To: xiaolei.wang@windriver.com,Frank.Li@nxp.com,hverkuil+cisco@kernel.org,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:41:42 +0200
Message-ID: <2026071341-throttle-refurbish-8c48@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273818-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiaolei.wang@windriver.com,m:Frank.Li@nxp.com,m:hverkuil+cisco@kernel.org,m:laurent.pinchart@ideasonboard.com,m:stable@vger.kernel.org,m:hverkuil@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,cisco];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,gregkh:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,nxp.com:email,ideasonboard.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 539B874BDD5


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b670bf89824ede5d07d20bb9bfbafb754846081d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071341-throttle-refurbish-8c48@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b670bf89824ede5d07d20bb9bfbafb754846081d Mon Sep 17 00:00:00 2001
From: Xiaolei Wang <xiaolei.wang@windriver.com>
Date: Thu, 7 May 2026 12:13:15 +0800
Subject: [PATCH] media: nxp: imx8-isi: Fix use-after-free on remove

KASAN reports a slab-use-after-free in __media_entity_remove_link()
during rmmod of imx8_isi:

  BUG: KASAN: slab-use-after-free in __media_entity_remove_link+0x608/0x650
  Read of size 2 at addr ffff0000d47cb02a by task rmmod/724

  Call trace:
   __media_entity_remove_link+0x608/0x650
   __media_entity_remove_links+0x78/0x144
   __media_device_unregister_entity+0x150/0x280
   media_device_unregister_entity+0x48/0x68
   v4l2_device_unregister_subdev+0x158/0x300
   v4l2_async_unbind_subdev_one+0x22c/0x358
   v4l2_async_nf_unbind_all_subdevs+0xfc/0x1c0
   v4l2_async_nf_unregister+0x5c/0x14c
   mxc_isi_remove+0x124/0x2a0 [imx8_isi]

  Allocated by task 249:
   __kmalloc_noprof+0x27c/0x690
   mxc_isi_crossbar_init+0x22c/0x560 [imx8_isi]

  Freed by task 724:
   kfree+0x1e4/0x5b0
   mxc_isi_crossbar_cleanup+0x34/0x80 [imx8_isi]
   mxc_isi_remove+0x11c/0x2a0 [imx8_isi]

The problem is that mxc_isi_remove() calls mxc_isi_crossbar_cleanup()
before mxc_isi_v4l2_cleanup(). The crossbar cleanup frees the media
entity pads, but the subsequent v4l2 cleanup still tries to remove
media links that reference those pads.

Fix this by calling mxc_isi_v4l2_cleanup() before
mxc_isi_crossbar_cleanup() to ensure all media entities are properly
unregistered while the pads are still valid.

Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20260507041318.491594-2-xiaolei.wang@windriver.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index 4bf8570e1b9e..2d639b789910 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -556,8 +556,8 @@ static void mxc_isi_remove(struct platform_device *pdev)
 		mxc_isi_pipe_cleanup(pipe);
 	}
 
-	mxc_isi_crossbar_cleanup(&isi->crossbar);
 	mxc_isi_v4l2_cleanup(isi);
+	mxc_isi_crossbar_cleanup(&isi->crossbar);
 }
 
 static const struct of_device_id mxc_isi_of_match[] = {


