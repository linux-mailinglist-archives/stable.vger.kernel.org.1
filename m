Return-Path: <stable+bounces-227195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEsEEKBKu2kliQIAu9opvQ
	(envelope-from <stable+bounces-227195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:00:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC12C441A
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B36C43091FF0
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B086353;
	Thu, 19 Mar 2026 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNpfpC6A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14D1547C0
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882012; cv=none; b=rEGXhNc/2pDksW370gs/uOkoTWif52RbTF5/VtdxAPKjKr4PDla1XdtyERQNmUGMpqLksSeIqP9HiORc+LZKlbk0r31zRwJqtUD01qjsfa+3GNRqB77tSd9JHgTiQBjcTjZMvReAd9TXR5MEGGmfQc6NQIKhJ6YS9Md0JzffLvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882012; c=relaxed/simple;
	bh=Gg+T8qsIKMDF7JVty08V9aRw2Q+nTH+SxLLqpSgO5q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfZ5sgFwZZYlZXd9UML8DGuBvw5CYzE9/t5Jynt19jhN5cbxlfjuBOtNxi14JTvGWUST+Y+LRVNtHg2IQaNvvwnz7KFsmEFELAWqT7V6UA/M4w4cavpYlaFpHDiT63z7+S2/rs1TeBg/SNfQ6K+145BVod6RD5tbri9TKxmiu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNpfpC6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F328C19421;
	Thu, 19 Mar 2026 01:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773882012;
	bh=Gg+T8qsIKMDF7JVty08V9aRw2Q+nTH+SxLLqpSgO5q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNpfpC6AH1wlF5hR9pQUefcBMXA4CnacK/Os31otcdh22uLH2+TIN3wqZdeFg+Haq
	 nON8MRmBz9o6YFTrLmiNx+F4s41cpXyxKxCi+vAW14OEC5a9lWEUAsa+knDb0hGf3R
	 3776MmWfLWLptMRSrjXbQo5kUqLtHBRGqYpHgUeohCnr26PGL3aHUjfLWG2P1vMJAh
	 ZvBkt2mIUi9bScEXeIFEUpyNlUYLfAa9xBEC5+2M+6ZEB5wifUzRrEWzKgGWN6BaeN
	 tiBgJfzShTvR9ciEvjp+J+HT0ukBJ+mzfdQpBpjoiBJ+1gjD19yX1HlUMHBLZoC3GX
	 +c2hXxDOx0m/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] netconsole: fix sysdata_release_enabled_show checking wrong flag
Date: Wed, 18 Mar 2026 21:00:09 -0400
Message-ID: <20260319010010.1861315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031741-agility-clench-4090@gregkh>
References: <2026031741-agility-clench-4090@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227195-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.886];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69CC12C441A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 5af6e8b54927f7a8d3c7fd02b1bdc09e93d5c079 ]

sysdata_release_enabled_show() checks SYSDATA_TASKNAME instead of
SYSDATA_RELEASE, causing the configfs release_enabled attribute to
reflect the taskname feature state rather than the release feature
state. This is a copy-paste error from the adjacent
sysdata_taskname_enabled_show() function.

The corresponding _store function already uses the correct
SYSDATA_RELEASE flag.

Fixes: 343f90227070 ("netconsole: implement configfs for release_enabled")
Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260302-sysdata_release_fix-v1-1-e5090f677c7c@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 020252961c906..7288b25d6b8c4 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -503,7 +503,7 @@ static ssize_t sysdata_release_enabled_show(struct config_item *item,
 	bool release_enabled;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	release_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
+	release_enabled = !!(nt->sysdata_fields & SYSDATA_RELEASE);
 	mutex_unlock(&dynamic_netconsole_mutex);
 
 	return sysfs_emit(buf, "%d\n", release_enabled);
-- 
2.51.0


