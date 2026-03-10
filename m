Return-Path: <stable+bounces-224426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGOtMp4CsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:38:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E48024B2A1
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FB413064156
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74CF38759A;
	Tue, 10 Mar 2026 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVgyXu/A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC743876DE;
	Tue, 10 Mar 2026 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142159; cv=none; b=NsBBmW7cExz0lL63ehzl/VBE98/JcllfRyJbJeGTJTPgsTwRkjpehVryRPWc1vO+DElHl0s9XRS9TSRibbU3pRwhsewR6p6/XJBKO63J4c998G14cww/JtyCFxhJNrFjzWbifabze1CudxW2gh9BR/xJ0RCKyP6aewq+QvGJ/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142159; c=relaxed/simple;
	bh=TuNfl08CHhdW20Kq40V82Yl5xAun2GoPmh/hrOD4VAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDshHwzwtzhS5dxhI94zKhMnxsM3bqEfNjtFYMrCImwlVj8NU/wH2TL5ZrMPUIkk2W39xo31FuICv1Qy7deYWf1OMFbzb3WDR4zNZcVUamWVgrjVnsgq9XEJvhqITc/0oMD1ipZhBXm0Fj5JR6UwSo4YlXVsuR6o5W3xpqJWWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVgyXu/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A068FC2BC86;
	Tue, 10 Mar 2026 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142159;
	bh=TuNfl08CHhdW20Kq40V82Yl5xAun2GoPmh/hrOD4VAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVgyXu/AO4Jpytx7mS1JzQjxNVAKg8eLQatPoU673f5HQJ96AeP5GJEwAFUMmbWCe
	 HIdOqZN+c3UEJ81A5JpKDEJxlA7lKFiD/gl3L3MiIHzJ7Ffj9z+BdgPBGVeBeY1daE
	 sigUWeSCkOHMwVH51+DgDC24LiJlAU+LbCjrAMuR6NwYE0U/cqpRjksBX4jMhdUWlT
	 y2Ek9PP3jXPMAqI7Sy5XhUalDCHE033pi/qx0iHbgsHQGm9Kz0ZaaLA5bjg61mqdEE
	 /jETXrBBkXZuGXJe8Ql7+yERAdk+VmoG40rpJTGGwVC2uz07CDWTzpf6a4L24B1q9u
	 KAikwEuUU4xlA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 247/314] net: dsa: realtek: rtl8365mb: fix rtl8365mb_phy_ocp_write return value
Date: Tue, 10 Mar 2026 07:18:26 -0400
Message-ID: <b8689a802467df4f1aa96258e9aa1df4c16aa590.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E48024B2A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[yahoo.com,lunn.ch,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224426-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Mieczyslaw Nalewaj <namiltd@yahoo.com>

[ Upstream commit 7cbe98f7bef965241a5908d50d557008cf998aee ]

Function rtl8365mb_phy_ocp_write() always returns 0, even when an error
occurs during register access. This patch fixes the return value to
propagate the actual error code from regmap operations.

Link: https://lore.kernel.org/netdev/a2dfde3c-d46f-434b-9d16-1e251e449068@yahoo.com/
Fixes: 2796728460b8 ("net: dsa: realtek: rtl8365mb: serialize indirect PHY register access")
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260301-realtek_namiltd_fix1-v1-1-43a6bb707f9c@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 964a56ee16cc9..d06b384d47643 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -769,7 +769,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 out:
 	rtl83xx_unlock(priv);
 
-	return 0;
+	return ret;
 }
 
 static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int regnum)
-- 
2.51.0


