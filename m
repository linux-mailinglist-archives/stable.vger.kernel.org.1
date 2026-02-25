Return-Path: <stable+bounces-218868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J4TIY5XnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:59:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B819057B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DBF530D3142
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F6626ED2A;
	Wed, 25 Feb 2026 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tg8I7Mis"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEB24677D;
	Wed, 25 Feb 2026 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983754; cv=none; b=Vcq1IIW6jdFI+t2XMfzllGKZUbuparwo+N03zmoOo3CYzHNf/EtpHhJjqpOrS1HNyZjjNu+82Eo6lhQ5kyifcHfdfEVq+95JlSv8EHdoVIRzkCaP8ISHrYqPia32oIp1Mn/dl3DhrytbC+auTFoQT3XvA/vmbv5xsHjUEafrxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983754; c=relaxed/simple;
	bh=u6aER71t1ksAxcPNRKrRrc2lB+xGDQ8VMq93YfzYaJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skwU6KiUyD7H+WXJFbe69msegYYsguzFvfgz+WB8xInAzEcRaaibWsDvaXMRroevUNTZV0IPqw6I0MXSXv+FQnkr12RxpFGpMNzFDwIXfyt+ABya2IEeHHVyHIzmbpk5BjRRQmonozn2YY4Yvnut+vELiJapWSVr1l9SCp2imc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tg8I7Mis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09741C2BC9E;
	Wed, 25 Feb 2026 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983754;
	bh=u6aER71t1ksAxcPNRKrRrc2lB+xGDQ8VMq93YfzYaJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tg8I7MistYUCIziU9tflzIE2L3WXlG5kJSRlbp7go4Rs/OZV9qDraO+EC5aSRCh2x
	 yRQIkhRA+9CsVrmw/3DOS5PnS0Hr2mRQSlCQMwOuuyt2m7tHvgD7QT3J7LCFqKMaEz
	 1NCPq9ne/+W+2xKkpMlfEY6Ldsf1TOjB2aW4Ce4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 008/641] i3c: Move device name assignment after i3c_bus_init
Date: Tue, 24 Feb 2026 17:15:34 -0800
Message-ID: <20260225012349.142850146@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218868-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: B01B819057B
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Billy Tsai <billy_tsai@aspeedtech.com>

[ Upstream commit 3502cea99c7ceb331458cbd34ef6792c83144687 ]

Move device name initialization to occur after i3c_bus_init()
so that i3cbus->id is guaranteed to be assigned before it is used.

Fixes: 9d4f219807d5 ("i3c: fix refcount inconsistency in i3c_master_register")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260112-upstream_i3c_fix-v1-1-cbbf2cb71809@aspeedtech.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 66513a27e6e77..bc68a5e7455be 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2884,7 +2884,6 @@ int i3c_master_register(struct i3c_master_controller *master,
 	INIT_LIST_HEAD(&master->boardinfo.i3c);
 
 	device_initialize(&master->dev);
-	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
 
 	master->dev.dma_mask = parent->dma_mask;
 	master->dev.coherent_dma_mask = parent->coherent_dma_mask;
@@ -2894,6 +2893,8 @@ int i3c_master_register(struct i3c_master_controller *master,
 	if (ret)
 		goto err_put_dev;
 
+	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
+
 	ret = of_populate_i3c_bus(master);
 	if (ret)
 		goto err_put_dev;
-- 
2.51.0




