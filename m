Return-Path: <stable+bounces-268749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q3H+BAkMPmpj/AgAu9opvQ
	(envelope-from <stable+bounces-268749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 07:20:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C06CA46C
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 07:20:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NQ0QhaXk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268749-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268749-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3FC630A1E42
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 05:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8E2750ED;
	Fri, 26 Jun 2026 05:18:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD453A3E9C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:18:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451097; cv=none; b=GcStdljTgMCqCtuROsneOxD+lsXFwne5Kp1oHiYc9Ft12X1hiDeTa0NzNehEVi/p4H/WlcpZnWPUjPmEo+T0JTxnjoAHnKfMhCcNnYZK+vGXnyZ1wSLoagYBiG+Wv0ScQucdbfEG6iBr0k3CRT88uuOZhxg+iJdd72SMFlf9koE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451097; c=relaxed/simple;
	bh=jH7yxfAWC8FtCXBmBiE9SK+l95/euwLj66x/Rb8M4CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0MjDokgS3yZ1fKvAK91q5s+5iCxrKxoliC1aoqHNBdNFpb2CC4/j+TYi3cMKPnUSdAZ8acgE3W3f7OUUQEKWuGVAIDmobqm0Mo/AL6ubhQZq1rJhE03IbY8SMLUzKib0exA6umMOZ6/3sGvfyPU+nTw3t68295/XNjoCRB6sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ0QhaXk; arc=none smtp.client-ip=74.125.82.178
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bc806fcf8so780987eec.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 22:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451095; x=1783055895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtcerxrkCDiELjGdG5Zz4juXMZ/LQY8Cpjf1LHHQ2PQ=;
        b=NQ0QhaXk3diD8JH9JWypjya9K2iQYfmZC4ucfrQ5Bvm2AMz3U22WRmva1okoX2giSa
         +sFJfMgws0PDCovEW5ZYhbcbmfs6wT8zvy8BCFTWPLVUUUSStD+BhQAH2tq3oUojCV2c
         ftn+ZH+1K1hBJu0NdqxRFkctNPlh3Oc+NLFqghKQcs6NkUsBchVr9Z8Cp2ni4raxuQqj
         sIGBJD4S/1YeaWkn6G/yWiLiWrOlS6LLEmT/ofiW31cRn7j480UO29JXbGpuUPzYnZBp
         LkAzM4GktVLDDaLYUERKBUP1dAilIZrBCkagVCYtvm37pRkqWUCqdx5xo8OhK7bcS25B
         nzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451095; x=1783055895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtcerxrkCDiELjGdG5Zz4juXMZ/LQY8Cpjf1LHHQ2PQ=;
        b=ao4iPRtxxApXDuijIfhTzxw6eHtG00Kvxv6fcPTJotRzeRFQ3h9UfNourtL2yIhFsk
         YWJ5xDAPAv8MEwtG+icrJJc9QaKCQMxRdbrN6VSGg3QOnWKZnRsnolZD5A0H+vIyq1fc
         tZR6Rt89N/X76r0Cxv3aKbvF3EYhYR/hqwWQgyPkpwupWLbHa5TRwlsQlJ9+OLAyylqe
         BifZaGmZ63cWWJwvFWx/7tzPZiC7P+kDsq9ZYxZZUriYOPnFe70prW1xIHbsCK/JUuHV
         OPbkUCRO2hvP6Cxa7w908xgwHjbNgwxMrc1jjlsCgO2rAGIBFDEVWGzS62lsHekUN+Rv
         lfkg==
X-Forwarded-Encrypted: i=1; AHgh+RpZQD5uAGTzVVYLVKPSP7mogTFiEb8Te+XXbx1eEh1HVidbGTRb2zTUDpymjcSlWszT9ox1ddc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxjaxHIL4HpGKlhdhhdY6N41wAn0cCmqnxCBwOLXIJRIYnh+f
	F37l52JX1vm9DztFjLAh5ZsRsULK93MCBFLTQN2v1fOUTHfQN19VG+Nn
X-Gm-Gg: AfdE7clS8i36RhdomeamyFwRNHJp89WRnR4gdcvaJ56SWuNT14hi2th3Z+41r5GpKdI
	ym6rTimX1rzthtoq6WBILtqen5MwyJmk2I57n0nbWPHbQGFNEBvIu0IVswOZjv1KKbSwohBO2JL
	Z5PISndFVjwZfYTXqME25gMLqJhlErP8V504KyjlfrbAtrpFXm++e8E2IuFZmi5CoUxuD0oGkQp
	HEe0HMLv0urM832V8B/ZgH7p3zOd00YSp+P1vqvZ2iD6unoybxKPy2A0YIgOQC6axWAFt4IP18p
	ID6rg8ySCGYa8RFfvfu4rg+8knt40NDVb5F/hOC2xK2vSB6g7ZBLjnkFtkcq8CqOj0odeUt9Kgt
	JDE9EhbtR48SZDs41Rl3Ar/6VCvSBbkHX8c3lwKVVExFYA48ZwTf5m2mm/k3fJg2R4BTNvF9tMC
	bdboQW1MDNb5cooMSpUFymR6Yv3J0rgRgGNpp8RRrCtOPGfknLRgsON6S2CGp3w8EDRBTvUozFr
	uBD
X-Received: by 2002:a05:7301:3f0c:b0:307:91f5:92e2 with SMTP id 5a478bee46e88-30c84b2b217mr5193094eec.4.1782451094992;
        Thu, 25 Jun 2026 22:18:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 07/10] Input: synaptics-rmi4 - check V4L2 buffer size in F54 queue
Date: Thu, 25 Jun 2026 22:17:56 -0700
Message-ID: <20260626051802.4033172-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:hverkuil@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268749-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E8C06CA46C

Add a safety check in rmi_f54_buffer_queue() to ensure that the
requested report size (f54->report_size) does not exceed the actual
allocated size of the V4L2 buffer (vb2_plane_size()).

This provides a defense-in-depth measure against any potential size
mismatches between the V4L2 queue and the driver's internal state.

Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index c86bc81845bb..93526feea563 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -354,6 +354,13 @@ static void rmi_f54_buffer_queue(struct vb2_buffer *vb)
 		goto data_done;
 	}
 
+	if (f54->report_size > vb2_plane_size(vb, 0)) {
+		dev_err(&f54->fn->dev, "Buffer too small (%lu < %d)\n",
+			vb2_plane_size(vb, 0), f54->report_size);
+		state = VB2_BUF_STATE_ERROR;
+		goto data_done;
+	}
+
 	memcpy(ptr, f54->report_data, f54->report_size);
 	vb2_set_plane_payload(vb, 0, rmi_f54_get_report_size(f54));
 	state = VB2_BUF_STATE_DONE;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


