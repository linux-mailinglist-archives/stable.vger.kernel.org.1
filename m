Return-Path: <stable+bounces-260912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w8TsG+JjJGqh5wEAu9opvQ
	(envelope-from <stable+bounces-260912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 20:16:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DEA64E01E
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 20:16:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="m+cwtDG/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260912-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260912-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A8D301F489
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 18:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA43344DA9;
	Sat,  6 Jun 2026 18:15:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808C4071DF
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 18:15:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780769756; cv=none; b=LC1RbrGhM04LT1o8ZJW6hrXjLvVCG+A3E2oMhFq7ljylvbsbICQ+/lCtqTDWQmb0zgKrjyyZiIyXf49tl8xo7O4g78GsCKYd0fPAe2U3/J+bTHKXF5l4DVaL11cWTdbuwD+N6huhQrjfWmNahyY/vVvDzUfUzP2O3sZEN0B9ItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780769756; c=relaxed/simple;
	bh=ZOV87Kkg50R0fU874RmouwMzvXYtcr5UpWLqwmdVues=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a0hiE1Wkg/3FiY2IJ5MdiAbU51xgDrXJlyQUwnV/IPBLKYV0+a1vl+QT/VknqBmBDPWcPhNATfe9vvZ9QC4y6waWHj0e6708rOtx3yuhxxKgPvH7GXWd47urYOFumUbgeOYUQ523+tsaw9quy3Xes89RyZIYWF5zed1ZMW38w3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+cwtDG/; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-842688fa7b8so3358112b3a.0
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780769755; x=1781374555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lEo1sTatDYxKdvMuuk7DWQBRmBc0R0fl8GArZamftro=;
        b=m+cwtDG/LcbEAuGufoTYXu5hhDX0HwP/YdGO7KWqsF4A4mJulHZlVL9+HKcaRFP7UN
         ry/FBNGmp3W88Oz0+GGUfN3X+9atd2GB1ZT7UWrXbNrgueClqMtDO+v+0HxQIj7hUyBF
         eQNMjFLqIEmoFkgaNJT5bYyrM/1Gh16tAulWX5Cab+rj10pSuNJqhl13f93ka8DnBdok
         3kKOMl7OW5mrxUbv8dWs5iAcIdFZhBNR4ftAIb8IZ/UuPSEF4JqHlT+p73FD0dNP3nz/
         QctE+A71iMNV+8n4U0qA0Eu7skOlCvaLYcJneQdcIs0qakymot6oHJa2NoJ8mrhW2wO1
         0Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780769755; x=1781374555;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEo1sTatDYxKdvMuuk7DWQBRmBc0R0fl8GArZamftro=;
        b=ceP2MFLJHW86GstxMVWFN3KNxSlzz8hGYDQZJWYtgdGHLSZgjp/66A6TjcvlVmkMZL
         Ks83KtS9ZBuARF8wOVvHFdZRrLBosUiGaNGO9AdtKca45rtPFVmEYoXvvpbL6Zhu3UG/
         DeQwnrRi2jP+Okel9Zc4JpdpHLe+odXHbcr5h7xBhXkWWdsK88sP4Ive/3pFSRPm/Tfq
         to4UGN6+Jy/6xPQR1vBQ3WMAR6YRDYy+PxBIf13ujgzL3+QpprLN4bx1gGL6g643uoAe
         R0ZVH3mZy7JxfjiherW/XIOHarAqCMbxfaYzYW07D1ouKjsIA8N8t/+Cr+3KZwuFOjCY
         KaLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/q7fKkkJEet673m0wOZWsd7nd1An42lCfxGqF1ugTFIiXANmhpLBLU+JvjldW0qnf5hzXkvTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsOW4vzW1PSGACwVf9tE3+zZhslP+A7NlryJhoexLSTIrrw78u
	NnnoynOz6OzOJvOv8S3fRa5pBlzhNWfGvk8QKyPmZfc7sXUhF+gamv7mfcKNwzhqMk1rHKk9+1L
	yaO84PBwdN3Sv+Q==
X-Received: from pfbhr3-n2.prod.google.com ([2002:a05:6a00:6b83:20b0:82f:a3bb:a943])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1952:b0:842:499d:450e with SMTP id d2e1a72fcca58-842b6766a9cmr5712176b3a.20.1780769754473;
 Sat, 06 Jun 2026 11:15:54 -0700 (PDT)
Date: Sat,  6 Jun 2026 18:15:52 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260606181552.3095967-1-cmllamas@google.com>
Subject: [PATCH] HID: uhid: convert to hid_safe_input_report()
From: Carlos Llamas <cmllamas@google.com>
To: David Rheinsberg <david@readahead.eu>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Lee Jones <lee@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, 
	"open list:UHID USERSPACE HID IO DRIVER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260912-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david@readahead.eu,m:jikos@kernel.org,m:bentiss@kernel.org,m:lee@kernel.org,m:kernel-team@android.com,m:linux-kernel@vger.kernel.org,m:cmllamas@google.com,m:stable@vger.kernel.org,m:linux-input@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04DEA64E01E

Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
bogus memset()"), added a check in hid_report_raw_event() to reject
reports if the received data size is smaller than expected. This was
intended to prevent OOB errors by no longer allowing zeroing-out of
shorter reports due to the lack of buffer size information.

However, this leads to regressions in hid_report_raw_event(), where
shorter than expected reports are rejected, even though their buffers
are sufficiently large to be zero-padded.

To solve this issue, Benjamin introduced a safer alternative in commit
206342541fc8 ("HID: core: introduce hid_safe_input_report()"), which
forwards the buffer size and allows hid_report_raw_event() to safely
zero-pad the data.

Convert uhid to use hid_safe_input_report() and pass UHID_DATA_MAX as
the buffer size. This prevents the reported regressions [1], allowing
hid core to zero-pad the shorter reports safely as expected.

Cc: stable@vger.kernel.org
Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
Closes: https://lore.kernel.org/all/ahsh0UtTX6e0ZeHa@google.com/ [1]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/hid/uhid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 524b53a3c87b..37b60c3aaf66 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -595,8 +595,8 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
-			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
@@ -606,8 +606,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data,
-			 min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
-- 
2.54.0.1032.g2f8565e1d1-goog


