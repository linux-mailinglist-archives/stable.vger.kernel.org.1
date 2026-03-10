Return-Path: <stable+bounces-224330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIovHgkCsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:35:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE92824B0BE
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 988AC30B3D90
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964CC38945A;
	Tue, 10 Mar 2026 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEIiffkn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B1387587;
	Tue, 10 Mar 2026 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142025; cv=none; b=V2Heo2n+f1AkOXRrfEkAxvPE9GRMCRoDfIDYGq0CBUdwYREbVMXXmGrZcBFWSj8oLXBCinwXfgmYJ4sjrZJOJdpzLD2smY7qs/BMNloMRI8AUrT6wOB/RA1qab2abEf9+v8NJMJmyDBhOcrGuxCsu+lOtNboaM+yM7yQLWbQrC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142025; c=relaxed/simple;
	bh=MO+DTedvHfeYd+fOzqnm2kL95nJK7R6tAgaybookIcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6X5mqQeY+w+5FKBotTe9UyD/lZYZ2JjWYUQBneweI2Jkh9afR1iz9dlLvHk3nG7XZ2aY2ZFKx7IcTwrCcMzVidaHPSxAhPwXv1H6FFMXQvX8nA0eYupvMWeNk7QQ8bVzM0Fh/c1BrCviGSLbnW6dSGQGq/ZJPM49x2oW7BeCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEIiffkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE43C19423;
	Tue, 10 Mar 2026 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142025;
	bh=MO+DTedvHfeYd+fOzqnm2kL95nJK7R6tAgaybookIcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEIiffknpV97CoUp/EBncfi6FeZLB66R18jiZCwRY5syhQeunI5p5B2LC5YbXk1WJ
	 e15Meqgw2zX4/vVXD5kLexU9IfbvD559ybnInFxiLqxtp7Iq+1YT63j/DVic5nu9tI
	 OfABZuxLxNvDnC6Gko8/b10LBiRYOYLN2YCGTaAmeH5qgyYTimhcMhZ4IC2jOH6q8l
	 2FivO9DF/rsnp2Edgeu25sAxCwSeJB4S9cz8YQwx6E0uLsmtgtnn2ob9X9HgLM5f6h
	 urUjhr25yv4zO8v/FwMC18kUwfVRmqYdh9L1j51RKzKhOlL7rp9+2i/LeZprLIbRVJ
	 6cPdb0JIwSKEg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 151/314] platform/x86: dell-wmi-sysman: Don't hex dump plaintext password data
Date: Tue, 10 Mar 2026 07:16:50 -0400
Message-ID: <5cb9b9a6bc26be66e85548835464758aa7b058eb.1773141555.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: DE92824B0BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224330-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,linux.dev:email]
X-Rspamd-Action: no action

From: Thorsten Blum <thorsten.blum@linux.dev>

commit d1a196e0a6dcddd03748468a0e9e3100790fc85c upstream.

set_new_password() hex dumps the entire buffer, which contains plaintext
password data, including current and new passwords. Remove the hex dump
to avoid leaking credentials.

Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260303113050.58127-2-thorsten.blum@linux.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c   | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
index 86ec962aace9b..e586f7957946b 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
@@ -93,7 +93,6 @@ int set_new_password(const char *password_type, const char *new)
 	if (ret < 0)
 		goto out;
 
-	print_hex_dump_bytes("set new password data: ", DUMP_PREFIX_NONE, buffer, buffer_size);
 	ret = call_password_interface(wmi_priv.password_attr_wdev, buffer, buffer_size);
 	/* on success copy the new password to current password */
 	if (!ret)
-- 
2.51.0


