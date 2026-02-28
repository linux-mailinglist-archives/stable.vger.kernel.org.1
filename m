Return-Path: <stable+bounces-220133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAv6Iawro2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 022421C52D9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 180113173608
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41183481FAB;
	Sat, 28 Feb 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpgSVuXv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F1481FA0;
	Sat, 28 Feb 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300043; cv=none; b=AHeTr7epQOuRHl4w2F47Z3gu1b7OjvndOgv2GzNjhA82Q1Ke/B59MYq0/nNtzKlLk8Kgjmyzs+m8hF9tgv5ENx+CpT5q6c3138FTD4Hfw7BVkDVMe/SYCGlAeISchbtpfvuNwH1OJUsq4Zrhwzy8ZWCXYe0CAHT+1lJxcoc+3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300043; c=relaxed/simple;
	bh=rCtsUBhmHVt+naUikG3iEK7KYnS6aBRu7BnLeOQdy9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIGA0iK+SkId/4Z7KdPL4jsRpCsviAX4+Y8YtQXroFGKfTig6UJcL6mu7IpIiCFcU5TcGEdAiYfKGKxOTO19zQXAh1U9hKSXAFtfHQu5EmbBAQiqW3A9ZroWT0VijaaUdhYp02z4EuMlg75IAjjZkcEknc1b5IBEAD6uQoZxhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpgSVuXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503BAC19423;
	Sat, 28 Feb 2026 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300042;
	bh=rCtsUBhmHVt+naUikG3iEK7KYnS6aBRu7BnLeOQdy9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpgSVuXvN+MUERPW0BPaYOtOv7yB26HHeC63w4RURfH1ooTsYVq99tRYcE389GI8K
	 B3ZXTHynhIQg0YOJGwLm9RXzcoGV73yHAWZcPM+X+dADVGKO2OduHF/JZOntTi8v83
	 cO4W7+38ZuIjqX9dmkka17mmnC9yzvtdYZmMbTkI5SjOFHY0KP2qQn2GQFPExqKJKi
	 EjkQU0xu05QSoZ3iI105hy6pPqNBTRV9ztGBs1kVO5ViGSbld9d60QotZ9BfH694OW
	 Iy922BAFFZewKwBrrvtNcwSc4+y3T/cQR3cIZvVPrSTUXBC1Cv53tskeRr1U1KnTr3
	 7uWdsHLKFmQtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 055/844] smb: client: prevent races in ->query_interfaces()
Date: Sat, 28 Feb 2026 12:19:28 -0500
Message-ID: <20260228173244.1509663-56-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220133-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 022421C52D9
X-Rspamd-Action: no action

From: Henrique Carvalho <henrique.carvalho@suse.com>

[ Upstream commit c3c06e42e1527716c54f3ad2ced6a034b5f3a489 ]

It was possible for two query interface works to be concurrently trying
to update the interfaces.

Prevent this by checking and updating iface_last_update under
iface_lock.

Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index c1aaf77e187b6..edfd6a4e87e8b 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -637,13 +637,6 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	p = buf;
 
 	spin_lock(&ses->iface_lock);
-	/* do not query too frequently, this time with lock held */
-	if (ses->iface_last_update &&
-	    time_before(jiffies, ses->iface_last_update +
-			(SMB_INTERFACE_POLL_INTERVAL * HZ))) {
-		spin_unlock(&ses->iface_lock);
-		return 0;
-	}
 
 	/*
 	 * Go through iface_list and mark them as inactive
@@ -666,7 +659,6 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 				 "Empty network interface list returned by server %s\n",
 				 ses->server->hostname);
 		rc = -EOPNOTSUPP;
-		ses->iface_last_update = jiffies;
 		goto out;
 	}
 
@@ -795,8 +787,6 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	     + sizeof(p->Next) && p->Next))
 		cifs_dbg(VFS, "%s: incomplete interface info\n", __func__);
 
-	ses->iface_last_update = jiffies;
-
 out:
 	/*
 	 * Go through the list again and put the inactive entries
@@ -825,10 +815,17 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_
 	struct TCP_Server_Info *pserver;
 
 	/* do not query too frequently */
+	spin_lock(&ses->iface_lock);
 	if (ses->iface_last_update &&
 	    time_before(jiffies, ses->iface_last_update +
-			(SMB_INTERFACE_POLL_INTERVAL * HZ)))
+			(SMB_INTERFACE_POLL_INTERVAL * HZ))) {
+		spin_unlock(&ses->iface_lock);
 		return 0;
+	}
+
+	ses->iface_last_update = jiffies;
+
+	spin_unlock(&ses->iface_lock);
 
 	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
 			FSCTL_QUERY_NETWORK_INTERFACE_INFO,
-- 
2.51.0


