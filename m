Return-Path: <stable+bounces-231718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCZmGW/+y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-231718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A18ED36DC35
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D6A1312B011
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2104401A38;
	Tue, 31 Mar 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K9tO9Ewd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2607B402BA9;
	Tue, 31 Mar 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974887; cv=none; b=O4yOPb+imZ4DmqpvAQ1co8NuoYVdrTNEaKp7LUxNhT6tSsXlIGlH6iNBMqusfjflZOkpAxdzPRFTM4ULnJWGjKUNd0PjXeAhCNkDKf3N4OO8bXgfR30a6ca95dsUajmUYk7cTZzwy7KOLmI0txnq3vJgr2jhwuEpnGltWlv9Gy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974887; c=relaxed/simple;
	bh=BJBxyLU9C+gEphDjt9UsMs7M79Y7r7B1HT2En9OVhSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5o7qAZBvwexLKk9N1eEQqIUcvdPr9rQyuHp+6Vo7/7bVjxkEDINCmYq1eAu8w1CUGtMXPflAM2O3xoqSeeknNIPx4kMcehqi7KXL1xJ0wMqei5HmK4kuwxOCp3/T+jLboclJTQkdcPNiVYZ9YK2/uQppCnkbbTFgb0f3gwB2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K9tO9Ewd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9749BC19423;
	Tue, 31 Mar 2026 16:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974886;
	bh=BJBxyLU9C+gEphDjt9UsMs7M79Y7r7B1HT2En9OVhSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9tO9EwdVlUGrGJMvD6azsuBPO30QtsDLLV8Wi8vIXc7EK+cSg8O71G7TVzpQNEI2
	 RfDRcV8yEOHAiLy92+sIFG9B5kL+2lyz/0QYxRToItXt99616lD0D2Hd7nXbnokOJa
	 Jy7cbsjV+PUGu5PEG6py59Ne5u/1xZDthfK6P35s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 082/342] pinctrl: renesas: rzt2h: Fix device node leak in rzt2h_gpio_register()
Date: Tue, 31 Mar 2026 18:18:35 +0200
Message-ID: <20260331161802.042887363@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-231718-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,glider.be,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,of_args.np:url]
X-Rspamd-Queue-Id: A18ED36DC35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit e825c79ef914bd55cf7c2476ddcfb2738eb689c3 ]

When calling of_parse_phandle_with_fixed_args(), the caller is
responsible for calling of_node_put() to release the device node
reference.

In rzt2h_gpio_register(), the driver fails to call of_node_put() to
release the reference in of_args.np, which causes a memory leak.

Add the missing of_node_put() call to fix the leak.

Fixes: 34d4d093077a ("pinctrl: renesas: Add support for RZ/T2H")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260127-rzt2h-v1-1-86472e7421b8@gmail.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
index 40df706210119..24b90c80f5131 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -648,6 +648,7 @@ static int rzt2h_gpio_register(struct rzt2h_pinctrl *pctrl)
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to parse gpio-ranges\n");
 
+	of_node_put(of_args.np);
 	if (of_args.args[0] != 0 || of_args.args[1] != 0 ||
 	    of_args.args[2] != pctrl->data->n_port_pins)
 		return dev_err_probe(dev, -EINVAL,
-- 
2.51.0




