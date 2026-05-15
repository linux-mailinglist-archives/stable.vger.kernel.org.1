Return-Path: <stable+bounces-248934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ90AH+aB2r/9wIAu9opvQ
	(envelope-from <stable+bounces-248934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:13:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0871C558A19
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9119E3009E3E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365143F5BC0;
	Fri, 15 May 2026 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="NJ1liADs"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF83F44D8
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883129; cv=none; b=Mk7Sp/zx6VvqOn3Z8jJrTrXiYcTdvtekfHUKd9vzRNMtz+ZqXOcEkDTERzN98unVeMXr6IHLakiKs1KTvfyXPDaTWnYNERMfVaoVMEk2K9WJaWbdUG4FnjN25arb9OIMyGAJ8UhrNn2EoK0qDXFd/LpMJu7SegQ9ekXD36ap12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883129; c=relaxed/simple;
	bh=ETivrwyXTq+z+Tc9f8R+CJ4bEtqYJQZwPgtTKbESsR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=odOxVWQEtHsMGBOQEF+t0C9KYYnx5jzgMCYjq+bgzIdTYs/BTDOd7Q3ToLLM3kLyeKRj5Py9JbCRL+/l2geMrvVzgm7zeI1BanGBvLFil8OWohljSt6VG8+d29r3kXjUr7EDBl86R6KCYG2KPHEudw6/KLTUpPsF//46Jt+Tqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=NJ1liADs; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso331184eec.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778883126; x=1779487926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VK26/8ZVBf9AU0/JWVkP19gRCj8fh89lDWUebzaejUk=;
        b=NJ1liADsROPs6MI1VskgSPEiKEBv5K8RpAzTUZDHhIR2VBApk/ngU0/CYej7i+QzYQ
         PqvQeKV1um2cJYTyD67/5+RP0cFeFXuMbKNutbTRWHoeVs7GS8cLhEZyH5WQwEs/KMYl
         9rrB6+brdtGlk3PmLxnkKSCX7/zvf389CjG0MUetgD389CAyeUJ0QqKdFsUWce1iY1pg
         s2nbI4phVhRXk0Bn/q1Dfoo70B0UDgBQgVidRtYvzECPyyT92lh9pL0wOlxZ3Y6yXM55
         p0gCb/QBcIKEJg05VXuNuZuL3RCS6swV9eBy1Kjpfy/+NT1vwoaB7f6wjaBDFmwYdX3e
         EItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883126; x=1779487926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VK26/8ZVBf9AU0/JWVkP19gRCj8fh89lDWUebzaejUk=;
        b=avN358bUWLfcezNUUvC3mO/V4l5Yc50VMvyCaC2Njx11DdJCZGoCKN1YJ0StDVJuNU
         UWGwD6VopLUTy7kLZpgodgzNoI1xbQoL2duglKTIGh/1idosfk7yh0FGdHwOQo4+WCHX
         yPOmJ32KUzlhY0g8mPHfKo0gF/gEJoF3YzxWBtMWbGA+mSHU9XTt7eHNRUa4VTPXZY0A
         8etuC7cjBtlevJ3hRd7rGJibAZzAWWVmpCW6eSrqLpvOEVOW9SoDW5ZLcZQdGygfeAvj
         rIGPrJX8r3jnWiAM0aga4GMCir6JDe47MuTAvUOGrw3Z+KqSyltVzXcJwKJKLPgLPXIZ
         bZQw==
X-Forwarded-Encrypted: i=1; AFNElJ8I16f9nWjQ8iTlGQtUVjPUxHViemdXbQ4WPun2bV8RzsAnjmHxEMAsgCvHhc0CzMVyu3ll0TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBfFXC6Oi/VbcB91nrt6o/rPMMv67WR5FNMVOcVAS/lmwn9aj
	DYsRHPa1I//ad8BVBs3LVj69jvzB4agNR/sbSBE/YL4feIy63s8ypUUGe9ae/TgJJv4gCtwN/hn
	ZR1/AzmY=
X-Gm-Gg: Acq92OHv6NZM+EzTF8jl+3XWu2b2yN0Sm2EILdU7ijAZwOVoUL0zPcUs//MhRM/aijn
	A6IRtRjWCrJrdCdzpIl17xViP/dLGh39eCTU9FZdbHRPKz5DpLwq3scpfWWeVI59YWlQPDxSMMh
	vnm3JOLQVr8rWHog714k/D6JtOnOaS1Tek0u5VGQ1TTN8sp+QWKxePVYJxg856WVJwcLz1wVoFf
	2qRVjDJXOgVLN0nw4uKWr4lhBzw6iUFkA4tmLNSPXHv7OUUl19f8fr0vfs7NdDFGL/Bty3U7Oma
	bYzaR6m5RqpSCq0NONNAG3EvLuB+gLHm5ypqfTqzoFvBm15GNt7GSIDXgddDCvR9Dg8g0wqS+rP
	K2JpewEXdHkruTrBSwI3hEJ9kAlV/+EHvk+SexFrVv1ysOkjoBjPNAb2E4zKsPfCxbEc0CECJ/a
	P04fQhuCgFI4wJwlYwD/xMeiHtsQ==
X-Received: by 2002:a05:7300:2216:b0:2ea:edc0:4fbe with SMTP id 5a478bee46e88-3039818a842mr2935169eec.14.1778883126240;
        Fri, 15 May 2026 15:12:06 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm9626315eec.5.2026.05.15.15.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:12:05 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Fri, 15 May 2026 15:11:49 -0700
Subject: [PATCH 3/5] hwmon: (pmbus/adm1266) reject implausible blackbox
 record_count
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-adm1266-fixes-v1-3-1c1ea1349cfe@nexthop.ai>
References: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
In-Reply-To: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778883122; l=1706;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=ETivrwyXTq+z+Tc9f8R+CJ4bEtqYJQZwPgtTKbESsR8=;
 b=8SOiEV2agb7TI1iKZEnDC91LZaCRSpz0eGiAL3QdL8dFrPyfdiPlcPRE3IrlB+eRS+Lsy9s4Z
 vh7m3FRKHa3CNcO24bG0fgz5UMOGhblHfQwXn03pugAXPUmz0F0jXLE
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: 0871C558A19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248934-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim]
X-Rspamd-Action: no action

adm1266_nvmem_read_blackbox() loops over a record_count that comes
straight from byte 3 of the BLACKBOX_INFO response.  The destination
buffer is data->dev_mem, sized for the nvmem cell's declared 2048
bytes (ADM1266_BLACKBOX_MAX_RECORDS * ADM1266_BLACKBOX_SIZE = 32 * 64).
A device that reports a record_count greater than 32 -- whether due
to firmware bugs, bus corruption, or a non-responsive slave returning
0xff -- would walk read_buff past the end of the dev_mem allocation
on the trailing iterations.

Cap record_count at ADM1266_BLACKBOX_MAX_RECORDS (introduced here)
before entering the loop and return -EIO on any larger value, so a
malformed BLACKBOX_INFO response cannot drive the loop out of bounds.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/hwmon/pmbus/adm1266.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 94691dec1359..43d9e7407795 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -46,6 +46,7 @@
 
 #define ADM1266_BLACKBOX_OFFSET		0
 #define ADM1266_BLACKBOX_SIZE		64
+#define ADM1266_BLACKBOX_MAX_RECORDS	32
 
 #define ADM1266_PMBUS_BLOCK_MAX		255
 
@@ -360,6 +361,8 @@ static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *read_buff)
 		return -EIO;
 
 	record_count = buf[3];
+	if (record_count > ADM1266_BLACKBOX_MAX_RECORDS)
+		return -EIO;
 
 	for (index = 0; index < record_count; index++) {
 		ret = adm1266_pmbus_block_xfer(data, ADM1266_READ_BLACKBOX, 1, &index, read_buff);

-- 
2.53.0


