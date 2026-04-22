Return-Path: <stable+bounces-240339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OXPGDbi6GkHRQIAu9opvQ
	(envelope-from <stable+bounces-240339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:59:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DC24479EB
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EC1430CC69C
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427A433261F;
	Wed, 22 Apr 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCrBVQ07"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD1223DD4
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869267; cv=none; b=tt+VwnG1b3tCgU+JD5vMrl8iwBaNuS40s/oIrQpOdUroth8qWyWxwGqbFhDAPBFa9gNzDqSyPK9RU36lX1tpYeYF5J4baCyoYpdRf3SwTr0McOcNJrMQ7fCxwx0365KMFCk8wFx3s349vG1LZUD7O6jsPsfOfygxxQKS9PxrYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869267; c=relaxed/simple;
	bh=+B/NESwsCaw3fNDb4vLX9lXWsiTZ4GQCNwTVw3G0D2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/zUA1brTj+1lwkQF0b8wJxtelXMlzypITRd8J1454d8EA6Kzm+5hLAEzvgdZiiHYk3ldzuZH4gPKx9ER4dpLssFGBvph+aWnoAk/y+1oaPS/qXrn9KseKiQpJPG8AGnMZej6Bbo4CvtNh2X6ddlnc1eeKWe9iy7PaPcIk0Fkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCrBVQ07; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c795a47186bso2274443a12.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869265; x=1777474065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAB1mHA/CNfSisiTk2OltjgaZv+ctRVr27O5r3zLjx8=;
        b=FCrBVQ07EM+6iL1AjYw0R/xYf1EyxdCPu6jBM0AxvP4Zn0lMAEsXiecU9RURw962q/
         ZCLpaRSkUWk4eyC3sZFItLk+6vL3/Ts++dBYFJntd4aO//j5xSdk5wUCBDtIrkc5azuX
         cz68SObwBxlqlgxoqeZK+MrFRWOnd69fgtk+cYTiuTowl/F9jwvvrfZF/cC5VCA4+Zw4
         tM77v8cgJulf2ZroHULqMbbJWDximBP8oXEMtoN2e8Rk7gqnTuNzy1oB1NpmnF8FAg4U
         e8KwP5tYtVsl/2XfscznNYG5692RM0PESPnYsjqoj4vxMUNpQHZC+oEv3WkLOXDdXQKW
         tcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869265; x=1777474065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAB1mHA/CNfSisiTk2OltjgaZv+ctRVr27O5r3zLjx8=;
        b=oSYYAfZOcoOtzm+H1Ypuns6ybrvYrLMmbYo5APtTrpGh8Dg3+Y/9BSWDOpSK6+UETd
         glcCKqNewOtFrOpT8BiwOptMBjg+5A+7SKWInCv3Z8xv8cACSwzuYjfOOQxjde8AR0aX
         w0P1uhtRcxCYqtHxMjUsBBUArt5svecYWs5HmHzAoXrgeN286+49TtFz2q35bYhuoXm2
         RCXqZYECMkYyUv3nCQghRA6KAu9xfOzzxc4JNsImLV3p3Bc/DZiECsvzpt/RsX3yclak
         eWHVzZm05F5GdUhbNF8Ev71A+Llt7yYZDIUxQijGFOZ7q+xRrhYSuDbNAji9/BopMWzj
         Qyrg==
X-Forwarded-Encrypted: i=1; AFNElJ8g70KTWR0P8gt5iWYmDmKItiDt899xUVWxNaDnwHefqAittY9S+D7Rph1LDd0tTosO/EkSO2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6281d2lUz0vNs+wHFpkrcN6pAk+KpRt3ZJJ2lBXpZw8ZETfOE
	9l28VkYJQRC6VXJnYo97x/8O+YCpS2jk6zUOvJRg6ZYt4xzuMNplakQE91FacKEm
X-Gm-Gg: AeBDievLyr5TawH187c8Nizu9IYWUSt/PFHvOK5/zdeggOKOFhrtrm8blFgcGo1hsYE
	tU1UAIAavQrAj0LyYm18D6X/VceaVWqRDUwclR3TgMxvdQwP7BgYwSnskxjCD8YQC5iTSB/KSfS
	4387OHp7SU0ZnUKntWYArUlI6LTf6kRK+jzfEFCPfkyEIv5eX/rGMnN9PMyWORvEpzvC7jRgVyi
	nqhvK4fwoOQ1w0hqQN3lD7seCCz62F1H5gWyQgAUnBOVR5Wc/neN8ZXWuaQwVRHDi/Csh4dyxys
	YbAe/DLOGV44ftP9hPCtTCKQAZ7Sp+J1cqPh1XzPte4vKfWQD8nsje8htTYTy74H+H4XiwLtsBY
	/EbJYQimU71GEVEg7OHzEJrN+ZwplxVg3SYtWPDIliOIuWFklG3qHMyEpjAIexFk3WU9X6Tk44l
	0wTF/kgqsgz+Kr9nWUBUaa3p9V6C/t6i4kYljMJItmOoTsq2OC+697cV/YfqusxUc3BA8R7bs5b
	bAApV7Jb2qd79jw9w==
X-Received: by 2002:a05:6a21:790b:b0:3a0:c285:e511 with SMTP id adf61e73a8af0-3a0c285f10bmr10916495637.24.1776869264848;
        Wed, 22 Apr 2026 07:47:44 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:3191:a257:32a3:b02c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f370sm13748370a12.7.2026.04.22.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:47:44 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mchehab@kernel.org
Cc: kees@kernel.org,
	peda@axentia.se,
	wsa@kernel.org,
	crope@iki.fi,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org,
	syzbot+019ced393ab913002b75@syzkaller.appspotmail.com
Subject: [PATCH v3] media: rtl2832: fix use-after-free in rtl2832_remove()
Date: Wed, 22 Apr 2026 20:17:34 +0530
Message-ID: <20260422144734.25650-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,axentia.se,iki.fi,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240339-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,019ced393ab913002b75];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: C3DC24479EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cancel_delayed_work_sync() is called before i2c_mux_del_adapters()
in rtl2832_remove(). While the cancel waits for any running instance
of i2c_gate_work to finish, it does not prevent the timer from being
rescheduled by a concurrent thread.

During probe, the r820t_attach() call attempts I2C transfers through
the mux adapter. These transfers go through i2c_mux_master_xfer(),
which calls rtl2832_deselect() after the transfer completes,
rescheduling i2c_gate_work via schedule_delayed_work(). If this
transfer is still in flight when rtl2832_remove() runs,
rtl2832_deselect() can reschedule i2c_gate_work after it has been
cancelled, causing a use-after-free when kfree(dev) is called.

Fix this by calling i2c_mux_del_adapters() before
cancel_delayed_work_sync(). Once the mux adapter is unregistered, no
new I2C transfers can go through it, so rtl2832_deselect() can no
longer reschedule i2c_gate_work. The subsequent
cancel_delayed_work_sync() is then guaranteed to be final.

Fixes: cddcc40b1b15 ("[media] rtl2832: convert to use an explicit i2c mux core")
Cc: stable@vger.kernel.org
Reported-by: syzbot+019ced393ab913002b75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=019ced393ab913002b75
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v3:
  - Fix missing PATCH v2 prefix in subject line
v2:
  - Fix Signed-off-by email address (lowercase k)
  - Add Cc: stable@vger.kernel.org for stable backport
---
 drivers/media/dvb-frontends/rtl2832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
index d8e1546aea5e..9898f729304a 100644
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -1115,10 +1115,10 @@ static void rtl2832_remove(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "\n");
 
-	cancel_delayed_work_sync(&dev->i2c_gate_work);
-
 	i2c_mux_del_adapters(dev->muxc);
 
+	cancel_delayed_work_sync(&dev->i2c_gate_work);
+
 	regmap_exit(dev->regmap);
 
 	kfree(dev);
-- 
2.43.0


