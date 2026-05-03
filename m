Return-Path: <stable+bounces-242789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHaHC4lY92mEgQIAu9opvQ
	(envelope-from <stable+bounces-242789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:15:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E54B5F75
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 285883007953
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53C73CCFA0;
	Sun,  3 May 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnhGm6rq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99A231A21
	for <stable@vger.kernel.org>; Sun,  3 May 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777817731; cv=none; b=jKYy2vo8UYEtZywtA5+jsK6nw/Z30IlrzQPghczhAddrTuO1aqgsyQPkgSYY6u7UzMkP97G3lT+MjVkqA6ngdgptLDx+7RxQj8J94hEfBAmX1KI/WkBH8JpHm0q/RsMVir/5BQUUJ3OZnFpkpGr0zD4dpfYqFbNP6IA03Z521Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777817731; c=relaxed/simple;
	bh=da761sZYS8Qfcqjx7tTH+rDqBWoz2Abmcj82tsKx624=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkdxXBCSym5mpQWrT3bowgKh/zFxRVdiz8r46LgCfuUk7pxvsYDWlykitfPHjD6hNlbE/6FPElX6ZhnTJglEwgD17Zl32UoIMbB3aJG/qzdwJTCA4VL1hXOgzVEf1MkYr56h5sz2qavl9B8FfxSEfueAW2KlQtYK0zESEd1QTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnhGm6rq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ec37d52c0dso372376485a.0
        for <stable@vger.kernel.org>; Sun, 03 May 2026 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777817728; x=1778422528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iAjdO9SNYauCKwr63OH+1/upS4pxxHhAek9kVw0MsI=;
        b=hnhGm6rqI4DTXlq8Mp0qa3Bsbzg00s1PC2VPqxMF2kvB36iyUs/XiSAOfC2xouV6Jy
         pOhT4UdO6mRDZbkqpbfRoYRQQH+NKwBHEYxePpvx7Ag24Ibn2U92pR5S0F+mYz0UYF1x
         mDtyPTLkWeqB+kniyYFZRdEWdc+ZRkVkgBraaArLYCPwYqBEUannh6aan6ZfExdGuGdh
         98VZ16k5SAOudSEuMK0OiT0euem8iFNoKXtDk4QwUpj+AJL5uW1Xht7ihKIK7mubZ9DV
         rQPrWB8ojVRZ4E8S/zhZmjDKu8DqY0iVO88qn/38laEFxAYG6oKIAhjOyHZCFyuzjuLX
         asgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777817728; x=1778422528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9iAjdO9SNYauCKwr63OH+1/upS4pxxHhAek9kVw0MsI=;
        b=nJvCnd7epiBqDzPmglRXR0xegaH8tP9vFh6VqLmUAQ5m1geRKiEx4guOtazI67AFpD
         WtPUmx2tvXHhLT4vxJ4zYCCaQ0RaEnEuHzaq4tKcEPpcI2aSXR0N3CY1u0S2pdzw9IYe
         SgYLXb6hUjRdXltfxWTHDJhNDLJtc3YTjRFvVbdFoTJPvv/NzP5WTnhft713XLLviVar
         5Jf0YQEG8LHF6mLTxU0U3KEMG6kaJyzvwNWwlRDPp8LJ/gP1gy65oKFxQozldtjNctA3
         tUvd70q6sLbUtZ++314DVb2kAdguDfCSNL2/PWSgGPJlEXAMbWUL61mWewm/Og1xsSHq
         R6ww==
X-Forwarded-Encrypted: i=1; AFNElJ+4JliFUHBar3YXoZdUHLEfH54NhZ8QzJX45qKpU2Qa6Ee46ll7sbFmHPVTXC+HL+VkWnixVys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9bQ72B2mXKSSFgshc9FncnC6HlyWsnxVu8TFghbGranXTG5a
	12qLxZgUcTixoNEFg4WRaYudMQHo0F+vM1qt5WzCS5T/D0l4PSCRQnen
X-Gm-Gg: AeBDievq5NhZ4NeU+ZAyzhS2ghOFVqO22jDBKalbqXNF4lPqpTMiMnmk7eTJlNvMxTb
	P/8FkaCx+FZLhMRjpvDcjRxI1tI+nHWS92pQPd9Oo+cckqAeHd0AjrT4Va24jeexsjzNlzp6lF5
	j8QoqZl4HI/Y/z9fExIkorWU7Q+Ij96L+YoL7/ShCV7JravCUhRUSpQaNU+x/eNADx3CTFVoRmy
	6GoLwRbLFbZE+y+jHSXCYVkQ4q079TxGoJ86N6Zdxj6QCGfeGNcJh7rpQ0cnRykQwI+10MAwlQx
	sNXPB/OgZEAiGsM/7+V6ZMJ9E12orD8AnsUSG0Cj/T+CnN3CQVpg4dpCO9Q6ZTmrImVmSjd7HQo
	fuO++qTrWTbsMCHAaNZvK9FfSsnz2FnHpjeK2L18FuDZ0X+gyitIqXjrVD4aK9cYlsWDlyjrSPW
	bMYDavTkqXIlYFdHu4UBlRvDwvirAyazH1fC2OMUAJuzRwSOwz2i5M1HyKt9J5FmlLFxNK6LC3g
	vgmerjEFpkNOIq3wV+WzDOm7e5G19s=
X-Received: by 2002:a05:620a:2a0c:b0:8ee:630e:351d with SMTP id af79cd13be357-8fd15ade400mr1019838985a.12.1777817728309;
        Sun, 03 May 2026 07:15:28 -0700 (PDT)
Received: from server1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938e0b9sm766261985a.9.2026.05.03.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 07:15:27 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	linux-usb@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/4] thunderbolt: property: reject u32 wrap in tb_property_entry_valid()
Date: Sun,  3 May 2026 10:15:05 -0400
Message-ID: <eeedf1e42fd71d3686b352b402466a70482f8b22.1777817011.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777817011.git.michael.bommarito@gmail.com>
References: <20260415123221.225149-1-michael.bommarito@gmail.com> <cover.1777817011.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E4E54B5F75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242789-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,intel.com,linuxfoundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

entry->value is u32 and entry->length is u16; the sum is performed in
u32 and wraps.  A malicious XDomain peer can pick
value = 0xffffff00, length = 0x100 so the sum 0x100000000 wraps to 0
and passes the > block_len check.  tb_property_parse() then passes
entry->value to parse_dwdata() as a dword offset into the property
block, reading attacker-directed memory far past the allocation.

For TEXT-typed entries with the "deviceid" or "vendorid" keys this
lands in xd->device_name / xd->vendor_name and is readable back via
the per-XDomain device_name / vendor_name sysfs attributes; the leak
is NUL-bounded (kstrdup() stops at the first zero byte) and
untargeted (the attacker picks a delta, not an absolute address).
DATA-typed entries are parsed into property->value.data but not
generically surfaced to userspace.

Use check_add_overflow() so a wrapped sum is rejected.

Fixes: cdae7c07e3e3 ("thunderbolt: Add support for XDomain properties")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2 -> v3 (no code changes):
- Lowercase 0xffffff00 in commit message.
- Fix Fixes: SHA (was e69b6c02b4c3, "net: Add support for
  networking over Thunderbolt cable"; correct is cdae7c07e3e3).

 drivers/thunderbolt/property.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 50cbfc92fe65..f5ee8f531300 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uuid.h>
@@ -52,13 +53,16 @@ static inline void format_dwdata(void *dst, const void *src, size_t dwords)
 static bool tb_property_entry_valid(const struct tb_property_entry *entry,
 				  size_t block_len)
 {
+	u32 end;
+
 	switch (entry->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 	case TB_PROPERTY_TYPE_DATA:
 	case TB_PROPERTY_TYPE_TEXT:
 		if (entry->length > block_len)
 			return false;
-		if (entry->value + entry->length > block_len)
+		if (check_add_overflow(entry->value, (u32)entry->length, &end) ||
+		    end > block_len)
 			return false;
 		break;
 
-- 
2.53.0


