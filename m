Return-Path: <stable+bounces-214209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEWoL/Fng2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:38:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBE1E903C
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C2893125741
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238692D978A;
	Wed,  4 Feb 2026 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zWJTWjqZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79D261B91;
	Wed,  4 Feb 2026 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218928; cv=none; b=IB3g6lIEyW3byyljE0z5yJQIljGH44U6UEl1rf1pLuQGwIcuL6wmqA9FSn0ycDjXdF27orvFiHzLlGEnY33tcvm91sQT5+XGpIYhAPviaoYB2vBkpcNRwuvQDKnqdvpi0cDSKtD5947Q6bYVwc0hP8ajcoTeX+MhmYvf/evePfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218928; c=relaxed/simple;
	bh=onO1zxNOudpklcCbFDcagFQPh4GjaiMAzHK2KBewA2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqrcVc4h6Kwoi96MjAVydrTbQnlrY24i1pkFpuzt6qqhZT6u3dB63RiDblgW11iAI2rn4nUNJD3qGmctOFDAdqpp6shAhAX4vJ/iE5oGHGOWofVL1pQWT/pkrRp5nKXxq75a5xj6uDyZrKu8g0D/fsJnxalC4gUuSuEJY05Zkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zWJTWjqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BEFC4CEF7;
	Wed,  4 Feb 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218928;
	bh=onO1zxNOudpklcCbFDcagFQPh4GjaiMAzHK2KBewA2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zWJTWjqZjKzSNct/pqqKkJALznixws2infxIrjTBNl5MPWbqG52uAMz0DK8MwACnU
	 46IQOEMqx023nbLlvjtTsrMn9wf47s6ep4UW0gYMqYfGdKm1Atec13FVCYalUrIRu2
	 PZme4F0hFr/3d+Crj32JAHvVdENaIGxuYQ3PXtRQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kery Qi <qikeyu2017@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 016/122] rocker: fix memory leak in rocker_world_port_post_fini()
Date: Wed,  4 Feb 2026 15:39:58 +0100
Message-ID: <20260204143852.451331169@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-214209-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 3CBE1E903C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kery Qi <qikeyu2017@gmail.com>

[ Upstream commit 8d7ba71e46216b8657a82ca2ec118bc93812a4d0 ]

In rocker_world_port_pre_init(), rocker_port->wpriv is allocated with
kzalloc(wops->port_priv_size, GFP_KERNEL). However, in
rocker_world_port_post_fini(), the memory is only freed when
wops->port_post_fini callback is set:

    if (!wops->port_post_fini)
        return;
    wops->port_post_fini(rocker_port);
    kfree(rocker_port->wpriv);

Since rocker_ofdpa_ops does not implement port_post_fini callback
(it is NULL), the wpriv memory allocated for each port is never freed
when ports are removed. This leads to a memory leak of
sizeof(struct ofdpa_port) bytes per port on every device removal.

Fix this by always calling kfree(rocker_port->wpriv) regardless of
whether the port_post_fini callback exists.

Fixes: e420114eef4a ("rocker: introduce worlds infrastructure")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260123211030.2109-2-qikeyu2017@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/rocker/rocker_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 36af94a2e062a..2794f75df8fcb 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1524,9 +1524,8 @@ static void rocker_world_port_post_fini(struct rocker_port *rocker_port)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
 
-	if (!wops->port_post_fini)
-		return;
-	wops->port_post_fini(rocker_port);
+	if (wops->port_post_fini)
+		wops->port_post_fini(rocker_port);
 	kfree(rocker_port->wpriv);
 }
 
-- 
2.51.0




