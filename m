Return-Path: <stable+bounces-219405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBAKCw6gnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:09:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84938193048
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D145F31C2982
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC42BDC03;
	Wed, 25 Feb 2026 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HnsJIMHK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5316D3081D7;
	Wed, 25 Feb 2026 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002694; cv=none; b=fHerpnqrwwD/msgnXsO6IXfqnQU8nUIdjjjDdBcGVf9GT9unyKinuij4Whx9oMm7Z439HIsd+Zk7qdTlhLGsaFDq4URYIw3FOeaqwjBKRWOu3qmEDSjbJXh/7XHYrjrcwMJrPCqLZs0rjgpCP12YXonaY6alVLMDagDOJO/+xVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002694; c=relaxed/simple;
	bh=LvPsTPBwJ3HAtTWL/sSbkPggwowCa15cDIQcxedsods=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDhsX05xguWomT8ziEWllsNQf2gf49OjaL2CdDOLuvuVDE/b59bE7yJDwlJBSWepCmHmv71UQRggwM7QBRlyONFsY1Zz5zUh1xwPX7Fx7C/Yo3+C1vsaOerQlEzoSDZMOAZBCz4ecrRYAk06cWbvcN7glkr8gB+9V1KhLjX94Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HnsJIMHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD3EC19425;
	Wed, 25 Feb 2026 06:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002694;
	bh=LvPsTPBwJ3HAtTWL/sSbkPggwowCa15cDIQcxedsods=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HnsJIMHKz5NkJKa6f21gshDaFB0K4LmIPwtui0YbU3EkLp+FeVkJ+Yul5mp1os7xj
	 EEP7ZEaHXARzj4idvxMXpX1fO22C4dRYb5XKyESYwWeuqRbLdTjQHgOBa9c1L03Izy
	 YU9HwIjrCzS8wEeLD1VPzKT28uodJJqbT6vOf+6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 489/641] pinctrl: meson: amlogic-a4: Fix device node reference leak in bank helpers
Date: Tue, 24 Feb 2026 17:23:35 -0800
Message-ID: <20260225012400.366423005@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-219405-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amlogic.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,amlogic.com:email]
X-Rspamd-Queue-Id: 84938193048
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit e56aa18eba32fb68ac5e19e44670010095bb189c ]

of_parse_phandle_with_fixed_args() increments the reference count of the
returned device node, so it must be explicitly released using
of_node_put() after use.

Fix the reference leak in aml_bank_pins() and aml_bank_number() by
adding the missing of_node_put() calls.

Fixes: 6e9be3abb78c ("pinctrl: Add driver support for Amlogic SoCs")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-amlogic-a4.c b/drivers/pinctrl/meson/pinctrl-amlogic-a4.c
index d9e3a8d5932a8..f05d8261624a4 100644
--- a/drivers/pinctrl/meson/pinctrl-amlogic-a4.c
+++ b/drivers/pinctrl/meson/pinctrl-amlogic-a4.c
@@ -725,8 +725,9 @@ static u32 aml_bank_pins(struct device_node *np)
 	if (of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3,
 					     0, &of_args))
 		return 0;
-	else
-		return of_args.args[2];
+
+	of_node_put(of_args.np);
+	return of_args.args[2];
 }
 
 static int aml_bank_number(struct device_node *np)
@@ -736,8 +737,9 @@ static int aml_bank_number(struct device_node *np)
 	if (of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3,
 					     0, &of_args))
 		return -EINVAL;
-	else
-		return of_args.args[1] >> 8;
+
+	of_node_put(of_args.np);
+	return of_args.args[1] >> 8;
 }
 
 static unsigned int aml_count_pins(struct device_node *np)
-- 
2.51.0




