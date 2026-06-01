Return-Path: <stable+bounces-259568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APXHGnmOHWqpcAkAu9opvQ
	(envelope-from <stable+bounces-259568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 15:51:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 071866204E9
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 825B13032832
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9F377018;
	Mon,  1 Jun 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7OskF6c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186AA3A48D5
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321295; cv=none; b=DBB0Lrwbi6jCxLukFxJfUfxwp60u7wRMIduISMq7lpcReA3L9nQgE1cBHkyCc4jUNXSJRJcFVQEsgAA3c6HR4lXRMOUudwMSoIFVZWigDzG5E41jMsUc8UCto5C3PTDy5+QAdnrhA/uBxjTPgisxo2/7bzkHZmAp646RDWOA/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321295; c=relaxed/simple;
	bh=aqgDoKG5VukJzyghkBryFWSabrvKwvQSuPUR+4Tw/n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3wDqhYk8X2HgaoDMNQyWXuvS81XiCABN24bZOuGufpSaSugUExTEARm0DRbrHOnidxUxUiD3MPsKV61AOUuPcM1x34vNaRMV3I37RHjUPiAxHvH1MP7UEqIV+ygn9byhNl4yROQnppYZ09e86Ptepnj5MkvHbpcxXtGMZTN144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7OskF6c; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so1828534a91.3
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321292; x=1780926092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfS5OoTJgnXFf4esSAMb4Qchj1zhL9EQ+SZTd3nWYUk=;
        b=R7OskF6cfOfoErYuE5K1lV+kHI4z9wolrxMCVxz1R1kNYys3XKHnjJ/B3the3HAAzX
         9bfUYUUJlnoHaM65kpxCvsHCbQpgmo1BMwfkKjK2wJz/VsnAASJhn3WNSpTDSINkBqHz
         qdi94Eg0uTHMgeka3Y5rsu9jFlX1ulM/KeeF+DCHPMHWv+YwBgCzFRK07E8SmLPecpnD
         PdP0M6JIxF7bPviLfWv8t2kgsB7jKMHGfs32bDiKrKNLHwUr/qlnzgsAxxpRyWKeQaLG
         pjptbsJgszubeBiJ2a5GDH2U7RQF92kxBLZLZnhA4RSirnySA0zsTKpicG+/v0UJ5M71
         uDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321292; x=1780926092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfS5OoTJgnXFf4esSAMb4Qchj1zhL9EQ+SZTd3nWYUk=;
        b=dkXM3MQ6EEXtNQnxXw7pZXBaZ6gBNPh8cWmvhYKNioOw+0QlsFkXgnUms65Yvw5Uiy
         UVF7yDWXDlMsgh+Lcn1CVd11wt+ICX5i4hdjvaORDUSFnoScbNl3EXAG8SK70F8cZxqY
         TFQaORuB/S599q5kKQngP65APsP587fmb2UZN9skV4F79JQ3cpo4xj45n36a0BktOFkx
         6/0DKh7s5YFjpS6o/HEu2gCdU82APj7HUzEFYb3eA0rJDV9tDlNTDDBz5Cw0TMLTBdxh
         NzmXfK/AnA9pVTwv6cKdK34jAbqvmE1RGUttVdaYtkRqGGXK/8y4+bL9k0YTJoc4a+rL
         UstA==
X-Forwarded-Encrypted: i=1; AFNElJ/0VoPnBlo/dmaKf3DaKMeclgLsqRaAGeOlIuNYnueZVqeRWqyKbwbpsUZIw4hrtG3Czr02+RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBq2gZpV/UDeF1ELCdWr13BFl5yTYhFOlPhK9RzserzJ4CHhx+
	NSMUV48lAZ+HzHLyKmZIqlSuBKwzf6EaSU2z+xmZcsSulzIBVp42CGpp
X-Gm-Gg: Acq92OGfwGubt9QHxAl8UH+3/yc6s4tgs+z5zEZv4uXLN7gDDctbe3QOCYo9rcdC4/3
	UsjZBfJwk5wuUGq+t3Xaf//98WBDK9dPD1EI7BrzOd+E4BkckLITZfWG0VRA0nF1PhknY8JP7Wy
	CYRpOwzSRkUJNk4O9qe1csF6uAuoWBXzC420Nb1uI5Jfa/4H5bD0NYOwckuLiWyt3Numuv1g1yi
	BuyHZX6CcgcdXRhdfO8pkos/VEeXtAdCzZgM+jzlj1U7x0iZs1v4mqjLeZbTnLkn54l0yk6k3Jk
	WxXCHU0vSWr6TmtKKSA9syA3vmTB90fVNUaxaOt6+QTPlWuqWynWxNI0Suu2Y02K2b0TdIJw/gv
	sZV4yZz45lP4ejb6V0fJUaUbps56ixDmy16pEoyD3Ksk/rl88HzcpBUNDgo9higzMw7Kmz28lqS
	5KgCDMGXa7u7DJy9XGstUceUNEijBpVhMkSQIxhte3pM0V98TS2OjN8JOpM9U=
X-Received: by 2002:a17:90b:3c92:b0:365:a5f6:4a5c with SMTP id 98e67ed59e1d1-36c4ff2c8c0mr10234658a91.1.1780321292225;
        Mon, 01 Jun 2026 06:41:32 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc65e8490sm11496959a91.3.2026.06.01.06.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:41:31 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com
Subject: [PATCH v2 2/2] HID: wacom: use cleanup.h for wacom_wac_queue_flush() buffer management
Date: Mon,  1 Jun 2026 22:41:24 +0900
Message-ID: <20260601134124.1560886-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601134124.1560886-1-jinmo44.yang@gmail.com>
References: <ahu2oxLwkgMlwXu7@google.com>
 <20260601134124.1560886-1-jinmo44.yang@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259568-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 071866204E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use __free(kfree) cleanup facility for the temporary buffer in
wacom_wac_queue_flush() to simplify error paths and ensure the buffer
is freed automatically when it goes out of scope.

Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_sys.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2e237bdd2..edc24fe2e 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -70,11 +70,10 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 {
 	while (!kfifo_is_empty(fifo)) {
 		int size = kfifo_peek_len(fifo);
-		u8 *buf;
+		u8 *buf __free(kfree) = kzalloc(size, GFP_ATOMIC);
 		unsigned int count;
 		int err;
 
-		buf = kzalloc(size, GFP_ATOMIC);
 		if (!buf) {
 			kfifo_skip(fifo);
 			continue;
@@ -87,7 +86,6 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 			// to flush seems reasonable enough, however.
 			hid_warn(hdev, "%s: removed fifo entry with unexpected size\n",
 				 __func__);
-			kfree(buf);
 			continue;
 		}
 		err = hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, size, false);
@@ -95,8 +93,6 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 			hid_warn(hdev, "%s: unable to flush event due to error %d\n",
 				 __func__, err);
 		}
-
-		kfree(buf);
 	}
 }
 
-- 
2.53.0


