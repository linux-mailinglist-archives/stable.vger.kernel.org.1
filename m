Return-Path: <stable+bounces-269564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v8ghKLdQQWoxngkAu9opvQ
	(envelope-from <stable+bounces-269564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:49:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5336D470C
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:49:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="jO/1wq9h";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269564-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269564-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F483303FF2F
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A25923BD1B;
	Sun, 28 Jun 2026 16:47:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361702D73BD
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:46:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665221; cv=none; b=WB5Gm01dXk4+fMzgxe9KCyYWFjMhMi7OoZVY6YHhmaDpTAnNl2V5B9N2JnWIUS2TQ5tMdp7t/OkCY1LcmplACYc8t/NrKonQj5Bx8wnhETMEFiUmjB1qu3ETwy4ZRMNQrqaj1bDSusCQhH4MVIBS4FfT6jUwNSPxKvGWPMuyQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665221; c=relaxed/simple;
	bh=NQDd7aTipShpTJcS/n12Lt/5N2jpXVMDt5mnwkK1bwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgsqbs7YHhSjPywLKanwiR/Iv6zptEY9IQSlms6IDCCw7cd7Uxpff1oAIDgCJu3WioHoECihlVpYWaDt1WWAfu64N0eOKxyJM5yi0IXMwNS4VBoIFg7vaPAWwmRpJmjBbut6MCg6TkTnT6+B91llsNErP63fzv00+o8yAaIT7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO/1wq9h; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4939a809b24so9527755e9.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665217; x=1783270017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L94599a5h3xEYD+xTPZLiwZIaocGIw8FBQJTuHEMGZ0=;
        b=jO/1wq9h1BwpU/Fi5+ORAYZJCevPtak0BopjfqJqXd8iFhs2hvS44oJZnQX/Y8U+X5
         tYJklpM6zdMWhR2SjQyMJtgI+HvvpwODEj6MJyfiLJB/BzQnuwkPgn1azJS2UeUgHSkF
         zbETCpQFkxpFz8LtoMBZAhdL200HJmKLU/8fH87oMRGzbNsJVO78e1qetRAHWKb5d/BN
         VfKPpL8mmwZdX3efQBhbUHgLqzyAhKXCNd6WBDLIDSGojD2+YJwbqqSVgQf5zOssSGmP
         kYpGPxcqqo6ZPFFZko5VAS8OCSIywK8sTWBEll/GXtQYykNEEmsNYxO1c/dwGZBJAi3J
         KIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665217; x=1783270017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L94599a5h3xEYD+xTPZLiwZIaocGIw8FBQJTuHEMGZ0=;
        b=HYw9F+HxycKCzcCn7XdEDl3dOtz1fGIxg466BZEKkz1ba59ApT3GAxm0/gIDIYIP+1
         aSau1icqPTnrWhfQeGxgZAtCds8BpJXsIVcICTMfXAfpmiwEO9mx+6QVAmTgmX2F0gEh
         KreuxRyIh4AwDKJpiP8+itFimP7Zivprt4DYhlYJs3mepj7LWAshRjaRi0LcD9pH1AmB
         BTbVuvFAmxcT1qqgE/vAHLro7IRyby6veYxOaVgL2+GyAubR5h7A0wQaD+egMEVbyJ7R
         C+d486itiI89mns25C+tfNrtfTGdkm6dGCsMn9w8RNpsZB8gMgp6hNwULaG86UxKtYM0
         NEow==
X-Forwarded-Encrypted: i=1; AFNElJ+QkiCPnh2Sby/FxKpuxcU74y9LfmX/fLuzNuc7C8EJh3qHD6SAH0YwQwXKT/2bezixKB8kN2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4TkL0mmp7Du4T24ISzN0DoujxN4PgXU7Cd5YTtJo011gks2Zi
	jMXfYBDIecl8j9o162nj78HXrEG5Ak35TggMxVO9Oq7mq4U6CZ+WkBkM
X-Gm-Gg: AfdE7cnEWpftb1P4m2fvbqlZeQz4NWxYIo0OGV8xwy4PbV+5MS0Hd8LcTYaVIRh+Yxb
	knkzFQ+IsoKcYGpRhmO0hmnH9xDO8xjnF/wuVYj4UfuX+Lpw+Lh7LzVaiRj1Q3qVjXXo2MWvv7T
	28nG+o4ykpdCWCPey7igE26+ldGpjXxjWb2cg+LDFuVGfV9dDEA5NH+P8PeUAH+E4jqavZjR0og
	rlklCFGquTyDPrrLMNKwcSzp6OLY6UBUGsiqN0Ibk6n/CtPsHTrRvqbl+QBln4NvRycVFwb+nAL
	PcbuCeFwpuiNepIbaGtDJIE4uEA/N63aUUc7FDqJpxmur6JjzX3QwS3q1d9HMnhTlYKslzzuMUX
	v6KMAHWXpLsdG9nvXJuI11LF+8LsEnaiseqD/H7N2Zxl6oZ8O5+OROSvwMkLeuddUxOdjauf9MP
	4BKTSAbeK1VzYqGrpLi/2O1F7gtg==
X-Received: by 2002:a05:600c:8109:b0:490:bad9:de43 with SMTP id 5b1f17b1804b1-492667ca5fbmr212753085e9.0.1782665216285;
        Sun, 28 Jun 2026 09:46:56 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:55 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 5/6] HID: roccat-konepure: reject short button reports
Date: Sun, 28 Jun 2026 18:46:10 +0200
Message-ID: <20260628164611.17467-5-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628164611.17467-1-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269564-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:erazor_de@users.sourceforge.net,m:jikos@kernel.org,m:bentiss@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:alhouseenyousef@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C5336D470C

konepure_raw_event() forwards button reports directly to
roccat_report_event(), which copies the fixed eight-byte report size
registered by this driver. A malformed USB device can send a shorter
report and make that copy read beyond the input buffer.

Only forward complete button reports.

Fixes: 8936aa31cd5f ("HID: roccat: add support for Roccat Kone Pure gaming mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-konepure.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index 7f753dfc2a10..d17dee18ac2b 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -181,7 +181,8 @@ static int konepure_raw_event(struct hid_device *hdev,
 			!= USB_INTERFACE_PROTOCOL_MOUSE)
 		return 0;
 
-	if (data[0] != KONEPURE_MOUSE_REPORT_NUMBER_BUTTON)
+	if (data[0] != KONEPURE_MOUSE_REPORT_NUMBER_BUTTON ||
+	    size < sizeof(struct konepure_mouse_report_button))
 		return 0;
 
 	if (konepure != NULL && konepure->roccat_claimed)
-- 
2.54.0


