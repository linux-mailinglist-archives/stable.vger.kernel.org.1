Return-Path: <stable+bounces-224331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG7SAbcBsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:34:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E424AFF5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B62B308CC58
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4AC3876D0;
	Tue, 10 Mar 2026 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ/JVb9U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B338A727;
	Tue, 10 Mar 2026 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142026; cv=none; b=dvZcoG0egPkMd0ZGxfvQMNjVrTx0aGf+ErH99rBSy6oEFVDR0c98uJ9kEyuYzxUbFtD5L7it3B0tly2O83lyD6RvCW9yWs0c2kLsazQNzueo10dpvOqMpNkKloV/IBxzrY5DIefk6LkI0EqFeVnRliI3xqApPGs8cnAu1b6tvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142026; c=relaxed/simple;
	bh=BobZ5EwQlXB/cTcUXuakRxS6/d38h/OVvjGufjxo/Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co5Dr0rsniRNOdwGAmOUxw/xgO+/qQ6EnMrU71vDjC7nh1AFomRY214iT+pAdUUpPs4JLmNqCKlG+jIDJmsrrIShyp/eWOLIGBcM9QJwG+82+eKPvP7wLKUzOl7mPsPOMM+TjGrFw69axRUfJMFQJzu0R6/4SGB2f8nl0/eWCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ/JVb9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AFDC2BC9E;
	Tue, 10 Mar 2026 11:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142026;
	bh=BobZ5EwQlXB/cTcUXuakRxS6/d38h/OVvjGufjxo/Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQ/JVb9UHj+cp4+Ju5hqN4C4WTkXQ63O30Khe2NPCuxkMz3mLeAGinYuc/oTQJwNr
	 V83Yplu5wRk5IrBXyf561dVW8r8AJo4tn6/QUKZJegaqFGTBpSEbP1i46Cs96+7aJh
	 HtsjYHRGxUYJKms7PfXJPzsvmpN4O8uvpeGhNEN/t5mf/PjRzXHqVLN2C93HgnrLqV
	 TkqAPbJ5Mc0r1hP4+aKzy1LdMOU3BGofby51P1xorU1+uFp8XUDc4ZjPynQpPrx3Im
	 hOojb6i8sALIN7oRTYZ7rPZg9HN3biCt+V//XHunPIAXW5GZaf2fLRxkQWL5jDZ20r
	 UnHEnLBXXeQAg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>,
	Olexa Bilaniuk <obilaniu@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 152/314] platform/x86: alienware-wmi-wmax: Add G-Mode support to m18 laptops
Date: Tue, 10 Mar 2026 07:16:51 -0400
Message-ID: <b699259f6671f0b8e323d7ddf4f30d4270114bba.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: 986E424AFF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224331-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
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
index 01af6dde9057f..fdae40689f178 100644
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


