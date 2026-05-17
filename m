Return-Path: <stable+bounces-249057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBFaIoMXCWqkIQQAu9opvQ
	(envelope-from <stable+bounces-249057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 03:18:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B5655EE03
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 03:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91AE4301E5A1
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 01:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AD12C158A;
	Sun, 17 May 2026 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="TcCiQumS"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B02BCF45
	for <stable@vger.kernel.org>; Sun, 17 May 2026 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778980707; cv=none; b=ACfmlzFKVt5VyxZjEdraQz7J7LQ9SRMCD95xFmDOi4oF9DAyLJG+Qkd+WTmUcSbJuOwm82XrcMxl/HaDcduLwW6qtraJjQbZqk/Os+Tr65kb2z2uc9ujN42RmBht3G+y0jQSQCgYgK5H3NUf+HzDKw13m80CFwJyzJzy/kVsUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778980707; c=relaxed/simple;
	bh=1oaVCYFu+Z3wn0PGr8YB2H02b7P7H8B/ZEdQDxK0+R8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJOR+b4oS99mrJn/59sprUXXMRDe0bGbjerpGxvPjDsUE/TjNTsZ8kYEAmv6hRJrx5NpBaSGMQ6etuXc2210sxQEID08B7jIR6sv+Z+1/FAuMK2q04cdw17jLmN73NlmrpGl8v9N/Xi6+oiXGl6ecqixmnSCN0Tg3nr2gU8+y8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=TcCiQumS; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so5126897eec.0
        for <stable@vger.kernel.org>; Sat, 16 May 2026 18:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778980705; x=1779585505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYSwPCVBiY867WtlOZHd6+dxA6JQuid7JW7mJwnbMfw=;
        b=TcCiQumS3JMRRQgYEl1wrq40MN8Mn/59wxYrvpKT23k3L8VjEZwEK0xFbB33BXhTHi
         O0AQPPoXg7//BN//7gMlXCtB4khoVY2U9zccNFhlFyU/zM0h0UUcKzub85EGF014sOpX
         ZXzlwsbIlfaW7NnMFg+lIIQpoXopYI2/UJaSS81WpBN5BmZ+nPRx5bdXhm06o4ar1FVw
         lpCnLG0lQbgAA5BIwQg2ZbDjO/J2uAaDZbqbLtbiaY/CB8bE+saqSozVf75uNqpqVbY4
         KNpFaIFrZER7QxIlmijRq/jQ0GoSyc2M0+TSQ0FugFu+PktMjcTS2vrudRl6YbZpfQzr
         Qjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778980705; x=1779585505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IYSwPCVBiY867WtlOZHd6+dxA6JQuid7JW7mJwnbMfw=;
        b=puaEmn+2kop86MfZ7siXO64EbCyhXtWyXKwbg0s/42TSTG72SepJpurd6+GV1+T62C
         xtUJ1oMOhWQS4nuuByaaAVBKZGwB2c2FlwYKflLXrt1rmiS911HMkf1fpBsPhLr1Jot2
         PPUgB0Z0rGgO8oIhKq2Abd0gpd2dhz1kkjg5DHDFRH4CEtt5yKOZnxd7nkM/hqdgvFox
         Am4ALChFPdLWXNh7dGy//wyBRJ7DZRCel5L7uXwpHiIKGbqJMJqMlYkcHtVtO4ChoAn/
         MWx/xyrCNZjEbrD2ewB1Lk/d8LFB0IRb8DOWHgGF0JulkXXyP3bBkG3a8uOwDt82ltoX
         F4Tg==
X-Forwarded-Encrypted: i=1; AFNElJ+a1XV6vcLEsV+Ip8MXoklPSL8YTzxItHlO3NuLcnO2RY6UFPtxQMywzIoAgxXh65Xpmu8Hf5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjN2xjNu3q6kC9Sz5Tw3hBBVlbMPd0gy+c4aYyNgCJTCdGV4Rw
	zZgWTOADGOrmSYucHTJXR39jwEo6c/xgJ2/PTK8pmn8smJJJwqnWzRnkuarXARCNU1I=
X-Gm-Gg: Acq92OGDvKMyr4HqzhAjIl9OEjFOGSqXkUI4++hfZqoB+WEACDBeGIhdMG2T1I7iB9q
	JXpjQNUFI6T9Tbi16lXWsEEhTyFyzGQzPXxanOpnQNeO08wLy8kWnq0hpatDWwKimstLm8Q56Wp
	OoibNju5Zj73BXD2lsq0u33EzBjjzadQ24zUcj4Bf24ot4iAPSyONmKVhMbm9a2mghrzAhfEtwQ
	2P1972PioHFR5y57FOglkWI7rVQ998E29TXG0Q80cTdN4PeT08bZDyrApIjLXV82H7ik6guGVrK
	HI9g9O7dP7/9GiJRvGrGvoTXzHTYqSlxnlue3F7nUGO2ozIBUZpTVML7fjMlKu1DFtinRe438jG
	yzjRIFd6VCt0Qwq3rzyErq/9xaBjQLoh7AaMj2tGfK4kjcd5dhyKBbfFNmkyOjDRj5u650Ru4BT
	RMgtjg7YyXXnK+4onT8TWPmJtqcw==
X-Received: by 2002:a05:7300:e430:b0:2f1:3aa8:f2c with SMTP id 5a478bee46e88-303981914bdmr4574268eec.4.1778980705368;
        Sat, 16 May 2026 18:18:25 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm10582179eec.20.2026.05.16.18.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 18:18:24 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Sat, 16 May 2026 18:18:21 -0700
Subject: [PATCH v4 3/3] hwmon: (pmbus/adm1266) serialize sequencer_state
 debugfs read with pmbus_lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-adm1266-v4-3-1f8df4797258@nexthop.ai>
References: <20260516-adm1266-v4-0-1f8df4797258@nexthop.ai>
In-Reply-To: <20260516-adm1266-v4-0-1f8df4797258@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778980702; l=1541;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=1oaVCYFu+Z3wn0PGr8YB2H02b7P7H8B/ZEdQDxK0+R8=;
 b=gw9OQFjQpIlwlV53+0l9EP5duOSRP6WpWgKJG5fonuIRM7fKGg7xEStTvs8VETKX9jmMk7tma
 /HbqVdVvgKqBdKEdbdmRGcXFTZWv+OJpKNiHYf/5ysVroM3jYn7OGr6
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: 07B5655EE03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249057-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

adm1266_state_read() backs the sequencer_state debugfs entry and
issues an i2c_smbus_read_word_data(client, ADM1266_READ_STATE)
against the device without taking pmbus_lock.  The pmbus_core
framework holds pmbus_lock around its own multi-transaction
sequences (notably the "set PAGE, then read paged register" pattern
used by hwmon attributes), so an unlocked debugfs reader can land
between a PAGE write and the subsequent paged read in another
thread.  READ_STATE itself is not paged, so it cannot corrupt the
PAGE register in flight, but the same defensive serialisation that
applies to the GPIO accessors applies here: any direct device
access from outside pmbus_core should be ordered with respect to
pmbus_core's own.

Take pmbus_lock at the top of adm1266_state_read() via the
scope-based guard().

Fixes: ed1ff457e187 ("hwmon: (pmbus/adm1266) add debugfs for states")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/hwmon/pmbus/adm1266.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 2edf3a424679..1425371bf1be 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -323,6 +323,7 @@ static int adm1266_state_read(struct seq_file *s, void *pdata)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	guard(pmbus_lock)(client);
 	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
 	if (ret < 0)
 		return ret;

-- 
2.53.0


