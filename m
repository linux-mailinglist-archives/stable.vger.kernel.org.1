Return-Path: <stable+bounces-214849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHQCE6wyiGnTkwQAu9opvQ
	(envelope-from <stable+bounces-214849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 07:52:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99887108097
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 07:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EABD3015736
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 06:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A01332EB5;
	Sun,  8 Feb 2026 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCA/B9In"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514F2F0C70
	for <stable@vger.kernel.org>; Sun,  8 Feb 2026 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770533537; cv=none; b=p4dxPcj67K76Rhg1kIT3qn1+m+RyHnzHMTu+BF6RrIsXFexVM1SkG0eh1L0qqU5WPjUIg1PQYqDYa999QTPZ0aMAJIbPtjqrc2kUPLrob0vknbH73JNyF0gGlCGxaW/CTSEW0joobdoCGuZvmMfyDTFUkIcUI0RNEYc3rOPZ2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770533537; c=relaxed/simple;
	bh=F9bNjK+pzEpZsGayI6GYJIczHINzrgN7fQGyUMcEuz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEX4kPJiHnCAvhQav5VStvoJyNdYy4VYaoSt/30MUYt6V/eqqpFmnnnALCp8I+NoE95o18LRYMgQbA50vO+/lwqig5Hy6BAEkvxxcrS0FfQxfXkCu1atHqeZDNz2s8IhKVfHmVOh1R9jAB/rH73a5EBxt5ogBshkTtQU5Ha3FZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCA/B9In; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4b77adso3754295c88.1
        for <stable@vger.kernel.org>; Sat, 07 Feb 2026 22:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770533536; x=1771138336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS/b5/sslw48AcYmgWpe60xwd/fLzbiXHPdcLj7bmSM=;
        b=iCA/B9InMxfKdSbUllM0X6EXujqq3zmgzcOVdFQrsoORXDGKmW05xy+tGlXAR9ysqY
         vf9ql8vMNnp5dJP/tx8rQcmgwUqGiN6saNGHLfnavdr/uDtZR4i3P1rx68iDOk/viDGC
         b0nwIJ39nOyLHV4wYNyQG5F1QfULnxdA0wnJl/0CGZiux1aRL2VfR+OH4FjUcPNturhp
         8bX+nYIqPTOYBly9ZowxE2VbZBFgrsDg7XDNMtyIHy611FIoKiXRqt7kYvjklcBnuA7m
         umunMZlVGO+QTT+BuYcHfjtRMVRYmcyPFp5OeGOm65q/enfKoGwB99GwUt8oBUuMWpTv
         tocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770533536; x=1771138336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS/b5/sslw48AcYmgWpe60xwd/fLzbiXHPdcLj7bmSM=;
        b=SHfuGedcHiYzuu9VP1GbRIIKOZFI6xmHPSO3uQFxLd4NOQzaygN60u6+OHLTcw/yLS
         PGN0YQjDDNSTdtn1PJr1VzPg0VLlgPLNPfhYkOg6/XtQ4ar7Rq9LURw1KRpI2IcWbPjH
         rojX6UrOkKRTw0hdnpPKYj56Y39roHBmU3OitAgOrwTiE0BrJtgpP1tnhPTcde545F1k
         7DjEcUw/PbZP/VITObn8iPlvL5Dj5RUVHrzZnBZ+MN2eSBPHuFuxh2wOHDgWvAU3ykJd
         dVTYJRo7UG+IF+1Z2xv05xEiSrg88Mse6NCy7+LVzNzXDLh884/p2CwYOGf9sFvuOQKC
         vj8A==
X-Forwarded-Encrypted: i=1; AJvYcCWnbAh2b5ruZ4HprzVfRU+dXjbtRSTUzM7jpwNWWycbHvknj/Ne5gyB+c9zmNmQ6hAzE6jQk7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxspNGnw6HTAZ4+p1RLU3q8J1UBvFcf3NrdcuKwCsSLQsuUBPLp
	zo2MJ5wk1VfS/Kwo0Ta51hNcjfROc4xtkxXKF9PZj2QohiZbsdnuR0He
X-Gm-Gg: AZuq6aJ8zBzPnsXbElDwTFxilkPZh4rxSf28Ztp1hA/ls3rU4/a1efhsA4O37x8AleH
	ISS2804NisRaz/n5fZZKLU2FtmSj7hMEuxKOsD7hlrThmB1CX9+w6chMoWRLc5fRy2+/YLUCo97
	MFsXNVVMm1fLWYQg298GIzckgw+Q+6Vw3Do33omSnHUBP90rA+6GiAwf6G+KprzJUjBhE0UwK0Q
	7K3crk682invIa7vv373mjKLZz55fPvlyog3/cz5v9TqA07g1bCNuv89e6aSv0iAYOR2CTK6V/l
	Y0Z8HGgUxN9TuYr2L96q4PltlyiU2Y1nI0mA+aPfh+J7lOtyAFRgj/aouTONeTZttxuD7sPSTWZ
	MwBENLMcmaw0dcls4LCZ0bXI5zqp/HBvZHfbJwbT8KvRBTAJ+LdPZIMB5tRvKnLnt3ePab+1DzH
	7HkTN/molj7gFvc50xkII5R6ZdZcGW5iwcr37/pc7Up/ypT/fbd0d/pCCio7Dn9XkVPjIY
X-Received: by 2002:a05:7022:60a3:b0:11d:f464:38b3 with SMTP id a92af1059eb24-12703f72281mr3368964c88.2.1770533536260;
        Sat, 07 Feb 2026 22:52:16 -0800 (PST)
Received: from binary.. ([177.39.58.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e5460sm5673025c88.6.2026.02.07.22.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 22:52:15 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
Date: Sun,  8 Feb 2026 06:49:49 +0000
Message-ID: <20260208064951.41392-2-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208064951.41392-1-maiquelpaiva@gmail.com>
References: <20260208064951.41392-1-maiquelpaiva@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,holtmann.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-214849-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maiquelpaiva@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99887108097
X-Rspamd-Action: no action

Add a check for the user-provided length in mgmt_mesh_add() against
the size of the param buffer. This prevents a heap buffer overflow
if the user provides a length larger than the destination buffer.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index aa7b5585cb26..bdce52363332 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -413,6 +413,9 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
+	if (len > sizeof(mesh_tx->param))
+			return NULL;
+
 	mesh_tx = kzalloc(sizeof(*mesh_tx), GFP_KERNEL);
 	if (!mesh_tx)
 		return NULL;
-- 
2.43.0


