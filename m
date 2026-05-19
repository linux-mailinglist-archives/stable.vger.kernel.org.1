Return-Path: <stable+bounces-249422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJGFGWu0C2q2LAUAu9opvQ
	(envelope-from <stable+bounces-249422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:52:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12319575C97
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 227713016B65
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 00:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6A42DB7BB;
	Tue, 19 May 2026 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="BHDlrNtW"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322672877DA
	for <stable@vger.kernel.org>; Tue, 19 May 2026 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151955; cv=none; b=DsRhlRBvsr0DTAecPLuwNKWp1g+y29UDedGH1HodR/qvopBe8JgH3zDnVrNfsQ+Jvw2ATQ6E5dmGSPCzsYE7UonFSHcMaxG9/E23wzBXKlrzS033mgWtMBxEQkFy3UDgzCmj8YOo3h65oCqNpOGtbbMqhU2/zj4rln3uitjv+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151955; c=relaxed/simple;
	bh=1JG+/zkIS+GEXFeDqZ4D4F9Ctl/p/94MPO/ij8zaqjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdrmEfuhyxbM7wybQpWqnCjTrqEKaa4KbKbYmqQDDytGlBBAnNagZcNER7nUnqbrpJO/QiDusAnCHqOW19VwiRvwztECDHgQIIif83h3PcImBHPO+3/fww6IxZxSx8ltiOgcmb+shXHBaL+AI2tdroZWKzUJ17NCpY2tNwFc0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=BHDlrNtW; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-135200bc7d2so8050405c88.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779151953; x=1779756753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zlzk3IweM6/T1gjXkni5pH832MnF1gtDJTKqsEsOXm8=;
        b=BHDlrNtWFcjsv4sNRVfNpmf2mpHdjuAbMov+K+YfBX8DJx5FKlJ2vVGbawleEYJInO
         nawHYFADCL48EgoxKTIaHrx9wAgtvmv44RswJDZED7VbfshZmj3Yal2vxSSthkaOIj4l
         bOpMGZJgCTFvHx7HrOZm+5LrIhxsPkRhSevzIfoLzmb5g3JUBJ4Q+z5XQzf9CULKoQff
         4ZH0a63aVxaIwAUJOc/79XdjD/SzSAe2OIUMldil0Gx/iSKkqs+prrEnEFKpcrqRddMv
         +t+ceypaYPMDMqYJwb2pNLd+WQEMbArKxjGKQBzViBtkvQ640Rpe3hQixj+JZpCDR3U5
         tOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151953; x=1779756753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zlzk3IweM6/T1gjXkni5pH832MnF1gtDJTKqsEsOXm8=;
        b=L+Y9UuKb4/knbWWutrRId9D+wnGKAiJJPqI5AyXxmlBxQXDggB6/KJTPhx4xQpgShm
         dzqFAtBRFcfbGO6q1QZLb+qPei6LAnhwaWJTJBQd2ql7VktKMM5T4pLPPTlMgbzUrRBp
         B3VUWznKOEYW02D2bJM1K+aL2A4bsn1zY977+gp4EarBZkRfHnLw2jUnQhjhLS9PG42C
         y7OqIoxicUTgCHlp925Be5AdvQBUbz3ubPnwchD1qFnZd14klRz9tsh6khXp+k2rVYYn
         mqOWIsuvCU6aV95CC9i2CbgsrNusfKMIRMDATy3uFyFehUE1mCna4OFxDibV18oPyWBD
         PXsg==
X-Forwarded-Encrypted: i=1; AFNElJ+Eoqjn7ronfPEDgo57XMlMMlCe65Va6CgUD5JkKHlWKSz7y32dODH61R21HCm3Z1AjcWrSTz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNGSCILH5bvQQS2/O+W+0uoooRANFaP/JpEEpReLcyFvwGZ68
	Is7ZqKbYAZgtNa5KEPMiA65OEAMEX7V4UBZvDD3f6AOl8hFPMpWk9u9U7dteYOllm6M=
X-Gm-Gg: Acq92OFdEaRjoc7v5wkdQRc+NGxFBpG1UQZXRS423cJboLJroBIviDIa5sOLbigHfY6
	7fsMuu657qSyWwdERRyyDCSMiRr+Fbo63SESV5ArqR2Z1Diu11T+VksjC1CyHt7ejfG3zwHDkTY
	cBHZsToFArntrCJDlbftCbxJ5fwL+DlVuNC/8qsDhKs6hfx6LcL06dFK8/bUUxU0S7x9um3eiCQ
	dGYp2HcRZeg4r0tBgPAmLzVkZcysW1OCzCz2fGWIKtIiEvMN59NoZ4tiJzlFGW+BfhsAM1o9X6j
	A0XgETkhmX7lozv7YSmmE00NbJfJbXffnOhs6Rv+iYn1mF3JOYad0qUt4Mzldo48MTYJRiN0S9i
	vMWoXF3wyYhK+l33PYmVUbTs8ukurms35ju2aXTkabdAYvHFN1o6Jh9FUA5bXkz5O+rh0694PHr
	YM8AxzwG94y3BCBDDhKuMhrjwiNg==
X-Received: by 2002:a05:7022:7a2:b0:12d:c9b6:bbdc with SMTP id a92af1059eb24-1350494e473mr8550867c88.30.1779151953289;
        Mon, 18 May 2026 17:52:33 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm22546633c88.3.2026.05.18.17.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:52:32 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 18 May 2026 17:52:28 -0700
Subject: [PATCH v3 4/8] hwmon: (pmbus/adm1266) register the gpio_chip after
 pmbus_do_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-adm1266-gpio-fixes-v3-4-e425e4f88139@nexthop.ai>
References: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
In-Reply-To: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779151949; l=1812;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=1JG+/zkIS+GEXFeDqZ4D4F9Ctl/p/94MPO/ij8zaqjI=;
 b=eDz6CtV+xk55DonqDrs1pNdpplss0Fqb6RErODkJAylZJrzDENIty2KbtoJC91N9SDjbi5UCS
 sbEujihg8YUC0+CRw+cQAghEQIkGIUQUkYd3V4fLbB9hMDwRxFEPzB2
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	TAGGED_FROM(0.00)[bounces-249422-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 12319575C97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

adm1266_probe() calls adm1266_config_gpio() -- which goes on to
devm_gpiochip_add_data() and exposes the gpio_chip callbacks to
gpiolib -- before pmbus_do_probe() has initialised the per-client
PMBus state (notably the pmbus_lock mutex the core hands out via
pmbus_get_data()).

That ordering is already a latent hazard: any GPIO access that lands
between adm1266_config_gpio() and the end of pmbus_do_probe() (for
example a sysfs read from a user space agent that opens the gpiochip
the instant gpiolib advertises it) races pmbus_do_probe()'s own
device accesses with no serialisation.

Move adm1266_config_gpio() down past pmbus_do_probe() so the chip
isn't reachable from userspace until the PMBus state it depends on
is fully initialised.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/hwmon/pmbus/adm1266.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 57cb7d302cdd..b91dcf067fa6 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -467,10 +467,6 @@ static int adm1266_probe(struct i2c_client *client)
 	crc8_populate_msb(pmbus_crc_table, 0x7);
 	mutex_init(&data->buf_mutex);
 
-	ret = adm1266_config_gpio(data);
-	if (ret < 0)
-		return ret;
-
 	ret = adm1266_set_rtc(data);
 	if (ret < 0)
 		return ret;
@@ -483,6 +479,10 @@ static int adm1266_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = adm1266_config_gpio(data);
+	if (ret < 0)
+		return ret;
+
 	adm1266_init_debugfs(data);
 
 	return 0;

-- 
2.53.0


