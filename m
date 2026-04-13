Return-Path: <stable+bounces-235928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO/lIIaR3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9EC3E7E67
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C457D30058FD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43598366057;
	Mon, 13 Apr 2026 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="MJBCRK6O"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351F1E7660
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062851; cv=none; b=HXSQMSm9js496ZP0nM3KheQHmeUjO9MK7USRBIUr3gqjXcP3aV6kw7NcoSb7ymehdkay3Oj+BUo8DubUQgCp8BQkiEMvR1BBiExf+uUr4Q+pWUchuxfgFbM1vwYWxTJ3nFAifZkfaa2UlLiqIUUlxNiYH6Sce3f73rsKj9FwPKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062851; c=relaxed/simple;
	bh=Uv76UbxLCtHLXW7zFwCRuXTy2ICJgdbYIk8MFy6DaAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1hzH/vlLoKHx91+PZwxG15RkpBHQ8IJEULZ/xOHczNRH7jdnTgZPhhhanpnI4SDSLXq981QTp+sUJ6ztcMK2Mbpfl0+IG4Q+oGW/cth6FK7SS9mrgq40voNWCEd2Uwlnm6pbZ+58Yjz1WQKOCbMPVaGxEqcwiMbMuxndudmCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=MJBCRK6O; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 87A913F1C0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062848;
	bh=jRimhRSeNz4PqjerWU+ZkoLNJUjW9NBVcj09LqruSng=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=MJBCRK6ODJSi/CsaguYzRsa3Hja2uRpb6KSZcaRHjcNUzOZSQzEHVOF02uLuCqCtn
	 +xCo4APwWgIKZAcgkTwinrY/2DUiIh4YrUgR8kVaiIUGc3j6sjM7cyAIaKXyjySBle
	 E73N+iqK5bb1Ij7OvccM3ltqu5XgVU4UoTbfZf/oIeUWhq72Bec5WUYjd5mi0V2pf4
	 Na833GonoCyBYO6cN+jwnyw4FxChHYO54GIHs6GrR7/YAWitMfupuihrmXdKTsA8SG
	 PKScs58wvbaDF6FAZJfzseeBxhpIUR5twf/3qye4zRB+Burha+zTpl3EdBm/rLsNC4
	 pkOa04kw6nHQt18o26RNV5cTsMn7YkVeLp4CekH0lNXMlIFlfsQXjpq3vwVbEi7X9/
	 u3hUs+l/U1KTu2A0+jKVRybNV24Ud0CSrZjtNFK9joFY4EC6JJQd8AbsitYjSLMCV6
	 Da91zGSh6tIXRgTu+iWgRjA65bNC9zsAMCk7QMd5Um+6jMvzr4RxRzq9QtaRxg82mf
	 PI79xHYta7Mtgh57zppEqyQPni5Aml805E/URMTUcn2k7bnZ2pwWH5szG/dCGZym/4
	 gCjqdqr/eX6z6OaKRKU6t/AEf2NMHTluvvrq055oEL3IUg3jeFA8syP5uNGPaVxlJ9
	 v6HLQv6tv3Z85eE7gkUWkp+0=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso4390100a91.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062847; x=1776667647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRimhRSeNz4PqjerWU+ZkoLNJUjW9NBVcj09LqruSng=;
        b=P/yladFPIovY9iADyOpJS5i7Xd5CXOAu5uVEBfd33PPG9ZOxCvJza3BFz6GZBd8yxr
         Qbwj34au/6Po3BHWF7hwMPydM8zgW8+f1RRDqpLbJH/uTWCfVCjVho5pzinN67p412ig
         q4UlBmGKqKfVc5FyzapODdjbg8uCjQokSxS3Iu97a/VLGxfv6XrLvlTW0jTQ/KEigdj9
         k6dy6fJ3TbJqhqld22a8H260SKwTL4S2qmsdaL1/DIQXP+d1NrxzBP5JXPtmMqu38MmY
         3jTy/nML4hE2EnPXTAUmRyawhk51XC0FyhrCXRgWEy7ayQnYyNvNcYTdanavN4tP4t8y
         SKjg==
X-Gm-Message-State: AOJu0YzovAJa57pXiiRcpgUWPchh2wxYyyaTOWnvGJWKA1cBaho8NYte
	dsmFNEzm4lgcOXl5oVpfVVPoOiQ/RRuIcN3BBZVR9wnZ7eABkV042QDNxhDtXnNGG/IfbEEahxd
	E0TNgpmHTn0x3na3En9wEzAzDslCbQ/WkzgtrMSXNgOcBkClgsDqJvNL9G5KSNXOpcnpzVyydlV
	I38s81Tw==
X-Gm-Gg: AeBDievAA7SHJzgktFCqzQwlwmFgRf4Uw++k2QkxdZisyZFcr824NwgE+FA6uBtk51B
	4IaVtTlvvAuFTVzTA+A9oX0vF/u9ezuESlHJtZVnHmyiMkMfqR6vo/e8CAOP+TFGS7Ha71yAwTB
	p6dUSUPTfdH1OLoMuUkr888enb9xrFrg0xwxUK1LiMcZzJCsif4Mn08EBW7f6+E3imPE3EJ4bWE
	WZbUsJhl9OMPenzEaRLq0l9prmXwkfzg7lPQ/eSOPD94XBOrMlffbMYnxvOIHqDUYHK+3QQqYsn
	0NHSCS1GD9KFZi+4Nc6ScjylY+P0KSgpCg+9sNpZHdY+D7e07E1BXnYmlXkdzCLMTY/GtlOZXaT
	O3/MZP5XeJP7LPsonnrudfEAh8wk=
X-Received: by 2002:a17:90a:ec86:b0:35a:cf:64a6 with SMTP id 98e67ed59e1d1-35e42874998mr12283380a91.23.1776062845275;
        Sun, 12 Apr 2026 23:47:25 -0700 (PDT)
X-Received: by 2002:a17:90a:ec86:b0:35a:cf:64a6 with SMTP id 98e67ed59e1d1-35e42874998mr12283363a91.23.1776062844878;
        Sun, 12 Apr 2026 23:47:24 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id 98e67ed59e1d1-35e41bca6e9sm4880733a91.0.2026.04.12.23.47.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:24 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 06/11] apparmor: fix missing bounds check on DEFAULT table in verify_dfa()
Date: Sun, 12 Apr 2026 23:46:31 -0700
Message-ID: <20260413064712.1581137-7-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064712.1581137-1-john.johansen@canonical.com>
References: <20260413064712.1581137-1-john.johansen@canonical.com>
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
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235928-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D9EC3E7E67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

commit d352873bbefa7eb39995239d0b44ccdf8aaa79a4 upstream.

The verify_dfa() function only checks DEFAULT_TABLE bounds when the state
is not differentially encoded.

When the verification loop traverses the differential encoding chain,
it reads k = DEFAULT_TABLE[j] and uses k as an array index without
validation. A malformed DFA with DEFAULT_TABLE[j] >= state_count,
therefore, causes both out-of-bounds reads and writes.

[   57.179855] ==================================================================
[   57.180549] BUG: KASAN: slab-out-of-bounds in verify_dfa+0x59a/0x660
[   57.180904] Read of size 4 at addr ffff888100eadec4 by task su/993

[   57.181554] CPU: 1 UID: 0 PID: 993 Comm: su Not tainted 6.19.0-rc7-next-20260127 #1 PREEMPT(lazy)
[   57.181558] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   57.181563] Call Trace:
[   57.181572]  <TASK>
[   57.181577]  dump_stack_lvl+0x5e/0x80
[   57.181596]  print_report+0xc8/0x270
[   57.181605]  ? verify_dfa+0x59a/0x660
[   57.181608]  kasan_report+0x118/0x150
[   57.181620]  ? verify_dfa+0x59a/0x660
[   57.181623]  verify_dfa+0x59a/0x660
[   57.181627]  aa_dfa_unpack+0x1610/0x1740
[   57.181629]  ? __kmalloc_cache_noprof+0x1d0/0x470
[   57.181640]  unpack_pdb+0x86d/0x46b0
[   57.181647]  ? srso_alias_return_thunk+0x5/0xfbef5
[   57.181653]  ? srso_alias_return_thunk+0x5/0xfbef5
[   57.181656]  ? aa_unpack_nameX+0x1a8/0x300
[   57.181659]  aa_unpack+0x20b0/0x4c30
[   57.181662]  ? srso_alias_return_thunk+0x5/0xfbef5
[   57.181664]  ? stack_depot_save_flags+0x33/0x700
[   57.181681]  ? kasan_save_track+0x4f/0x80
[   57.181683]  ? kasan_save_track+0x3e/0x80
[   57.181686]  ? __kasan_kmalloc+0x93/0xb0
[   57.181688]  ? __kvmalloc_node_noprof+0x44a/0x780
[   57.181693]  ? aa_simple_write_to_buffer+0x54/0x130
[   57.181697]  ? policy_update+0x154/0x330
[   57.181704]  aa_replace_profiles+0x15a/0x1dd0
[   57.181707]  ? srso_alias_return_thunk+0x5/0xfbef5
[   57.181710]  ? __kvmalloc_node_noprof+0x44a/0x780
[   57.181712]  ? aa_loaddata_alloc+0x77/0x140
[   57.181715]  ? srso_alias_return_thunk+0x5/0xfbef5
[   57.181717]  ? _copy_from_user+0x2a/0x70
[   57.181730]  policy_update+0x17a/0x330
[   57.181733]  profile_replace+0x153/0x1a0
[   57.181735]  ? rw_verify_area+0x93/0x2d0
[   57.181740]  vfs_write+0x235/0xab0
[   57.181745]  ksys_write+0xb0/0x170
[   57.181748]  do_syscall_64+0x8e/0x660
[   57.181762]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   57.181765] RIP: 0033:0x7f6192792eb2

Remove the MATCH_FLAG_DIFF_ENCODE condition to validate all DEFAULT_TABLE
entries unconditionally.

Fixes: 031dcc8f4e84 ("apparmor: dfa add support for state differential encoding")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/match.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index ae07fe81b47f..f70e5f769ef0 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -204,9 +204,10 @@ static int verify_dfa(struct aa_dfa *dfa)
 	if (state_count == 0)
 		goto out;
 	for (i = 0; i < state_count; i++) {
-		if (!(BASE_TABLE(dfa)[i] & MATCH_FLAG_DIFF_ENCODE) &&
-		    (DEFAULT_TABLE(dfa)[i] >= state_count))
+		if (DEFAULT_TABLE(dfa)[i] >= state_count) {
+			pr_err("AppArmor DFA default state out of bounds");
 			goto out;
+		}
 		if (BASE_TABLE(dfa)[i] & MATCH_FLAGS_INVALID) {
 			pr_err("AppArmor DFA state with invalid match flags");
 			goto out;
-- 
2.51.0


