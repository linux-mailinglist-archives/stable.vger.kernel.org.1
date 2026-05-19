Return-Path: <stable+bounces-249427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEKeOQS1C2q2LAUAu9opvQ
	(envelope-from <stable+bounces-249427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:55:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D170575D71
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71E2C307762F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 00:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F1307AF0;
	Tue, 19 May 2026 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="HLBhpNFK"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4E27A476
	for <stable@vger.kernel.org>; Tue, 19 May 2026 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151960; cv=none; b=eLYCf6wA+GlcEg3RnMTVrpE0UKnnhKzMLQjpztWygRTjzo5MBH0hAw3wao8/hUrqTn++ZO1jq0lpnIidKhkU4gBzFZegEKCxUHcy6GKCVDiS4rCqb6udOpJZ7jQUd+GZ/iKIrtmTYFTdSb4dRmfOR2rG2qLezR9ptbHMMJg6NXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151960; c=relaxed/simple;
	bh=MbcEhPfilDl5djs8OwiISgXUAGJH031p6hDtDP0Q1lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtT7RGUcrsb1yisU0erxBc9B7WHniz8AeUaEhEOEabSWsctbS+TAXZfwGN7vAd0UoRKg0vufEa4lvVQi8RHVPuds9YlL5d9EASNy4AqlAZCVQNuU2H9wE/SPHKvsc8M30bv///6Bx1e3ZswTXoM/KUjnXf0CjDNKBaZktxEqniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=HLBhpNFK; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-134ac81c445so10801947c88.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779151957; x=1779756757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWewpsuFbzTqoRaVPbiB62v6E+GOY+1kwxAn2d+qoXs=;
        b=HLBhpNFKhHmcW89rtStr/gT2BTY9pEKaCzvShRGGfeaTMbrtbKv83n4BKV+OIJcfV+
         nDheqI9UjvqzcntyDsPWPkMNj2k8BEVVV9MPP1+cXrXUfjnmJPTjsL08fH/uzmLu5fxJ
         mAJxqRHqbABchNgCc32T/1/v8XgNzpL8U9fVVWwJWl7wye6fVgVdvCJBuGvPR/2Wu7/V
         GhHSr1SRrn4geRzsniihVyEOItBFmMG/V7ZgX3vDbgrlocMvnpSnt6v/hKhU6idYDfCI
         Qxb+NpSGkKhZnkmfRrlnQ/8OoFlI2jpCe3z7VuGLV2PKqWWmHfdOPWmQrfr27SmJK9PD
         2KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151957; x=1779756757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jWewpsuFbzTqoRaVPbiB62v6E+GOY+1kwxAn2d+qoXs=;
        b=gD6giV0d3R8MnU2ZgRMxG3e1aFZILOyLQXVMq2kG9MFrrLK+0c8XmS4zYlCILgpMSV
         eXkGk+4VaMWkDh06HjoaB05bOcpkxO0NWErznu2aKXkUU3UIDISFlGKUVj+gFZMf4Snz
         +cOMfnuiUu9Us/JCWqyhbZY5cFcMnPd9tHYyJt/s68/iyKZDjmBCDQIJhBq2BKKlIio2
         PFFPHFPm+Bdqi5hcThXhOxXoihbadGFh2UXN+qSTZ2lDVWmov/CqumyREXaM40SwMIro
         WAGdJAslu/qLaccrDAa49jr+GQoVWHmxUqkm/nvoJIJLifKorXR8nphRDK8pvFrs0bfm
         aHrg==
X-Forwarded-Encrypted: i=1; AFNElJ/9DtwizPwjLJZZY/DL8PpGOPbqOcygFxoOW+zq6h2mYg3IAvxxXqUWuSS70er/FACQ3wJ57Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBCmV1KW5M43E/qBAexDqo4ZYuVyKMWSjDm/AVo/QHp080+oiB
	JeSG1wrm9CQqTI88HaElbB4VH9EHaPVnDgwO1nnIAfC9z9gRL8ZT1UFRS8lgGAJ6zP4=
X-Gm-Gg: Acq92OGs7tg8hDgoQHt30C+0TygDHAu8R27Xzflwc1rqIZTigUaX4QUJuVqAEzmqsJp
	eX+QyRRvcDbWD1od/Q97t7Rm84/he00AEaoV6hJ5c4YjCBs1mKH0LW+w7jhZOlI1KtHVdeD6KEP
	XCEm6l2CwEA/z8TQGAwIXqPVqiiIIqzG0BSYsIK7TM82DxJxO/iYO5GkGlhu68QKWDGfyWLDkm0
	HrieC94gIEr3oV9KEYzt6s4rDEZaS7zCkfCS2KRI4OHay/RBd2G84zX0ECdXLtCCutTrm8JGRoY
	zAKmrSQBk/a3oiDCwB64ll4BRQXwEV2bEqiyWng+THnCRiBKskaINr4Q5OqwE8dFdCj+vl+S7Cp
	LYsW4MTsZU5IIpY2O2aEv6zNx+TTLsVAVUws78h63lUdtZc/jgIuCazvX0Um4p7glYBA5rCUa7P
	CbrnzqfFi4+ACq1AOgzvGBR+sJ7g==
X-Received: by 2002:a05:7022:2201:b0:128:bae0:e03c with SMTP id a92af1059eb24-13504948b9cmr7313101c88.30.1779151956831;
        Mon, 18 May 2026 17:52:36 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm22546633c88.3.2026.05.18.17.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:52:36 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 18 May 2026 17:52:32 -0700
Subject: [PATCH v3 8/8] hwmon: (pmbus/adm1266) serialize sequencer_state
 debugfs read with pmbus_lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-adm1266-gpio-fixes-v3-8-e425e4f88139@nexthop.ai>
References: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
In-Reply-To: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779151949; l=1513;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=MbcEhPfilDl5djs8OwiISgXUAGJH031p6hDtDP0Q1lw=;
 b=tZbataWxursToK6TwLtzAmcuF1Y17nbY6u7cTpaJYyj/zzPSkodk7mxZZH1JHVU1DnAEfVJlV
 wM8DBAZHWeaDlPp97HVGOW3fr13+66tWHGwfFTqkXPbMbpgV5W2XWyX
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	TAGGED_FROM(0.00)[bounces-249427-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7D170575D71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

adm1266_state_read() backs the sequencer_state debugfs entry and
issues an i2c_smbus_read_word_data(client, ADM1266_READ_STATE)
against the device without taking pmbus_lock.  pmbus_core holds
pmbus_lock around its own multi-transaction sequences (notably the
"set PAGE, then read paged register" pattern used by hwmon
attributes), so an unlocked debugfs reader can land between a PAGE
write and the subsequent paged read in another thread.  READ_STATE
itself is not paged, so it cannot corrupt PAGE in flight, but the
same defensive serialisation that applies to the GPIO accessors
applies here: any direct device access from outside pmbus_core
should be ordered with respect to pmbus_core's own.

Take pmbus_lock at the top of adm1266_state_read() via the
scope-based guard().

Fixes: ed1ff457e187 ("hwmon: (pmbus/adm1266) add debugfs for states")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/hwmon/pmbus/adm1266.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 051f4f188ec5..605db086236c 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -333,6 +333,7 @@ static int adm1266_state_read(struct seq_file *s, void *pdata)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	guard(pmbus_lock)(client);
 	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
 	if (ret < 0)
 		return ret;

-- 
2.53.0


