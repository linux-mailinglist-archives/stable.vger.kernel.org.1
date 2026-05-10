Return-Path: <stable+bounces-245087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN+wOkkSAWq4QQEAu9opvQ
	(envelope-from <stable+bounces-245087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:18:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98852506C9F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855A23033FB0
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935203AF66F;
	Sun, 10 May 2026 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpJmxHLT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548D3A5E61
	for <stable@vger.kernel.org>; Sun, 10 May 2026 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778455042; cv=none; b=ahFwwWWNyPT0mBYdFfCpTXRO2bj8lQt2DNhXNDIm0J2DCOQwogmtjQWy4PJiGm5fQ5hqyVHoao0XdmNonvApCTMoCFJCKxTMzO5el8AI+rzSeTkey3yryckqJWv1N+C3RxBzW4PQNKDTaUZJJO26VBU+qyE8aTynkkqBPYvg9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778455042; c=relaxed/simple;
	bh=dF5X1LUG4r0lQCtZsSoClebMfzIDwW0CmxgsuMikSXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZLrje/yldmig1WDAUV2ZGpsLMou8pAXPvEy0r7p5zQBN2gOWrCukrG1yvXNY4Dyo6X6UVfohsZlSnGkooC69eQvOAN5MqhLp7FhSs6VPQLfE9T9uIZP9JaN6IbeRw9lsjXkPlHeOL+R4AYWiwSdzCTO4j6YNBUSfITSvod43CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpJmxHLT; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so39980206d6.0
        for <stable@vger.kernel.org>; Sun, 10 May 2026 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778455038; x=1779059838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=494zAqIk8zsiLJlcWBVQHIjNxVWqGVKEvJi7UcMRGg8=;
        b=MpJmxHLT/RYdk48gXTuE2zW7wR2N4qIz+GMK+X5jFZ6b942obo319ubHmJDOl1tKOG
         Ms+ZYR09foP3qTzXn1IrTTqdtzY6m726rPLD1C/uNkTlm7QrLaLls61b23aUviRRFV3P
         HWIY+bjLiHwv1ASy6C1tVWHP18vHAlgDhZHyuLKiZht33vrQZl+i5jQG5skFGiQm0P9w
         kPxPINAXBHVtTOADgXgNbvrWSg4Fs1m6j7DPkvz0W5QLFpXshjBvMbixugbfPD8uimao
         nReRlHz1kjd5NWrmfxqhRTJ2qzK+/4RGJcndJi/WEHv6zfOcWQ2SfApvgXTUqPMIS25D
         MSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778455038; x=1779059838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=494zAqIk8zsiLJlcWBVQHIjNxVWqGVKEvJi7UcMRGg8=;
        b=Ic+kqasWgCfa9n70NclMiDO1jRNvedMuFPrw0RYXlYAn6E9Tu6VRQ6VeQTkhZEVm8J
         jwItMBu3EcekLN8Nf0vYENOri+YZZH1/+NrVUQHxepAp0VzezcF88Nwj5aaaghwk8sjR
         TavEfgG5BZ7IUTKFB58MYQ+XefVVpBJxKJJHYsw8DcOA1ICzMXAcC7isH77UoWKzvvFi
         l8aAd2ifzud7PFoyk9ZxGI3UcTnZl3Zbl3ArlR/28FJZD2rjjeXOdN71sO19BujXMCli
         S+btI/61JtcTzA0OGC+Ub5npoQ1lTphEANkW4HHnh/enPW50WvSpGwDDi5mAoLveVnlc
         bbvA==
X-Forwarded-Encrypted: i=1; AFNElJ+mDTDM+j6siFTDQ2s1a74TQugI98EeWSl3IDjLsEjKSKlbLX818uFE0pgh8K2vlPspZZGgTu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhgSmoEwV89t6hHwRuT6xB4U7XdhDhdhCNMGrpu5FU77znPbIt
	jJ/xwtMg9dsg6IPHtpBdptjKQ6shAPQigh1j03SLx+XZIcfdKWxSMOzjme0K3Q==
X-Gm-Gg: Acq92OHxG9CpZTU0dbe0536XYFGx7eJKV8H7sDnwm6l/pomfYgZgghvXbNyqytJ+Phb
	KybW29Op1EAm5QvJB4L2Krf7PXfr0eA8LEu8dcuLrg/3Z3/QQRsu+1breZo/6PMPh6+fvvDVKBR
	ft9WzaRg3/D7N1oqIYrDHs8rXJFwvdSWwyGqln3wak+TsAEqEPd0ZxDycIday01UrG1wsMmbGW7
	UNR7AaeBgBA1jfoq+ZdLvFX3qJ06Mgf2srVo214xFCurgE5o2cu2XnGfF2oiXT91ra1m5ppVhm7
	d9JX5Z+tF+FxgVmy0ptrfiBpu9yVWdBHAQv1JcD06X3Zr4pZBho0aHItJMfVAMEM7bmlvexhD5J
	o13zPW9Zs6YsyKhDb3Gc4MBeHxc1eYMZUqfU4QcZT/UuomCg3guvz1c8d2vT8nuffSstCUR5LxW
	CJrUWmBMSQlAQsE99OVb2ODwCkPwhIIB6jtbTmcZ/krV3Lt4mOPhh+iYkAt0t5+1tKBUlLYTlhl
	wdWR7T/rbpfgWpNTAvsWKLFZuoSOjLbs17AV2eE/IYTC1RfW2jB9A==
X-Received: by 2002:a05:622a:2b48:b0:510:4174:507d with SMTP id d75a77b69052e-51475c8cdd4mr207655871cf.29.1778455038269;
        Sun, 10 May 2026 16:17:18 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e830ddfsm75015031cf.27.2026.05.10.16.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 16:17:17 -0700 (PDT)
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
Subject: [PATCH v4 2/4] thunderbolt: property: reject dir_len < 4 to prevent size_t underflow
Date: Sun, 10 May 2026 19:16:57 -0400
Message-ID: <20260510231715.2215605-2-michael.bommarito@gmail.com>
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
X-Rspamd-Queue-Id: 98852506C9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245087-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On the non-root path, __tb_property_parse_dir() takes dir_len from
entry->length (u16 widened to size_t).  Two distinct OOB conditions
follow when entry->length < 4:

1. The non-root path begins with kmemdup(&block[dir_offset],
   sizeof(*dir->uuid), ...) which always reads 4 dwords from
   dir_offset.  tb_property_entry_valid() only enforces
   dir_offset + entry->length <= block_len, so a crafted entry
   with dir_offset close to the end of the property block and
   entry->length in 0..3 passes that gate but lets the UUID copy
   run off the block (e.g. dir_offset = 497, dir_len = 3 in a
   500-dword block reads block[497..501]).

2. After the kmemdup, content_len = dir_len - 4 underflows size_t
   to ~SIZE_MAX, nentries becomes SIZE_MAX / 4, and the entry
   walk runs OOB on each iteration until an entry fails
   validation or the kernel oopses on an unmapped page.

Reject dir_len < 4 on the non-root path *before* the UUID kmemdup,
which closes both holes.

Also move INIT_LIST_HEAD(&dir->properties) up to immediately after
the dir allocation so the new error-return path (and the existing
uuid-alloc failure path) calling tb_property_free_dir() sees a
walkable list rather than the zero-initialized NULL next/prev that
list_for_each_entry_safe() would oops on.

Fixes: cdae7c07e3e3 ("thunderbolt: Add support for XDomain properties")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/thunderbolt/property.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 29cd60c11ac4..74c92f9801ff 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -174,10 +174,16 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	if (!dir)
 		return NULL;
 
+	INIT_LIST_HEAD(&dir->properties);
+
 	if (is_root) {
 		content_offset = dir_offset + 2;
 		content_len = dir_len;
 	} else {
+		if (dir_len < 4) {
+			tb_property_free_dir(dir);
+			return NULL;
+		}
 		dir->uuid = kmemdup(&block[dir_offset], sizeof(*dir->uuid),
 				    GFP_KERNEL);
 		if (!dir->uuid) {
@@ -191,8 +197,6 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	entries = (const struct tb_property_entry *)&block[content_offset];
 	nentries = content_len / (sizeof(*entries) / 4);
 
-	INIT_LIST_HEAD(&dir->properties);
-
 	for (i = 0; i < nentries; i++) {
 		struct tb_property *property;
 
-- 
2.53.0

