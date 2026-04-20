Return-Path: <stable+bounces-239464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ4KEzBh5mmavgEAu9opvQ
	(envelope-from <stable+bounces-239464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:24:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 515594311DE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B06331EAE02
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE7E33262B;
	Mon, 20 Apr 2026 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wAe5Xvss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62511334C39;
	Mon, 20 Apr 2026 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700320; cv=none; b=PGG4SnszRuNH8IaN4tggMDqkdnLZTgJ/990DDQpN8JFt7H0xj6Vs/WDfUwVd3ZIWDMBwZohgzecthb1gvk5zUFFiWSy1HI8gmtsd1OlVZFJlNf8xSQrYfL40sDEyQmypj5VqeV2z1duM4ACq4EqgzGmlTXUQOV9PrwIGaNlv63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700320; c=relaxed/simple;
	bh=j8VbCZ9HbnqpSGlcWAfqTpOCEA9XXksrdbjhrAnbl6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEnm34K33iTFS2QJAh0F6Hxg9EKVZi/9qvFQYZ8ZaBNxG1yBwu9yrY6hiyRiiccaFpn07DTQJaHlRyOhaJm5s6RF6S+I4TrDeOMrZQUHZs17DAzzDLT49KoCLEZ2TqYuaiWHh5AhFRLRdoksdPc3vuhgLlsMP+8xO3ki5d/4SM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wAe5Xvss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC194C19425;
	Mon, 20 Apr 2026 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700320;
	bh=j8VbCZ9HbnqpSGlcWAfqTpOCEA9XXksrdbjhrAnbl6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wAe5Xvss3l91U8ZCo5T6f38nxqGULj8VfEClqdkowIttxOLJhcVtgkcHpfnE1vIh9
	 SAZLN8rI6f+Yy8FEMeQnpzjlFFfqnGEcWVxvUENl/mqXThnvw79VigIZcz3nTYQESb
	 rKbQTULDWCqaFRV7/pi3fHOpAs55DPHy0hpEI0RQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 126/220] net: txgbe: leave space for null terminators on property_entry
Date: Mon, 20 Apr 2026 17:41:07 +0200
Message-ID: <20260420153938.564408546@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-239464-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,trustnetic.com:email]
X-Rspamd-Queue-Id: 515594311DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
index 82433e9cb0e33..6b05f32b4a010 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -424,10 +424,10 @@ struct txgbe_nodes {
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




