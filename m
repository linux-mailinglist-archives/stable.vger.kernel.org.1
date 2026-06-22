Return-Path: <stable+bounces-267608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wFCRBlngOGoWjgcAu9opvQ
	(envelope-from <stable+bounces-267608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:12:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A836AD2A4
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:12:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=Mc61r6eo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267608-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267608-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0B40303B716
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 07:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F774361DC3;
	Mon, 22 Jun 2026 07:11:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC363360ED5;
	Mon, 22 Jun 2026 07:11:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782112271; cv=none; b=LSrDqqVPyubQuVgbcDhHvcWyXdPNSDs86LPqiQWCDBHWyVpX//ic728db13bPzlgMyXRe0jtsJ1Gfe4G4463yjIhDsIEElo2R4XS1J9GmqpS+oClFoL2H7RB1EWiqCHVwtulm+M9hG+qgacBtbipGxdeEMz4qbD1PbEwxIcTjs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782112271; c=relaxed/simple;
	bh=B40VaEU65JwSYa7gOXvsSdUFzIVvMvqwMZdEw1ZcIV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDXUQyUlGwnpCMRVWxdTRsp9eaV+JCXVT6DcbMmFj/YFCbnjO5Eq8BkmPtnux7zRFN4QT9krjhHKjO19oEfE6UP/ckReRNjWNkO0lHclrevaFJnTFsaTuERjQ9DjhCzEvHBvTl/7/eBwHyjE+G1+15skOoaW2uLf5w/SsmpD+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mc61r6eo; arc=none smtp.client-ip=117.135.210.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PK
	KpVdrDqnA2ZI2QQYb9QpGJK08L53pkl9uf3Eglr+E=; b=Mc61r6eoBo3Zj2fSog
	DbAenP3c1ATyZb8YielV5V/QhtIZNPmWDLsD+VRT4q7KPOcwTWLLdnj9fn3t7u0w
	qBI5dHDFGnqdP9OE/1Z0QMucpqt2VmnKU2cH15FOpje5KP5QscdN4nejk63+IgRZ
	iCC3ak4ikwPQWJmYZiXILHZqg=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wA3RArQ3zhq4SzfEw--.24449S4;
	Mon, 22 Jun 2026 15:10:15 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
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
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH v3] coresight: etm-perf: Fix reference count leak in etm_setup_aux
Date: Mon, 22 Jun 2026 15:10:07 +0800
Message-ID: <20260622071007.691231-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3RArQ3zhq4SzfEw--.24449S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4UAr17uF43tr4kJF48Crg_yoW8ZFyrpF
	4jkws0yF98Gr40vws7Jr18Zay5uw4SvF4agFyfKw4DuF4YqFWfZFyjgryFyrn3urZ5Gas0
	g3WxtF48uFWUXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_miiDUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC0xfV4Go439cCMAAA3Z
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:suzuki.poulose@arm.com,m:mike.leach@arm.com,m:james.clark@linaro.org,m:leo.yan@arm.com,m:alexander.shishkin@linux.intel.com,m:mathieu.poirier@linaro.org,m:coresight@lists.linaro.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:make_ruc2021@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[make_ruc2021@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267608-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[make_ruc2021@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linaro.org,lists.infradead.org,vger.kernel.org,linux-foundation.org,163.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61A836AD2A4

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

Signed-off-by: Ma Ke <make_ruc2021@163.com>
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


