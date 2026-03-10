Return-Path: <stable+bounces-223960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEfYBDf9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0AB24A399
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 537CC3186C07
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F8C313537;
	Tue, 10 Mar 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtQ4Kx0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CEF352C4F;
	Tue, 10 Mar 2026 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141095; cv=none; b=XUjUUZMHzsotCBLfd0PHSoUg7eZglbiT7nEZdpM1yia6d7e3vqoX8lobu5wfIZQaKoT+ZJHqax8q54/bkV0AEJASNIe+JYGGMiw1m0FXoo1FqiB2XUa5DP+CUE8A9UmDtN/t4ok+DAuqCQumpdajNDe0hLhs0jLhHSWzcRul2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141095; c=relaxed/simple;
	bh=fQca0xB1uESPYq0X1asaQ/hsUhw/9uOf7yUREpM9Ex0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ow5vKhPnsuGJpHNr/6Cz6Yrgc5GtO1He8aV4i5eOv9HCMsylBy+i49Z4OU101VcSlHlgVG0cP+bw6qi5SLlm0JisvrT3I/a3Ax8SVwEfYpgqPPUsRq/RPFT4jgTv+LyFsBuFlslmeVIj5Tyrr2H/ZcSFE6eFyth8RaS/d4vBJiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtQ4Kx0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F5FC2BC9E;
	Tue, 10 Mar 2026 11:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141094;
	bh=fQca0xB1uESPYq0X1asaQ/hsUhw/9uOf7yUREpM9Ex0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtQ4Kx0bJNZoIEyTQ2XDvRSmHoZAIYCpiPIr96TZ6xglRxJZmGf/9endXRMovZJRl
	 V3C+ttjh80H1100bHP4UxpOK/7fR8LlJSeUDt8Fcf9MAiV1iMxjkC1g9sIuuMIva42
	 9gIuLnZXJ3AS5ipNXkZixrgrSaVs3QvK+1nacwiztEXbUg8TthQKhpjLtiIyIXbfuz
	 DBHg9lx+pOsCNUpiiGEdJLHuXkLqWc3GaLR/r7xhxI2hdOeqDqmmN+ATg+g7ynFRox
	 dAr6qHTb7FlunkOfo381xANP37lo/AeHBreBKKwJwgq2ZqTLkQ0LllylPaGi0uyfiI
	 NpjTpQALchJAA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 095/311] usb: gadget: u_ether: Add auto-cleanup helper for freeing net_device
Date: Tue, 10 Mar 2026 07:02:22 -0400
Message-ID: <2862c8044134d685ad26da601be136d2570daa17.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C0AB24A399
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223960-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Action: no action

From: Kuen-Han Tsai <khtsai@google.com>

[ Upstream commit 0c0981126b99288ed354d3d414c8a5fd42ac9e25 ]

The net_device in the u_ether framework currently requires explicit
calls to unregister and free the device.

Introduce gether_unregister_free_netdev() and the corresponding
auto-cleanup macro. This ensures that if a net_device is registered, it
is properly unregistered and the associated work queue is flushed before
the memory is freed.

This is a preparatory patch to simplify error handling paths in gadget
drivers by removing the need for explicit goto labels for net_device
cleanup.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20251230-ncm-refactor-v1-2-793e347bc7a7@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 56a512a9b410 ("usb: gadget: f_ncm: align net_device lifecycle with bind/unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/u_ether.c | 15 +++++++++++++++
 drivers/usb/gadget/function/u_ether.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 745ed2c212e3a..6c32665538cc0 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1125,6 +1125,21 @@ void gether_cleanup(struct eth_dev *dev)
 }
 EXPORT_SYMBOL_GPL(gether_cleanup);
 
+void gether_unregister_free_netdev(struct net_device *net)
+{
+	if (!net)
+		return;
+
+	struct eth_dev *dev = netdev_priv(net);
+
+	if (net->reg_state == NETREG_REGISTERED) {
+		unregister_netdev(net);
+		flush_work(&dev->work);
+	}
+	free_netdev(net);
+}
+EXPORT_SYMBOL_GPL(gether_unregister_free_netdev);
+
 /**
  * gether_connect - notify network layer that USB link is active
  * @link: the USB link, set up with endpoints, descriptors matching
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index 63a0240df4d74..a212a8ec5eb1b 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -283,6 +283,8 @@ int gether_get_ifname(struct net_device *net, char *name, int len);
 int gether_set_ifname(struct net_device *net, const char *name, int len);
 
 void gether_cleanup(struct eth_dev *dev);
+void gether_unregister_free_netdev(struct net_device *net);
+DEFINE_FREE(free_gether_netdev, struct net_device *, gether_unregister_free_netdev(_T));
 
 void gether_setup_opts_default(struct gether_opts *opts, const char *name);
 void gether_apply_opts(struct net_device *net, struct gether_opts *opts);
-- 
2.51.0


