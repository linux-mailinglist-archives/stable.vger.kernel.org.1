Return-Path: <stable+bounces-212996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jctNG6tTf2mNoAIAu9opvQ
	(envelope-from <stable+bounces-212996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 14:22:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE04EC5FDE
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 14:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10B7A300E5F6
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2F34FF77;
	Sun,  1 Feb 2026 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq0pmD+2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E429B795
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769952164; cv=none; b=pga69P9PyLZeaJ6BJ6bIYAGQTWbZQMqdk5/L9OOiFYVCdE9K5/4acZY/0d2rOVcEnspHoImw9+OKG+lXZ+uEfSyUj1wuXUwDnH8i3mULB4TPywwLb4cfSVDChNmNPOmagq4j+X3X3r/fcP6qW9Olr/+PimkwogzEXySsNeMwLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769952164; c=relaxed/simple;
	bh=whaSL81KwS/fiw68Cl8rxBwbDrJF+JXFC07BGw2yzDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jP8x2q60b07hfAgkmyZL/HCTO/A92lTpc/8jg6EEC+PgmhdxuUtckipCg86TiqgHqDR6ddd53oFJXoSYpM9A7sr/jqrP1zu61kPT+nBBxJjQ9CnMTtoIV4kvLg5PGHhPJCRYU5tpOtr0JyqipZlmdqG79kjHqbnBeX8LGoyG7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iq0pmD+2; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-794d58b892cso565637b3.2
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769952162; x=1770556962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7a7p4/y/BHQxkvFbtwlRAV/7isrEcljAgUdtq1UtJI=;
        b=iq0pmD+2lkzgamH99+ASy7h2olbuLnSd7nmamGoYPvl7xTTFj3Lb8kEOaGZEU+5Lrt
         Dux2x7CcR1Yk94sOn4v2zxG62cIM7KS+YILaTHs+MFnz9ZPUzrog5J4VmzEq1UmvLtPc
         fjTcPcVqvr3jAbxdx8R47BjBibJJuSTOE8biyRvV8aBCffHw6tnfeTXiphxGzpK3ul2s
         RRCIQvuZbCLAoE159/cMBZkv+eOupS1c44KssnOhBC2g7Ml9XGl741mbg29JQzGPTZvE
         qfefehLXcIbMX8WpYMOnQUNC68uFJYHOpn13XcM+/ovteuZ6UIok45MamyrvfZGWtgeR
         v8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769952162; x=1770556962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7a7p4/y/BHQxkvFbtwlRAV/7isrEcljAgUdtq1UtJI=;
        b=adDoV4qsHWzx2A1RPv2i6hPHmotKP/4hzxI5+O+vfkEEoTnIFoJVv09P/yueybqKBl
         q/M2mUNat3KaUXKrDUNrCckxrqN/lUBX7uQSYqhhwVvEp3IJLafWmFvtu3kKZflEhf1z
         ecq9azdGtO4MKGSW/fZsvGXywOHfwoMYCyfhuTIm9O+fg6eCU3CrbycP+O1U25Pqq1xY
         rV3tB5p/gLLCG9D0uX9dXdRA6kSaBfF2u3UMPJyj75Reknp9zemydQJHETpHPjaER97D
         bar/z3or9cFH4A+W13FCYZ8/mVkYFuHCnpGONsOqw6XROfCiAeCf9SZG5UN9R+UG75fM
         KblQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvwJQu+Sh27Egu6ne+AsEfeNLKUY+DIIhg7ldrrkBZdvZ2HkBPBwrUmB7WBH9XVzikrENyYqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkrI2osnnFBS9mZS7mLVbMWdpYULNB/kOfEumufTXKMTFfngg6
	AqyJWYvn/fPmuse8eQG2EIlN5gkG7qgMmL9vp6YkwckKuINGGfjeiS0r
X-Gm-Gg: AZuq6aI1lFxE2jxsHrtb4cf+ojVijPb5KJiLIFFNhqp29t1fWdYtVoA7BdVeklLy8MI
	AdK64Df/ByB/Sb+1uQMxuZvClwuzc4VEIeLFcXvUug71oQGKQ2iYuH02bhQyAAa257qH3UR+5EJ
	OgW19euL6s1GgW0+qSI0kvYpTkWhQ0Kvv+z5RLT3WJmWtMu1sBpApNaIwnXuEJc/51rRDGVlVvv
	7GFLHgubxspA+Sa8SNBeDhn6S+z4MfR8s8ccoWAnfg06/XqlAAd/uzf9/JeSB8fQ7um0ve4SI3J
	9XRlU+FfXOyFEyVLsh52GY0UGlMUgLnLahPMBJwKtKNF3PsJ4gxxn4vK2OPgwaZWKyJ1N2uwXlo
	6ey5GiI+nM+WVnjRQ3LOlHZsMT2G2MssXCPsnjgLuS7pNGVQhuwBF9AqZbJUbIiLXvX3lKX2YPB
	vWzdjggSP8Y9pPV9bq9l2T5e8=
X-Received: by 2002:a05:690c:4992:b0:794:b7f1:59f1 with SMTP id 00721157ae682-794b7f15dd2mr35296067b3.66.1769952161640;
        Sun, 01 Feb 2026 05:22:41 -0800 (PST)
Received: from guava.tail5f562.ts.net ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79482762e59sm62700987b3.7.2026.02.01.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 05:22:41 -0800 (PST)
From: Pwnverse <ritviktanksalkar@gmail.com>
X-Google-Original-From: Pwnverse <stanksal@purdue.edu>
To: kees@kernel.org
Cc: gregkh@linuxfoundation.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	anton.vorontsov@linaro.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sai Ritvik Tanksalkar <stanksal@purdue.edu>
Subject: [PATCH v2] pstore/ram: fix buffer overflow in persistent_ram_save_old()
Date: Sun,  1 Feb 2026 13:22:40 +0000
Message-ID: <20260201132240.2948732-1-stanksal@purdue.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <SJ2PR22MB4268740D8B115ED88EAC4959BE9DA@SJ2PR22MB4268.namprd22.prod.outlook.com>
References: <SJ2PR22MB4268740D8B115ED88EAC4959BE9DA@SJ2PR22MB4268.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212996-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ritviktanksalkar@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purdue.edu:mid,purdue.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE04EC5FDE
X-Rspamd-Action: no action

From: Sai Ritvik Tanksalkar <stanksal@purdue.edu>

persistent_ram_save_old() can be called multiple times for the same
persistent_ram_zone (e.g., via ramoops_pstore_read -> ramoops_get_next_prz
for PSTORE_TYPE_DMESG records).

Currently, the function only allocates prz->old_log when it is NULL,
but it unconditionally updates prz->old_log_size to the current buffer
size and then performs memcpy_fromio() using this new size. If the
buffer size has grown since the first allocation (which can happen
across different kernel boot cycles), this leads to:

1. A heap buffer overflow (OOB write) in the memcpy_fromio() calls
2. A subsequent OOB read when ramoops_pstore_read() accesses the buffer
   using the incorrect (larger) old_log_size

The KASAN splat would look similar to:
  BUG: KASAN: slab-out-of-bounds in ramoops_pstore_read+0x...
  Read of size N at addr ... by task ...

Fix this by freeing and reallocating the buffer when the new size
exceeds the previously allocated size. This ensures old_log always has
sufficient space for the data being copied.

Fixes: 201e4aca5aa1 ("pstore/ram: Should update old dmesg buffer before reading")
Cc: stable@vger.kernel.org
Signed-off-by: Sai Ritvik Tanksalkar <stanksal@purdue.edu>
---
v2: Fixed Signed-off-by to use real name (was using Github ID).
    Resending with proper mail client to preserve tabs.

 fs/pstore/ram_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index f1848cdd6d34..8df813a42a41 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -298,6 +298,14 @@ void persistent_ram_save_old(struct persistent_ram_zone *prz)
 	if (!size)
 		return;
 
+	/*
+	 * If the existing buffer is too small, free it so a new one is
+	 * allocated. This can happen when persistent_ram_save_old() is
+	 * called multiple times with different buffer sizes.
+	 */
+	if (prz->old_log && prz->old_log_size < size)
+		persistent_ram_free_old(prz);
+
 	if (!prz->old_log) {
 		persistent_ram_ecc_old(prz);
 		prz->old_log = kvzalloc(size, GFP_KERNEL);
-- 
2.43.0


