Return-Path: <stable+bounces-267405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t9MSAtdTNWqEtAYAu9opvQ
	(envelope-from <stable+bounces-267405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 16:36:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F946A670A
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 16:36:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=astralinux.ru header.s=mail header.b=HfKAFaoe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267405-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267405-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=astralinux.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4487B3031332
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C5C3A1A27;
	Fri, 19 Jun 2026 14:34:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007D38E12B;
	Fri, 19 Jun 2026 14:34:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879698; cv=none; b=J2AbORJJ5YkI2esuM5f3GIwmlhJQLIzV44TY9Z4ZYGTDauF/GSFJTTunLGio5vtRudJDCzk2IPVp/u1c1JAuh5vt0X8pVMnLKwPCmhOIxZtnqonXuLKpi3sTdQLE3kRw1xi723Fp81zJNPNh32ipcXytVRKRbiLuJvbWkKllktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879698; c=relaxed/simple;
	bh=NU3782cVOybHYBLWoHmEeKhEJd3b7gxDgkIUQa1NAw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a/gSHaIGZkVL5tr0AerqVjm3qFkuTEfxm8R0G1Ep3CPfr0DlaShq4mCldRs7s82/tkbVySwAa3pGSqqYtCqJH7gMLAlQO1OB+VxNoBBtWnNa1/bLWfiQZp4bRUrKIg9IwY+W8iwgTKYtRYIMUYPQpKD5R4LOPEggbBCS9KufH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=HfKAFaoe; arc=none smtp.client-ip=93.188.205.243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1781879690;
	bh=NU3782cVOybHYBLWoHmEeKhEJd3b7gxDgkIUQa1NAw8=;
	h=From:To:Cc:Subject:Date:From;
	b=HfKAFaoerEI7vpsIf0jatdLBLYHWyjU4udLsVn71iSaO+woW4WdwwKfy/WMcYgurf
	 ymheCG+6vLJn2nPAegaclrduMbEdVQ+FSNQCGdEMMSPFqTVd58NXPEv1a0VegNoFF2
	 kCQEM5WbmpGoZ3hllc7Ja3tRbneJ6kdQrdopc0NylLKoH+6P90riq2EvCG3CsFlV9/
	 R7/ZNe2/nBGkwLoqD2GCsKh14zR0iomBSnjrYnJv15zccr4mJrEL349skkO0NEVpVN
	 n0NS6HeXujrSntL4zmMsAXVbOhkWZpYfHU7QVpd7HqTxWCNV7HfbvDB7nEHXaF7rMb
	 1wnqNQyg8hjHQ==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 79C5E1F9C8;
	Fri, 19 Jun 2026 17:34:50 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 17:34:49 +0300 (MSK)
Received: from rbta-spb-lt-115149.astralinux.ru (rbta-spb-lt-115149.astralinux.ru [10.198.55.79])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4ghg942r2yzwQg6;
	Fri, 19 Jun 2026 17:34:48 +0300 (MSK)
From: Elizaveta Tereshkina <etereshkina@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Elizaveta Tereshkina <etereshkina@astralinux.ru>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15/6.12] iio: light: bh1780: fix PM runtime leak on error path
Date: Fri, 19 Jun 2026 17:34:43 +0300
Message-Id: <20260619143443.678491-1-etereshkina@astralinux.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: etereshkina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 108 0.3.108 b3af89ff4c48cefaff455d02ab4cd72c6de3312f, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203953 [Jun 19 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/19 09:24:00 #28253626
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[astralinux.ru,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[astralinux.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267405-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:etereshkina@astralinux.ru,m:jic23@kernel.org,m:lars@metafoo.de,m:antoniu.miclaus@analog.com,m:linusw@kernel.org,m:sashal@kernel.org,m:ulf.hansson@linaro.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:Stable@vger.kernel.org,m:Jonathan.Cameron@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[etereshkina@astralinux.ru,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[astralinux.ru:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[etereshkina@astralinux.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:email,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86F946A670A

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit dd72e6c3cdea05cad24e99710939086f7a113fb5 upstream.

Move pm_runtime_put_autosuspend() before the error check to ensure
the PM runtime reference count is always decremented after
pm_runtime_get_sync(), regardless of whether the read operation
succeeds or fails.

Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ moved both pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() before the error check instead of just pm_runtime_put_autosuspend() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Elizaveta Tereshkina <etereshkina@astralinux.ru>
---
Backport fix for CVE-2026-43355
 drivers/iio/light/bh1780.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index 475f44954f61..f478f12640d5 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -109,10 +109,10 @@ static int bh1780_read_raw(struct iio_dev *indio_dev,
 		case IIO_LIGHT:
 			pm_runtime_get_sync(&bh1780->client->dev);
 			value = bh1780_read_word(bh1780, BH1780_REG_DLOW);
-			if (value < 0)
-				return value;
 			pm_runtime_mark_last_busy(&bh1780->client->dev);
 			pm_runtime_put_autosuspend(&bh1780->client->dev);
+			if (value < 0)
+				return value;
 			*val = value;
 
 			return IIO_VAL_INT;
-- 
2.39.2


