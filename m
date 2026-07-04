Return-Path: <stable+bounces-271924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id emu2Bs+iSGqxsAAAu9opvQ
	(envelope-from <stable+bounces-271924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 08:06:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70346706CE6
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 08:06:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dBoBvSia;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271924-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271924-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5CB9301DE30
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 06:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3238D414;
	Sat,  4 Jul 2026 06:01:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847F38D3F7
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 06:01:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144882; cv=none; b=fvBoGv2fmDeX+E9Z8AivRD4/YGojjyb5jJ+ewxp+RhbuEphpnocv6nl5GJ3/jF/ovmJpPhZnr675uoqgIdpm5ChBK2vehd/2Wld/EDLjn+ibLatu8a4DzPvoF425mIghjExGHxG5/cSoR/frvtH4tQJjVglTKdSAdXEhPJomjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144882; c=relaxed/simple;
	bh=U7meGQ/yqO5nue3fmIDavhUgJX4jlw+ACCtfxt6efyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UVJBx7IQvK/jBxCoBmp07eEAltFsSy2/geLS3PiXhkQVfkuWLbyol//kVUZ8ZzzEv5NsdSxzpROe4BTN5vy00lM3+nry7RISp9ZvK+tdLpaLONyuy6J1W2NJDFlxuPnYFtblYgl9gdKU5mdJtiM7rAmOiBy/q3L3Tnu8xgPMd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBoBvSia; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so855548a91.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144881; x=1783749681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgeg1hy/5eCNX45AyPB+pHlq+bl3Mkeu4yKxcFxgJUE=;
        b=dBoBvSiazvtcI9BjWQD2C4QFZOyw4pnWYoCX4Ba28rN/pBcIospsB7FZCGKb6SjppR
         Hr2tWvF7L1JVElFYmWIfEkIx+V4l5Wm0IrYAsTO70wRa0GrK3Spdd1l1FT5udno2pv2p
         H9fNPtkEitDnFedAAUnVXzS3hR5mxImmMR7AITNW+fnZdfscVWkPha7OWz8wSLFBXzfG
         x81uhEvEm8K2k3VLltddq4s/2n2tKmIJVukrsSRl7BGzUaOAbT6baUkJziwwU9K9PsFT
         LIZAVtq8TBD4hL5LhqHPM80c52eHeEdvirtCd692moqsQkUwLLQLQL1Vb6SjIEQ4K9GK
         ChTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144881; x=1783749681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgeg1hy/5eCNX45AyPB+pHlq+bl3Mkeu4yKxcFxgJUE=;
        b=UUx/qowDIJ/cvWUvrEmO3W0osoD8ahsxzR7UHanj95zoW3PkSBq14iRPmrLkM12EtG
         Sp6RIMuHm7W3HZdzK7J6ZmPQSjWJgdkuuZmikRxVEgIs1tq09AThy9JN24LhHI6ORup/
         ZzUts6sA9AyM2jU87C9ArOSHwc2LQxpjrxpDBRkcMj/fznFS4/SFH94alnEpCf4CJx4c
         QC7GMqHQvvedTMHktNb52TaNFu0lwxyLsAZxA5fx5bLL016dPD4EJvcfPqf0e+6LbMB6
         fiIPQ9HZCmlpEJQOvjk4mJvWUBl8XrFk+MAQmX1F8tmKiXXQoTatBwAauhgG2VDsUC20
         /aIw==
X-Forwarded-Encrypted: i=1; AHgh+RrPH8aPcGiWMHoYo+MWXNfWoNZUYRCkKuAhHipjyYeWK83xYhnKEof8IKMBYLry+IxwpB8x/YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBN4g9cwq9o93eTd25k8HNAdYVU6wSzWxYPCKDF2Rxk0RGLlpr
	2FmMkCF+fxx7kpQqbZAftp/DI8WteZpj7VVq7SvxnUaKesMDGdV1MdM3
X-Gm-Gg: AfdE7cnVLPklXWFJDmEMQIkRqAglU+ENW7aO4Btbb4roiFV78RR/O25pW9sRIYtYk23
	LSLWniCHSZiN+9RMV/CvsNOw5PCN8PBxxjVgsYGSG4Xwlh3bdaZ038sRj40nQZiPo5MYAru8qsp
	qwdaQcqmBDGNe+gf4bDtRN3cb00xDC6XmF/6jf8E1YI4XlbmxvDtrGGtwpkRYvKb9M2LxRyt5V/
	0iSfzSYg7dRa3+cwmuwWDec3EaErqx4lV/tmyX5XzvcP09Q6uo8GKlTV6YZNtj3LE0TS4mp8/N/
	2bJAsCxnlmv35yhUsooTeXugb75YuAMQc1b2U1mqeD43ijJ+ieiJCwk6JbT520DMzb5NtZPLEt3
	RlD7lem7YxU4/ocULJJQ7b4LL9NC+6BF1r7rnCVcoCMHuvActaHUACvU5jcDq5sjASLZvguD85r
	L18tx6+WbLng1Vz2r7gAOuXXcRHk2wBS2DS1TAfUU/Av6BZqDi+nX93MqR3vuCV/TrW+2jUUW3T
	t8=
X-Received: by 2002:a17:90b:5251:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-38112063c22mr7862238a91.3.1783144880763;
        Fri, 03 Jul 2026 23:01:20 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm25081378eec.11.2026.07.03.23.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:01:19 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH 1/3] Input: mms114 - fix multi-touch slot corruption
Date: Fri,  3 Jul 2026 23:01:12 -0700
Message-ID: <20260704060115.353049-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-input@vger.kernel.org,m:hexlabsecurity@proton.me,m:linusw@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271924-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70346706CE6

If the touchscreen controller reports a touch ID of 0, the driver
calculates the slot ID as touch->id - 1, which underflows to UINT_MAX.
This is passed to input_mt_slot() as -1.

Since the input core ignores negative slot values, the active slot remains
unchanged. The driver then reports the touch coordinates for the previously
active slot, corrupting its state.

Fix this by rejecting touch reports with ID 0.

Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 006dded17eb8..23e0283bc6b8 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -248,7 +248,7 @@ static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *tou
 	unsigned int x;
 	unsigned int y;
 
-	if (touch->id > MMS114_MAX_TOUCH) {
+	if (touch->id == 0 || touch->id > MMS114_MAX_TOUCH) {
 		dev_err(&client->dev, "Wrong touch id (%d)\n", touch->id);
 		return;
 	}
-- 
2.55.0.rc0.799.gd6f94ed593-goog


