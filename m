Return-Path: <stable+bounces-253270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHn6LpcHDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:12:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C92E597EE9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A9BF399CBBB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F354E427A1F;
	Wed, 20 May 2026 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tNb7NCMF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130D400E0E;
	Wed, 20 May 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302839; cv=none; b=RXmE3gAf9HVwQXHqZuONMh9wMpo9Gmw/QjZXg9Nx1PX6VsIyb3nedMbFdJ5JAs9vx7tgW1YZV+uwUOjQPtB2eTJGGFuiQisW6rLpC7EePww6vQrDeHmLncsiXy5n1sHmtklYGuBa8IAgF02nX0auHfvbPGhIF8ZYUmIx3qKXIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302839; c=relaxed/simple;
	bh=6dlPH9MioAO+uphQE8FAY90CneWtEWAtEJpc/X9io4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHuZgxNzrXTSL/wGSGvGMyuQJXl4WBd68zGCHPXeA6LN0p8TGtLoqKzEBRE32YTWk1U9sfh30BHnvdfT2I7Co2qGpK82QDFKHj0dEF3ijuxrv2gpozwZrB3tThP21ckBpbylzUDL35h7kUs+X58mqjeV80Pks2PvZ4gZ6Sum3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tNb7NCMF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1111F000E9;
	Wed, 20 May 2026 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302838;
	bh=Hm8dPmmWWtuPpMSUBYb1KQ25XAewV9ucF1SlgcD3b7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tNb7NCMFp3vkqPDe1RTPoPw2sDva6NW4NkCR+bjM2V7gzZqAx1pIDJyjxy1SuZ8XQ
	 tQ5fisqP6XvugAQxz3u0Ia2UDcqa4CoKvDiiqNcIQk5tf81mO9DXNpZI0JfDdK84ef
	 avFRzU4S8YgcRduJwX9Uvq8p/Qiu17dN4HM9/Gac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 418/508] netconsole: propagate device name truncation in dev_name_store()
Date: Wed, 20 May 2026 18:24:01 +0200
Message-ID: <20260520162107.663803973@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253270-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0C92E597EE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 92ceb7bff62c2606f664c204750eca0b85d44112 ]

dev_name_store() calls strscpy(nt->np.dev_name, buf, IFNAMSIZ) without
checking the return value. If userspace writes an interface name longer
than IFNAMSIZ - 1, strscpy() silently truncates and returns -E2BIG, but
the function ignores it and reports a fully successful write back to
userspace.

If a real interface happens to match the truncated name, netconsole will
bind to the wrong device on the next enable, sending kernel logs and
panic output to an unintended network segment with no indication to
userspace that anything was rewritten.

Reject writes whose length cannot fit in nt->np.dev_name up front:

	if (count >= IFNAMSIZ)
		return -ENAMETOOLONG;

This is not a big deal of a problem, but, it is still the correct
approach.

Fixes: 0bcc1816188e57 ("[NET] netconsole: Support dynamic reconfiguration using configfs")
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20260427-netconsole_ai_fixes-v2-3-59965f29d9cc@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netconsole.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2045872de5328..f58643bdafc5c 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -476,6 +476,13 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 		size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
+	size_t len = count;
+
+	/* Account for a trailing newline appended by tools like echo */
+	if (len && buf[len - 1] == '\n')
+		len--;
+	if (len >= IFNAMSIZ)
+		return -ENAMETOOLONG;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
-- 
2.53.0




