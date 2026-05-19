Return-Path: <stable+bounces-249494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FJbDtMiDGpqXAUAu9opvQ
	(envelope-from <stable+bounces-249494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:44:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9140657A5FC
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0915B3028B5B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E33E9299;
	Tue, 19 May 2026 08:43:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00A3E7BDE;
	Tue, 19 May 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180234; cv=none; b=bDakxNIvvaA0cy0X+/iRkk2j08Fie8mYEnrMVt2pX5n7UYlGmGDWSJMN9Y8DzUaoyXgUUGdBRcVnP0YrhP8PQswkTMX9hDuSOuW77k5m2lbYefwvgUpuTcChfTzKiaAEkmMB7e+jiz+0+AbVRyrArWB3EYg5XB5u+QLETtXhahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180234; c=relaxed/simple;
	bh=iSJ0AS2xXghWt1W8sPzLPnGhDWHB+FN/8/ONggYmDVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=he8R6NdHqHwynqakfDhd975HAF3sEeyPllTbHKEJQjFSUZ28GEVVsov7Z37Cg129UZejjR8xK/vqMbGJ7THaPgVz5a9p6lhM0WAyIKieqHROspBq0DuZvdxmQvBOixQQ69N8Ziw5zD9e7hFdjXU4X2oJXX55WXp6ym8cXJMiBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubuntu.. (unknown [202.112.113.208])
	by APP-01 (Coremail) with SMTP id qwCowADXemapIgxqiN6_EA--.144S2;
	Tue, 19 May 2026 16:43:31 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: suzuki.poulose@arm.com,
	mike.leach@arm.com,
	james.clark@linaro.org,
	leo.yan@arm.com,
	alexander.shishkin@linux.intel.com,
	mathieu.poirier@linaro.org,
	peterz@infradead.org,
	acme@redhat.com
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] coresight: drop lookup reference in coresight_get_sink_by_id()
Date: Tue, 19 May 2026 16:43:17 +0800
Message-ID: <20260519084317.1472444-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXemapIgxqiN6_EA--.144S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4ktFykXFy8CF4DKFyrXrb_yoW8ur18pr
	WDKa45ArW5Gr4Ik397XrnrZr45A340yw4SgryfGw1q9w1FqF9avFyUXrnYq3Z3CrWkKFyI
	gr17tFy0ga4UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[make24@iscas.ac.cn,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249494-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9140657A5FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bus_find_device() returns a device with its reference count
incremented. coresight_get_sink_by_id() only uses the returned device
to find the matching CoreSight sink by id and does not need to
transfer this lookup reference to its callers.

Keeping the reference forces callers such as etm_setup_aux() to know
about the internal lookup implementation and to drop the reference
themselves. This is error-prone and led to a leaked reference when a
user-selected sink is used for perf AUX tracing.

Drop the reference inside coresight_get_sink_by_id() after converting
the device to the corresponding coresight_device. The CoreSight path
code takes device references it needs when building/using the path.

Found by code review.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Cc: stable@vger.kernel.org
Fixes: 226443925887 ("coresight: Use event attributes for sink selection")
---
 drivers/hwtracing/coresight/coresight-core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 46f247f73cf6..2cca4ed83e2c 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -624,11 +624,24 @@ static int coresight_sink_by_id(struct device *dev, const void *data)
 struct coresight_device *coresight_get_sink_by_id(u32 id)
 {
 	struct device *dev = NULL;
+	struct coresight_device *csdev;
 
 	dev = bus_find_device(&coresight_bustype, NULL, &id,
 			      coresight_sink_by_id);
+	if (!dev)
+		return NULL;
+
+	csdev = to_coresight_device(dev);
+
+	/*
+	 * bus_find_device() returns a device with its reference count
+	 * incremented. coresight_get_sink_by_id() only performs a lookup;
+	 * the CoreSight path code takes the references it needs when the
+	 * path is built, so drop the lookup reference here.
+	 */
+	put_device(dev);
 
-	return dev ? to_coresight_device(dev) : NULL;
+	return csdev;
 }
 
 /**
-- 
2.43.0


