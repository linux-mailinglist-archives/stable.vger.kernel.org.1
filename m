Return-Path: <stable+bounces-239696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLCaIlNn5mnBvwEAu9opvQ
	(envelope-from <stable+bounces-239696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:50:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B77432283
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1205B33399DA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E146333DEDF;
	Mon, 20 Apr 2026 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qwmtAXiX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52272E2665;
	Mon, 20 Apr 2026 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700982; cv=none; b=lLnP9vnGLFyxn4raTp5l0oCpyyfJjOyVjtsmHpCANBaP/FPmfbyMIVMMFUYZcJIZ+zeqkWVJ4zs09cMdIeE+NGGT/UygexJNKdOIDna1Iry0iU+KcnrOSG89I3q28IlsQ2hsEhuVhPvqqjRV9V8boAi+bgkqISuEU+in2y4nPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700982; c=relaxed/simple;
	bh=+9YZ2gGSkubi0OBXxCyh9ZbJeiVYmeab2V+RA0x2cWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1DRX4iad+Z0IOXZUlV8URDmIMwgMJdqgwiQcEm2k/mRhxilIIeqGIucWBn90CQnxgkP9VzQH4r1bukNubprPZJdopYFHWdKZb7uZ2osN0h9Q7XZ64T0JxSxqs5BOCfvt5RiRs3TpejG3IKEizkYTP4lm2aB3AofI7XNxGDgRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qwmtAXiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE0EC19425;
	Mon, 20 Apr 2026 16:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700982;
	bh=+9YZ2gGSkubi0OBXxCyh9ZbJeiVYmeab2V+RA0x2cWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwmtAXiXsyhIKPKRpJ6XEn+CqeCaHin/upO/j0PQYUYANCniJIeEfeiixhuCVxULh
	 uTPnAZeWOfrLliv/8RTLb3JWkHFUF1wEfNyYgYB2U6bjSSRD+fVK5Ti3WaIRvFxUSh
	 MRAcwZZC1us9A3CL96F6PfjzCBhNOWYF6MGDUtBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 108/198] net: txgbe: leave space for null terminators on property_entry
Date: Mon, 20 Apr 2026 17:41:27 +0200
Message-ID: <20260420153939.491203296@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-239696-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,trustnetic.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07B77432283
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Baltieri <fabio.baltieri@gmail.com>

[ Upstream commit 5a37d228799b0ec2c277459c83c814a59d310bc3 ]

Lists of struct property_entry are supposed to be terminated with an
empty property, this driver currently seems to be allocating exactly the
amount of entry used.

Change the struct definition to leave an extra element for all
property_entry.

Fixes: c3e382ad6d15 ("net: txgbe: Add software nodes to support phylink")
Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
Link: https://patch.msgid.link/20260405222013.5347-1-fabio.baltieri@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 41915d7dd372a..be78f8f61a795 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -399,10 +399,10 @@ struct txgbe_nodes {
 	char i2c_name[32];
 	char sfp_name[32];
 	char phylink_name[32];
-	struct property_entry gpio_props[1];
-	struct property_entry i2c_props[3];
-	struct property_entry sfp_props[8];
-	struct property_entry phylink_props[2];
+	struct property_entry gpio_props[2];
+	struct property_entry i2c_props[4];
+	struct property_entry sfp_props[9];
+	struct property_entry phylink_props[3];
 	struct software_node_ref_args i2c_ref[1];
 	struct software_node_ref_args gpio0_ref[1];
 	struct software_node_ref_args gpio1_ref[1];
-- 
2.53.0




