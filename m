Return-Path: <stable+bounces-271516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pvr+KECcRmpxaAsAu9opvQ
	(envelope-from <stable+bounces-271516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:13:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA16FB258
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:13:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=UmbYMVzh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271516-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271516-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DDAB30A5022
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3597926F46F;
	Thu,  2 Jul 2026 17:02:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E9C1FA859;
	Thu,  2 Jul 2026 17:02:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011747; cv=none; b=QdgJgahhQRNDzFl6WUgmBeJ9VeP5+a4ctZZ7Chl/EYEdsYEiBnQXQZYqSv26MtEMnUxoIRP7gHLWIdgmGXIpjDoH4rjTRYgjFsoIiI4iXm6TiZj8M8CO6vJrsvg0nClujM+euafbSq2UrJGxAzCaWgj/6pgoU7oUUk9PG6tMGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011747; c=relaxed/simple;
	bh=U3ZVO9hpU5+THjMxo0FwOPElPuI9EEwiaT+Db9aMvMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UV0bjfWqEGsUzF+r9rUeW2RulPBEc+itsY21t8XHDiv8NKKUKQMjzufMnfsygYuX9nP7pkMXNkbhWaSA8zSk3GuYF8eBbZFJ3tlIJmGDeqs9hZWN8Qt7hPJbFJMv1jo+zeoyPMPVjnSUOHwMdZENy4Gw0FiFbHZBrunk2WTv+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UmbYMVzh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC961F000E9;
	Thu,  2 Jul 2026 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011746;
	bh=72nSTPrl30qdpY5BG9A0wMUTscVXxSINo4WEB8iYwzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UmbYMVzhw97k3pymlphhIhe7D0Mm2Ka8H/LG/0GuUuw2a0sOvQuqeTB1zlTniCQDo
	 K5AzjAejyixGfa6B6K7cs2FoUC4fjUn9/VZmr5C2cJ5b9ONDAMA4JHhIfQxs+arfqw
	 wsXh4UMEGPb1DpXcGL44KvqtBBQJs58lXyW8fBlI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Anna Schumaker <anna.schumaker@hammerspace.com>
Subject: [PATCH 7.1 117/120] NFS: Prevent resource leak in nfs_alloc_server()
Date: Thu,  2 Jul 2026 18:21:53 +0200
Message-ID: <20260702155115.379621308@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271516-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:christophe.jaillet@wanadoo.fr,m:elfring@users.sourceforge.net,m:anna.schumaker@hammerspace.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wanadoo.fr,users.sourceforge.net,hammerspace.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34DA16FB258

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Elfring <elfring@users.sourceforge.net>

commit d189f224308c8ac3feeea8e442c99922bd18f1b2 upstream.

It was overlooked to call ida_free() after a failed nfs_alloc_iostats() call.
Thus add the missed function call in an if branch.

Fixes: 1c7251187dc067a6d460cf33ca67da9c1dd87807 ("NFS: add superblock sysfs entries")
Cc: stable@vger.kernel.org
Reported-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/linux-nfs/1c8e10c9-def7-4f0d-8aa1-23c8035a38c8@wanadoo.fr/
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/client.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1074,6 +1074,7 @@ struct nfs_server *nfs_alloc_server(void
 
 	server->io_stats = nfs_alloc_iostats();
 	if (!server->io_stats) {
+		ida_free(&s_sysfs_ids, server->s_sysfs_id);
 		kfree(server);
 		return NULL;
 	}



