Return-Path: <stable+bounces-220131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PZ9JBMso2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E51C5378
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B588B3085D71
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B6B34CFD4;
	Sat, 28 Feb 2026 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvjKgoLA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62472481A89;
	Sat, 28 Feb 2026 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300041; cv=none; b=UDSZa0v5hRB7Rt34fh/rFS7F7ozPv7yQNvrcL3aRjeRJeqTXROBxrrnyG6omT4Hm0o6XKpMTabIuVj1bAOFzFc/tms0HkL++wc1+foyR6V0ELbeG5Q78OSgll/y0wIhZIIKW5FQmiOUIsqHQbhFW1LHsBD4WjQ30TagVIaBp4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300041; c=relaxed/simple;
	bh=Lo+ZeyzO3oAro0iucUjc9K+Xe8giSkt3BfgizsfWyJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbkkKcn+01PkzcDftKHH4wyg47OiXd7cXvuFfUVhZFhYchBZJUa3YZ5kFAKA81546fw94JPc3bNiwbVBrT2vABr1knzul2f4tV36KgMXgt6BgGCK3O+SSxtxWD8p4kggPGDNPg4Tzs9IsKnLzavozBrY3GWXlPd++4R6TZ2guwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvjKgoLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8C6C19423;
	Sat, 28 Feb 2026 17:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300041;
	bh=Lo+ZeyzO3oAro0iucUjc9K+Xe8giSkt3BfgizsfWyJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvjKgoLAxwOOcQuGVSYGf9RBwUcA7fd5fTLIkZ5/K9vUqZRIzeNp86aNdOtrhMC1x
	 iW+rfHIOGgwWmneJKqEaBIhbakrT8ew0EWs+PVZWRDn5ZzVvUSGIaprR3mUvzCSdX8
	 7VplhNPglOwgGHug2FYdgwDewRrmf3KPwchOme2wwz8Up700UKi+zKKAmk5urHQ6IC
	 4rqbD+IRgyomypoeEt7XufXRn06htZwWTpSAWKx6EfllkQEo2RxAn4Lt7op1NeWBD/
	 /XkejJCklG8Uc2fsgLG4+KBbD73e3UPzJgK6ZFsalo1URCcpH7dlTzWQoo0z47s06R
	 NUngUjS4rWwrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 053/844] smb: client: add proper locking around ses->iface_last_update
Date: Sat, 28 Feb 2026 12:19:26 -0500
Message-ID: <20260228173244.1509663-54-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220131-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: B63E51C5378
X-Rspamd-Action: no action

From: Henrique Carvalho <henrique.carvalho@suse.com>

[ Upstream commit e97dcac3dc0bd37e4b56aaa6874b572a3a461102 ]

There is a missing ses->iface_lock in cifs_setup_session,
around ses->iface_last_update.

Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index ce620503e9f70..60c76375f0f50 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4270,7 +4270,9 @@ cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
 		ses->ses_status = SES_IN_SETUP;
 
 		/* force iface_list refresh */
+		spin_lock(&ses->iface_lock);
 		ses->iface_last_update = 0;
+		spin_unlock(&ses->iface_lock);
 	}
 	spin_unlock(&ses->ses_lock);
 
-- 
2.51.0


