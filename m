Return-Path: <stable+bounces-127542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8974A7A56E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E95F17932F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCB024EF97;
	Thu,  3 Apr 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="aGFoUDH2"
X-Original-To: stable@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AC24EF65;
	Thu,  3 Apr 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691082; cv=none; b=sgUCyVVYw3j4Ovzit29qTMXLhOIhjpLmuMXzuU8ndPHAnox+LZzYdgnG4MyxN6IjfzTbulDcPDeoqbPaBJvZkebv9VpL3T0HGjhZVts2wqPPEn7Zz7raUDBs0oBGcDVWv4g/L93C3L4Cmr1OC8+u/+RjlEJW4NfBeRewCFw/4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691082; c=relaxed/simple;
	bh=EGDrURtfG5yFHwcUAchmVR+dug88BgT7eHBywOOr/gs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rSAnCRqpFD5TRB71OartswccldoAg0EIDwly6ABIhWPRLYK76QsJNNAI0jnIC9FPsw0BR54Ei6sGEfxI9/FRvECGbvYkf+p81IGZoibqUfkn93IC6Gp2dfGNOmH3HgMQEuE3WxD6XAxKuHq0zE6e0Cppd5HWHgLyo6JvFNgjNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=aGFoUDH2; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id A0D7E10CEBC3;
	Thu,  3 Apr 2025 17:32:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru A0D7E10CEBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1743690752; bh=0kH8yCOJxBoXdRUYBya9BNYFEjEa0yk3zYUKsrPhS8E=;
	h=From:To:CC:Subject:Date:From;
	b=aGFoUDH2sGyQbA6y/3ck69ucv+NkHWUdR0RTVr9tCbiaEtoI8fKjTZTNx2CO2MDmg
	 cASNKCueBcT3Kw47VQfLaj9RntHRTAKru6zR0NQWm6fBLN0mrFu6RE7Q3JT4rID9tE
	 a6nktyJ3RgHiBBWm4NN3qMsWYhs1XtsU3gXMG3Oc=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 9A4923052D09;
	Thu,  3 Apr 2025 17:32:31 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>, Luo Meng <luomeng12@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, Ming-Hung Tsai
	<mtsai@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Joe Thornber
	<thornber@redhat.com>
Subject: [PATCH 5.10/5.15] dm cache: fix flushing uninitialized delayed_work
 on cache_ctr error
Thread-Topic: [PATCH 5.10/5.15] dm cache: fix flushing uninitialized
 delayed_work on cache_ctr error
Thread-Index: AQHbpKU7QX5+wT/V+U2UI5y/KVFTOg==
Date: Thu, 3 Apr 2025 14:32:31 +0000
Message-ID: <20250403143230.1601620-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2025/04/03 10:37:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/04/03 13:33:00 #27853030
X-KLMS-AntiVirus-Status: Clean, skipped

From: Ming-Hung Tsai <mtsai@redhat.com>

commit 135496c208ba26fd68cdef10b64ed7a91ac9a7ff upstream.

An unexpected WARN_ON from flush_work() may occur when cache creation
fails, caused by destroying the uninitialized delayed_work waker in the
error path of cache_create(). For example, the warning appears on the
superblock checksum error.

Reproduce steps:

dmsetup create cmeta --table "0 8192 linear /dev/sdc 0"
dmsetup create cdata --table "0 65536 linear /dev/sdc 8192"
dmsetup create corig --table "0 524288 linear /dev/sdc 262144"
dd if=3D/dev/urandom of=3D/dev/mapper/cmeta bs=3D4k count=3D1 oflag=3Ddirec=
t
dmsetup create cache --table "0 524288 cache /dev/mapper/cmeta \
/dev/mapper/cdata /dev/mapper/corig 128 2 metadata2 writethrough smq 0"

Kernel logs:

(snip)
WARNING: CPU: 0 PID: 84 at kernel/workqueue.c:4178 __flush_work+0x5d4/0x890

Fix by pulling out the cancel_delayed_work_sync() from the constructor's
error path. This patch doesn't affect the use-after-free fix for
concurrent dm_resume and dm_destroy (commit 6a459d8edbdb ("dm cache: Fix
UAF in destroy()")) as cache_dtr is not changed.

Signed-off-by: Ming-Hung Tsai <mtsai@redhat.com>
Fixes: 6a459d8edbdb ("dm cache: Fix UAF in destroy()")
Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Acked-by: Joe Thornber <thornber@redhat.com>
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
Backport fix for CVE-2024-50280
 drivers/md/dm-cache-target.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 63eac25ec881..8a03357f8c93 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -1960,16 +1960,13 @@ static void check_migrations(struct work_struct *ws=
)
  * This function gets called on the error paths of the constructor, so we
  * have to cope with a partially initialised struct.
  */
-static void destroy(struct cache *cache)
+static void __destroy(struct cache *cache)
 {
-	unsigned i;
-
 	mempool_exit(&cache->migration_pool);
=20
 	if (cache->prison)
 		dm_bio_prison_destroy_v2(cache->prison);
=20
-	cancel_delayed_work_sync(&cache->waker);
 	if (cache->wq)
 		destroy_workqueue(cache->wq);
=20
@@ -1997,13 +1994,22 @@ static void destroy(struct cache *cache)
 	if (cache->policy)
 		dm_cache_policy_destroy(cache->policy);
=20
+	bioset_exit(&cache->bs);
+
+	kfree(cache);
+}
+
+static void destroy(struct cache *cache)
+{
+	unsigned int i;
+
+	cancel_delayed_work_sync(&cache->waker);
+
 	for (i =3D 0; i < cache->nr_ctr_args ; i++)
 		kfree(cache->ctr_args[i]);
 	kfree(cache->ctr_args);
=20
-	bioset_exit(&cache->bs);
-
-	kfree(cache);
+	__destroy(cache);
 }
=20
 static void cache_dtr(struct dm_target *ti)
@@ -2616,7 +2622,7 @@ static int cache_create(struct cache_args *ca, struct=
 cache **result)
 	*result =3D cache;
 	return 0;
 bad:
-	destroy(cache);
+	__destroy(cache);
 	return r;
 }
=20
@@ -2667,7 +2673,7 @@ static int cache_ctr(struct dm_target *ti, unsigned a=
rgc, char **argv)
=20
 	r =3D copy_ctr_args(cache, argc - 3, (const char **)argv + 3);
 	if (r) {
-		destroy(cache);
+		__destroy(cache);
 		goto out;
 	}
=20
--=20
2.39.5

