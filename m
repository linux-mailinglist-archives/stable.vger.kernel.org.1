Return-Path: <stable+bounces-256395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGa5I4euGGrBmAgAu9opvQ
	(envelope-from <stable+bounces-256395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:07:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 946715FA3DB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CDAE3069621
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4DA35E1DB;
	Thu, 28 May 2026 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TukwXtOT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB4E35E1CC;
	Thu, 28 May 2026 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001577; cv=none; b=ueES0YKXNuJk35BzwcVNc3DVJO4mxptuol0XYeGYOgxq+uCcMIBrqvZEROpEJLH3r7+swmOvhVZAMx5A2aygTw1dRtksA0pKJTK6FjZtXxuMXZ63El8X+CF6txyA50hlY+KEYzjdqCDp8hWv9Bt5ZDME6dGiB6jlL3vaZm9urDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001577; c=relaxed/simple;
	bh=eqgpqE+nWB8SLSENvayDgEJ9VWWEnoEKFp3WlF6dpog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m60/LYI3a1IksdptyxLLfaxRhQiiSYlA2/8rzygqchVaf3QB9AA8TPtxtfjyOggcYfIsIL7QJGV/KEvKxWQF2JjP61bH0RyP+7ixByk7LKut1DfIN1tGXar1SFlVUlVZ9er9DocNI8czk4/mEP1EEyOjXDHgmvu/moeyLjsp0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TukwXtOT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167641F000E9;
	Thu, 28 May 2026 20:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001576;
	bh=EKbPZhgujRUkTiRmEXyoyiGVz2iaxvkRwBUTvVqmKOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TukwXtOTjeT0Z13D2IhQZJV4iQMRHmjnygaIH4GY9GM+YlZiCESA5DxCcqFAhcDkP
	 nFjEakj9nIwPTDaR2tEbL+iXsIjZ1Ra/HedUtMW0KVLqKYfDe5YPvqT//3MJ4i08y3
	 SbqtWGfSg3E7cd8je/wL6TvaPvq7udSH7LvGpdhk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rosen Penev <rosenp@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 176/186] net: ag71xx: check error for platform_get_irq
Date: Thu, 28 May 2026 21:50:56 +0200
Message-ID: <20260528194933.738875839@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,pengutronix.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-256395-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,pengutronix.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 946715FA3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit e7c70bf97e90d974cd575e4c90f8f9b07d056da3 ]

Complete error handling for a failed platform_get_irq() call

Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20260516212616.11758-1-rosenp@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/ag71xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index baf12ae0b8c4c..576e75b5168e8 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1880,6 +1880,9 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq < 0)
+		return ndev->irq;
+
 	err = devm_request_irq(&pdev->dev, ndev->irq, ag71xx_interrupt,
 			       0x0, dev_name(&pdev->dev), ndev);
 	if (err) {
-- 
2.53.0




