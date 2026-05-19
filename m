Return-Path: <stable+bounces-249581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNK0H4hcDGrMgAUAu9opvQ
	(envelope-from <stable+bounces-249581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:50:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF157F01B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6946D301F5D3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692103161BE;
	Tue, 19 May 2026 12:44:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521E4A340C;
	Tue, 19 May 2026 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194663; cv=none; b=L7bDkW1b98Jvfvxp6iy7YJ9hYKJQar2bB/5tU8gslIbDoUdiKgPAQ84L/16cJ7W7wk+dL2fqreMaVi7JYKSyCYw+EPg4E4b2N+4dH1YA7ck9y2rYJGM8G9kHCnbp1gXtdEniBSnrd2EWyCOgyvUyVnARJ5kk/CpvZanADjDUL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194663; c=relaxed/simple;
	bh=fF6Uoj9AQ8ugSOAAgLX/KKhg1RLSQ6zAcTIQddMFxBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8Gg+zR9NEHr00sYb0XHJkitPq2yGFJnpYOkeUVYE0ErHOdZhRggBFRDqbjboiNNYg0avzsjOpksXjCdnTzrDh5YvCeOh5h6msCUqPIBvZwDzjwCWBVpUVS754uU24xWh8Lg6XoIsxc4Wx6NygcxHXo4hB0Bv0es7FB4c9IWVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubuntu.. (unknown [202.112.113.208])
	by APP-03 (Coremail) with SMTP id rQCowAC32N8RWwxqEC+KEQ--.16549S2;
	Tue, 19 May 2026 20:44:06 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: suzuki.poulose@arm.com,
	mike.leach@arm.com,
	james.clark@linaro.org,
	leo.yan@arm.com,
	alexander.shishkin@linux.intel.com,
	mathieu.poirier@linaro.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] coresight: etm-perf: Fix reference count leak in etm_setup_aux
Date: Tue, 19 May 2026 20:43:57 +0800
Message-ID: <20260519124357.1656180-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC32N8RWwxqEC+KEQ--.16549S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4UAr17uF43tr4kJF48Crg_yoW8ZFy8pF
	4jkws0yF98Gr40vws7Jr18Zay5uw4SvF4agryfKw4DuF4YqFW3ZFyjgryFyrn3CrZ5Kas0
	g3WxtF409FWUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[make24@iscas.ac.cn,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:mid,iscas.ac.cn:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249581-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9AAF157F01B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bus_find_device() returns a device with its reference count
incremented. When a user-selected sink is obtained through
coresight_get_sink_by_id(), etm_setup_aux() keeps using the returned
sink while building the path and allocating the sink buffer.

Therefore the lookup reference must remain valid while etm_setup_aux()
is still using the sink, otherwise the sink could be removed under the
caller. Drop the lookup reference on the common exit path, after
etm_setup_aux() no longer directly uses the user-selected sink.

The CoreSight path code takes the references it needs for built paths,
so the initial lookup reference from coresight_get_sink_by_id() is no
longer needed after setup_aux finishes.

Found by code review.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Cc: stable@vger.kernel.org
Fixes: 0e6c20517596 ("coresight: etm-perf: Allow an event to use different sinks")
---
Changes in v3:
- do not drop the lookup reference in coresight_get_sink_by_id(), as 
that would return a sink pointer without keeping the device reference 
while etm_setup_aux() is still using it.
- dropped the lookup reference in etm_setup_aux on the common exit path, 
as suggested by Suzuki.
- updated the commit message to describe why the reference is kept 
until etm_setup_aux() finishes using the sink.
Changes in v2:
- modified the patch as suggestions.
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f85dedf89a3f..d5116177c1b9 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -456,6 +456,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		goto err;
 
 out:
+	if (user_sink) {
+		put_device(&user_sink->dev);
+		user_sink = NULL;
+	}
+
 	return event_data;
 
 err:
-- 
2.43.0


