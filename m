Return-Path: <stable+bounces-254047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DQCMLw7E2qa9QYAu9opvQ
	(envelope-from <stable+bounces-254047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 19:56:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 294775C3538
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 572CE3009B3B
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CBF301004;
	Sun, 24 May 2026 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5SSa3iB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E882F60B2
	for <stable@vger.kernel.org>; Sun, 24 May 2026 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779645364; cv=none; b=uwYmq1tWt1i9ummyCpOm0EFWVD3ud80/SM16/w4XpeCB5177rsgqV8V8gNImw5EZj783aeWHZjueCWfwx5Gq7beqtmXWsHE1zU/qB8+sCP67wScsRK+aoAbcuqlGd89u1GYrlgDKIcNjbeGLx3lgaUOAIHW7Tcl+cKGBfh9lbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779645364; c=relaxed/simple;
	bh=JepkO0OxBLNbdzM+sY7O9zfCw+GPn0XpgWDyblYtgmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LisJhQdfh3BOlE+k/z4zBykqcSe9DNmPJWIJgw6P9WUtynENTgouDjzg8NRhlcaXVqs5o6+v4Knaxzndo9m8bPs6BibNiDGXocnZUjkolyWSGjFPz+FV4KflQ8Jpyxh6ERmCSI6TwMV6RQOW0edwJn82uOJJSyUGut/zfjJneoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5SSa3iB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso5825126a91.2
        for <stable@vger.kernel.org>; Sun, 24 May 2026 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779645363; x=1780250163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZe8sDfbFbrFagrlSiLzrDPDhtWv1FCgy5wZfrXmVes=;
        b=N5SSa3iBaf4AsN+87519Lrk+Gh/l4IjJthXxyjj8Zx4xHzXWw5QrekDqki8ydWGOHq
         PhS6fonxpzLqHpg0Bb7NaVEv0c9piCh3QcojXR9G6v/JFpcNID2R3Q9e23oxFK6HYhpd
         dFdDECqb36RD8aWaUxOz30RL6HE0EJd7xeiytDdaUno1ORunoCnP/K1nhQEcE+SfYtx3
         R+RKxagYLMJEbIEfZ8ufIQ7wpb/lg0FSCxQHV5NUE7fDgJxy2j1eroQuC3YvTOQG3ttU
         i73Ma0i+V4SfXaLVeuIOFP9aZhc6zM+fnzz8aQo/tiIUv4uPHLtrs52KXBy2cw1gF0bT
         s40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779645363; x=1780250163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZe8sDfbFbrFagrlSiLzrDPDhtWv1FCgy5wZfrXmVes=;
        b=hIV4DjgbEUidqhZX1ncK3/KUXzQgxYOjBloz0whZKdoH7M6Jn24kRUEq/4Yxtfn4UI
         GTa8kaiNgvqe4HCXOvYoBW982lqWR7e29mhX4UCJvnK+0whAHoKnZsKQEzCTPvTwk1Vc
         evgP/pb8hQVzUi9CfvX3KPpnGSUZFc/m9NZODN3MQpQY2gOUcPIae3Lk6WezgV1omoj0
         07sLODrX2jeyedB0aE4bknk31kGwSkH9Fq1VfmQoXIpVFmrn8SexSgAZ/GCdm3aK3i7C
         Gpw2Drsh5x+eVCmoa7crR9hxIV4Fg1+3t7v45eIQ0ZEygIeuQ9B9ZYDd9+sxL+mREEFU
         cBQA==
X-Forwarded-Encrypted: i=1; AFNElJ9OGl1UQ9kr4MO1YpILiDLFB5c/K8rHWjYECn293Fq2zYeFYMnLXb4Wc4kw8cR0cmtM5iKkCAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQ910R8xuXqc1HrK7uegHMFIV4goMpCGYGOhezUCg2bcDV72x
	xux/JkyfuyV7GpkDgWYoOr7bBDl1V5J0hUOHKZ1IrPWUrqlMupXTalbWmjOt2o1rww==
X-Gm-Gg: Acq92OEk6kZhP3pk6kXqGITG5syfLJl/2CJz3bQt4P9MIuBXZ8ouaMTFhM3TIG1sobk
	om5bfqKAuX+6J5wn2p8R7FhF2f/6MuLozp33Ugl7KIX0ibCzdMNm91fE13fL9v+aRkHNttt77Kg
	U1iXN1yBaIMxwGS7bXGSnVy73lxXQ7hht1aY8W/W8V9kGWEeUKqHL7H00uNY0KCwuzA4MkOU01I
	sAmILHB7IPCzETTmsFFRYLF9+CkSeV6GYM9yTxrNZJzYNJWmNoglinwdy56iLSITXlTQ5pIdbMk
	ijBhzILIxH2B5l6lq/mjFDUOl2MGRjgS3dZ1CXWcnKOYTocXzxAcwWubj6/UIqh69CuFIBdGRZY
	ryQAnwyzR1wG22nCcYc9nv4jTiRqBuM9YSmiuY1B7VPy2V8fvrLf8D7c0gl/dG5qmj0uVKvwI+i
	WDjnXMHR8WV1OaUoSDdZ20gNKB8IcSKnfpz0wIuht52Q9RpMWOmqU6rIh03xt7Sf8ybbdwrToBk
	y270krg8g==
X-Received: by 2002:a17:90b:58a8:b0:36a:cd8c:ad3d with SMTP id 98e67ed59e1d1-36acd8cb47amr1301821a91.22.1779645362771;
        Sun, 24 May 2026 10:56:02 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852058557bsm6080557a12.30.2026.05.24.10.55.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 10:56:02 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] HID: wacom: stop hardware after post-start probe failures
Date: Mon, 25 May 2026 02:53:33 +0900
Message-ID: <20260524175552.1973-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254047-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 294775C3538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

wacom_parse_and_register() starts HID hardware before registering inputs
and initializing pad LEDs/remotes. Those later steps can fail, but their
error paths currently release Wacom resources without stopping the HID
hardware.

Route post-hid_hw_start() failures through hid_hw_stop() before
releasing driver resources.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: c1d6708bf0d3 ("HID: wacom: Do not register input devices until after hid_hw_start")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/hid/wacom_sys.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0d1c6d90fe..c824d9c224 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2456,16 +2456,16 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	error = wacom_register_inputs(wacom);
 	if (error)
-		goto fail;
+		goto fail_hw_stop;
 
 	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
 		error = wacom_initialize_leds(wacom);
 		if (error)
-			goto fail;
+			goto fail_hw_stop;
 
 		error = wacom_initialize_remotes(wacom);
 		if (error)
-			goto fail;
+			goto fail_hw_stop;
 	}
 
 	if (!wireless) {
@@ -2496,6 +2496,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	return 0;
 
 fail_quirks:
+fail_hw_stop:
 	hid_hw_stop(hdev);
 fail:
 	wacom_release_resources(wacom);
-- 
2.47.1

