Return-Path: <stable+bounces-222885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJSpNS3rpmnjZgAAu9opvQ
	(envelope-from <stable+bounces-222885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 15:07:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E01291F10F0
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 15:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F4B9302CBFD
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD01536405D;
	Tue,  3 Mar 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dfFGKV/W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dfFGKV/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692D37105D
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546759; cv=none; b=Tvq19zaIXND9t9ozWyIZ8OnptVR0ex0WxHLLOj06upXjMTZktNsTIxey+hiE8REUpd/DjzcMVhk3eGTwrPVfUEYpNkky9JhdxXuochN8bNyiSMXZNUfUaxsdz9qnp5CBY5FzoPJlB4Tva67wmodMz9ieihDugvFEVrdGrQFao+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546759; c=relaxed/simple;
	bh=LQND7J8+2ZBFcRB5Zjr0bxaVWhfHBAfE4LB1WVwVC/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I42VQ4Ce39CG8PdZBQdg3QQA5NjyvC6ThIixx7UlhVUqeOkpFWcmIyETpt8jxL2Z1MlSGEShWqz8TysqxT/khkPmJ2K3sMoaObvieUU5Hu6V5I5l9q/iUwnk6HwsHZV5Py8h+2MgIM48g8vRIebfy/mekQlMA7liKptZipRGIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dfFGKV/W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dfFGKV/W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A21755BE06;
	Tue,  3 Mar 2026 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772546756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kQ1/rdj9rZoOX1Odh9tqQ+jU6G3mgipvCPL1b30fPwY=;
	b=dfFGKV/WvxFAmdnMAJzUpqptWDjQuMTzr4hc9SXeubvfNfTynYUzRGjdHhDgUC4HcftxpM
	Wn8Hp8YN/y0YKM4pv/ZfcTY2xnBH8CbQSdRedEdEIh5gtlZ97muKUKxm5i13dXWr5d8Uke
	JIgvwY0Sa279J2swDimZplmCcWV5m2o=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="dfFGKV/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772546756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kQ1/rdj9rZoOX1Odh9tqQ+jU6G3mgipvCPL1b30fPwY=;
	b=dfFGKV/WvxFAmdnMAJzUpqptWDjQuMTzr4hc9SXeubvfNfTynYUzRGjdHhDgUC4HcftxpM
	Wn8Hp8YN/y0YKM4pv/ZfcTY2xnBH8CbQSdRedEdEIh5gtlZ97muKUKxm5i13dXWr5d8Uke
	JIgvwY0Sa279J2swDimZplmCcWV5m2o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AE1F3EA69;
	Tue,  3 Mar 2026 14:05:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cwPOIMTqpmlMdwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:05:56 +0000
From: Oliver Neukum <oneukum@suse.com>
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] HID: hid-pl: handle probe errors
Date: Tue,  3 Mar 2026 15:05:31 +0100
Message-ID: <20260303140548.1313133-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: E01291F10F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222885-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Commit 3756a272d2cf356d2203da8474d173257f5f8521 upstream.

Errors in init must be reported back or we'll
follow a NULL pointer the first time FF is used.

Fixes: 20eb127906709 ("hid: force feedback driver for PantherLord USB/PS2 2in1 Adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/hid/hid-pl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index 3c8827081dea..dc11d5322fc0 100644
--- a/drivers/hid/hid-pl.c
+++ b/drivers/hid/hid-pl.c
@@ -194,9 +194,14 @@ static int pl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err;
 	}
 
-	plff_init(hdev);
+	ret = plff_init(hdev);
+	if (ret)
+		goto stop;
 
 	return 0;
+
+stop:
+	hid_hw_stop(hdev);
 err:
 	return ret;
 }
-- 
2.53.0


