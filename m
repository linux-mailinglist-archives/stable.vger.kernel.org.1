Return-Path: <stable+bounces-230223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PsBJVLswmkdnQQAu9opvQ
	(envelope-from <stable+bounces-230223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:56:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8C031BF2E
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C3323076357
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB666318EF4;
	Tue, 24 Mar 2026 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC6rNT4j"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF323BCE3
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381853; cv=none; b=dS4QMbyyZrsUe5XDgZTLdZ2d1ryRP+xlYB6dIum6Y8dYfxptBfVhstY5/yLmNs5bli//u8sfKa1BP1+OXq75ab6lOekaEmPSgQZ4XhF+QDtKzlySFHamms3ui/by3iVCIxgWf3nqt4iEl0A3+wu4eYZZx7CS9Da5oBbzEfyOtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381853; c=relaxed/simple;
	bh=DFzrGNuqedqy8atkxndExskD/dr9k9qOU+KriiRa2NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkdJJS44HBCTTdHSbIS/1W8YKP6N0M4PX13dAzWa5y/x3ESpytrePbepV/Nh9wo5Yr4aF/jMng4Fvwwbk/HAZv5tOhgG/Z6q58orqz9RuIR4a/k5dnCkvtvM0ivzbScZqb6MiWjjpTUjKf8YhNf49WmL0Q5s02pdqZpqEViXyR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC6rNT4j; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56ccdd0044dso173887e0c.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381851; x=1774986651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qryctq+sXb4beB+BGrqpu6BjYxUYcgGS3vT4B/l0hBg=;
        b=GC6rNT4j7mM9YW1GxztmbQ2XipS/du4b+9qooanl38rThdP0skbCLL+NJgM+1ckeqj
         Jv6S4lKA8cVkdAfXdmdKPs2FRiX5C5mrKt3F0/bJ9bq56CAtNrsHRAzdYcKJR7nm714y
         /nsGKWiXdz3ZrZvomqbv6JHKKaI+MK2JuPLJmecw6iWWGhpIx7cZasRqnw5M9m8fOAXA
         gFKCeBmIwmtQjp+Z/J6z89Xp0GEVPlu/LgPupOx2BQzeCvDcDn7qyeE4lnTk+bWRQa0/
         sno5wVeC5ZBOxi/rlJHMuZQqCU2xPY7QdGPst+pzEI7ppwBddUaADGdmh8TtXuhPDr2r
         8PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381851; x=1774986651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qryctq+sXb4beB+BGrqpu6BjYxUYcgGS3vT4B/l0hBg=;
        b=kKFnh7F6Nsvy7dLfwwJIGZpXRyU2MsxflXn8KSPG6UfoDcSUV2PgRLnFeX+iaTfo/R
         9cLl+RD52IZgs6EFHrc8kMoQlate1JSMvlttNyHdN9rp0ABB7ujfqXiYTbzebuwolUHK
         kxg47Kk/qWPI4ZRmQGqGFOgAk+czY8gZc7AsvunlpbUOCFUbsukhA6mp5lqZADqTwt/y
         3xzinycYzDV2EV/P6itL5+VpBijLcJaS23fl/Fp0VczaCkJH4tKbv3JlfnA+iYroRl5y
         cqNCM/PZ9eDbAmFMtcOkK0IWLR4JJjgOBckfHs4F8OXeBoIr6JD0l900FO5Qaewx21I+
         TgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXndEYeI+KeO4eUaeRPb0TYL2fWti+ImYpYRJRxYZUT9fUfWaCAp4u+3bIGpULDcCA2t4SGj7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWW77HluNhYkAusfdVeD+P5Qt3I18hdz/mntbDB5/zuXucRsI6
	MaPIqjnMk4JvgQr1X26VywlSzJv21LuIYw2rqjV588OCy4clHPcyDsgt
X-Gm-Gg: ATEYQzwB5jyP45ONRPZ+gPcfrWAsV4Hjgnma8jEL8QLuiwoxnf6yjM1LCXu3zbAYA+I
	SIZmTquKex1iqCkkGwKbvRZ+Jb3+oLDRKO2LAFqnH897cPo1oVBCjXlzfsuFRR/BC/EReRrEKBv
	oq76I2a0TVB1gUO2B3LEUxkL/szdU1DWqxgI7oYY3nl1VoK1CLoF56Gp8qVwkbUqg8AG/TEUPVH
	ahvFZ5XKbAQicfFN3XDWS768eFGT8QEvfSOiCF5BFIGn5NxVyJM6udVsLg3PQn4qz6uaSxIoDQt
	03bBPWS49bEdzDu4V4jqw2iMZu07I32qDTj1AS7tVYpj0JTbNsfLshox6a+xrGdOd/k01/Dimmh
	2vmsurEAz78MrxgMAytHdX94vO11FaG7iJ/y8xTUDflIzaBQxtGooZoSDoCWtgDvFnpyw5RKRqg
	YkAUo7xS5Ye7f4+daGJWkaG5S+TxmFpmS+vcA=
X-Received: by 2002:a05:6102:38c8:b0:602:90b8:9840 with SMTP id ada2fe7eead31-6031628530emr2537503137.18.1774381851377;
        Tue, 24 Mar 2026 12:50:51 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d71:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136b4b8basm12952273241.2.2026.03.24.12.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:50:50 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: marvin24@gmx.de
Cc: ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] staging: nvec: validate battery response length before memcpy
Date: Tue, 24 Mar 2026 13:50:41 -0600
Message-ID: <20260324195041.38343-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230223-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.launchpad.net,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B8C031BF2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In nvec_power_notifier(), the response length from the embedded
controller is used directly as the size argument to memcpy() when
copying battery manufacturer, model, and type strings. The
destination buffers (bat_manu, bat_model, bat_type) are fixed at 30
bytes, but res->length is a u8 that can be up to 255, allowing a
heap buffer overflow.

Additionally, if res->length is less than 2, the subtraction
res->length - 2 wraps around as an unsigned value, resulting in a
large copy that corrupts kernel heap memory.

Add bounds checks before each memcpy to ensure the copy length does
not exceed the destination buffer size, and that res->length is at
least 2 to prevent unsigned integer underflow.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/staging/nvec/nvec_power.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/nvec/nvec_power.c b/drivers/staging/nvec/nvec_power.c
index 2faab9fde..29beef0a7 100644
--- a/drivers/staging/nvec/nvec_power.c
+++ b/drivers/staging/nvec/nvec_power.c
@@ -193,14 +193,20 @@ static int nvec_power_bat_notifier(struct notifier_block *nb,
 		power->bat_temperature = res->plu - 2732;
 		break;
 	case MANUFACTURER:
+		if (res->length < 2 || res->length - 2 > sizeof(power->bat_manu) - 1)
+			break;
 		memcpy(power->bat_manu, &res->plc, res->length - 2);
 		power->bat_manu[res->length - 2] = '\0';
 		break;
 	case MODEL:
+		if (res->length < 2 || res->length - 2 > sizeof(power->bat_model) - 1)
+			break;
 		memcpy(power->bat_model, &res->plc, res->length - 2);
 		power->bat_model[res->length - 2] = '\0';
 		break;
 	case TYPE:
+		if (res->length < 2 || res->length - 2 > sizeof(power->bat_type) - 1)
+			break;
 		memcpy(power->bat_type, &res->plc, res->length - 2);
 		power->bat_type[res->length - 2] = '\0';
 		/*
-- 
2.43.0


