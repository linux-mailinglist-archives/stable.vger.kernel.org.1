Return-Path: <stable+bounces-248933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NhSFW6aB2r/9wIAu9opvQ
	(envelope-from <stable+bounces-248933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:13:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543EC5589EF
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DE5D300862E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071773F44F6;
	Fri, 15 May 2026 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="I5Yrs9tM"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B969305693
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883128; cv=none; b=Cl1f7skqUYDqRkNgMRUieYhbd+OheJqNmekBjBJks9E7YjjsnqudjMX5kGQ37uHwwQ6ojHdY3VypodJScWm6K5/BkQ4nzY2NjBb99GJoLGzRWpyJmicmcOmLK6H6yEzyefoXlAtglxFhHzxLQiB9hncAwxF4NRHYC788LdhS4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883128; c=relaxed/simple;
	bh=YuUrT1BEnFyF/ImxIJNRuH++hsrfZzAUxyPbwt2jgrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUgq/uiZd6UMV51YC+v8lODir3Ye2VyzebO2dauBmg2H2gVI5atL60NnjZPRnkJ23zzaBi2+GEBjpfXBNubj/TQvWjSUBWaKtxRxG+7QrjgQxjjUyfamNT50VNiOZj3TzGtMnWUXZibIodRDdYZE8SSO5oyf9QLqfWZnkkB46zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=I5Yrs9tM; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f68f3b075fso1330319eec.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778883125; x=1779487925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lf1AbfbJq6OKtzU38AjcQmkVu/SnjdthMQ1Neq2C96U=;
        b=I5Yrs9tMQxiZpf6fOuxQk97nq51PWESCJmQx8KKmcOaq66BVukO4ecsuYvcm3A0pC2
         6VtXyoVadGJOKTN2dTHcVuqcExtWUZTHbmDXiaN0uqfnnOQSlZ68zRaqNalNBX0YfeOP
         kOaqFdhgCX3k2DxjjDhwDIc/eUiCIIpJW8JHqOZYvnWpaUqgeLTxr6uQoKDjxei+x4AA
         H0JxSK7WJaqLErqXqyIAZgBgTSCuxERmMz5BQkGa1Vp4DnUmU84gXPGcrbebUjOxWQA1
         22Trf/dQiv9SqwpyjTjO55bxi8jmIlgoPS0CbynbjZ411zxNlM1I13zIjzSDzG0zWms5
         rUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883125; x=1779487925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lf1AbfbJq6OKtzU38AjcQmkVu/SnjdthMQ1Neq2C96U=;
        b=KxoulHgu6TjFZjWMNv+juSFaTNxX+SQLRvJD9jtAVqfSdXp4uwzXcVIlONlT4Sq3BF
         SD4lDH1+hQJ210NeqCG2JMnlj6JvcFQdiF0LloZs2lqQRd3Hn9+BY+NmJEt1+FbfYmAa
         t/SQjecbP9gd2XAI0RTI3WRSQ8phJ6+ioor6h/SpgRae/zlNYPUwu+cx7EiRPAAhnDM/
         l3PyIKMDAyLy0InlMGjNNITRlur3A1korUgX71/5uhDLwEKVHHwmH/SE7d0qS1KG3/EQ
         SZTt0WwtMWQ2s7ld7EyiUBX2FuN9Q/en8R7B55G26W84auujDb6Lo4KHireOr3nrQUYC
         pxpw==
X-Forwarded-Encrypted: i=1; AFNElJ+SAqV14ydJSgMLkj7SP+dA09Wo1ZNEfRko18Zgj5G3EZyvx8khhJpl86BRWZCI6HlJYpYiDeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWtgLafoRucmzUmI7v0+p56oYz2jdEnIUM4FzPvzMAfSJYuOA
	qg/0q17tulnC/b3ZNzmxNi3+Ag4N1uzCu6lkVszoXYxlcSiY5ya2DAqx5I5GtzBl0zU=
X-Gm-Gg: Acq92OHvhWhcKkVN8kRp48quX7PSBadPEH/PZTcddZ1B/mNhGZq49Oqncymr6bhooui
	P5COy6LWQL0BxC0QVTanaxP1semYJLexKxzlq2xpq6TtFPa7yIMqvGSbn5HcCIbn8vZSDnGjlY2
	KR5beA2Kn586klCUuIGn8un0zTntOpKHHVABuwdzcIs9/BJcAP1Bzap3mNijOgKZptxUJloQZSM
	CeD9phiqRG3SlIkzX76mXOT2hb+pvZo0a5w3EVsTNKtgWsHc4IGBUvvSXhmeVQEEO8hg0uE+ZzZ
	hfgOYZ1DdpS1sL/FqigJ9xXP9iyOPBy1wIMP31gXFcR13R2NwHnztKYnPWwm+gcXexFK00Voc3g
	un22t+5jQ6oP30Z/4ydtf+fc21IWMbylcpDONEae/1X+hRkDu/rU8wWucT7hEFMDvUoZeG3QDqE
	dTLFwg4TeV5XCXVvmgveoT/M1wvp9MI9/zIw8f
X-Received: by 2002:a05:7300:be17:b0:2f2:6dde:df67 with SMTP id 5a478bee46e88-3039862657bmr2942193eec.22.1778883125129;
        Fri, 15 May 2026 15:12:05 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm9626315eec.5.2026.05.15.15.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:12:04 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Fri, 15 May 2026 15:11:48 -0700
Subject: [PATCH 2/5] hwmon: (pmbus/adm1266) widen blackbox-info buffer to
 I2C_SMBUS_BLOCK_MAX
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-adm1266-fixes-v1-2-1c1ea1349cfe@nexthop.ai>
References: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
In-Reply-To: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778883122; l=1590;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=YuUrT1BEnFyF/ImxIJNRuH++hsrfZzAUxyPbwt2jgrY=;
 b=Hkbvw8/WxKlbe9Pm3Qn0o3qVsSb8cvHHc0pzRPts595HAREP6TY9GKq/4yMbs3lGIgbYxXKGf
 e/EcqvM1iy6AHb7WaSHgPvXVXt3bFxRepcYluK3eKQN6k0+sI+vC2XB
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: 543EC5589EF
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
	TAGGED_FROM(0.00)[bounces-248933-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

adm1266_nvmem_read_blackbox() declares a 5-byte stack buffer and
passes it to i2c_smbus_read_block_data() to retrieve the 4-byte
BLACKBOX_INFO response.  i2c_smbus_read_block_data() does not honour
caller buffer sizes -- it memcpy()s data.block[0] bytes from the
SMBus transaction (where data.block[0] is the length byte returned by
the slave device, up to I2C_SMBUS_BLOCK_MAX = 32):

	memcpy(values, &data.block[1], data.block[0]);

If the device returns any block length above 5, the call overflows
the caller's 5-byte stack buffer before the post-call

	if (ret != 4)
		return -EIO;

check has a chance to reject the response.

Widen the local buffer to I2C_SMBUS_BLOCK_MAX so the helper has room
for any well-formed SMBus block response, matching the convention used
by the other i2c_smbus_read_block_data() callers in this driver.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/hwmon/pmbus/adm1266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index a86666c73a5e..94691dec1359 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -349,7 +349,7 @@ static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *read_buff)
 {
 	int record_count;
 	char index;
-	u8 buf[5];
+	u8 buf[I2C_SMBUS_BLOCK_MAX];
 	int ret;
 
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_BLACKBOX_INFO, buf);

-- 
2.53.0


