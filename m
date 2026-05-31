Return-Path: <stable+bounces-259385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH9zCKW/HGpgSAkAu9opvQ
	(envelope-from <stable+bounces-259385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 01:09:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5FE618399
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 01:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A54DD303F05C
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 23:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C591360EE1;
	Sun, 31 May 2026 23:08:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9735B646;
	Sun, 31 May 2026 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268897; cv=none; b=fe+6PZODyW1jYMip7mQ6+9fPDXJ2hpqsO4IgDb0zHU6kZjA4FmmVWnmeBl79sk/vNiDcJlK5n1rHVuoDYKJPoBeC5mK9iUpaNi9tCf9vbH/vHIYf4PiFxkF1gMG2z8SNK3j5ZUEPL8hq7zUd8Rh7fDDQu+k6TKc01qQjlWKmplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268897; c=relaxed/simple;
	bh=nf71MnN7TLOen3jIbWLstVoH/wsOLzifDRN9SbIG5qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNwz+N83R4elwYGawmldIVSgASNvxCv6EWo0VyR/FBiqb7p3gwADUX/jus0bphrDDFBqsBAjmACHubONJqk+QZm9tPdymKMREAjpY1PvQ9tb3wd9ZjrMiBfbo8u3F467HDggAgKI7pxzfEtetJS48NaCdzpKLH3EwRrC1Py/iO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 8C2F2A4922;
	Mon,  1 Jun 2026 01:08:07 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2yRe5eissX9z; Mon,  1 Jun 2026 01:08:07 +0200 (CEST)
Received: from end (aamiens-653-1-40-48.w83-192.abo.wanadoo.fr [83.192.199.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 6EE35A73D9;
	Mon,  1 Jun 2026 01:08:06 +0200 (CEST)
Received: from samy by end with local (Exim 4.99.3)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1wTpGH-000000014LA-3IF8;
	Mon, 01 Jun 2026 01:08:05 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: gregkh@linuxfoundation.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	linux-kernel@vger.kernel.org,
	w.d.hubbs@gmail.com,
	kirk@reisers.ca,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	stable@vger.kernel.org
Subject: [PATCH 15/15] accessibility: speakup: unregister tty ldisc on later init failures
Date: Mon,  1 Jun 2026 01:08:04 +0200
Message-ID: <20260531230804.254962-16-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531230804.254962-1-samuel.thibault@ens-lyon.org>
References: <20260531230804.254962-1-samuel.thibault@ens-lyon.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259385-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[ens-lyon.org];
	FREEMAIL_CC(0.00)[isrc.iscas.ac.cn,vger.kernel.org,gmail.com,reisers.ca,ens-lyon.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.thibault@ens-lyon.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7A5FE618399
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

The ldisc registration is intentionally non-fatal, since some synth
drivers do not use tty/ldisc.  However, once speakup_init() continues
past the registration point and later fails, the init unwind path should
mirror speakup_exit() and call spk_ttyio_unregister_ldisc().

Add the missing unregister call to the error path after synth_release(),
matching the normal module exit cleanup order.

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Fixes: e23a9b439ce9 ("staging: speakup: safely register and unregister ldisc")
Cc: stable@vger.kernel.org
---
 drivers/accessibility/speakup/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 0962741a2ca2..e9b7c2761f6f 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -2444,6 +2444,7 @@ static int __init speakup_init(void)
 	mutex_lock(&spk_mutex);
 	synth_release();
 	mutex_unlock(&spk_mutex);
+	spk_ttyio_unregister_ldisc();
 	speakup_kobj_exit();
 
 error_kobjects:
-- 
2.47.3


