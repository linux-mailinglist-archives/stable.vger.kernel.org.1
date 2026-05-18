Return-Path: <stable+bounces-249309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG4uHGYlC2p5DwUAu9opvQ
	(envelope-from <stable+bounces-249309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:42:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EB556F0CF
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7615F31BDA10
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70C30EF94;
	Mon, 18 May 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOLKuC7J"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB30242D9B
	for <stable@vger.kernel.org>; Mon, 18 May 2026 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114799; cv=none; b=j7wBW6CbsqkXal5TEU8v0bisBtycaLnt3e41ECnA/pTytfUQ3XkttEL8vf03dFasBvCP/Lm7PwWS264ekTTgMhHU0Ii3zgUe6Zxd1yITYQmtQpM5pw7xo5PimnDrS5hEH2jMr6aIf0On2Hh6o7HjcsRYnIjFqZ64+Dkm9XkLMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114799; c=relaxed/simple;
	bh=CHhU3OrOdk340qyqkitwJIqaC84MqZ7shflUGPh4pxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlcgsRjuBZsWC9HIZ1akDHnn2P0XKRBcGUvHRLEfHw+BDnwHl/Cvcel7ONuKPjFLBMqc0H9AUwYRAwoBf/iCK/AHhpM8PXOtoP62QkNy+c1N9WjY0iKymAAiOfksqDo4gRoYNKaj9Da7cGSxwoyEqC7r/61Ac39jvHzblljHtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOLKuC7J; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bcc2b199c17so301029666b.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114797; x=1779719597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbt3n/YhJ+P2VJtD3JU+1cQAnR79ZzwjF6VuK9LVFGM=;
        b=NOLKuC7J2pAbK9B2JLJd/uK3HY516XbyKgSiK1uzDIBlFPcTN6YyAcqL2F/+vRZMNQ
         dF9WwuzIq2NmFGATITetxqJFam8PgHFENk+Afh/DzMkPJSmyx/h0t8Pn/5hJdmd17+Mf
         8WxwaKlQcG9Su178SbgAJ+iQQSYbXuENlzaaQmGovCS0lkxLoaU4wlJ7mX97ayyki/Uq
         va5FTMtbwjgHh3TnBOudU/A0krUj++ACU63CbXfksJ7BbeCmnLmbPSH940SXAVVdvbP8
         pZxh9pF3qI8JZH5+AAW4eLl0+bBuVhghORSUdN3XNgSl2FKu3JP9PjSudTLK1qSBB4x1
         CdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114797; x=1779719597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbt3n/YhJ+P2VJtD3JU+1cQAnR79ZzwjF6VuK9LVFGM=;
        b=FJKPJczGHAcDo5m6JqxFVComXyQ33AERsuxvtTJje+9l6Su3gQvzYQ0SvQSvVTD8/m
         k/NN24HK9DG7wMJzePHiPxAnfxyiTcBLTlbtDqHfTr4DD40P1fFpH0fAF36EFASEaxd6
         KIVdiz9nXdarEfU55tqqwzgDilxReh2SxvETgGY1MhfEtjZNvQAJBwO7qByLH3Lfkdeu
         xGG5aOhxZk98DUA0TJboB1D3rh2xlJVHBqiRbysxLF0Ns+2XFXT8RHYCIo4l/JHdqZed
         lVJ7AL1mzuzTQIkzNfWa3VIeq0mWgA+Vp4R3p9np6u1Ed0Zs7j0gv9FaQk6IlfLdAVJG
         PBXg==
X-Forwarded-Encrypted: i=1; AFNElJ+xCOQjfj1jILUywoKfPwt+TxMKez5L/oY+O17BnNcS2SiNGMb5t2O2s0t2hnAiKF8fnJBIPes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJakwOoEcd3txtS+AZ6cpjRf8tkFyWnxDW/bzlrK6FcZR4OESZ
	KGU+y8Etm7mgdKkgHzwX4tB4bGvK+k7F2UJtejnidnOypXCZPGV8ZJHz
X-Gm-Gg: Acq92OHQkspfcrsdhwOFwuZy/bi98mq0PECGFyGzEsrn0DoFnV9sBbXkd7v1KNLEZJJ
	BivMK9cmkleuFCHhTLB6MBKNDlG40Tj7HKhbRkW+MXptcHjclppWvEt34vjtFXoArAKKajkKYys
	SW+73/4WzPSJUkCDHEYC7pAXc+PBLEWOOXR3KrdBOa7Gv5CNcQGBtH+mVQaziIvdINZRG3C1LQn
	fU/AiAkUjE4WS1Mj0wVbhVwiJibFE06TIHU1uDasEiwzArD7YisVE17a+y/avTpG6h4QvKoVlqm
	R1ggE/l3qwVoyq/5fqoZCzA0CmAb4hZAlHe59lB9tuzEi4zWSGKripkCIAKJTDa5cvVQ6ahyKIa
	0UNxMxQNDrSFOFChgUXBg4NF+UX514hBGdUO7gu/vE4pUSNrAAYZ/if8y+XUrvyf5HIXjwMtt4Y
	3F8ZsmomWbDZi1l5VN5K/1Y1POqp2v706pfn0li6HFJsOZL+PIP1M=
X-Received: by 2002:a17:907:15d6:b0:bcd:53e5:c8f1 with SMTP id a640c23a62f3a-bd5177e2d11mr620050866b.13.1779114796477;
        Mon, 18 May 2026 07:33:16 -0700 (PDT)
Received: from nixbug.lan ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dee08fsm563732966b.29.2026.05.18.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:33:16 -0700 (PDT)
From: Andrii Kuchmenko <capyenglishlite@gmail.com>
To: linux-modules@vger.kernel.org
Cc: chleroy@kernel.org,
	mcgrof@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Andrii Kuchmenko <capyenglishlite@gmail.com>
Subject: [PATCH v2] module: decompress: check return value of module_extend_max_pages()
Date: Mon, 18 May 2026 17:32:33 +0300
Message-ID: <20260518143233.16091-1-capyenglishlite@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249309-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[capyenglishlite@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C6EB556F0CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

module_extend_max_pages() calls kvrealloc() internally and returns
-ENOMEM on allocation failure. The return value is never checked.
The decompression loop then continues calling module_get_next_page(),
which writes struct page pointers into info->pages[]. When used_pages
reaches the stale max_pages value (not updated due to the failed
extend), a subsequent write to info->pages[used_pages++] goes out of
bounds into adjacent heap memory.

Adjacent slab objects in the same kmalloc cache (pipe_buffer,
seq_operations, cred) can be corrupted, potentially leading to local
privilege escalation on kernels without SLAB_VIRTUAL mitigation.

The call order in finit_module() is:

  module_decompress()    <- vulnerable, runs FIRST
  load_module()
    module_sig_check()   <- signature check, runs SECOND

Decompression happens before signature verification. A crafted
compressed module submitted via finit_module(MODULE_INIT_COMPRESSED_FILE)
reaches this code path before any signature gate is applied. On kernels
with module.sig_enforce=0 (default without SecureBoot) or with
unprivileged user namespaces (Ubuntu, Debian default), this is
reachable without CAP_SYS_MODULE.

Confirmed present in mainline (tested on v6.14-rc3).

Fix: add the missing error check after module_extend_max_pages() and
return immediately on failure. This matches the pattern used by every
other kvrealloc() caller in the module loading path.

Fixes: 169a58ad824d ("module: add in-kernel support for decompressing")
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
---
Changes in v2:
 - Remove unnecessary initialization of 'error' to 0 (Christophe Leroy)
 - Remove unrelated blank line after if (error) return error (Christophe Leroy)

 kernel/module/decompress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -XXX,9 +XXX,12 @@ int module_decompress(struct load_info *info,
 				const void *buf, size_t size)
 {
 	unsigned int n_pages;
 	int error;
 	ssize_t data_size;
 
 	n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
 	error = module_extend_max_pages(info, n_pages);
+	if (error)
+		return error;
 	data_size = MODULE_DECOMPRESS_FN(info, buf, size);
 	if (data_size < 0) {
 		error = data_size;
-- 
2.39.0

