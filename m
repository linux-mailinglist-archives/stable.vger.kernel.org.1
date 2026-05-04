Return-Path: <stable+bounces-243178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMWtJDqo+GlexgIAu9opvQ
	(envelope-from <stable+bounces-243178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:07:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F4E4BE922
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA6DC30970FC
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3CF3DDDDA;
	Mon,  4 May 2026 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIPaQpiU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A93D0917;
	Mon,  4 May 2026 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903216; cv=none; b=EldvEeZ5P2ApArbXdGKr4nAMi+arn8syZOmNm0iRD+cqPjnplZQ+d4mho3Kt10oSvuK831TLg1mnQScDOHAqYvphtB1cDZGS8SAVas7c7Ndx0SWZZvpt+KIsxCgP3ro/MR+zDpvQYbP8D6msCtOkIajbAMqhhbO0BCmkiBWxBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903216; c=relaxed/simple;
	bh=qqzgYwrCq2l/MQIA6oMpEYxp3X8zQVFScssmLlwL4+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViWL26LKW3/xyCGlZKtiiLIPRjDFsSQ24wNDl2M9bbElW1HuUWZclB6v6dOUCpill/fBgRp6JaXlYqusIPO7+Bfo/57okHchQ/l4CIC+RvLu7IGc0ua0p4FdXzaZUeEeJJyZcdhnluRqOib9m8p9iWwXqKto9UIfyYGhWEiVzcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIPaQpiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026C5C2BCB8;
	Mon,  4 May 2026 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903216;
	bh=qqzgYwrCq2l/MQIA6oMpEYxp3X8zQVFScssmLlwL4+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIPaQpiUnlCAxkMHszf3tBZuBJd7MlWnuYPKE7F1AAU2ZSnhNzEgC+hj38ulEXSlA
	 tHez31uDUevko3Bl4bTXomWGqI+vp80u7yQZyfK8cczmQmmVmwSS6rCGmZ4ghiv3p8
	 UhMkFIosXiHSWGeAflZHC97qruKB/M1CFsLsPjPY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 7.0 149/307] drm/arcpgu: fix device node leak
Date: Mon,  4 May 2026 15:50:34 +0200
Message-ID: <20260504135148.390609089@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B9F4E4BE922
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243178-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

commit ad3ac32a3893a2bbcad545efc005a8e4e7ecf10c upstream.

This function gets a device_node reference via
of_graph_get_remote_port_parent() and stores it in encoder_node, but never
puts that reference. Add it.

There used to be a of_node_put(encoder_node) but it has been removed by
mistake during a rework in commit 3ea66a794fdc ("drm/arc: Inline
arcpgu_drm_hdmi_init").

Fixes: 3ea66a794fdc ("drm/arc: Inline arcpgu_drm_hdmi_init")
Cc: stable@vger.kernel.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://patch.msgid.link/20260402-drm-arcgpu-fix-device-node-leak-v2-1-d773cf754ae5@bootlin.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tiny/arcpgu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -250,7 +250,8 @@ DEFINE_DRM_GEM_DMA_FOPS(arcpgu_drm_ops);
 static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 {
 	struct platform_device *pdev = to_platform_device(arcpgu->drm.dev);
-	struct device_node *encoder_node = NULL, *endpoint_node = NULL;
+	struct device_node *encoder_node __free(device_node) = NULL;
+	struct device_node *endpoint_node = NULL;
 	struct drm_connector *connector = NULL;
 	struct drm_device *drm = &arcpgu->drm;
 	int ret;



