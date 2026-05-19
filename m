Return-Path: <stable+bounces-249426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SESkGuu0C2raLQUAu9opvQ
	(envelope-from <stable+bounces-249426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:55:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8AC575D53
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BB89306FFE3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 00:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4223C8C7;
	Tue, 19 May 2026 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="FokCYGVf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75B2F49FD
	for <stable@vger.kernel.org>; Tue, 19 May 2026 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151959; cv=none; b=hjay7NsjKpvCs/jvsPJ0RS7cIt8oTKPmplFoj5OMt6+C0L0v0/rcVfOtbzIH+QQyyx1pXK1OlurX1grKTe7U3/BAYJC1OoE89emGGliKPs+1znONoH97f0J3grmeAo7Jkjrebo5YYdSJhIYX6lZtlDZb0wQe3Z95D+O5FCfeU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151959; c=relaxed/simple;
	bh=FDObNUWMvwjjzrN2IkV6Cgo3wEKZLI2a8RqN+knZ8DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JXcAqp5iyMSgCV4VV3/HSMQI0pf+IEgY6JW9M4o+oROtC2I8kE/sPUOVTXHQgia6IhyP5MYmOvvPOH0fqB7o7hZLBZBvqyq7qqMdKldD0zqjHOqz6YxCcllrG/OkbC/x2QlkyNl1GCUbR43KXVPsKLUUQKorvSlnPCcNbBdq5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=FokCYGVf; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c1a170a50so3668521c88.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779151956; x=1779756756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/5ooRxhmqvebnRUuOuBr2iP+EihWYORWSHfWOHXOBo=;
        b=FokCYGVfbUh3NyYoQHX98CPim+tFdcPD3ttErufWDJtZIqPQbdnPeRsCt/cv+gInSR
         BAdSdvFMUROPobIGUgaWJUaodkTLlj0Lizu3cM0FW1Pq8CzEj6O8W7liMNbEpVBbXxeG
         v6vRGyj+YiNdB/sJYyCCbA/9da4qzUi5uTnFINwKDTPQA8qUOk8oqfbYwyk7cIF1eW0s
         u+Sgofk85lc1fhVYTPG9ZKi4wwkehkoyx1YCKxf+ZvcodoAO3O2wzaKPMSfgxK2UhEj3
         b+ny1xDjhaEVM0qBav3u1kA3jdlJFQlgpvwYTL3YWOTIeMHW1k+PJFbjvMmTTn91b+eS
         ev3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151956; x=1779756756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k/5ooRxhmqvebnRUuOuBr2iP+EihWYORWSHfWOHXOBo=;
        b=DIjclSDaT4Gyp3FdoYK6c2sd3SRhpgViv650/TE56/Z0l2rcZXq+AENMLN0UwUjj3r
         bif5ePEes9iLIjMYRBvh0FyLG928QiKORUEQCcHVK+Cdu//pKnlVkChx5m/iP5rNqYB2
         24fyY+/ZEHmhzb1sV8jr3iXa903QCqAM5XdcPwz2l7yzUqe46FSBAjQXBtHjZplt2eYh
         VGk3g+ulaQjMBsKLcN/F3PShOrSApfwWrgyU5Ca2Khf943kXm9u81p0oYYk01FvQDeFT
         VNm9ybpr12vFWMZqQOmyKpcU0LwHcJ5dKWhqZfBbHLsXgNaM/NkVsSrXZXwiLqXoZaat
         8KRg==
X-Forwarded-Encrypted: i=1; AFNElJ/flyMMzlK4xee+6bZdswCLelclVLV4YyNpEZskw6DwybjI4t0+jRJMFliDmWo2HNU3mIQ+u48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHAm/t05tb3USfOEKVC4FI1tshrrk7McYH15joDDRv+6yJB9j
	8A+AjxTeEPqco+jEY1CqqufgMslQXVeRHZH1h7hBbkuFHNEYZ7pBMdW6OfO7nbamkTs=
X-Gm-Gg: Acq92OHoWV5GdgK+IlUKgK1Pa5eQQ3rvpKWCLGq9iUe58AQxz+DvMMEECXdeWbk0BEu
	iA+OeSCMWyImUm+o9X+yQs3SMeTHvUG/67KbRdtG/stbIdXA/3nyFYtuT9sHTQxt6HSLWasxz1o
	71X34x7oBJPViqjiufz18/LugHesQhJKbAJAguahHMqCFsMAkm7y5KsglTDpjsVeOiXxDpNJK+F
	5+deyCs5PkHLS5IRoA+ShNSRpuflUqu3AR8l9jYnTuwZUxRLFSD21hwaFwBprgTBVEfN9bNoL2l
	tGFjKdqzwJs/HOjwEsQNrgXAZC45bHL6nPIYgWLIVo0oiAl8VCYdW2JxEaWG5pVPV+Ag/bitGlf
	9V8kzRxt0xnH/pYJs36mQ1sOP7k/ULg93fs1dNZkRYQytKyQeW/lV+44K8iDcKT3iVKSSDzgrCJ
	z9bGPACYyZZeyn8b+RQKRPES6hiw==
X-Received: by 2002:a05:7022:f88:b0:12c:2dd7:9099 with SMTP id a92af1059eb24-13504945cc6mr6484019c88.30.1779151956046;
        Mon, 18 May 2026 17:52:36 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm22546633c88.3.2026.05.18.17.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:52:35 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 18 May 2026 17:52:31 -0700
Subject: [PATCH v3 7/8] hwmon: (pmbus/adm1266) serialize NVMEM blackbox
 read with pmbus_lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-adm1266-gpio-fixes-v3-7-e425e4f88139@nexthop.ai>
References: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
In-Reply-To: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779151949; l=2029;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=FDObNUWMvwjjzrN2IkV6Cgo3wEKZLI2a8RqN+knZ8DY=;
 b=o4T0vpm7vwd7nU4PKFq3LRjfSe8OC/WKKKQElG1ohtEyZMkibITfRtuoo4iMw2HUrWZ5T/jQj
 fdKq75w5UTrA8wEIqtvyvFpSdRLwy/IkjcE+xsu56FiOHl5FTYfOXj8
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
	TAGGED_FROM(0.00)[bounces-249426-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: DB8AC575D53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/hwmon/pmbus/adm1266.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index a80fb2ea73bd..051f4f188ec5 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -394,6 +394,8 @@ static int adm1266_nvmem_read(void *priv, unsigned int offset, void *val, size_t
 	if (offset + bytes > data->nvmem_config.size)
 		return -EINVAL;
 
+	guard(pmbus_lock)(data->client);
+
 	if (offset == 0) {
 		memset(data->dev_mem, 0, data->nvmem_config.size);
 

-- 
2.53.0


