Return-Path: <stable+bounces-220243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCeoN3Iuo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D73A1C566D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD71C31DC2AF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0B637314F;
	Sat, 28 Feb 2026 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxfO8uVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD66373149;
	Sat, 28 Feb 2026 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300147; cv=none; b=bCI2YUor5pXvwC9Fa+RqcmpGX6Hqp4wy4EXtZEPmxaoBF5MQhyLUmKj/SxoVbk/VoD+g5Xgb8bdozqbp1/JlrvZNhLCR+bohMu8eUVcFtGQ1iPOjQqfu17JWZ7fIONDNaGNGUOvjqp6gV8tTCzJg0WYmu259u238GKWrx7VUxxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300147; c=relaxed/simple;
	bh=wdudqbYngq88C0TzinB/h0Ifxxl/S8VyroMgpAofPbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGC24WDC0M51SeWi2lYEBqrwQBcAsjm9knEX3wPswx0tiqZyeNmjdQzg+8KN0FJ7gYJdkVhjw3aXBUeO2QLdwI+iswFKCP2rWpsU0pugvY1oD8t+9axGPD42Hya9fMJBEpkkH/W8ItWTkzOcE+Hl6R+cbL0nkkD9kzr129PPo08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxfO8uVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FAFC19423;
	Sat, 28 Feb 2026 17:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300147;
	bh=wdudqbYngq88C0TzinB/h0Ifxxl/S8VyroMgpAofPbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxfO8uVi2iTHW5aDjiCxGS/NpH+7AEqSzq4XT92+yHAugrtAz8yLwZwPeq+AtMnQd
	 AgePOv84CMnm1OsN5lWDBGKW/Zz94e8b9Ux1ZdnAC3Z9326eOlQqgNga8s64glvKkF
	 h3jv/JmmnDu+CYNubdpbizNl7tfC5CZ4pmbogPW51cnpL7mCg/C08oUqnMUhzARVG8
	 UySPczB3fyxeFRoYDBfnGiUPm03wiyvl970TzUZk8n396oVThkDEo2VtcvbVX0rYnW
	 7B3THiWdjyKtV3cHuLZfuXw/1JB2xNPKvBciQqCOqPPCKgC71rNvnU6/bPmU/9zqZV
	 CXa/rYxyFCLSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joey Bednar <linux@joeybednar.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 165/844] HID: apple: Add "SONiX KN85 Keyboard" to the list of non-apple keyboards
Date: Sat, 28 Feb 2026 12:21:18 -0500
Message-ID: <20260228173244.1509663-166-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220243-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,joeybednar.com:email]
X-Rspamd-Queue-Id: 5D73A1C566D
X-Rspamd-Action: no action

From: Joey Bednar <linux@joeybednar.com>

[ Upstream commit 7273acfd0aef106093a8ffa3b4973eb70e5a3799 ]

The SoNiX KN85 keyboard identifies as the "Apple, Inc. Aluminium
Keyboard" and is not recognized as a non-apple keyboard. Adding "SoNiX
KN85 Keyboard" to the list of non-apple keyboards fixes the function
keys.

Signed-off-by: Joey Bednar <linux@joeybednar.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 57da4f86a9fa7..233e367cce1d1 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -354,6 +354,7 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
 };
 
 static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
+	{ "SONiX KN85 Keyboard" },
 	{ "SONiX USB DEVICE" },
 	{ "SONiX AK870 PRO" },
 	{ "Keychron" },
-- 
2.51.0


