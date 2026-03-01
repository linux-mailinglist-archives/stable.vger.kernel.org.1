Return-Path: <stable+bounces-221365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOS9D7OVo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:26:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B041CA972
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE52F3016150
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE841283CAF;
	Sun,  1 Mar 2026 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViqGU/Im"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD5E26E710;
	Sun,  1 Mar 2026 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328080; cv=none; b=SGJW6WGFjmnycVsHpSg0U5Jp97P71P0F5RUlGiyj6UZfmoJY44YV6uD+R2WIEBSEzFTCl0fqLyLInmf3h3yZhVPnhsmFkG7WoOcUmH9tuWLzjlocY1EnmkY6gTO+/S+SnEBgjOwp4/io5G0EtFkr0B2uAWokfU12EBCNdhjFqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328080; c=relaxed/simple;
	bh=nQi1ZwZu+uxNekWTc62vjx6L1HetqztgxKUdU7MC5Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=er8HynWwrJATjOOTEMj7FYJ80HMBFdjY37F+QKi48QpPNKiGMA7Djj65FXvQXv4Gkatf+jhqHjeMmyS+qMOnJ8EG88niOcjE7Kd2qJ2i61ugMLXCRSr+Xl+IifRMiZhlPYtu4paCFD0GJX00DTgZYhg1rM+LEzyvh46AfSl5jiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViqGU/Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5BBC19421;
	Sun,  1 Mar 2026 01:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328080;
	bh=nQi1ZwZu+uxNekWTc62vjx6L1HetqztgxKUdU7MC5Xw=;
	h=From:To:Cc:Subject:Date:From;
	b=ViqGU/ImNXjNkA7XbRDttcC0vb44p71MF4PcE3XiqLp+NjVpnDJz707KR+fG3x01H
	 t5hVS8RwmgvjdydGui5bsXL5e2zckIIyqp1x8mLoi8knVsIV1Pzih24LEP8P4ptBuo
	 KvQhcZWBQqLsFybUmO7piNZI7W4jpEsX360FmcunyYMVsdpz79aOaum5W0qwEtbGiX
	 5RpepB8nC2okgXaBTh0pJqHAc/3xp1zV824ORevYS7lF2yWr02aqSt+CNrBjyycrbo
	 TyquL6J/vfVlGEC1qNZLj6ZPwJf/5y3ZPFjTmP+ZuWoKBSuRI3zmQWZROJoa9hyrc4
	 HrNHX3jQ+KhUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	j@jannau.net
Cc: Stephen Boyd <sboyd@kernel.org>,
	Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: FAILED: Patch "clk: clk-apple-nco: Add "apple,t8103-nco" compatible" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:21:18 -0500
Message-ID: <20260301012118.1677195-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221365-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,jannau.net:email]
X-Rspamd-Queue-Id: 86B041CA972
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ef9b3b4dbe767e4ac642a88dc0507927ac545047 Mon Sep 17 00:00:00 2001
From: Janne Grunau <j@jannau.net>
Date: Wed, 31 Dec 2025 13:22:00 +0100
Subject: [PATCH] clk: clk-apple-nco: Add "apple,t8103-nco" compatible

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,nco" anymore [1]. Use
"apple,t8103-nco" as base compatible as it is the SoC the driver and
bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Fixes: 6641057d5dba ("clk: clk-apple-nco: Add driver for Apple NCO")
Cc: stable@vger.kernel.org
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-apple-nco.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-apple-nco.c b/drivers/clk/clk-apple-nco.c
index d3ced4a0f029e..434c067968bbc 100644
--- a/drivers/clk/clk-apple-nco.c
+++ b/drivers/clk/clk-apple-nco.c
@@ -320,6 +320,7 @@ static int applnco_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id applnco_ids[] = {
+	{ .compatible = "apple,t8103-nco" },
 	{ .compatible = "apple,nco" },
 	{ }
 };
-- 
2.51.0





