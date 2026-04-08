Return-Path: <stable+bounces-233841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNS2M8Q21mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:06:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 637893BB13B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6801300C326
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 11:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417B34DB6B;
	Wed,  8 Apr 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDwpVHEN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6C2BDC0F
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646400; cv=none; b=DeS3vco+52KWSKa895QGwBrtrp5gNyLw5z2vx2/LDJN2NoXFqq04ffNzeY0dT9b5dPQojLdIAha7czGQDrmuAtMwCm6kxqIj9PuhKL64fUd/GUDQhcoWvMdD8LWF70aZwVHY8RL22a0F7aHrpU2O/tcUzsAm2WWGN/KBhVBxXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646400; c=relaxed/simple;
	bh=Vhch6dxT6NteYtm2ncYe0Feahb2tNlGUnSePBe9Kdrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8CV+/yqmSCtoQeD1O+ZDTWGyvkftM4t8cBoBdofaqfNNKvWMh6DfA2AyUlAvigBAfBisThBvy5WoebcqJBiWUlZtdoZSjQPatp/fZH8UJk/VACthvia9H/eTlVY33zzqOZUIWEjo4/VGtNKlTx+N5cv3jZyHhspGp2hV+J6sZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDwpVHEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F956C19421;
	Wed,  8 Apr 2026 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775646399;
	bh=Vhch6dxT6NteYtm2ncYe0Feahb2tNlGUnSePBe9Kdrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDwpVHENq+SOQRutMDEBR7H7yxuKXSoQv7Mpz3EdISx6v4RkMxrzmbJjAvvgh7ef7
	 E8m44K2b7tho+rBDRoaKAqKz3I0zAgN1YmsqvsymiTX+Rm/D6XGtdjFX1kr73ez4Cy
	 MIiU3QoLLQK3xbOh1botStA3DzYvM9yuE4WAMp/mlp/EYkY4Xf1uqIoSgGHZ9URhtA
	 IHgL28pusnAtMjOuMen0QsOjyt+ImtAS9E8VaFZLeL1TiaoqmvCuw2yUwR384ZgZ/l
	 PC12jw7anjVSmNGTxY5Ej/6M+0tsxUJehgWj6fPV+2SW2VhmKdVomr0vFqFobhJCvB
	 iZBQ+nzOr5mMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] s390/perf_cpum_sf: Convert to use try_cmpxchg128()
Date: Wed,  8 Apr 2026 07:06:36 -0400
Message-ID: <20260408110637.978601-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040840-running-plethora-7f54@gregkh>
References: <2026040840-running-plethora-7f54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233841-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 637893BB13B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit e449399ffd295a1202b74a258227193454ef333f ]

Convert cmpxchg128() usages to try_cmpxchg128() in order to generate
slightly better code.

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Stable-dep-of: 57ad0d4a00f5 ("s390/cpum_sf: Cap sampling rate to prevent lsctl exception")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 23a2a49547b7a..62247f20c2163 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1188,8 +1188,8 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 static void hw_perf_event_update(struct perf_event *event, int flush_all)
 {
 	unsigned long long event_overflow, sampl_overflow, num_sdb;
-	union hws_trailer_header old, prev, new;
 	struct hw_perf_event *hwc = &event->hw;
+	union hws_trailer_header prev, new;
 	struct hws_trailer_entry *te;
 	unsigned long *sdbt, sdb;
 	int done;
@@ -1233,13 +1233,11 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 		/* Reset trailer (using compare-double-and-swap) */
 		prev.val = READ_ONCE_ALIGNED_128(te->header.val);
 		do {
-			old.val = prev.val;
 			new.val = prev.val;
 			new.f = 0;
 			new.a = 1;
 			new.overflow = 0;
-			prev.val = cmpxchg128(&te->header.val, old.val, new.val);
-		} while (prev.val != old.val);
+		} while (!try_cmpxchg128(&te->header.val, &prev.val, new.val));
 
 		/* Advance to next sample-data-block */
 		sdbt++;
@@ -1405,16 +1403,15 @@ static int aux_output_begin(struct perf_output_handle *handle,
 static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 			  unsigned long long *overflow)
 {
-	union hws_trailer_header old, prev, new;
+	union hws_trailer_header prev, new;
 	struct hws_trailer_entry *te;
 
 	te = aux_sdb_trailer(aux, alert_index);
 	prev.val = READ_ONCE_ALIGNED_128(te->header.val);
 	do {
-		old.val = prev.val;
 		new.val = prev.val;
-		*overflow = old.overflow;
-		if (old.f) {
+		*overflow = prev.overflow;
+		if (prev.f) {
 			/*
 			 * SDB is already set by hardware.
 			 * Abort and try to set somewhere
@@ -1424,8 +1421,7 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 		}
 		new.a = 1;
 		new.overflow = 0;
-		prev.val = cmpxchg128(&te->header.val, old.val, new.val);
-	} while (prev.val != old.val);
+	} while (!try_cmpxchg128(&te->header.val, &prev.val, new.val));
 	return true;
 }
 
@@ -1454,7 +1450,7 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 			     unsigned long long *overflow)
 {
-	union hws_trailer_header old, prev, new;
+	union hws_trailer_header prev, new;
 	unsigned long i, range_scan, idx;
 	unsigned long long orig_overflow;
 	struct hws_trailer_entry *te;
@@ -1486,17 +1482,15 @@ static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 		te = aux_sdb_trailer(aux, idx);
 		prev.val = READ_ONCE_ALIGNED_128(te->header.val);
 		do {
-			old.val = prev.val;
 			new.val = prev.val;
-			orig_overflow = old.overflow;
+			orig_overflow = prev.overflow;
 			new.f = 0;
 			new.overflow = 0;
 			if (idx == aux->alert_mark)
 				new.a = 1;
 			else
 				new.a = 0;
-			prev.val = cmpxchg128(&te->header.val, old.val, new.val);
-		} while (prev.val != old.val);
+		} while (!try_cmpxchg128(&te->header.val, &prev.val, new.val));
 		*overflow += orig_overflow;
 	}
 
-- 
2.53.0


