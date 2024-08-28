Return-Path: <stable+bounces-71450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A9F963544
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 01:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA4F2860FA
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 23:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA401667E1;
	Wed, 28 Aug 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvThTGea"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882714EC44
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886951; cv=none; b=Yu1sTeO1TF8ZsrvksSwAf0cdh73O4i3hJideJeonbAYToXM+/bSAivn/7z1wJLTzSW6jPRrQ9UL9MiqjYKwBy0WMbZ9vGk1Yb5+tABTZ1VPZlPAiqYNGBa2umlc2PLUw3wZY2MOf2NvC3Kg+VX63weTv5qNyZsYqUEL9LA8h5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886951; c=relaxed/simple;
	bh=ISwT3XDvRm7A2zqtsYKzBvvLDzqlF2Njc9Eqd6paImQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=coR4QMn7LhMVfiBraerS8m3PWNh771OTvREPGmbkaa9X3mazb5TwzBYByXhmwX9QRi0SWdc7TG3HNS7P42M7cttrNaGvIUhVg9vbUtmvHGySLXDNxsTnFc5ii2SSXR5T/qlpLJJVkpXMw20OiHh0ksJtiIQILOGTog2Y2GvvUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvThTGea; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6af8f7a30dbso2094727b3.2
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724886949; x=1725491749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MMRQE9M5HKxzvMTzsEDSmvB+myXexAwhYGndQpAOIRM=;
        b=fvThTGea6+WIx98nHt8lNwBOv1drWJW+AUC1Fjjf+wj7lYJ76vRQiz/Gxw4VyhBa1m
         9br7i/4lp5GkXAXHAQqWQ1utm1vb3w5QIOjkqXNSwf49xAGEuQtOPfR2MrPiptne3GSU
         pFnO6C/KRsX2Emmyn/wpyqDV66Yq53Y433mhwtetdQPA3wpXFS17VAUDEKVdpGJyF2oF
         6hsTiydzk07zwxz+ZOvuBRnB1N92hW7UaCnzXGYGcOSsSmpyy4sWnorKaHW6M7B3xUPU
         CQ2PpxVVrnugD4BENghUMwQTI6ay+j6kGAYiKB8kYOPClQ9QWmc+sGb7fE5X+Zmgwfy3
         lG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886949; x=1725491749;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMRQE9M5HKxzvMTzsEDSmvB+myXexAwhYGndQpAOIRM=;
        b=JeX29ZFMajd+5zu4NLKjBvZcVo8pvT2hbby5wuEa0o+8P1J9F5OG8Zm0xekKoMhRwg
         xemPm2YegWjZzar9lE6RN/sVBxU068sMkzIU6BcHpCWV8SXN0IeChO4Hl4Y5yo70bJ9F
         x2xcP8IZlDIc4YvaqmUVzA25rofE3gBWolE2fjnU1EDAYWtawY0IOtsP265G6pIMct6a
         EAtSUyefRgh37y27if1tZ0/3xDR3zIKpxwLAWftz0S9OrG9F7FbMZ6TCnp+MDXYCkHyZ
         s8ovx3+t+4t6J390ZeC+3aCX0puK2IN8cWyi+r+Qr1nmX5n1nbxedRaWWy3iwCA6Lgff
         a4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXh6zwUalhgBK4XbRliRBCCZ78tW0I4HJm9vPSTCXKEQ7AFCxYPYu/akxFGIIGToAaT28x+gA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PR4aIcKlK0KHx5g0hEeIpirpVKrxfh/mKFQzHTKkekpJloOK
	kvxUF3DCeT67xhfQ00PeBKLOdiiP/qlP0yVgQ2idOz4f+WQaMV7OYEIWHRcxreqzKM3k1qoykHs
	WHQ==
X-Google-Smtp-Source: AGHT+IHZ+O35i4VghFjFn/vmGMPTny7V3ShVkfOR7KuwKnk76ug3SO1rO9edrN4QbyJehMcztWhlCgXbs0g=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1513:a:29f6:5d06])
 (user=surenb job=sendgmr) by 2002:a05:690c:6382:b0:650:93e3:fe73 with SMTP id
 00721157ae682-6d277880caamr395607b3.5.1724886949080; Wed, 28 Aug 2024
 16:15:49 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:15:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828231536.1770519-1-surenb@google.com>
Subject: [PATCH 1/1] alloc_tag: fix allocation tag reporting when CONFIG_MODULES=n
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, david@redhat.com, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

codetag_module_init() is used to initialize sections containing allocation
tags. This function is used to initialize module sections as well as core
kernel sections, in which case the module parameter is set to NULL. This
function has to be called even when CONFIG_MODULES=n to initialize core
kernel allocation tag sections.
When CONFIG_MODULES=n, this function is a NOP, which is wrong. This leads
to /proc/allocinfo reported as empty. Fix this by making it independent
of CONFIG_MODULES.

Fixes: 916cc5167cc6 ("lib: code tagging framework")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10
---
 lib/codetag.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/codetag.c b/lib/codetag.c
index 5ace625f2328..afa8a2d4f317 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -125,7 +125,6 @@ static inline size_t range_size(const struct codetag_type *cttype,
 			cttype->desc.tag_size;
 }
 
-#ifdef CONFIG_MODULES
 static void *get_symbol(struct module *mod, const char *prefix, const char *name)
 {
 	DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
@@ -155,6 +154,15 @@ static struct codetag_range get_section_range(struct module *mod,
 	};
 }
 
+static const char *get_mod_name(__maybe_unused struct module *mod)
+{
+#ifdef CONFIG_MODULES
+	if (mod)
+		return mod->name;
+#endif
+	return "(built-in)";
+}
+
 static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 {
 	struct codetag_range range;
@@ -164,8 +172,7 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 	range = get_section_range(mod, cttype->desc.section);
 	if (!range.start || !range.stop) {
 		pr_warn("Failed to load code tags of type %s from the module %s\n",
-			cttype->desc.section,
-			mod ? mod->name : "(built-in)");
+			cttype->desc.section, get_mod_name(mod));
 		return -EINVAL;
 	}
 
@@ -199,6 +206,7 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
 void codetag_load_module(struct module *mod)
 {
 	struct codetag_type *cttype;
@@ -248,9 +256,6 @@ bool codetag_unload_module(struct module *mod)
 
 	return unload_ok;
 }
-
-#else /* CONFIG_MODULES */
-static int codetag_module_init(struct codetag_type *cttype, struct module *mod) { return 0; }
 #endif /* CONFIG_MODULES */
 
 struct codetag_type *

base-commit: 9287e4adbc6ab8fa04d25eb82e097fed877a4642
-- 
2.46.0.295.g3b9ea8a38a-goog


