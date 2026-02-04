Return-Path: <stable+bounces-214161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGk+FoNsg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:57:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB8E9ACE
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555DA304566D
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB7B4218B1;
	Wed,  4 Feb 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hw6hd1N/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1902421892;
	Wed,  4 Feb 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218768; cv=none; b=WiEcIZvIhPuc1k+4l4AFjQHwMMVZEeHp54rOCs3kbreHphnWy+3JzuZS4hJrL5hmWT4xOk2OqoopHMdcaKfiTj6n51EKDxHsBLi3ZytnCDPXK70XDhKxhbJuOmPOXRnTeJor+RKKS97oDXXEZIngWSo9l5tYquTIq1IL6oysxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218768; c=relaxed/simple;
	bh=+Mey00/kW/ejua5XquUGx038YiffpidrALcbT1rfpdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh3KaIcXGatynszwYwmMbdOiZFuKFCY0f6zSWfqYDoseBMK+1syxEis09PsZRY3aR0anpTyzIx9rU9EJ21KpoDvL0PnKcAUFOg4oV+83Dhvx7UP9didp+pOfCImD7/6WUoErDmEB0XeuGAxgG41Cx6cOirkxduIj0uvZj6hLYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hw6hd1N/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6886DC4CEF7;
	Wed,  4 Feb 2026 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218767;
	bh=+Mey00/kW/ejua5XquUGx038YiffpidrALcbT1rfpdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hw6hd1N/HukQ52uPg5Wfb0JFYqdFres7qUSViHKx8OxJSrvt0Y1XDCZct1VivyGOP
	 pRu4bm4AEv1QtoV1crkiSyihtY4XTfSdGFIo2+u4GPhGfN8paGEUKtaqC+POY/KkCb
	 8MtMZhOLbYLuGChDFWsPiL1FLiUD5KrOXB6+z07o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kery Qi <qikeyu2017@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 12/87] rocker: fix memory leak in rocker_world_port_post_fini()
Date: Wed,  4 Feb 2026 15:40:10 +0100
Message-ID: <20260204143847.354860649@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-214161-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 81CB8E9ACE
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index fe0bf1d3217af..23b20d5fd0168 100644
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




