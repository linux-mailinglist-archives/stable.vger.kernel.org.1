Return-Path: <stable+bounces-253732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMgqOGomEGoYUQYAu9opvQ
	(envelope-from <stable+bounces-253732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:48:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0622E5B170B
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED439300CFF2
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD603624B7;
	Fri, 22 May 2026 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B7+4qIOH"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903AD3B83F8
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443128; cv=none; b=lzbP/n8ULU8xnRmkJVYx5K72MauDYwvL44JlVQ8B0ZzGMbJfKHh7QBdiCw72NVi5mZFeJGnMhxBUDQfy2TlDO9eDp7Rj3jO2f7z2JbAoGTaUSlFhHOQnoCIneTOGewst108/78Yw9Y5jKFhqKbH06RjnWowMz26gSDdtz4RfRxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443128; c=relaxed/simple;
	bh=DfWpdJcRaZ53yrjDsoyNnfVJq6RrxKAt61FGJUKZ72E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhTy9cpGtT6yqdV33epyLdzJRxNu0Hhd3M2cgv3R/5oZ089RSj2zILscmYJDgQrQXeyl/1iF6fvJS9J6MPCYn3TrJu+IKK2RMZLRQ1DO6GlNDt3gXUIhHI5+zvo6EqpN4W3wjryung7jwm5FLa2Ht/uY72ve/tTcYoQhDNzQfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B7+4qIOH; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779443124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g5agdTFGEfWZbLCwQ4kJJjc5gZ15gxHIdT5eE3Z8E90=;
	b=B7+4qIOHzP+1/A75WlMe+Zkio3GKTzFX6fm6Ygv7/RAqNAh/HS1aOJFUL7gU5wFaGQzKFn
	Te8XsC2TH70tqTIQty8Vof9T/HD5o6bo1pCM+dK9jrrSi69Tj0Cfvrg2sRGdYOj8OMjL71
	E71mYDXqFAFpyvY1qRweJatSH80WP1w=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Harald Hoyer <harald@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: fix event_size output in tpm1_binary_bios_measurements_show
Date: Fri, 22 May 2026 11:44:38 +0200
Message-ID: <20260522094440.583766-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855; i=thorsten.blum@linux.dev; h=from:subject; bh=DfWpdJcRaZ53yrjDsoyNnfVJq6RrxKAt61FGJUKZ72E=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkCqh06e55KKjhuaJCRWXhN1bmd60VV4+lL15a/0LeVy GIK+362o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACYy9x0jw/Hc74d1dR9nabhs e+GYmuGpIJ3z6Yb4+79H523Lnxz+R52RYWX1lUdTL+wxDnnBcunio83nr4TsmCZamxBQ/OegYKm cCgMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,ziepe.ca,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-253732-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0622E5B170B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
split the output to write the endian-converted event header first and
then the variable-length event data.

However, the split was at sizeof(struct tcpa_event) - 1, even though
event_data was a zero-length array, and later a flexible array member,
both of which already excluded the event data.

Therefore, the current code writes the first three bytes of event_size
from the endian-converted header and then the last byte from the raw
header, which can emit a corrupted event_size on PPC64, where
do_endian_conversion() maps to be32_to_cpu().

Split one byte later to write the full endian-converted header first,
followed by the variable-length event->event_data.

Fixes: 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Minimal fix without using seq_write()
- v1: https://lore.kernel.org/lkml/20260521093639.162095-3-thorsten.blum@linux.dev/
---
 drivers/char/tpm/eventlog/tpm1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index e7913b2853d5..0397e3361020 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -236,12 +236,12 @@ static int tpm1_binary_bios_measurements_show(struct seq_file *m, void *v)
 
 	temp_ptr = (char *) &temp_event;
 
-	for (i = 0; i < (sizeof(struct tcpa_event) - 1) ; i++)
+	for (i = 0; i < sizeof(struct tcpa_event); i++)
 		seq_putc(m, temp_ptr[i]);
 
 	temp_ptr = (char *) v;
 
-	for (i = (sizeof(struct tcpa_event) - 1);
+	for (i = sizeof(struct tcpa_event);
 	     i < (sizeof(struct tcpa_event) + temp_event.event_size); i++)
 		seq_putc(m, temp_ptr[i]);
 

