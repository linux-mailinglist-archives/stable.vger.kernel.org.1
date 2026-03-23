Return-Path: <stable+bounces-229059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBsCCa5YwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAE22F6027
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6261430F978E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E29394461;
	Mon, 23 Mar 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m8T81APj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875D26ED46;
	Mon, 23 Mar 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277930; cv=none; b=lXDhSEMEjc4PRRFcIgq/kF1oTyystrc2wJLZ5FLest+JJa/clzl+pCbpLuJgn/KbTDQUvRbTZZzAvkKhC/4nopQAYB7s3vKXfiuxuDghgGQ63phszRw1EiZdyVchpWQMZd//Lk0TirX/sHBr0hUB5N5Adk6OIDY/VJc6/UtXwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277930; c=relaxed/simple;
	bh=zwe6f2852xMrJYrEwT7K/G8rYXn3Tgox1drvqKv8JS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozWdpUrYP89Zd+UceIgmHh0z/4UC/LaE8h/3OjNC3zT8oDSy4ST7b442MjFLmSSzYDljNtXS2WQ3adsM9JKLRMRKikoqBgTKTpuv4l3FjtmYW1bJ8gOgohxzQQ7kkkC8JvsD/MddQh5Y3Wsqllca87uGdctPlnZa8dp6UVo8Wu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m8T81APj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918A9C4CEF7;
	Mon, 23 Mar 2026 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277930;
	bh=zwe6f2852xMrJYrEwT7K/G8rYXn3Tgox1drvqKv8JS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8T81APjUPft7+91d4jY+imBtWBIarrZlhrcHCc5L0Nw+zZoTJKVknulBY1Oa29Up
	 H7oc9iNB2f1lkssBTnw7i2T2DMlaTe5PSSee/uaaxbWK4L/6HerBMsz/0JUiTtN+0h
	 Nc8fLGsq1NdfE3LM2h0pl16Wqr8ATw/D1ResIpqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junrui Luo <moonafterrain@outlook.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 140/567] dpaa2-switch: Fix interrupt storm after receiving bad if_id in IRQ handler
Date: Mon, 23 Mar 2026 14:41:00 +0100
Message-ID: <20260323134537.276883910@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-229059-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,roeck-us.net,nxp.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BAAE22F6027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 74badb9c20b1a9c02a95c735c6d3cd6121679c93 ]

Commit 31a7a0bbeb00 ("dpaa2-switch: add bounds check for if_id in IRQ
handler") introduces a range check for if_id to avoid an out-of-bounds
access. If an out-of-bounds if_id is detected, the interrupt status is
not cleared. This may result in an interrupt storm.

Clear the interrupt status after detecting an out-of-bounds if_id to avoid
the problem.

Found by an experimental AI code review agent at Google.

Fixes: 31a7a0bbeb00 ("dpaa2-switch: add bounds check for if_id in IRQ handler")
Cc: Junrui Luo <moonafterrain@outlook.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://patch.msgid.link/20260227055812.1777915-1-linux@roeck-us.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index e44ab53448500..176f7072338b2 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1532,7 +1532,7 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	if_id = (status & 0xFFFF0000) >> 16;
 	if (if_id >= ethsw->sw_attr.num_ifs) {
 		dev_err(dev, "Invalid if_id %d in IRQ status\n", if_id);
-		goto out;
+		goto out_clear;
 	}
 	port_priv = ethsw->ports[if_id];
 
@@ -1553,6 +1553,7 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 			dpaa2_switch_port_connect_mac(port_priv);
 	}
 
+out_clear:
 	err = dpsw_clear_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				    DPSW_IRQ_INDEX_IF, status);
 	if (err)
-- 
2.51.0




