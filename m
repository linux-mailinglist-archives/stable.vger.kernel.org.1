Return-Path: <stable+bounces-242792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AreD6FY92mEgQIAu9opvQ
	(envelope-from <stable+bounces-242792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:16:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D04B5FAD
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82B0330154A6
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D073CE499;
	Sun,  3 May 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4OZm5fB"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D523CD8B1
	for <stable@vger.kernel.org>; Sun,  3 May 2026 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777817734; cv=none; b=ptA8pG+LIoDg75KmQXCMEASJvNNqTekzOfDw/KDhcX0+YP36KHB1cuO96y1jeYBDbB2IM9/lLCp/GJeopnzdJIF4+3XPjLqGLKnUKy8y4FsITMhDRLlKAjMRj+YtqYPbCn3WNXT2zmUB2LSzul63tPPOJb0CPDQjVf3zp98hFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777817734; c=relaxed/simple;
	bh=sNYg3v35X3Zb6ai1EEiwl45wwE7v2/fvnp/4sYLMCpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYjS3YPdDvmWFggHcfFI716cIrqz3IEto2uiDm+HOmkNmN07f4YrtzDr5W5hVhAi8WkUzzkMQpOya8c9xDPbc0zzGVgKy99s+hIiS0HXvdrWzB0XiRL1nxXdDhdXGWX0OJVf1AScFsrBJ4jQ877GAgxhpOaDGHf6NFX3oy9VCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4OZm5fB; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8ef2118b478so333350885a.0
        for <stable@vger.kernel.org>; Sun, 03 May 2026 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777817732; x=1778422532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+ka8zjHbzrAJc7Li4EgptLPQUFhFF6o2unBqDH+EWo=;
        b=N4OZm5fBSV3d40wA+/gFKdacCBK6iqA8fy7trjJrmUP4dRQA7fmYPnXeAs1A9bVQY9
         E7NbdUNv7A/FxerTZFSI3du2E4zHhbczBeb609Dcf1GkWuSvLSUv2LUSe4zw3Rd+bfbj
         8b2giS4luaKrFSY3gwc7R+JF+c6Ww7sCIh0xybWrOA6P5DtqEJRUdb/ZKYet8QmVQ+UE
         PdhGbkRe2SCUMoFx2Ud0xnE+FQYqigDaQIcMnLcMrXZEastvivnqgSvk5x2Z6sAa1Qxj
         jnTHZQ4iVuNDD0+TmVJDA/4I2sySGXFKIvxZDv1whb/9D2ipl1detkOGGTHTmkkKU6iU
         qHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777817732; x=1778422532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+ka8zjHbzrAJc7Li4EgptLPQUFhFF6o2unBqDH+EWo=;
        b=Avb4e6D8vN02K2rqaDA0HZlZq9VuP2VrkIAAjyFJAhPZxNDOyVPNne8k8C+q58R2J+
         Yba4CLrpdH7aa3P6KxfKXGW9rqJLpOcO/CfENm4xCQB3yNt1c8UIx+NLqJR0DbBtkcx/
         jec0UHrybrCHIJEArOhBfjC3+U024Z30lVZ/ZmoGz+nOfUvRELt2k5qN4+z/eBq2zVxQ
         5Hi0FQMRNzKOz9oX166tLyy+QJEyqr2zstVWDcjWahWoFT+3W3Fz5HX9/HQDjwVO/nMJ
         msDPzIe6z5hWdghX7Ho1mSKH6VL1hojiU9kFsSFx0F7FHgYy/y7VMewcUfiXWWQhqjjU
         JasQ==
X-Forwarded-Encrypted: i=1; AFNElJ/83NyhFhzXiCptrpctuqcQRjm5IUWDJrwlcQRkoyeMdBQYdy0jmD6dA7V0OE/evp7nCNXG8EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzusMqVnc6O+wiXhth8P3fkFAChtk0THiaSXJyWEDvVD2iwF6Ge
	aOI3RtFqq+vn/cSRJP02QolyppBr+cCJq95hPEvE+jtNT80hi1k5rDvx
X-Gm-Gg: AeBDiev/uDYm5bWXK2UmFsbYQ+IJkIdQZtUrGT6b+/MFU/TyLSePfxMdjUuUl3kLqvf
	JJVNUEhCDRLxm9dXLnXo0nZ10dK8WBMY/Fr2rFpNUx8J7+8iEY8A5xBjBNLk7gok2+ie6KUFLbr
	4VJUedzYhVuAOvNvhtOANvkax1PMFjSqrdNFssJOwyPniEtyRfpPiNKc2JVqDmWS9/wU8bVyi25
	nAbxCXGXPjS+U5ou34yWwDdSlEgI96sR/U5e48sVguDF+bKZgeDRbwPYs7YxfNYCmN7U7Jlngza
	9IqN0opaNubxNZU6+hW7F/PN3tcqgbSdhCMX6LrQ1AiL7jn21xL4q3fPO/goU7ktHT/5UamnyL2
	8LJ1mmOVU5v6fkAzhGFIovovLNZ05+hQaBPMgOz9ttLlprFivQI159lK7RSbUbEii9h9o4lfot/
	j1EBd+3mT1lygj9IBhxGELxEQl3GB0C6DsKBIKAxtU92tnNCjRRmxV4L6wGDRN1OJgvY65uAEj2
	sZcPftdSXE40bCJZ2MBK2MRqKVFFuQ=
X-Received: by 2002:a05:620a:450c:b0:8d7:e3ab:4c17 with SMTP id af79cd13be357-8fd1824178bmr976368885a.41.1777817730017;
        Sun, 03 May 2026 07:15:30 -0700 (PDT)
Received: from server1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938e0b9sm766261985a.9.2026.05.03.07.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 07:15:29 -0700 (PDT)
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
Subject: [PATCH v3 2/4] thunderbolt: property: reject dir_len < 4 to prevent size_t underflow
Date: Sun,  3 May 2026 10:15:06 -0400
Message-ID: <e3c84da6e0c1defbb07e712939df0db1b2019fff.1777817011.git.michael.bommarito@gmail.com>
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
X-Rspamd-Queue-Id: 013D04B5FAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242792-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.990];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
v2 -> v3 (material):
- Move dir_len < 4 reject before the UUID kmemdup in the non-root
  branch.  v2 ordering let dir_offset near end of block + dir_len
  in 0..3 OOB-read the kmemdup before the reject ran
  (dir_offset=497, dir_len=3, block_len=500 passes
  value+length<=block_len but kmemdup reads block[497..501]).
- Fix Fixes: SHA (was e69b6c02b4c3; correct is cdae7c07e3e3).

 drivers/thunderbolt/property.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index f5ee8f531300..90fa6f760963 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -173,11 +173,16 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	dir = kzalloc_obj(*dir);
 	if (!dir)
 		return NULL;
+	INIT_LIST_HEAD(&dir->properties);
 
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
@@ -191,8 +196,6 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	entries = (const struct tb_property_entry *)&block[content_offset];
 	nentries = content_len / (sizeof(*entries) / 4);
 
-	INIT_LIST_HEAD(&dir->properties);
-
 	for (i = 0; i < nentries; i++) {
 		struct tb_property *property;
 
-- 
2.53.0


