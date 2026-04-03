Return-Path: <stable+bounces-233134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCraFN8Zz2nDswYAu9opvQ
	(envelope-from <stable+bounces-233134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 03:37:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B6F39018D
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 03:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD33730565C1
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 01:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15642346AC5;
	Fri,  3 Apr 2026 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-sg.20251104.gappssmtp.com header.i=@starlabs-sg.20251104.gappssmtp.com header.b="beXRCr7V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95230345731
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180224; cv=none; b=C2eoyeyzKwhmn4gLnlITJeQKAaaLbwpRgLw86FetToVY323IKHHMUQ4GMQ60TuzQCU0ePmmLBGKCZvnN/cnpd9xqvdlAYeDxx11veNFtpELgfooAbVQjlBPwXP51X4Lclhd0lLpLnBfS6bf5YfOGgeE36DiVjhUbR7bmMOM7GdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180224; c=relaxed/simple;
	bh=IYFkw8oljp4nyG98JJ4c07/8WieLbCh+uS+oBqqBHso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMa6PzG9bs/GUh83jc0lgKf4K+mMw+FdVq3eZDMlol55yjnOXQP3ZCAb83E7JzNzrYeaOzYhwJbHPjqWVcY75euj1CQ+MYUA2N8+yhT1vcTy45ESfifMgW6DD5yXiI0CEqdEgH+5Knp/90t1AgvDDejQGD/Z14fNweUJMaQUMlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg; spf=pass smtp.mailfrom=starlabs.sg; dkim=pass (2048-bit key) header.d=starlabs-sg.20251104.gappssmtp.com header.i=@starlabs-sg.20251104.gappssmtp.com header.b=beXRCr7V; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.sg
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82cf83bf375so631429b3a.0
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 18:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20251104.gappssmtp.com; s=20251104; t=1775180223; x=1775785023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94FIw1CabjzT89bVE5z8v3hqiWvqsDssKUWaYlLNlCU=;
        b=beXRCr7VTPWq2VHPZLMiLsVtYQjgRKcdP7vqaeQNyJOgcsbpHJ8cyrAf9Dtk4WLRIS
         APgcgPcJgXwLuwRNURMV0XMMQcxDCQc1j39T3+S+aM712zXBF213sic/yZFkSjjuSoII
         Q/wU2X60Css32ypwqRxCeHYd+PnvnezMJA10pRuA8mbg1mbp7/ff++Sgo9kaXlYltZqT
         l8c/5DyO5SG9lMDyr7qhtadBe38frGe/bZUHX5osNS8iQVRacZslCdifRLwL5B9bNBHQ
         1cnJRu+1/fr8XtmONWssirLEUCfQSrSq035KCevuMhQmNHzYWAFaYFFuLy7VLytCp1ey
         2l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775180223; x=1775785023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94FIw1CabjzT89bVE5z8v3hqiWvqsDssKUWaYlLNlCU=;
        b=qPLDQI+hHsMYQSpSCejeDxhq7gnd02QODQueh9w8C//03OjpoTtkoDiF2MHdbSphel
         LxWwo/TYN7s5xoysvWElzulguaMCKCRMAhHwBRKkuTmTVh8u5mkUKX0FTaOwVFoxVwV7
         XAlZn76z0HqAOafSr8FQXzlVv9je7wYfyYakcWe26G4FS9PohyAhgQh/L/9l5TxaYHIl
         JYP5rTZH2jvlJaDWquVYQgpLYQcrvDLCH1aZzOAfGsGTtV5sAfMkeYULk6x9IawMwgHG
         tiDN1iBHk/by6iDX5OCPk3O7EBFyM2OTRCoq6ti8s68XTb6hr/PYFCZVKL2yL9diUo8v
         qRPA==
X-Forwarded-Encrypted: i=1; AJvYcCWWI4X+j8CbSODA+Ii4F+gnWO83eQXVeQP44P96T1KUoT6XLU5LRtOvHZ1sgqmcLHGvH270b0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwtrGjamNEwNLiV8yB/u03/pQTuaQG8gE4mf/BoYBOnYb3HOY
	a47m37+lBCSfaM+mz02cmyoDH73haSJ/O25DEBvkv3lF1pfxRJMJa3+QlhQDjBHRCQ==
X-Gm-Gg: ATEYQzwniZ0xoJam5D7/HV9R/Sg4P0OwPGWyCFql01Qib0OEayLpxb3r0CS7dj2wCAO
	guBzKBfYjZLZUvwhajeetzKe7hdVOQ0x/G0ji1PI/+EeS3L8Wp9ho9whRlHHfpUw15aS0J30uRH
	Fc92I/NlyKfCsTQCFgsTuzTqs8rcooyoWeFQLRmhjJmtuK4iJMuqeYdtY6BERPWZqVHZhylaPil
	nLl8mUxKgjwNtwjgfw+eMMnMoGLJ4yHPuU9Qndop0j1/OFCyOZZSR7ZJ/b8G8nXCNgSAg+8v8tg
	daTsjEQMhJzfCvEsXLosKbRPisvOZsSg/L9Dj/4hcgZFGuVZ53jiZ9LJjw+13SY2VgDaj02bs8f
	icChBD1DKTJneoFE6UYZwbL3GFCKXoAsDlApvJAoeG8QVteKP+n4ntxoHpU0CWE5oA3Z5iYcdoU
	N8lnO+fQwmC43C4ZS7zzZ0I5bL+tTiQIy344Y=
X-Received: by 2002:a05:6a00:124e:b0:81f:5ec1:8bcd with SMTP id d2e1a72fcca58-82d0da59d14mr1143380b3a.20.1775180222995;
        Thu, 02 Apr 2026 18:37:02 -0700 (PDT)
Received: from localhost.localdomain ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9ba21sm6042331b3a.51.2026.04.02.18.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 18:37:02 -0700 (PDT)
From: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	info@starlabs.sg,
	Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>,
	stable@vger.kernel.org
Subject: [PATCH] net/tls: fix use-after-free in -EBUSY error path of tls_do_encryption
Date: Fri,  3 Apr 2026 09:36:17 +0800
Message-ID: <20260403013617.2838875-1-ramdhan@starlabs.sg>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[starlabs-sg.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,gmail.com,starlabs.sg,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[starlabs.sg];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233134-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[starlabs-sg.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ramdhan@starlabs.sg,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 10B6F39018D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The -EBUSY handling in tls_do_encryption(), introduced by commit
859054147318 ("net: tls: handle backlogging of crypto requests"), has
a use-after-free due to double cleanup of encrypt_pending and the
scatterlist entry.

When crypto_aead_encrypt() returns -EBUSY, the request is enqueued to
the cryptd backlog and the async callback tls_encrypt_done() will be
invoked upon completion. That callback unconditionally restores the
scatterlist entry (sge->offset, sge->length) and decrements
ctx->encrypt_pending. However, if tls_encrypt_async_wait() returns an
error, the synchronous error path in tls_do_encryption() performs the
same cleanup again, double-decrementing encrypt_pending and
double-restoring the scatterlist.

The double-decrement corrupts the encrypt_pending sentinel (initialized
to 1), making tls_encrypt_async_wait() permanently skip the wait for
pending async callbacks. A subsequent sendmsg can then free the
tls_rec via bpf_exec_tx_verdict() while a cryptd callback is still
pending, resulting in a use-after-free when the callback fires on the
freed record.

Fix this by skipping the synchronous cleanup when the -EBUSY async
wait returns an error, since the callback has already handled
encrypt_pending and sge restoration.

Fixes: 859054147318 ("net: tls: handle backlogging of crypto requests")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
---
 net/tls/tls_sw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -584,6 +584,16 @@ static int tls_do_encryption(struct sock *sk,
 	if (rc == -EBUSY) {
 		rc = tls_encrypt_async_wait(ctx);
 		rc = rc ?: -EINPROGRESS;
+		/*
+		 * The async callback tls_encrypt_done() has already
+		 * decremented encrypt_pending and restored the sge on
+		 * both success and error. Skip the synchronous cleanup
+		 * below on error, just remove the record and return.
+		 */
+		if (rc != -EINPROGRESS) {
+			list_del(&rec->list);
+			return rc;
+		}
 	}
 	if (!rc || rc != -EINPROGRESS) {
 		atomic_dec(&ctx->encrypt_pending);
--
2.43.0

