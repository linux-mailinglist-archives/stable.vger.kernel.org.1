Return-Path: <stable+bounces-213169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL9ROl6CgWlNGwMAu9opvQ
	(envelope-from <stable+bounces-213169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 06:06:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5E4D48DC
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 06:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99B623064668
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 05:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D11C84DE;
	Tue,  3 Feb 2026 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MpBRTKAB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A021B91D
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 05:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095115; cv=none; b=ZCuc/TcAJqgZuK3Hd/JO4XOZcSgHsaruTBNg/79PgC6bR1S7bPN6pykQrMcuf82ThpoMsjO4vjXfmqCgvmTcHx+XaYQJXHgjVaA0PXD1OO5ojfa09tsIe3fYUweah5ddvt7nBe5EK0NFRoCe0e3RlN/3kspmyAoRX5xe7GYmEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095115; c=relaxed/simple;
	bh=VCo63EohHg9R4n60pBZBkW4WsfS50JSKYJzFfI2/KGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eTXoDlFWXTUrkhFZe4vxkpCjKaMR9el3boaAtri0A4MQkkFQIVg0mfmOFYySbw75VV88ipEhZtdSv2P/IFUTYBN2yVYuygfM6GA6SyiySG/TidYPxXu49GNVvCJ3LTC8DpxLw6BT1ifIFtyz4W/lXNI4yYAIIT4HIiSaDY7DATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MpBRTKAB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359108fd24so3135477f8f.2
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 21:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770095112; x=1770699912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z26YEcNLVoZu6mr2Po50elIyHrboJpja1LhFTkAjfiI=;
        b=MpBRTKABHgxcaRNQf7Z6nIUVt/jJ+uqDnM0x2xP/wlHt0kjQWUE3iC5Z39vJCdpl3p
         kWRv+IuvEXIo1ex8MTWMfU0wRnyY9+3mbWqHURMoapWw6H5qaVqcAn6KbzAgqo2dsDu9
         b7sES5QpAf0DVXmJS+J5cfg7C05VEBJgO9BwowMVCebMA6MTKJU+DdlVhWd8L4UvMrhs
         OCPcIGVqe4F/5r/AA2Ls+LjKDpB6aDv+SPT9zuyhdDzi5gxbqGvq9Ypyw3/No58coLRM
         uv8P5ADifTAWi2jBt+9kMKmfzew/Qnpk9YNHGLCkKCBxx0eldzp065J81JITJCtPMkYS
         Eidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095112; x=1770699912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z26YEcNLVoZu6mr2Po50elIyHrboJpja1LhFTkAjfiI=;
        b=avu+14cs+WSRUTdsncFmFJbi/kDDgo1GzAUeF6QUWmFmsOwaKSGU4/mkIDFysDl6K3
         gvCBE3yEyRiJjl/lkpL1r3CDXwk3WTMuJ2vsxudVDir9uXUXqVQ++168RNVGM6LRhHcj
         LC+dyKHpNWRPNMzLoAx58WxD8XW7AvlbfGdU8/P/GkbKeSKoInEXjhFML44IECuZOtdz
         qN7kN0dkU5VDMcUU603y4ULmZP8lXT79FpCApzEOIgvErn6dcJy13Oi8liLxVQ48Skmo
         h+gMNaE7VX1a+h9ZBO+7M+SwWeeTte3UnuSbebkJCXD1BXLKpaV379hANgwAjb5Z7GxY
         ccPA==
X-Gm-Message-State: AOJu0Yw8+teojnEOC02dgwoQCsW6QzUAQLDkeDXuopAO7j+5/weQSsBP
	gqtCLHBxYIFIFeRq9NlAnq5FU3JOOWwG+aIuaT0aC52LY0QqW5vFiWEmfBPwRvsyyu6aJpEQUNh
	NdmOp
X-Gm-Gg: AZuq6aJZuMFRqW74gYCKKTNR/g0fMneGYN/Drh1AzQmKcMuzhv6X9az2tRUenTFy9w9
	W477nDyUSFprcuUdRkSTgQig5n71R8Hz/4rsUE7a2TnGWCuPe8uhankprFwOnZpy9ck1+ziiHsW
	zodji7Ll82Artz0PO89Xpx3eDN8xRj+pS2bzGrcakWbTLZ0NcTWU1Cgt5rsFz/6MQg4iTW3u9X/
	tbbB4GEuWrUaInukk2WQPI8zSq+uv5fnozTZhCReu2p05Ter55Op4KFRuZ0C60uy37koKahsz+I
	Kk6GAc3Hr92+IzT5zthfD/VnsbnOzUGmmiXYaaw2WMb2V2jnIzbjJ2U0ez4b+u9BBPNSAFT9v++
	j1m7Z9xBfKeeLueKJ9yz/BVLFuUz+HHMUzQJusqopy/75BDHM7RE+E8X6vnMK2MPG4VpeHtSKEk
	pMDHXjFaRz/rv+xS8Lg1ZYw6G7bDmQ4abTD0I=
X-Received: by 2002:a05:6000:2012:b0:435:e3bd:5838 with SMTP id ffacd0b85a97d-435f3a8cc99mr21232753f8f.25.1770095111667;
        Mon, 02 Feb 2026 21:05:11 -0800 (PST)
Received: from localhost (27-240-89-6.adsl.fetnet.net. [27.240.89.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1323034sm50972713f8f.35.2026.02.02.21.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:05:11 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 1/1] libbpf: Fix -Wdiscarded-qualifiers under C23
Date: Tue,  3 Feb 2026 13:04:56 +0800
Message-ID: <20260203050457.50877-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,suse.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-213169-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B5E4D48DC
X-Rspamd-Action: no action

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

commit d70f79fef65810faf64dbae1f3a1b5623cdb2345 upstream.

glibc ≥ 2.42 (GCC 15) defaults to -std=gnu23, which promotes
-Wdiscarded-qualifiers to an error.

In C23, strstr() and strchr() return "const char *".

Change variable types to const char * where the pointers are never
modified (res, sym_sfx, next_path).

Suggested-by: Florian Weimer <fweimer@redhat.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://lore.kernel.org/r/20251206092825.1471385-1-mikhail.v.gavrilov@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: needed to fix kernel build failure due to libbpf since glibc
2.43+ (which adds 'const' qualifier to strstr). 'sym_sfx' hunk dropped because
commit f8a05692de06 ("libbpf: Work around kernel inconsistently stripping
'.llvm.' suffix") is not present.]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 060aecf60b76..7d496f0a9a30 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8174,7 +8174,7 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	struct bpf_object *obj = ctx;
 	const struct btf_type *t;
 	struct extern_desc *ext;
-	char *res;
+	const char *res;
 
 	res = strstr(sym_name, ".llvm.");
 	if (sym_type == 'd' && res)
@@ -11959,7 +11959,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')
-- 
2.52.0


