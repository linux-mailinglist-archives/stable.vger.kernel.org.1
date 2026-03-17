Return-Path: <stable+bounces-226673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNMFNNqNuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:22:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5702AF729
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 433B53049720
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2C3346A0;
	Tue, 17 Mar 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l4sL9qs2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496321A9B58;
	Tue, 17 Mar 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767759; cv=none; b=Kp2U/f5HGzOx7ylKKoSNqHhug/gjhx5mg1h+/k9sWzuLPXA+i7HRcA1vtSo5vh4iL462ds7uGw/E9TMYjpd4fR8jrlDeS8PcbSGfEygEJdxGMOvctrrDmz+lhomMfAvPSzjCS3CmRVRQha/xKskghnSj61km0imKosrXpanFPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767759; c=relaxed/simple;
	bh=kLtS3YPVj6d3wF3ExoUR/beLdsBbPcNmANk1NowF3Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoZ0QELucIVuUzp/YpYQUfLjvd+LH4haoCv9Bi0blfeszdtl19j/JabDwQlUxgOUs2jBW0IIS6ruR+643syLIgN7PDdPyirg/KSFGZ54ZH/IYO25QUDqHQOotvwePI9wKdrerZVjeywuP6edXsj/PBHrIVjcIwCYTJ15ttR9XfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l4sL9qs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B21C4CEF7;
	Tue, 17 Mar 2026 17:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767759;
	bh=kLtS3YPVj6d3wF3ExoUR/beLdsBbPcNmANk1NowF3Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4sL9qs2BGa8DjUsjKSnJ19PeghWVccA7+agMcoyaiiOnn7zPqB0NWK6jcbqm+kdL
	 LBH/0sjTtDv5e9KpW5fkmWvHwV8VwtTBxk9LOB1szIDLQGkIDipAIZlyuBcbkb6irs
	 SQHflZhbBzKDn9mQjBblws07P3S/3tHeVz+JJ+q8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Heidelberg <david@ixit.cz>,
	stable <stable@kernel.org>,
	Kuen-Han Tsai <khtsai@google.com>
Subject: [PATCH 6.18 152/333] Revert "usb: gadget: u_ether: Add auto-cleanup helper for freeing net_device"
Date: Tue, 17 Mar 2026 17:33:01 +0100
Message-ID: <20260317163004.994719630@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226673-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,ixit.cz:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF5702AF729
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuen-Han Tsai <khtsai@google.com>

commit 46662d3a1ad40282ba9f753cccc6f909ec4468cc upstream.

This reverts commit 0c0981126b99288ed354d3d414c8a5fd42ac9e25.

This commit is being reverted as part of a series-wide revert.

By deferring the net_device allocation to the bind() phase, a single
function instance will spawn multiple network devices if it is symlinked
to multiple USB configurations.

This causes regressions for userspace tools (like the postmarketOS DHCP
daemon) that rely on reading the interface name (e.g., "usb0") from
configfs. Currently, configfs returns the template "usb%d", causing the
userspace network setup to fail.

Crucially, because this patch breaks the 1:1 mapping between the
function instance and the network device, this naming issue cannot
simply be patched. Configfs only exposes a single 'ifname' attribute per
instance, making it impossible to accurately report the actual interface
name when multiple underlying network devices can exist for that single
instance.

All configurations tied to the same function instance are meant to share
a single network device. Revert this change to restore the 1:1 mapping
by allocating the network device at the instance level (alloc_inst).

Reported-by: David Heidelberg <david@ixit.cz>
Closes: https://lore.kernel.org/linux-usb/70b558ea-a12e-4170-9b8e-c951131249af@ixit.cz/
Fixes: 56a512a9b410 ("usb: gadget: f_ncm: align net_device lifecycle with bind/unbind")
Cc: stable <stable@kernel.org>
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20260309-f-ncm-revert-v2-4-ea2afbc7d9b2@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/u_ether.c |   15 ---------------
 drivers/usb/gadget/function/u_ether.h |    2 --
 2 files changed, 17 deletions(-)

--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1125,21 +1125,6 @@ void gether_cleanup(struct eth_dev *dev)
 }
 EXPORT_SYMBOL_GPL(gether_cleanup);
 
-void gether_unregister_free_netdev(struct net_device *net)
-{
-	if (!net)
-		return;
-
-	struct eth_dev *dev = netdev_priv(net);
-
-	if (net->reg_state == NETREG_REGISTERED) {
-		unregister_netdev(net);
-		flush_work(&dev->work);
-	}
-	free_netdev(net);
-}
-EXPORT_SYMBOL_GPL(gether_unregister_free_netdev);
-
 /**
  * gether_connect - notify network layer that USB link is active
  * @link: the USB link, set up with endpoints, descriptors matching
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -283,8 +283,6 @@ int gether_get_ifname(struct net_device
 int gether_set_ifname(struct net_device *net, const char *name, int len);
 
 void gether_cleanup(struct eth_dev *dev);
-void gether_unregister_free_netdev(struct net_device *net);
-DEFINE_FREE(free_gether_netdev, struct net_device *, gether_unregister_free_netdev(_T));
 
 void gether_setup_opts_default(struct gether_opts *opts, const char *name);
 void gether_apply_opts(struct net_device *net, struct gether_opts *opts);



