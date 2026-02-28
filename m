Return-Path: <stable+bounces-220311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA/AJiZFo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:42:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B66881C747A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C2C431477F1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282603907A4;
	Sat, 28 Feb 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goUL80ki"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38447ECD8;
	Sat, 28 Feb 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300213; cv=none; b=DyKDqNTygTYF7gcu2TaKyDolNWUX5b2IjR5rdQ11+yG+uUJsIrKaB2YlU+2XdCTgrA/2RBTsRaMfSrfqBytEgAqyBPjvGHzjKOJ2hUNkeUfe2VvGaGFxNGfalcASgUSj7AYDqiRiQWO9X4d7Dwrj/uRl17VDx0uZd+Mj+uhRh2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300213; c=relaxed/simple;
	bh=xThnOp80bagP+sxV1jx0SyaleSC/4bhcPbj9NQNTjhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZ8Vzq0l0w4RwT99JSkkBNKVIlD6nQlQB39P46TdC9Iesv6Yp/4M/eU8hQtCxizWPs8INwv9YKiMYNSxXXPP457qtKj5naVWnHNOMBjVq+VZy7gG+MUBVgEdBEVgxYQR9Ij8BlF6FXzlMT/Gkae8rWX6M7HBDuQNzt0sxprBjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goUL80ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1EEC19423;
	Sat, 28 Feb 2026 17:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300213;
	bh=xThnOp80bagP+sxV1jx0SyaleSC/4bhcPbj9NQNTjhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=goUL80ki8/WMsyp90OCRQUtfXRU2kEO7aGzwj8v5637QxL2zkLCvEPrXYMIoUltNt
	 dAYfLHVdxUBG1ps+8h4rIlMM+4xAXJYLeD/01/vKGPH4SIlC9xwpuCTft6hIyzhXjE
	 44yBjikcTxMCjtsFnFADilKBY1q+TXJhkKbVUVuBLNWKKCsyvMXRQ3fRo7IDAzwxVo
	 3W4aQL6kBbDIzJ1Dgw6aGsz2gZ5NrG0wtbusA2JuGX97otjH9qiXfnAubcFxp6AqZG
	 Uip7CG+v4p6HwiaFX+Qvu3xeBNe89nC858vkXeLExLDyOKXqW6dMfnk2/0KBREBQZi
	 MnHy4rUGDHx6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Gu <gu_0233@qq.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 233/844] hwmon: (nct7363) Fix a resource leak in nct7363_present_pwm_fanin
Date: Sat, 28 Feb 2026 12:22:26 -0500
Message-ID: <20260228173244.1509663-234-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,roeck-us.net,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220311-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qq.com:email]
X-Rspamd-Queue-Id: B66881C747A
X-Rspamd-Action: no action

From: Felix Gu <gu_0233@qq.com>

[ Upstream commit 4923bbff0bcffe488b3aa76829c829bd15b02585 ]

When calling of_parse_phandle_with_args(), the caller is responsible
to call of_node_put() to release the reference of device node.
In nct7363_present_pwm_fanin, it does not release the reference,
causing a resource leak.

Signed-off-by: Felix Gu <gu_0233@qq.com>
Link: https://lore.kernel.org/r/tencent_9717645269E4C07D3D131F52201E12E5E10A@qq.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct7363.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct7363.c b/drivers/hwmon/nct7363.c
index 71cef794835df..47fc1b4a0f3f9 100644
--- a/drivers/hwmon/nct7363.c
+++ b/drivers/hwmon/nct7363.c
@@ -349,6 +349,7 @@ static int nct7363_present_pwm_fanin(struct device *dev,
 	if (ret)
 		return ret;
 
+	of_node_put(args.np);
 	if (args.args[0] >= NCT7363_PWM_COUNT)
 		return -EINVAL;
 	data->pwm_mask |= BIT(args.args[0]);
-- 
2.51.0


