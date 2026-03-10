Return-Path: <stable+bounces-224023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJtOHi7+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:19:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FBE24A60C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38FB631DCEB9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7982A386425;
	Tue, 10 Mar 2026 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIOFMN3h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70236EA89;
	Tue, 10 Mar 2026 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141156; cv=none; b=XlwbPJfLda5H8bpkvejc54X05LWOa59WeRulIISUolflgpNbB8fzjrgWKryr59A9w3MRwZ7guBHTrS6oGHJ+NrZ4llo1D1VRuKRY47YsZFFDdp4/LHfm2yUyJc7h9Rsr48XnGlq1WZmCYEmDzSg3AWFplmR45VwIJX1rrlXlV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141156; c=relaxed/simple;
	bh=DOLgvmvfT15pdlGT0sGmmk+6NYhFev5as4TzeMT+aAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Warc/MuSaJw1gGgZhHHeGBADaUitwp6g4EtsBLFiyVg3rkk2GhbHXLhB8Dg/fN7ZOjVjRnNjcYRpNh4qTs7lkED6o32BTT+9NupF5+db92scmr0flISUoanDn3AsJB/MSzUbf6Epb5L4M14XwXLhd4R9Mm0kLAa/7s/3+W+fd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIOFMN3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF79C19423;
	Tue, 10 Mar 2026 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141156;
	bh=DOLgvmvfT15pdlGT0sGmmk+6NYhFev5as4TzeMT+aAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIOFMN3hzG79pf5K0L9wzEcjMY7X9oU+iMoVWLb8rXcC6fPZ5LrOcIiQWiKIhBIOm
	 yRIk+4vrZXG28BmT2LZmhlpNHONOM+jrvSSIpR25oaXEtY/1xPnevCal7FkESPMj/X
	 ie09pa6MU4HP7n3Dguz0vcwfiBlHH6EI+ABHv6Y7wW+gQgVB98VrmEfZGW5buPd6HH
	 brFF+Y9Xacl5JMZx0U6kkdr5mFeXlvtyn2f0xKgY7TDAEi7mKlC1JRf/l42mcHvbeU
	 1XYQwcAlCZGA2neA5Ti/8NkAaWF2w9iNo419cNuRi32XKh1TNihRHVDG3q1q5MWgKu
	 f+FShx+hg/mUA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 158/311] smb: client: Don't log plaintext credentials in cifs_set_cifscreds
Date: Tue, 10 Mar 2026 07:03:25 -0400
Message-ID: <44b8a13f8c505c8328c53d3b089be4e3c0ea3de0.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D4FBE24A60C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224023-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,manguebit.org:email,linuxfoundation.org:email,linux.dev:email]
X-Rspamd-Action: no action

From: Thorsten Blum <thorsten.blum@linux.dev>

commit 2f37dc436d4e61ff7ae0b0353cf91b8c10396e4d upstream.

When debug logging is enabled, cifs_set_cifscreds() logs the key
payload and exposes the plaintext username and password. Remove the
debug log to avoid exposing credentials.

Fixes: 8a8798a5ff90 ("cifs: fetch credentials out of keyring for non-krb5 auth multiuser mounts")
Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 60c76375f0f50..9d082f8bfa4ae 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2233,7 +2233,6 @@ cifs_set_cifscreds(struct smb3_fs_context *ctx, struct cifs_ses *ses)
 	/* find first : in payload */
 	payload = upayload->data;
 	delim = strnchr(payload, upayload->datalen, ':');
-	cifs_dbg(FYI, "payload=%s\n", payload);
 	if (!delim) {
 		cifs_dbg(FYI, "Unable to find ':' in payload (datalen=%d)\n",
 			 upayload->datalen);
-- 
2.51.0


