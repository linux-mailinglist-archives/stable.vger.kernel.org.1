Return-Path: <stable+bounces-269919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ElB6NOyLQ2pCbAoAu9opvQ
	(envelope-from <stable+bounces-269919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:27:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C090D6E2288
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:27:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=RSjykhL+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269919-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269919-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 645F03021C95
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35F3E9C23;
	Tue, 30 Jun 2026 09:12:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6333E6389;
	Tue, 30 Jun 2026 09:12:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810755; cv=none; b=ZjpCyXI16U/w/H5k0cgzGvrWSEi5k6+6h47yHxGZGheHHiXXtwB3G+Fx7NnwfcHmnFQB6OG9I6ALlBjMnPYtBL3YHadvvP2+bq05RAXO1ETVDgYEcbrcBr0gZErYjCI5JpShRCMuLNRz69HBbhXJAg+49h6ywRyghBoWKiH6g/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810755; c=relaxed/simple;
	bh=sjSntLCSysQkK53FZ+99YUPy4NhyQJPGMZYMeDhK/UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bD3y5+G8b6iJz8vFsGorwpFuHho8jo5eCS0saAIhavKiwjz+162aBU4SnqBbMhUx33qCVjqRpcLBkALAssP8AVNHR/xQX0iVx86/5Mh0h6CK56AukLPlt9A23UYAkktxEb83BrnFdQkFI4EOOU5/KzZGIbKACnX68bzFYY6emRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RSjykhL+; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xm
	vnf3eUbULdFm7pDoD/hgbP3E1mr0Xg4XKRaqaAFkM=; b=RSjykhL+dbsVXPTBLk
	GUIbRhSUf0WE1KMHCstknYM92E/6lOAPukvXFBF9Zy517hoZ/vh4PZJmZRZ92zeC
	Cuz7Y1bkcA3Se8Ht7I+H8uOvQkS2A5ejKMMMdLePMipez+MhGSjL17EJxQxaYe95
	z85vvbusaPQ6cl4t8tWDY80kk=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAn2PtBiENqTaSvFw--.25512S4;
	Tue, 30 Jun 2026 17:11:38 +0800 (CST)
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
Date: Tue, 30 Jun 2026 17:11:27 +0800
Message-ID: <20260630091128.1854303-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn2PtBiENqTaSvFw--.25512S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4UAr17uF43tr4kJF48Crg_yoW8ZFyrpF
	4jkw4Yyr98Gr40vws7Jr18Zay5uw4SvF4agryfKw4Dur4YqFWxZF1jgryFyrs3urZ5Gas0
	g3WxJF409FWDXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGjg7UUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC1AqfqmpDiEoCvgAA38
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[make_ruc2021@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_RECIPIENTS(0.00)[m:suzuki.poulose@arm.com,m:mike.leach@arm.com,m:james.clark@linaro.org,m:leo.yan@arm.com,m:alexander.shishkin@linux.intel.com,m:mathieu.poirier@linaro.org,m:coresight@lists.linaro.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:make_ruc2021@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269919-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C090D6E2288

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
index 09b21a711a87..a25985743b7f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -509,6 +509,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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


