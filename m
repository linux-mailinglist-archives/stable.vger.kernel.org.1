Return-Path: <stable+bounces-257480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCGJADYcG2p3/QgAu9opvQ
	(envelope-from <stable+bounces-257480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:19:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA160F66D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B07133077024
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F734389B;
	Sat, 30 May 2026 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JRSzktEe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11F481DD;
	Sat, 30 May 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161142; cv=none; b=aixuUZmRGcv3305hNZmtWjEVSx8z8yAyNXOqdlPJgx2QmWm3s/8SFees0ttW7hrs6R152PQNFpbvWQKFdyleBykIxRgoWeOKywzdPpVxHNUETiUiwyXyYqMAfK5Mf6Tn1FIs22GGhuOf6/xl44Emrp8iCXFAzXDpueIFENg0B6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161142; c=relaxed/simple;
	bh=JUOYDfX67cykOTwWzMomC5e98Spgb/wy6hhMNZaEPZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shu6VP5PWN6v1GsvvDa4rBSU+GwiwJbou3qwWjhcBuYCpE0vZLZQNpRnGcIXtdj4pXp6EYHDIlf6Bb0eDTj8ZhlCYkNVUuAl2FabVQkW02mVwjUn9bQ08zW9XIggyFNkc8c4MfPxqnHVa2ChnSBJisQsn9rOQjX9I/VVSTXTqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JRSzktEe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898281F00893;
	Sat, 30 May 2026 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161141;
	bh=/VfGUbwT/BalWM8EXZ+ZTUrATvp4w36uvp7Wl0mk12o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JRSzktEelhYS7wYY4q5E11LULEGmoVEWYAg+XGbk2sEopmXamW094sX2feZ+6lziT
	 DhKroS4kBXpKanxyGNJMFrgY+oyJVMwGOqivdLfgxKNkDkifUX4uabjdRUEmzbv3Nn
	 n44pG9Ff6HV+Y2G+AJIFp1Zw8VBiKTr/vMKj7U1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guillaume Gonnet <ggonnet.linux@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 507/969] dm init: ensure device probing has finished in dm-mod.waitfor=
Date: Sat, 30 May 2026 18:00:31 +0200
Message-ID: <20260530160314.332647192@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257480-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8EEA160F66D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Gonnet <ggonnet.linux@gmail.com>

[ Upstream commit 99a2312f69805f4ba92d98a757625e0300a747ab ]

The early_lookup_bdev() function returns successfully when the disk
device is present but not necessarily its partitions. In this situation,
dm_early_create() fails as the partition block device does not exist
yet.

In my case, this phenomenon occurs quite often because the device is
an SD card with slow reading times, on which kernel takes time to
enumerate available partitions.

Fortunately, the underlying device is back to "probing" state while
enumerating partitions. Waiting for all probing to end is enough to fix
this issue.

That's also the reason why this problem never occurs with rootwait=
parameter: the while loop inside wait_for_root() explicitly waits for
probing to be done and then the function calls async_synchronize_full().
These lines were omitted in 035641b, even though the commit says it's
based on the rootwait logic...

Anyway, calling wait_for_device_probe() after our while loop does the
job (it both waits for probing and calls async_synchronize_full).

Fixes: 035641b01e72 ("dm init: add dm-mod.waitfor to wait for asynchronously probed block devices")
Signed-off-by: Guillaume Gonnet <ggonnet.linux@gmail.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index 6e9e73a558740..882dc385cf068 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -302,8 +302,10 @@ static int __init dm_init_init(void)
 		}
 	}
 
-	if (waitfor[0])
+	if (waitfor[0]) {
+		wait_for_device_probe();
 		DMINFO("all devices available");
+	}
 
 	list_for_each_entry(dev, &devices, list) {
 		if (dm_early_create(&dev->dmi, dev->table,
-- 
2.53.0




