Return-Path: <stable+bounces-245123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFsuM0SKAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:50:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA0509902
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67241300FC08
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABF0387371;
	Mon, 11 May 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQFT9Syw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83C3859F7
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485018; cv=none; b=RFZT9MYjovYvMsLh/DAkYaNs+yiUwpYlRTduB7k/raaUK6DZdAcAFeO3oux/8SE/NddReXYpMd1TTDgc3FR4px9nQGql/UN+ljc9o9UII5eme5EeajMEKCpIW8Sj7MN5kZGvOIhE89oq9TZToHZJbZXJkIEOKWRszHjiyGgvhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485018; c=relaxed/simple;
	bh=jpL3mzX9DFcfcSYmOuTF0r/I+aFAAQuGXmvexiAWa2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNc7CY/T8YvyMx89sAGF4EbHzgO6HtGHwURAFqcPGL5q8KD+PMxpvMYVeYyaLxJeb01ISAYFkM5Pr2IR+4xJJCoHJ7Xh3mbqQ+f3BaY3CzwizMXevZohNkG3Zt5kTKNPLmlXbnnYGdTyR8y/MmdFCXAq+xKrzPjo3x8NQKh5tSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQFT9Syw; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8eab809593cso428443785a.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485014; x=1779089814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKnu9789dgOmVzJ+fafjIpAVy3vYKMRIr5NOXQEo/lg=;
        b=oQFT9Syw/5hD/BxPnC1R8/mobrU6URBW9jnqBrKQQ8gSBJV4fYtMVo3vLLIyan9Uke
         LvU3AyRo2lt8DpNoglrmDvIITrLFcaCskVzEMHtz3kdWVnrHetNVlSbRceE+j1/ohoF5
         /wbALrdrISbzQ7Rvyrm0gcF0MP6mIJ+3B9JKldn2AAd5l1Bg+AN6rYYNhE+kgglDGwsT
         bQN4uAQoTwh5kDHMS9R0PWSS/3pilWPFwo2+KluhWs+VoOoV0hOGitgVSX43nbN81Bdx
         V6rn+jfjfwg4PtIVFQIG3TXoBx7C1eaX6kfIVRjo8kLMUrKUmkMhxJJM9PGzXVpeme44
         /09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485014; x=1779089814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AKnu9789dgOmVzJ+fafjIpAVy3vYKMRIr5NOXQEo/lg=;
        b=C6mpNQrdkQpvs8ElAVGqkoQaf4JWibd+hiuXeMKqkcZ2tI+jWo1aPTR0oUitPN1HbC
         lO1voMGjrHuAF2FgkWCDmSpSFHcYno7samNYjKDmzfcimoC1S7Ok+ioVcsCDt4SKw3ag
         bQ6Vd8JGthXl6Yfhggjx2k9gNTOqzkbjWExt2TfkO5hWQJIEDdcp9kzony8p5cIUND0k
         Q6uv4Hv6MYGYP5GMDBGrOavuJPInz4y28fQaj4qeTCSV4QYRIifiA5D9zDE9/ou9zhhE
         HMMTLmuj9IihKEXFmOgUTAmaJiN64D6WYJhKZpBHVXeEPjJFymzvB8YNNry/iakRcznJ
         YG3g==
X-Forwarded-Encrypted: i=1; AFNElJ/MA5jdkAguH59KNgIIco/COYcDrafH1B6syBiqIxqV7H2pc3LX0VK3Exb3iLg9U06z+93lDok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzj8nPBAbj9bA0x3B1qDqQsnzA7f/VPS03l/yRuqxXvacmkBLG
	lebvQmz8hYq7UyIkxOKs3FtNZzsu5wtkt6+pymuRNBqocJO+s16DRzO5
X-Gm-Gg: Acq92OG/jb9uRFaBidqEKSMXL4cnTpzxLAGCNqLcwXyK6GhXKEoU0cOFOz9QlASWbqV
	6YJQ8B8nja2Liwp+9g9LZmyjKDGO3b1L5udfmUUbv0QkBLzVZ5RXwkEFuWTvKmA4sUPcVrimbQe
	aalo611nSItE/Ej+9doYaTCD5ZB5M9lLfikgN3YbW72XADP1VPAWDN1o8AMUNyHbIbyGuq+B0fX
	h7Yub8eSVOWpCNd0QLxPEeniPuJCPquFkqbk2R8IXjwLtfidV4BFtGV8WGdGIvOapnxZMC/O7it
	DDHlGfcdYszt+7/x8Mowc7UZQfOJEg2kKaNwVA84eJGO9RbctNOfizjz9sOTFq1GlNsxifGKwxw
	cZEz1N0pC7A+jW568bbnOeAMqWFGEnGhRawxRTR9Wx1/chil+WZCv1vq1xfJ0SR8+6OQesxumuJ
	iIvdZU/6J/FAdocFnDdh3dDqYQWQxT1obZ9aZeL22bwAjAGfOyfS5LIHBxJlo0hk03NSc1Suj9P
	pTTBHjWIKY=
X-Received: by 2002:a05:620a:710b:b0:8cd:a3ab:352d with SMTP id af79cd13be357-90910c0e948mr1263035685a.61.1778485013735;
        Mon, 11 May 2026 00:36:53 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:36:53 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Florian Weimer <fweimer@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.1.y v2 01/18] libbpf: Fix -Wdiscarded-qualifiers under C23
Date: Mon, 11 May 2026 12:40:34 +0530
Message-ID: <20260511071051.537859-2-yesshedi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511071051.537859-1-yesshedi@gmail.com>
References: <20260511071051.537859-1-yesshedi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7CA0509902
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245123-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

commit d70f79fef65810faf64dbae1f3a1b5623cdb2345 upstream

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
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7bd6aff6e260..33b214a91338 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10748,7 +10748,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')
-- 
2.54.0


