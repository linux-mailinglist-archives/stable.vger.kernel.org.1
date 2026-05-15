Return-Path: <stable+bounces-248219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LR+aLUhKB2pXwwIAu9opvQ
	(envelope-from <stable+bounces-248219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:31:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB445534FD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D986231AD4DA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849F3F86F9;
	Fri, 15 May 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jjb5OXt6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7CC3F86FF;
	Fri, 15 May 2026 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861174; cv=none; b=NdSPvQuiSH3S6GUc0zi8RwK3AJnsCAT9IXBuQPcIOenOhbXO9QFUbCqrgCKfBjDCdoEXszTo9RXHtoVqMOrePK/bTkhbb3kiGcyorCnP1wPgx2nQOU8SRyd2aXTLQI73+uUm5Wua/8NqU819xRYuKaZ1ak3tCxzf+GNLHjFMLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861174; c=relaxed/simple;
	bh=RtGS/6a/95oXMClgEkTv9456iKLmIzCXsmdmzfbd9X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESQn0nPEJ2DlWUXdwKa4vcS2Q/EU7WJW1paJJxzeiZQJknrtJCq9NoXGtAqqP71qwFY6ErWc8CVEOnvY+RkFuUJw9rsHmt4SAB9LmqwBxT2MduAQigFZGxDpQu/Va1clP66KrmIeYOb5DMtPcX+GYfyzuCODVaaaW5BR6xkjF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jjb5OXt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616D0C2BCB0;
	Fri, 15 May 2026 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861174;
	bh=RtGS/6a/95oXMClgEkTv9456iKLmIzCXsmdmzfbd9X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjb5OXt618/shutBa3cznUaPzCVJpIQ5EXjyC89epTPtdzn7W3Ns75rc0yO63Kx45
	 5rJ6OMYtMmuftNu1oix+R2PdCS04YIZGN3G4WOUwAt5Ky+uqSnhEydDijmW2naxcVF
	 9h+CcslMWwPeyBJhvOmSd4hvva53motFQoXRYt7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Johan Hovold <johan@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.6 227/474] clk: rk808: fix OF node reference imbalance
Date: Fri, 15 May 2026 17:45:36 +0200
Message-ID: <20260515154719.918391067@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4EB445534FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248219-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit de019f203b0d472c98ead4081ad4f05d92c9b826 upstream.

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 2dc51ca822e4 ("clk: RK808: Reduce 'struct rk808' usage")
Cc: stable@vger.kernel.org	# 6.5
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-rk808.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -153,7 +153,7 @@ static int rk808_clkout_probe(struct pla
 	struct rk808_clkout *rk808_clkout;
 	int ret;
 
-	dev->of_node = pdev->dev.parent->of_node;
+	device_set_of_node_from_dev(dev, dev->parent);
 
 	rk808_clkout = devm_kzalloc(dev,
 				    sizeof(*rk808_clkout), GFP_KERNEL);



