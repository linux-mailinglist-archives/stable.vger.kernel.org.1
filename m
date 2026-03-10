Return-Path: <stable+bounces-223986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAucAtD9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A57324A4FC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FAD831B1E95
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFF135AC23;
	Tue, 10 Mar 2026 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0qoew/d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C372D24B7;
	Tue, 10 Mar 2026 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141119; cv=none; b=VtqGbo30LX5ebWBBbt5CMuIwOWPmS1Ko5I3Q8yZ5f51OJR/7OaAWiiPBVCO3YEmsOZuLS9yBopDo/zABTXmxtozvAFWRzEkSU00iIUU6ml6zbxSfGjxiwIXqSYNAnb+yF2wxRddIPMt9DCAZczmNCnWOk1u8kz5pOmYdvSuMAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141119; c=relaxed/simple;
	bh=MO+DTedvHfeYd+fOzqnm2kL95nJK7R6tAgaybookIcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFdPC6Nt2VOCTYaf8IXQWq+fe1DJrpR0Gni1srNY/JntLRMKAk/6tLD6FhpyRm42SJ+I6NopenYmyqh7GjCg9g2WWmbzBv236Y/j6BzjkpehdDjrrvuODo6Su0EEOmUao65t7IDThHqH4p1DbBM95lps4fm20qY9BqMs0zifHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0qoew/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3146C19423;
	Tue, 10 Mar 2026 11:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141119;
	bh=MO+DTedvHfeYd+fOzqnm2kL95nJK7R6tAgaybookIcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0qoew/dVJaS5uQIUwMDOhO61oAoLWeRGnZpwAQQIVpsJyGJ+WFClnJoTjdzlhZIf
	 fWV6SM//3arCve7gpp0eOhiagD7Xi6Rw+13+wT89tT4MJcNXSY8tEHjK+UywElGO4S
	 AWGGCftkXO/85PtRbiU1gLzGtlLRCYdSKO0XPIVmXjkrpVI4JwdbJ/bOh9HJJJTzzc
	 0kTYSQ42tYzMqtP8PFQEbmXzYXMWmm4MbRAw6LL/E6sx51s5AempZoHFy6dbo5a51N
	 w6Xtt9qjytUI6NV9B9pZSozwC/hOA8WlQVPRVfgGIMOIB06mUw8gMxB+TF0Tg0t1Nl
	 d4WZD0XU2ZTVg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 121/311] platform/x86: dell-wmi-sysman: Don't hex dump plaintext password data
Date: Tue, 10 Mar 2026 07:02:48 -0400
Message-ID: <93985644b62145421efaf828916a9427a256c67b.1773140655.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: 4A57324A4FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223986-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,linuxfoundation.org:email,msgid.link:url]
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


