Return-Path: <stable+bounces-223987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFYNJdb9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDC024A504
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0759431B41C3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C6E36EA89;
	Tue, 10 Mar 2026 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6C7hl9l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A22D24B7;
	Tue, 10 Mar 2026 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141120; cv=none; b=CBYWYuTqIp6gpG57EaUqiWSM12SoDSxqix23JKZ9M3QP80RbBnjZ41teFCez9Gv/bmzlVyfYvwL+g9SKKb2IZqMTyIknwUDfgPScVodynVbHLyi8VUuWnG1vTrxQMo68x+NReyWZ+I7nGtlvpcBcDF6IXttwtl8H62z6opTHnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141120; c=relaxed/simple;
	bh=ekmfVpfFkeT/x9Bls5lRxgfdW8GDZSZ417PXPDKtKCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KImZEpsViqYazXmtE2bgHj5DEr6HV+y8xb8WE5PMUr6+izVHK+O8fLaDkPiGebANhPA+0km0cTMYWXY/lHBDDzZ4MJxyzbmUgmtxEUxg7YNxg9yntOmNmj/VEaUUuBUWeW4j5+C+Ry9ZHQPm/kJSzajDedv+eO2O3C0uu0zjkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6C7hl9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC9AC19423;
	Tue, 10 Mar 2026 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141120;
	bh=ekmfVpfFkeT/x9Bls5lRxgfdW8GDZSZ417PXPDKtKCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6C7hl9lRhlqA7f9aKEqyJMzAwHtPADtZQvKdo3j9q90FJnTVkyHyAcTe9I5dbDwB
	 x534Wc7iGMQ+EpZYKQ3j/8muSfpa46eXBpIfJmVZepQ6fBMNCvfgw/214nvBtEL8vv
	 RwquKdHDOJrXj9QHzGnBiKPhRkbFeANOLW7GikReEELtHs5p5ywJrdKAkNC16hWVHb
	 59kPkRQSJ8qGoQKqkflt1c6euYDn4nTESArTgdyUCDjHxX3GEmbFyWLDQxXvSQv1Ms
	 wZF0CBFDJeGLywKoLSPeQ7fUtYSAVzbJY8m+2i++EhjbrSQh6OekUAHD+kgNP97M2G
	 VED6EAmRwX69w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>,
	Olexa Bilaniuk <obilaniu@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 122/311] platform/x86: alienware-wmi-wmax: Add G-Mode support to m18 laptops
Date: Tue, 10 Mar 2026 07:02:49 -0400
Message-ID: <8ce5849acb47c3b81074392457e2cdd58b6bfeff.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEDC024A504
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-223987-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

From: Kurt Borja <kuurtb@gmail.com>

commit bd5914caeb4b2de233992c31babccda88041b035 upstream.

Alienware m18 laptops support G-Mode. Therefore, match them with
G-Series quirks.

Cc: stable@vger.kernel.org
Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://patch.msgid.link/20260129-m18-gmode-v1-1-48be521487b9@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index e69b50162bb1b..d1b4df91401b1 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -175,7 +175,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m18"),
 		},
-		.driver_data = &generic_quirks,
+		.driver_data = &g_series_quirks,
 	},
 	{
 		.ident = "Alienware x15",
-- 
2.51.0


