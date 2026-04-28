Return-Path: <stable+bounces-241457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKcrL+8I8GkINgEAu9opvQ
	(envelope-from <stable+bounces-241457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 03:10:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1A347C4FD
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 03:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B09F304046F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 01:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD162BE02C;
	Tue, 28 Apr 2026 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFRnZk3I"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FE22A4E9
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338567; cv=none; b=hLCucD5UI370kYJWMCrGaP02OsCNU8oX8kMgtt6oBJO/pxA3vQBBhHS4RNDF3YP45/j/WhMfhPpO3MD/L5qPNGIhSGIhe7L8K3K9LVZzZwxlaoCN+FTXO3n2LEO0TkIJZI0DJLKqWgqfB5rTfVehvPh0mDp94vR18tv4tTFfWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338567; c=relaxed/simple;
	bh=r/elXJM0fR9V2vGs3JzDAmTG3GxkVjz51UhlEFnw6jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mt/coeIhnJmmnAIz2xEwepBkXH7y0yuvAbB2a3g1enAG4CR8VfC0/zc7ljkw9lIo8Ac8cT/F11rqNcpVqh06rMqkzGvglSgCz2EXTnuMe3Joc0sHODa3kXKFKPs7eAgW9PKfLpKvhQe7RVRDUXvqacCBZ6So/akIHucUX/vng9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFRnZk3I; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2d9916deb14so19170263eec.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777338564; x=1777943364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1UWV0CnQblrZEKWmmzMKh8oajfG3299hpJ7cT8CIuo=;
        b=iFRnZk3ITSRmxH7NkzG/vprI/o5ytQJu8Z1aZ2NcyzHHGPiTOkAC3T8CXnl3CVFdRQ
         yqpSGWcEbf+blMdzomdGkaTwRhhYClhoeqWW1F71QU//TwwG7GWUJJxG3EtEp2wMBMvZ
         7Vm0TDUF4QeWZNZ143XwqQrI3/WGEw6jFTvEVL7iLtYTa1iB+kaD43ZU51OQ1OMKG01E
         hZca01+7P8dFU3VoI8MH7sYEKMo7kv0CddJbpMZDLnU+zWN1CpEpF/EttZBPy4zMEOAQ
         va3YOOkYB+G8BsP9sgfQ1TK0kdiLYkPI4auskCcF0NYjoBm+OvPqCJgDrR4kiLQM3E6y
         YrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777338564; x=1777943364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1UWV0CnQblrZEKWmmzMKh8oajfG3299hpJ7cT8CIuo=;
        b=f4do0oltOq+bxTFY3A2NVO2nPWWSz3Zgo8kiREWRc6y8MQYHTfxLc2/ZCxeuYTUPV1
         LEY0B+uVrf/acaF+u4df015q4c/TBcao/9cJO2FGC82aXcJn0kvVfPJ3fY3szb0oCqgf
         StuHxOOWa0cq/4tGh11p5O69l7POqUNu92Z6d/39cdpQmyxXuy+Y7cFBgU2X7065vDCg
         /liRv1bxe5ixH6LNG6zqVsV1a5Odqir7B5jRR0z4DmisMpLhY8AHrdTTiQ6hLrJ9UtAt
         hxYQ89cGe2EOeZOvPjKvVwrrpI6by/GfmSdtfND48zO9Z4E1tV9HbeZcJDSUJHhF735I
         d5lA==
X-Forwarded-Encrypted: i=1; AFNElJ+CMyDv3kBAi7HFZ9rvh4/mkiJAtTKgHAKKpkHMJYQ3NGpEhXBIIr2uN+s6L0DpqsAoRw42B1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hCX8+LBtkLBoy2HAZSnMw/46xI8hYuNcXDPuWRZDOy3Qvufo
	A+KPfJqLHr2sP94FOhnJHOFEXFI/GDaNmAc9MX+qSch2V22AHrF52c2P
X-Gm-Gg: AeBDiespirQD1YQqdLnUtKqi60HUE4F69Psf5Lqepc6jxroX/KgfnaGJIOUxyIEcMLp
	0dXBO+cc7N5tcNnCvOOlUIW2zy4aPY8riLb+zWgInLO763IlfCzX5xbSsOm8ZmDf5TqTa0w9A0H
	M8hHfFXZU9jNKTJaNivjdX0RNEHPW/GZMdy5O9pxCS4nY1J+NXUt1P42QjxxeaoXkrlpWocO5yD
	dhFgSZOUglLcitVl51YmJmanuMzinO4NMLHDBrfowO+Ti4slLvnYAQ+J+IdGFFCiksq0RY7YQ44
	GgWTxUE5zaDLHIaZJWCGFVVVWLK3bmvoyaeuBVjMOMLpedHSzCtTKUvSSeZCb41NhtqryEumx81
	PlDt+08QfxqbjFG9UlXvhs8YWOa003/llDJwyPO6ucA/vGZ7WrHFNeH3jc/ip7sjIbLG56k6yAw
	CGAbely6tlvKCLgjlSzhlWHNYYajDMfB9vzU0LshzRl92+ps4VSv/icrb1xBV4mK6Gs4zQ3MqpK
	9FlMjhRzWk3vcAqlELvg51VRbqMB4Rm4SAT
X-Received: by 2002:a05:7300:5721:b0:2d9:b466:5e19 with SMTP id 5a478bee46e88-2ed0a155432mr640510eec.21.1777338564052;
        Mon, 27 Apr 2026 18:09:24 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e678:f42a:a63c:516c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09fb64d7sm1071380eec.9.2026.04.27.18.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:09:23 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Input: rmi4 - fix num_subpackets overflow in register descriptor
Date: Mon, 27 Apr 2026 18:09:16 -0700
Message-ID: <20260428010917.1320927-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260428010917.1320927-1-dmitry.torokhov@gmail.com>
References: <20260428010917.1320927-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D1A347C4FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241457-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

RMI_REG_DESC_SUBPACKET_BITS is defined as 296 (37 * BITS_PER_BYTE). This
may overflow num_subpackets in struct rmi_register_desc_item which is
defined as a u8.

Fix this by changing the type of num_subpackets to u16.

Pack the structure by rearranging the members to avoid holes, change
reg_size from unsigned long to u32 to save space and ensure consistent
size across 32-bit and 64-bit architectures, and use DECLARE_BITMAP()
for subpacket_map.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.h | 8 ++++----
 drivers/input/rmi4/rmi_f12.c    | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index e84495caab15..865ffc7882f3 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -11,6 +11,7 @@
 #include <linux/hrtimer.h>
 #include <linux/ktime.h>
 #include <linux/input.h>
+#include <linux/types.h>
 #include "rmi_bus.h"
 
 #define SYNAPTICS_INPUT_DEVICE_NAME "Synaptics RMI4 Touch Sensor"
@@ -52,10 +53,9 @@ struct pdt_entry {
 /* describes a single packet register */
 struct rmi_register_desc_item {
 	u16 reg;
-	unsigned long reg_size;
-	u8 num_subpackets;
-	unsigned long subpacket_map[BITS_TO_LONGS(
-				RMI_REG_DESC_SUBPACKET_BITS)];
+	u16 num_subpackets;
+	u32 reg_size;
+	DECLARE_BITMAP(subpacket_map, RMI_REG_DESC_SUBPACKET_BITS);
 };
 
 /*
diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 8246fe77114b..9bcc27e9d308 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -88,7 +88,7 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 
 	if (item->reg_size > sizeof(buf)) {
 		dev_err(&fn->dev,
-			"F12 control8 should be no bigger than %zd bytes, not: %ld\n",
+			"F12 control8 should be no bigger than %zd bytes, not: %d\n",
 			sizeof(buf), item->reg_size);
 		return -ENODEV;
 	}
-- 
2.54.0.545.g6539524ca2-goog


