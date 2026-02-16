Return-Path: <stable+bounces-216696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMY6CiYhk2kX1wEAu9opvQ
	(envelope-from <stable+bounces-216696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 14:52:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7951C1442E3
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 14:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F4A304D25B
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9572D30EF67;
	Mon, 16 Feb 2026 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WCTFXue3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WCTFXue3"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5C301037
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249812; cv=none; b=ebJ10gKhpPwRHC7+NtFfmhdOLvDWBedePH5L3LZg0GZEcGL0xwg9Jh++yT9gBJum4NtZwS0r9inOEpvYJZ/eN3RAE6KjFN9MtNCKYhfR/vu5evJfB7k7oE6kFR0NXUnBwN9Ga35ARaB/lrYP1+PfPYNgF/zoaT8RRDhcua8bb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249812; c=relaxed/simple;
	bh=EdySwl7INbiW37OAVmD6OlVMBRe3VgamUvWf/zzBXNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEZXy9/ndj61OneGCS28fIBnE8RYM40XX8d+9FigXlo9c8aMUVhMlwVM5bCC9yvvOnJfcI84FN7bjHuy7OT5Gm1jHTB3RpkYJZKISn5juNqfBf1fV0FiRqcxdgHZsRLq1pvR/WUWBjCAHAfo93rXJvcGC0Ou9fVzOgxkL3BqvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WCTFXue3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WCTFXue3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C0C05BD82;
	Mon, 16 Feb 2026 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771249808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJQHaPDeQnQT1UVWU+fCmZAgJxcNcQSnSfiOuzlQq50=;
	b=WCTFXue3smNJAdZnXO5RRzCVYaK9BIzEMYaumyPkOlo4ZZELt6CVKXVKvz4q4cqdmzrjUe
	jLej6DBH7QiSarZzURLnOi3jBCUpRccY7u+uCtDXcIsJCRfJieFgn2O/UZPicJJRxsNlbP
	Tq5oIEf7jyeRXq8y/RFPoEL7FKnrBis=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771249808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJQHaPDeQnQT1UVWU+fCmZAgJxcNcQSnSfiOuzlQq50=;
	b=WCTFXue3smNJAdZnXO5RRzCVYaK9BIzEMYaumyPkOlo4ZZELt6CVKXVKvz4q4cqdmzrjUe
	jLej6DBH7QiSarZzURLnOi3jBCUpRccY7u+uCtDXcIsJCRfJieFgn2O/UZPicJJRxsNlbP
	Tq5oIEf7jyeRXq8y/RFPoEL7FKnrBis=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79F8A3EA64;
	Mon, 16 Feb 2026 13:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iJOQHI8gk2k3BAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 16 Feb 2026 13:50:07 +0000
From: Oliver Neukum <oneukum@suse.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 1/2] hid: hid-pl: handle probe errors
Date: Mon, 16 Feb 2026 14:44:00 +0100
Message-ID: <20260216134958.260648-2-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216134958.260648-1-oneukum@suse.com>
References: <20260216134958.260648-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216696-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7951C1442E3
X-Rspamd-Action: no action

Errors in init must be reported back or we'll
follow a NULL pointer the first time FF is used,
because plff_init() initializes the private member.

V2: resend full series

Fixes: 20eb127906709 ("hid: force feedback driver for PantherLord USB/PS2 2in1 Adapter")
Cc: <stable@vger.kernel.org>
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


