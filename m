Return-Path: <stable+bounces-235884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Dt2GRlo3GnoQQkAu9opvQ
	(envelope-from <stable+bounces-235884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:50:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34693E7077
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE660300D6AA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 03:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319EB37C910;
	Mon, 13 Apr 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW3XHypW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7E2D592C
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052231; cv=none; b=jSGdtiHs06vpgPD1sCTxWPW3YO8+hdYZrw2JZBxy8Xkqpl5IhrCGc7BmkGkgb0VbMoZ5Y50jK1aTDvtmsymOb8ohg/8ljr5cxaeXKanLf5rNPTs6b2gWMKpGLGnfsH2Z9rev0QuSS6RRRFv+8fcRhj5Bikqtx4VJVbrhS3unbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052231; c=relaxed/simple;
	bh=G+z3juLYTTGNnge1Q7+l118XoMP53BlwRMWS2rp4EwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZnyJqpEBdqs3fyjiB4kskxwqK69ehXax8dZjUwgskl8jeIzrbOc4SefaPXIL3oLsTtqrcwazrS2PJIWZmoEwN56bEJHFjb8DR6PcS7pgsMMgvJJ4Wbr9f3zjDiPcRdpMJnhFwR1xbbQ/Ah0cFmrUS8eqZRQdiOenIJAMvuMIJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW3XHypW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so3331127a91.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 20:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776052229; x=1776657029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLYrZW1/bb0BohbqxF1IHAXhdfS6eaDzFERz8UW0w5s=;
        b=lW3XHypWwk5qpf0yKb3Gq68AQDZ80/kx9uMnJZfPlwnrGiAyzD6FUTk8riQ51UEVL0
         8AxZW+fd0/eiM0t+TeqWX9F4o78R3yHikqr0lv2AZae7/DeZD6yHBNgoZFrMZIONRoS1
         z6uaWCj1B+CINvxF97eukhHHFGnln6SjuXtR04Z9Ik25yqTTyLIrhFwf4fH4Co5+z5+n
         DSoPgAgs1m1tDZGxcJFiOU93ufZ0mCpSyVfMTSPkb+/qmdG4N1gKscRrra5N7DxByVb6
         iGeqzejFN7Ru8cjCUqn75qhCk4GL1cVQ1N+fqZaV5Fi7quAOm9+Ccq2+r8uPDA8YHZFb
         tbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776052229; x=1776657029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLYrZW1/bb0BohbqxF1IHAXhdfS6eaDzFERz8UW0w5s=;
        b=hRJo2voP+Uh+EQRgfNBAzVkzS1pPSHSSUgbzeumN+qmWIjw1uwWW1fy1+3nMofhC0M
         nYgMesprsk5+3D4xJsYwAtvcM1fTzFPomQom1+qURQHOAqybfY2CUH8DWT1M9h6x5u0x
         a9L1OHIfGnreg2nH6d2YnAQ0UGaIw23u1p/k3oxvfqLt9iG7vPe3ooJzZ6BeeEIv5xT2
         eCEMOZtxhgEqOkHZO8et3Qa58eGWkftu7ocn6A6W4ZYTodLIrHB9r4BzF7mV6qXUa81B
         n/t9l+BcZG1C8/dMcRcsiKny8XIWABMivX66DlS1zzeHg40C7HyL96chlxD4dPttsm1C
         OPLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EVgdfN/Ag/2Lhx3kZ/+91t7KIdo4OF+Rd0LLdXPIEmVBBV2AZpCnrhBvJmyP1ElphplbU04I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBUjivz1UUYTB9zba899EX0U3RgEirqOzEb7IJuZIyyW6EXAw
	A7lM76SkfVxBqf2AUx9J5cwcVlJqx+RyBun0aUj1IY0DhTINVGWgQ/l3
X-Gm-Gg: AeBDiet6BpZKe2sOsv3XPJW8Q+Qj9r1VBOnda5q+nRbPQP2Tl1TbTo3R8AzKS3apA8x
	mB7p7FCd/eU9dS2fTej4LBk6cUAEBRzmSwu490ZTfKv3MoCZty/MQPrtnrAclw1KCcoDkTUpMDT
	/rIw1rNSIL3fx3S+NqkxQd5AciGyG43mfV1TyCljCROCPUCDP+qGUM7FWzOKXdVqKmcdwYJZHk8
	7NQfaTdulw8bqcNNElBuhUg0OjjvQsWBDxpVg68NFd7vRNXnBc7IfYVn+cRTVX5Qj3aurBs2Tdt
	rw/vd8Nij4Y8jXuvVRskVY4eTTDg4aqlgzE/Tsuvkp8MLEO9onyaBxbV6bLIhJRLdQZym/AWk85
	1NfILQ6ftbm9X12vtKVGNvhHux8bywi+bdtOF+eRWigRuFXSGLgXUZd+G6nVNKcX5UPj0JG6/WJ
	0LaI+n1q8p678ePINqESadj/Z9z6unQmFs/EmC5SfJvMoNwYrbAPYCMvZkgT9kpWLNdcQtn8TFM
	Q==
X-Received: by 2002:a17:90b:4e85:b0:35b:a8cf:7960 with SMTP id 98e67ed59e1d1-35e42769f93mr11744410a91.3.1776052229174;
        Sun, 12 Apr 2026 20:50:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:6580:9cc0:8700:96ae:8c3d:9c98:97d9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4e2dbf47sm7030644a91.0.2026.04.12.20.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 20:50:28 -0700 (PDT)
From: Berk Cem Goksel <berkcgoksel@gmail.com>
To: zonque@gmail.com,
	tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreyknvl@gmail.com,
	stable@vger.kernel.org,
	Berk Cem Goksel <berkcgoksel@gmail.com>
Subject: [PATCH v2 1/2] ALSA: caiaq: fix use-after-free and double-free in setup_card()
Date: Mon, 13 Apr 2026 06:49:40 +0300
Message-Id: <20260413034941.1131465-2-berkcgoksel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413034941.1131465-1-berkcgoksel@gmail.com>
References: <20260413034941.1131465-1-berkcgoksel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235884-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,perex.cz];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berkcgoksel@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C34693E7077
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When snd_card_register() fails in setup_card(), snd_card_free() is
called on the card, but there is no return statement afterwards.
Execution falls through to snd_usb_caiaq_control_init(cdev), which
dereferences members of the just-freed card, resulting in a
use-after-free.

setup_card() is void and init_card() still returns 0 on this path,
so snd_probe() leaves the freed card pointer in the USB interface's
private data via usb_set_intfdata(). When the device is later
disconnected, snd_usb_caiaq_disconnect() calls
snd_card_free_when_closed() on that same pointer, producing a
double-free and slab corruption.

Add the missing return so a failed snd_card_register() cleanly
aborts setup without touching freed memory.

The issue is reachable by any caiaq-compatible USB device whose
descriptors cause snd_card_register() to fail. It was reproduced
with raw-gadget + dummy_hcd on 7.0.0-rc5 (arm64, KASAN).

Fixes: 8e3cd08ed8e5 ("[ALSA] caiaq - add control API and more input features")
Cc: stable@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>
---
v2:
 - Correct "Fixes:" tag

 sound/usb/caiaq/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 3a71bab8a477..d52f3b9a2bac 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -369,6 +369,7 @@ static void setup_card(struct snd_usb_caiaqdev *cdev)
 	if (ret < 0) {
 		dev_err(dev, "snd_card_register() returned %d\n", ret);
 		snd_card_free(cdev->chip.card);
+		return;
 	}
 
 	ret = snd_usb_caiaq_control_init(cdev);
-- 
2.34.1


