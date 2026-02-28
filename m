Return-Path: <stable+bounces-220461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFkmCNs2o2lg+gQAu9opvQ
	(envelope-from <stable+bounces-220461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E18FB1C6211
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 536C2314FF02
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753E535D9B5;
	Sat, 28 Feb 2026 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hzq8OTtK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212235D9A5;
	Sat, 28 Feb 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300349; cv=none; b=pnOyamTSbensk+MWTycFCWHtq/qYU2g70+Vt3EdavQnpSyH+/r9iEP+VV++Ec7li+1xCGoef+PnOsp+1jk4B8M+uWuaJjp9c4ZZGwPkapmx32EzcCzYnqqA4Ae5EA9wB2H7qGlMWYNGtQmFgg/zzyQ8VLthxpG6nYs5ZSWv70jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300349; c=relaxed/simple;
	bh=vDZ/7HLswCBu3RNHT/Isx3jQGWhJcnEeUc0aAdaKRdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWFsApas+D9hM5OvvVSAu4pPT/Qcv/7rRHUdWX38IPjqOz6cioZ9kkuKog53X5pDgctDhHHRnL6OGAxn2eT0bFajwVCgemi44VyJ8oI7A/xSexKhH446e/PUfRTFqKxKPOy6WwAiOZOyNe7O3S/95NZ9OygdqYvc9kWi6lqMajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hzq8OTtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F33C19424;
	Sat, 28 Feb 2026 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300348;
	bh=vDZ/7HLswCBu3RNHT/Isx3jQGWhJcnEeUc0aAdaKRdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hzq8OTtKsWxY4fzxEWLWvRzJ0TJk8LjyuofPdX4T0CGZgRIc9kc2g3jiV1NSLKMLg
	 6+i1HUDJqgZRRdshj9jXhuhwtj1fgjcqKm62VtvOMA1Swwj5cdrKZFwZIHFyzryPmy
	 csOYeuwJAWLJQ/PZ6Rgk2buY93oP3GSXTU0cuV2iO23L8Eo6splrEgbngsTMzwoS7S
	 x8U83JqIwBfvmRO+EnczsoKPfwzta/CDxmA0gaYbTWmCrVhwhahupqlcQxmBXDnBgV
	 eiRq6PtL7HSwK8qleCUii1+/PCTSwVeMDXojke06wmKvLVOMgWqi5haWxl32wJkH2T
	 lNbzZSqnEuZ/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Gu <gu_0233@qq.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 382/844] misc: ti_fpc202: fix a potential memory leak in probe function
Date: Sat, 28 Feb 2026 12:24:55 -0500
Message-ID: <20260228173244.1509663-383-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[qq.com,bootlin.com,linuxfoundation.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220461-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E18FB1C6211
X-Rspamd-Action: no action

From: Felix Gu <gu_0233@qq.com>

[ Upstream commit dad9f13d967b4e53e8eaf5f9c690f8e778ad9802 ]

Use for_each_child_of_node_scoped() to simplify the code and ensure the
device node reference is automatically released when the loop scope
ends.

Signed-off-by: Felix Gu <gu_0233@qq.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Link: https://patch.msgid.link/tencent_FA1AC670F5CF49873F88A44424F866994A08@qq.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/ti_fpc202.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/ti_fpc202.c b/drivers/misc/ti_fpc202.c
index 7964e46c74482..8eb2b5ac98506 100644
--- a/drivers/misc/ti_fpc202.c
+++ b/drivers/misc/ti_fpc202.c
@@ -309,7 +309,6 @@ static void fpc202_remove_port(struct fpc202_priv *priv, int port_id)
 static int fpc202_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct device_node *i2c_handle;
 	struct fpc202_priv *priv;
 	int ret, port_id;
 
@@ -357,7 +356,7 @@ static int fpc202_probe(struct i2c_client *client)
 
 	bitmap_zero(priv->probed_ports, FPC202_NUM_PORTS);
 
-	for_each_child_of_node(dev->of_node, i2c_handle) {
+	for_each_child_of_node_scoped(dev->of_node, i2c_handle) {
 		ret = of_property_read_u32(i2c_handle, "reg", &port_id);
 		if (ret) {
 			if (ret == -EINVAL)
-- 
2.51.0


