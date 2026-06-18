Return-Path: <stable+bounces-266958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D24cKIs8M2pr+gUAu9opvQ
	(envelope-from <stable+bounces-266958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:32:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C669CE89
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:32:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nexthop.ai header.s=google header.b=kdDZzY6O;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266958-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266958-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nexthop.ai;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDC74301EC0E
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 00:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939581DA23;
	Thu, 18 Jun 2026 00:32:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A1227EA4
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:32:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742724; cv=none; b=Z1+iLC4VOXp/01Y9FNG4z0CiHx5RgdbkSIITX1rGmlvkOBMrNmq+RBxovDrEoabGNbv+yaAV/wYBHyl14k4xdepahRHzsJH4c5svGlau4t5uaunwhrZd/GNpntlXCFWy7+MN/Cor1JC88kLD2qTyPG2FH0Wva2tVaLNA6+PjJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742724; c=relaxed/simple;
	bh=Jx9Ax6SbXDWTMmmGxlsEVh8HAVZUE1v4PfB7l9v7pcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBLERiJHM+PHaBpXyvd4eJOpywDEPMowt4VnsYI4V+fFavk3heJpYGUXj2NKdJ+NzWYmMdZlOKMvXfmJnRaVPKhTpItZny1UxxruZpLdNrPRUQCHEGUEGXcKwlCJi5xdulqZiAsgk1UzxBz9pstwYjZXAEw7jIAl0E6cc/N846o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=kdDZzY6O; arc=none smtp.client-ip=74.125.82.181
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30bf132969bso398790eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742722; x=1782347522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHbAZjK/cz1kcFe5fSUkq/kHLF+QZBoC+wC/LlZktx0=;
        b=kdDZzY6Or1uKnDwCun9VKn9NkTeEQ/TSETjCxRauqHkaybvpHrFYRwo/2qmnHGJPCP
         G2Tf+EH70muqGuR+YiPrOYmMvVbOFtmgfAC1Y+GVA7Tao4abQKFVfMcCk+Wy657S6vJi
         UAWyOR+Hg+71hkeyK9UnsvHsk8Bi/hZxaSS9GPtwbCjmLj0ZiLNq6zVWpoBCqioE++v/
         eoXJHF0Tgct+vnzV2ozC81MJOE9aT2zg3mUtbZlWA7y970LXDez/WOYnXtUi74scas7Q
         VnyH8kuZSVNbDwvQqdOHecfIGDEbEU9icNYSglbkWSKfAaonCx7PUf28d2SIcPDZ5cju
         jGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742722; x=1782347522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHbAZjK/cz1kcFe5fSUkq/kHLF+QZBoC+wC/LlZktx0=;
        b=QBz3UYZJKUKW/eSfpfc+GZ3qjnN2g/+Naa9RvcWXAi1uyWA9BF8OoYxCmROirmi4lN
         QnM+6xBQGyA7LlJvAmJn6PWC3Vv4Y4R270sIj5TfT8H3PoKM4dkdv9Bno6oSODJAJea9
         NpAAy/OgT9BklRPHDUf7FdyP7ekY3uLvWC06jEbqnqER/M60Jlfxd+ri6w4iOiQPDH/l
         4i3YuDb+Uj1jOlbvbQ2K6BjUrGB+LS9I1/8tMtJgiccV9+SFrYYmcfFKE57zibluxbzk
         N7PEiZGRDjdBwUZweaUfESGW5QBbbnVJtEK/qzW5bAIP3AEsAadCubLGu8n7IVTjChOe
         Q5fg==
X-Gm-Message-State: AOJu0YzW4MZNHjtf1o55wGTEBj/eVF2/ZGANX6GWnBgokqVJcdTFXPbx
	9WT7h69g2MGVFFnxGeLx+pWpC0IjcN8aFAe9zNxCzouqlZ37buU/Mh04Ad7wJzlKiCI=
X-Gm-Gg: AfdE7cloDoAo+VbgIDwxN0+qXSQQiPZwBmNvGpH3CSxDwQ0tCXOe5Gzno5JEFi550wJ
	HSHCvjku+utlGaXPQT9jE58z1Tq6g1OYM1PeqBoyuA7c9+fAQunfEQ+XIBz947QCcPsyH2nl2zB
	ZBRUsAwnPpi6iMAJiEN58ii9IeoWKV85dXDMnuiPDWeiwKzSlWTG/zBBpyOEdjnJaJ8sI2Sj5mh
	eczDSikJT3peR3AGYbBYcDgQeYi4dNuhRydrSbpoP/OHoXnPr4raNBbLTeRnQppdjM6nlvhxg2f
	YIrqNFKL//wHAO795gZ2RwEYil1cjev5YHHWCPJEmwl8VXvYhXBc+MMk7Z+sqd2/RreDQOKkelw
	Lf8YIcHgh5lzflDHTbK7svQlGSJHRR7/frc3/ebcECd1Fow3UCotZvP6g+2zqcWaDJIv+eZh5ZX
	9j0wsh//kIDo8g1U8DCOxBavJWJEdYpW5W+g==
X-Received: by 2002:a05:7300:6da8:b0:304:d92a:e60a with SMTP id 5a478bee46e88-30bf0a3de5dmr806727eec.31.1781742722323;
        Wed, 17 Jun 2026 17:32:02 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:32:01 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 31/38] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock
Date: Wed, 17 Jun 2026 17:31:21 -0700
Message-ID: <20260618003128.3112824-31-abdurrahman@nexthop.ai>
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
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266958-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:abdurrahman@nexthop.ai,m:stable@vger.kernel.org,m:linux@roeck-us.net,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB0C669CE89

[ Upstream commit 9f1dd8f9491eb840cbea7ffdf4cad031e25f8ae0 ]

adm1266_nvmem_read() is the reg_read callback the NVMEM core invokes
when userspace reads /sys/bus/nvmem/devices/.../nvmem on this chip.
On the first byte of every read it does a memset of data->dev_mem,
walks the device blackbox through adm1266_nvmem_read_blackbox()
(which issues a chain of PMBus block transactions), and then memcpys
the refreshed buffer out to userspace.  None of that runs under
pmbus_lock today.

Two consequences:

  - The PMBus traffic the refresh issues is not serialised against
    pmbus_core's own multi-step PAGE+register sequences.  A paged
    hwmon attribute read from another thread can land between a
    PAGE write and the paged read in either direction and corrupt
    one side's view of the device state machine.

  - The NVMEM core does not serialise concurrent reg_read calls, so
    two userspace readers racing at offset 0 can interleave the
    memset of data->dev_mem with another reader's
    adm1266_nvmem_read_blackbox() refill or memcpy out, returning
    torn data to userspace.

Take pmbus_lock at the top of adm1266_nvmem_read() via the
scope-based guard().  Patch 5 of this series moves
adm1266_config_nvmem() past pmbus_do_probe() so the lock is
guaranteed to be live before the callback is reachable from
userspace.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-7-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ changed `guard(pmbus_lock)(data->client)` to explicit `pmbus_lock_interruptible()`/`pmbus_unlock()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 4afd10b8eea3..ae119caa6517 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -398,18 +398,25 @@ static int adm1266_nvmem_read(void *priv, unsigned int offset, void *val, size_t
 	if (offset + bytes > data->nvmem_config.size)
 		return -EINVAL;
 
+	ret = pmbus_lock_interruptible(data->client);
+	if (ret)
+		return ret;
+
 	if (offset == 0) {
 		memset(data->dev_mem, 0, data->nvmem_config.size);
 
 		ret = adm1266_nvmem_read_blackbox(data, data->dev_mem);
 		if (ret) {
 			dev_err(&data->client->dev, "Could not read blackbox!");
+			pmbus_unlock(data->client);
 			return ret;
 		}
 	}
 
 	memcpy(val, data->dev_mem + offset, bytes);
 
+	pmbus_unlock(data->client);
+
 	return 0;
 }
 
-- 
2.54.0


