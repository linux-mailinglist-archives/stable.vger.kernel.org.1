Return-Path: <stable+bounces-266955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SG9nGok8M2pp+gUAu9opvQ
	(envelope-from <stable+bounces-266955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:32:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE1F69CE7D
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:32:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nexthop.ai header.s=google header.b=jcDez4xM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266955-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266955-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nexthop.ai;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B08BE3014274
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 00:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F001CAA6C;
	Thu, 18 Jun 2026 00:32:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686E223322
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:32:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742722; cv=none; b=BrrQI6zTLOw0TZeXGtoakd783DaQgAlNQGWtMPb3KGBq2GpKuxZjTNOe/kgWjgnE1M9kT8xWNRExpyhAArXz5rvBWub87520Ld258b6BqJxzuKbLDdvvB3e0kVpUzNNuaYFBsCdivvC6r3e1Psta375TaGQ3SA0jN/ws//zibOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742722; c=relaxed/simple;
	bh=eNzyY5an+UYSDFqPtbJhs49fyNHe+L7Ce3ptMSTJtLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX2khPPXmq7px4WhMMHpoTaduPXieg5rZhBRulPvbzR3QXFebpW0UhxAMk5v7Ovc/6+7aimf9Y7O7h2BPn/UIwi/wkSlm1SVgQzu4VqtuQbwj6TxX0SMyAoMKFFSG3VEi/DR+Ox31dhO9RbhipRAe+e5EOqkdCCaBW2+kuWP8MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=jcDez4xM; arc=none smtp.client-ip=74.125.82.177
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30beab3af9eso1044927eec.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742720; x=1782347520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yiw7DU7NFko9mIKw41asQhT846GihiMJXVCKt9bBXvs=;
        b=jcDez4xM+Aj69oxtOss8KO6BjzNPEtBDO1RjYGCvNazWT5b/0jvmoNS8R1RyaKrnMn
         EIR1InwkuHKn7wNzuyQaBBfo4Dc9obI/eC/LHFaymqRVboTaN8XIqHWCBpksyhMz5Hon
         cQgL87Pt0bQ75ROQiDJiMZ41Y9hVEmyfMFpo9hghP02YNnSvrudiaWzdHltfKCzUc27+
         /+6uidxdU5MvjXjgHO60/9DmLlBJlD71Pm2bvW/q62SM1ESvGDPC7a9KyUddbjQAARqd
         5x6Q9lLPEcFk+wIPuK6VIczyj3oignHa4bMfXaXSD4pO/HkPjyE04VCS0LOxobQglBdN
         EqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742720; x=1782347520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yiw7DU7NFko9mIKw41asQhT846GihiMJXVCKt9bBXvs=;
        b=SW3ou8TIuaayUPuQd3tE03WzSsUQUp624/jebMkeDvDgtl+43J2S6gh5+UlHuoGLS2
         JM0rqLrGe/+yulVlBCr6dqnGcmgsvV4SvOpbFqn79ob12y+7HsLfoh0C5nFb4LSR+gtO
         6N6oru6D3floI/+e3yVmlQ9SwBuspg2C4zStGBs5L5O2MCsTWPWbXsFXVKmkhsNPF67/
         r28xdbBAu1SGzLdc0AjSXF+31w2KjhmaU+t37ZFnN0UYvW9i+YJjBgEKoX+sgsq0H9Rp
         Cvh82qDUEGMaGrmfAw/lH7MGP6pNn07DSbv6gw+VZYKiKoqQQwemgfACmX7F802Cx6Nl
         kYXw==
X-Gm-Message-State: AOJu0YwgvgVgt2kacHnDTaJXbge38N29C9B2pI5zXnOHJQKF8lcVlEom
	aaaHGEvBAJyXI9qNZc/hssdMRJNhdF9uVr7HngCuNkWPCffC4agGYL2txgS23kIvetI=
X-Gm-Gg: AfdE7cmUTceRFaB/PbuabEb6oVvl7JDU8t/jc9bjTzeQUTpCX4CQg9qiwQzJlc2Gudu
	mgR2uW0r06ys7YZ7hoL+ekvZuX3xV9G3gUsmh1JSgr7g2yzwXQEYfB8D8kYspl4o5HM96AtyxAS
	12RiRfTR3cwp5RXcYE2diuf1OgXuYs0S6XoQdX0BUtUILhvFfy7vMlW67SVQoy85u7PhafPjnz/
	bHJBHxwPWBhOc3OulnUtiHxKoCsqt7zmgXrI+AFnCMkA1Y9Sa0z71MuRzZxB6Uirzvq6lYIy+/7
	uscMoa7xXXEzVDfkZTMKxie+OVhnCRw+7sYpe0TXz2YrbZhztHLhem5J1UsT3QSOjFO1LPvBZPB
	bxnReKhj2sm4MFLBk8n5xm2jZV0SMpB/xnFVKfU4VYbJEqGrhyr9bHFFw4h7Hyz+QUplQu4Kszm
	r63zfkFofCTXWYkEJV8Nsy8u+aSxN08zdfbw==
X-Received: by 2002:a05:7300:1824:b0:30b:8877:77e9 with SMTP id 5a478bee46e88-30bc9f54aabmr4239002eec.17.1781742719947;
        Wed, 17 Jun 2026 17:31:59 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:31:59 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 28/38] hwmon: (pmbus/adm1266) register the nvmem device after pmbus_do_probe()
Date: Wed, 17 Jun 2026 17:31:18 -0700
Message-ID: <20260618003128.3112824-28-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
References: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266955-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:abdurrahman@nexthop.ai,m:stable@vger.kernel.org,m:linux@roeck-us.net,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BE1F69CE7D

commit 6af713af91d5c34ec049eb3cc2c5b3f5eba953b8 upstream.

adm1266_probe() calls adm1266_config_nvmem() -- which goes on to
devm_nvmem_register() and exposes adm1266_nvmem_read() to userspace --
before pmbus_do_probe() has initialised the per-client PMBus state.

Same latent hazard as the gpio_chip one fixed in the previous patch:
once the nvmem device is registered, gpiolib's nvmem char-dev / sysfs
interface is reachable, and any concurrent read triggers
adm1266_nvmem_read() -> adm1266_nvmem_read_blackbox(), which issues
PMBus traffic that races pmbus_do_probe()'s own device accesses with
no serialisation.

Move adm1266_config_nvmem() down past pmbus_do_probe() so the nvmem
device isn't reachable from userspace until the PMBus state the
nvmem accessors depend on is fully initialised.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-5-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index c3fd4d05a762..d37c71c0ad9f 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -470,14 +470,14 @@ static int adm1266_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = adm1266_config_nvmem(data);
-	if (ret < 0)
-		return ret;
-
 	ret = pmbus_do_probe(client, &data->info);
 	if (ret)
 		return ret;
 
+	ret = adm1266_config_nvmem(data);
+	if (ret < 0)
+		return ret;
+
 	ret = adm1266_config_gpio(data);
 	if (ret < 0)
 		return ret;
-- 
2.54.0


