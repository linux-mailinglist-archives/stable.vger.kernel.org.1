Return-Path: <stable+bounces-245084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN7wLAQSAWq4QQEAu9opvQ
	(envelope-from <stable+bounces-245084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:17:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565D506C63
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FA35300AEEE
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C4C13B58A;
	Sun, 10 May 2026 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HubDfnyx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F352D6E44
	for <stable@vger.kernel.org>; Sun, 10 May 2026 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778455039; cv=none; b=sAeA5vrXdduugmTICgCalfWD+LwSPFPEFNS/QrVKk/h9saFl8RsXmU8GxEgey8AsPeXJF7dKU+AGGyiG+zYx56J2c3ZGWsPjj94WcAh+sM8MzqqpXFXJSk0YNRSA29fg/3AynnBpT5Tp4fIqNor/X4wPKaQnB2KfVQzW5u0/d04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778455039; c=relaxed/simple;
	bh=r8DfgjwteyhNATjsAQWVfs8YuAP56djRXgiQDaVaWdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ldga/ucyRDvbU1WoMYtus79/48hKn9UdZ/8BvdHPYdI5SIAa1tAeyerlUVLj2K8/1ySzq4+GodOtgcy5YnCyquEoTHGqneVwXUAuki41mF8sox0E+35VJXeTbUumdMJeE4YPY5J1P5VYXISE5SfiiPBWbOqwv7pbuZuKtgwrYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HubDfnyx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50fb8e9a4edso42147931cf.1
        for <stable@vger.kernel.org>; Sun, 10 May 2026 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778455037; x=1779059837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+Pq1q7AVM368YnM6hKBCnVHKHtkRiZ76Gi1xm2eLZc=;
        b=HubDfnyxcrGf94B9pj7++gT/c4Y30F/ov46ZOxWQ+bbLtflN1UsP5eyV91u7/FvRKT
         VhH0plh7jIyK/bvm6rTE6OdfWwC4FU/O4ytTMOoFHWD/4Q4/UfT3+4OWt/nQZBrjpzgW
         Ep26G0Jp/OhNVzCD2XGx7UbpuPs38hdjbsRDXCcJRYMpKGZ+98KcCQGP6Kcgqq0TzT/Z
         R93+EsatCHzZ57ZS10/6aHtssJkxUm0qRUIsfsVCkcSCngYgrQK5trASGGLhv/1APzDx
         USu/ziycidlNYZ+gjPgn6iSLhWs71I0h7nhTOEgGgrCZm+5hSnHs5kkBSWQCWd3NeRpD
         YyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778455037; x=1779059837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D+Pq1q7AVM368YnM6hKBCnVHKHtkRiZ76Gi1xm2eLZc=;
        b=fwXSOZP9F+bBAzllZXb1RcFMQDPR56DmUU0t1uMwcn8TEbArtY/OmgJqz5HoZdTKUS
         JqSlGquvbzn2Z/olvdsKSURF1GBNufU2oCanbjBw/YCfHcxpSAjb8s7p7ZWSz+xplGKY
         HzEGr8EB2fRE8QB+hx01brkT7SQJuxWwZJxFnJFMrPzvjSYvvMWIVi2AquTdwO2eIdSC
         IevUMbVY3pgPYlOqc+8GtVZd5zQHkc3vmnwvxvFGeJebaixnmJ/RPXQ02RV3e2vDIbMT
         O50/6oTRmYTxujsB2ZhfKI5LXKE2m7ehd5oLkcHJ6SEDbCWnFLc2Y8+wpksJu4qU+muh
         WjLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+N/SEbOPnIIRbW59I7Th4Lz04YfoS81sE/TaKYxnt+x64v0pk2uCBE8TZ4zeFC2t3MVUQQEbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSlowvC68aWfn8dZXZldcc00LdY2eDm5bUEPCtwbKvfdN12Odv
	NQv2MmtgnI5X2jd7FTVL41vxiimEreVciWsNMo73/xAQvmg6aFiq/q+C
X-Gm-Gg: Acq92OElgiyR1kn5e0iWV1ziuUysWtexq/YQKzmY3fmVJpAcpwuwoegbwhB69Q2NJjK
	khc3R1x/R4xj2KipneSHTdQCZr7KmdoMS0Ugo6shvvbwQg77IbFUeJDmdpU3Rx5keTgkeX1GS7V
	Dxh9gnDgZ3po7gDKTo4vzBrkWRUeW23FkoFFbqwiMMXt2DK/c7/JDHPD5W/ldqdpv3JzBduvnaE
	Om3Fb1AZXAXp26Y1dCHj7hl6+YVCKJpVi0x91CdtDpmgJUGJyRfMMJ+Xs5b4j2p/1YiscUtx8Gc
	FS3Yd48/GAHq5RdFNndiG0MhvgvH5GnSiksDsBZpIgjJ+h3Pv8eR4Um/mgEjzi5ZtfHygIR0Mln
	9h5sqbIoqfcFncZ6qOSjCS1h3CW4e3raI+CAb7cXYnh8EIFetbQ9VpqfcDvLoQ8sGa349mCP3Fm
	dZNJPbqw1GuZkAL1AerEFlA1tlg8A1dTXIpi5094PuBaSm7Vh6hhM13BfOvTBuh+YlU3omfOVdL
	fI6hopRK4GBrors2b1kZnF0OkWrQnJe16kTG/w60BE=
X-Received: by 2002:a05:622a:352:b0:50d:8db0:7abb with SMTP id d75a77b69052e-51461fc4f53mr300106661cf.42.1778455037011;
        Sun, 10 May 2026 16:17:17 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e830ddfsm75015031cf.27.2026.05.10.16.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 16:17:16 -0700 (PDT)
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
Subject: [PATCH v4 1/4] thunderbolt: property: reject u32 wrap in tb_property_entry_valid()
Date: Sun, 10 May 2026 19:16:56 -0400
Message-ID: <20260510231715.2215605-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.v4.git.michael.bommarito@gmail.com>
References: <20260415123221.225149-1-michael.bommarito@gmail.com> <cover.1777817011.git.michael.bommarito@gmail.com> <cover.v4.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3565D506C63
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
	TAGGED_FROM(0.00)[bounces-245084-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
 drivers/thunderbolt/property.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 50cbfc92fe65..29cd60c11ac4 100644
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
+		if (check_add_overflow(entry->value, entry->length, &end) ||
+		    end > block_len)
 			return false;
 		break;
 
-- 
2.53.0

