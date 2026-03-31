Return-Path: <stable+bounces-232296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D+xFjIGzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD5436F001
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAB6830D9C11
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DF1425CD4;
	Tue, 31 Mar 2026 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQEfJkgQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF53A1E8C;
	Tue, 31 Mar 2026 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976383; cv=none; b=nLhuplApr76Ao7XOUt4ejEv68Rqro1F606n8ZYaANN8DzsJYZXVN7M/RFeNqbpKDgLPSAHSBKNjtKp/uRCBZXV+NxTGTs1INK4qOKnH56850CVoTSUxgBfKNW3XFVk8Gf/A6+ZoXjE8WMdUh53GYbxQpV3G8j3JapBbs8A3ykTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976383; c=relaxed/simple;
	bh=EqybEF6snh+6ZqZcPajdEib+kMGiOOPWTeBubflfpmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcEDUQZK+WhXQSnQvPI874zaRqM3VGg4Nip4u0j6ushC0Tx/nfxWnxsUz5ieclAvjXJFaU+d9ET5CZ5l3sqet+BdCwbXxJv1sBzzpe9htozFqGL1DS5gX5+89hPXYsgrfhvHssvk6fv346zk966MBGWd9zb0aLGqSCQplj7o3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQEfJkgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC02C19423;
	Tue, 31 Mar 2026 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976382;
	bh=EqybEF6snh+6ZqZcPajdEib+kMGiOOPWTeBubflfpmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQEfJkgQXZRwcKWy6nw6g9/Qij1196n7C+bZXdQzrYact25Oe0PUZkRtJDH2If/js
	 LPxpZ1psLWfaARxAbF/8Y01BmdGSPZqPqLoqyhVd9sngtO4CjyOrxoH/k63ID1vZd+
	 sBnevxbG5qV7/h67VpS3hLesaro5fW0CD/D37YyA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 072/309] pinctrl: renesas: rzt2h: Fix device node leak in rzt2h_gpio_register()
Date: Tue, 31 Mar 2026 18:19:35 +0200
Message-ID: <20260331161756.138590905@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-232296-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,glider.be,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,glider.be:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,of_args.np:url]
X-Rspamd-Queue-Id: 5CD5436F001
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 3161b2469c362..595ad5c83aa00 100644
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




