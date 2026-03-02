Return-Path: <stable+bounces-222578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFA2I5N5pWm6CAYAu9opvQ
	(envelope-from <stable+bounces-222578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 12:50:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4131D7DD4
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 12:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1EC53048B2C
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 11:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032EF363096;
	Mon,  2 Mar 2026 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VCOk+SFP"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC433321B1;
	Mon,  2 Mar 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451983; cv=none; b=ZsCANbt+yxyHFLqu+LPuGcv579mY+v/mxdC0M88VqqG3AnvFUvBrj99SYSfLkCCtv97qZpR65MnwZDW8dlpHNlUONYSnpZxBwOep84opAtq+FzBc1pknvBov9YN/gKpRBcx8HgZmv6bErhOJ8qGBY6GomrJhJMh5bu6J0ifvB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451983; c=relaxed/simple;
	bh=+E1EkHiWLx5KeRwLM8g20RgtZDp190j7/8zrLOAH8/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FQtV0UozH5y9nKlAwjxhGRvjB8JB0kKPFEGe+LnIXl+G6xYbXpqF/dtLaT73KTrH1d2uVw3tVtmk7bWubjy1CccvQ+iEg+XjrdqJ1IWaYxrn27/p9JmiTKdEjAaIEPzRAVXbKn5hi9+i5B68TmqWUai5SgtTl2eSFVL+XR+lTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VCOk+SFP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=HLjzje/PjhXfTMg1ixH5k3muyDrM3fLHjdFWR+TFpJU=; b=VCOk+SFP/zFsmCTL1aLshMeBMZ
	m0pGu9ly4IpVq282Or92WcsKN7kWLdK2KfDTTPiYtUDpRM43SMT0IT1kPjMdUnp9sVf+hCCOCXafF
	3ShvoBAYQrO99Nb+sZU1ufORBLa3FxF2UzoEB+Oy/QFzix3bdtdXfa6pqqRMHJJYiIESY4/jPER3s
	21h5pQtxXz/n2Nr0RhgFJSj9q91p1YCg0MY/4nnwF/eg1mId09bbX4sWf4uyBkfCtT/OWKAVVMmI5
	fJUphxM4JL2mEc0R/htbJkSxNyrU3C0904WfjKsfb4KMoi/sqS7CPVqdoRY/J9y6y6y9KGOcKfgIT
	ygI6SULA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vx1j0-00ENmP-VF; Mon, 02 Mar 2026 11:46:11 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Mar 2026 03:40:46 -0800
Subject: [PATCH net] netconsole: fix sysdata_release_enabled_show checking
 wrong flag
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-sysdata_release_fix-v1-1-e5090f677c7c@debian.org>
X-B4-Tracking: v=1; b=H4sIAD53pWkC/yXMQQrCMBAF0KuEv24gTTCLXEWkTJOpjkiUTJRK6
 d1F3b7F26DchBXJbGj8EpV7RTLjYJAvVM9spSAZeOejC85bfWuhTlPjG5PytMhqcyiBxujinA8
 YDB6NF1l/6xGVO05/1Od85dy/H/b9A6HGgJp8AAAA
X-Change-ID: 20260302-sysdata_release_fix-c3d3a1606bc5
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=leitao@debian.org;
 h=from:subject:message-id; bh=+E1EkHiWLx5KeRwLM8g20RgtZDp190j7/8zrLOAH8/w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBppXh+rokRnVU4NfbljppgzodFkWsysakpfvaSI
 AuTizT03sOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaaV4fgAKCRA1o5Of/Hh3
 bTDoD/wKFXleOTNRGj22Z5DM9a5n3GdD68UHk3gw3Re/9lwyDaJerqEGoy7JMnbxfI7nirpIqLi
 cvgdZsELJGQ6ybZKJ2Zix/tDmYMp+EF3Gy4v0gkefAEeHvYQndyPCLYuQyFuI5wbUgUNMneHl48
 LKTEoFQdIFl5kdBOEAKc1ZvhvDiK1GKhJOz67sXi/FsxQVAaAqXbd1zKCI7CahKQ/kmvsbKfihe
 a+OWpPbBALeGDOAvEqslKa0I8/eOVCaSQMZFDd//99mJokNqZbanAeY9l+8Q2VDJFnEJn66O7+h
 Jrw0o8JKk6Tg+UmPCvlRjTQKnbLE1lGV4vRk/gvV99Pp1Jzmus+MyZ+3DhwqSM5AkTXPru1cHov
 a8xiY/pVulvKzenKruWTCNxRkDVR63B/OnXxYEfYZxInlPhLCfVodnflvNC3m9g/0clU2PmLAjQ
 fb6yWYO4XvU8PzrcdHDuXkA3MeXp5488kfswwPYjlrJNpQikZGMFuMDmhqqxt8teCY5YmsdIL55
 +u46XnnHNhRQDvo0xGeaWx1MnvDQtcNHGn5Al5TbVrSXhe2v1jl/cNOozEzn5Py+DdjUnW3Oc2U
 2DMYlz5vBmPUhmThQeFSM1gJtzc8nLsKifAKZ7G/QeLTTJXfXmsZn/1mFoJ69XZxKJGt3mIS126
 mpenBHH55NTDHbw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-222578-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB4131D7DD4
X-Rspamd-Action: no action

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
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2db116fb1a7cd..3c9acd6e49e86 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -617,7 +617,7 @@ static ssize_t sysdata_release_enabled_show(struct config_item *item,
 	bool release_enabled;
 
 	dynamic_netconsole_mutex_lock();
-	release_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
+	release_enabled = !!(nt->sysdata_fields & SYSDATA_RELEASE);
 	dynamic_netconsole_mutex_unlock();
 
 	return sysfs_emit(buf, "%d\n", release_enabled);

---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260302-sysdata_release_fix-c3d3a1606bc5

Best regards,
--  
Breno Leitao <leitao@debian.org>


