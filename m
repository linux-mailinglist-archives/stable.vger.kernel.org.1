Return-Path: <stable+bounces-213167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HvEbGOGBgWlNGwMAu9opvQ
	(envelope-from <stable+bounces-213167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 06:04:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BCAD4886
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 06:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9442C303E491
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 05:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F691C84A2;
	Tue,  3 Feb 2026 05:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="URE9k6of"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC02286A7
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095068; cv=none; b=aH6h1t9Kpvud5t0qBLjXei1qQIUslj2OnLdbqx5qvFka/j7nUX4szpIqYD5D7/0I6sLtZI+i+WpNyr9jHn/zoqx85njzXVGKE+Qudjr7qpxw72de0rp0iDnRoITdD8y29s1/q+R1n5XMwcHqVz3s+BoeDEQ9QvCFrYiBrDmAasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095068; c=relaxed/simple;
	bh=jnm3m/3XkO9Wf/pRJ8hFwy5cJ/+lsic4aaTyfsdq218=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ToGvT0AKV+v0T8Uoc99j6W2+Ml86YsxjjVcN/7lCDHBjAD3+61ZMW2l7rDJGqiX3zzijNaf0Rz4yuqLHEoYgl13JzxQeqbMUqSWXe15EGLlMFft/Q6EVyzBGGo/dwMCRX33E4pIde4DEHm0pvkO/3aXvZuSqpBkX8NF5U0qRSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=URE9k6of; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso39323675e9.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 21:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770095065; x=1770699865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQGW9cQsVou0c1GIoRXi+a3u05FfBz2kEjjudveRXmo=;
        b=URE9k6ofnPszmk63yraBWRdliz5qFXwf2CEmKFx1qymrwkJZQ1RRRcsdOuw7fHV7tk
         EPNU2jgDa9QmFYEKt0+Cb/cLOVkf4M26vm+fbqbXjuez8Kw8i8GlZShUdiQDo0EMisBD
         5mwJV4oxPrACEOGlznT3CUgjt6C3TwZzFf//KpGPaDNMI3zZe9P7XKJr7q6B2aVZ0zE6
         pYoigTnrXoUEJ9vwrTF/o1lx9jxeTCxcksqu4wY+VcIHTbW2uuqX4KEGvN8/dRPU/Xd6
         TmAv2rn+kQkv2X64eZWvSUTqZwAz40aZV/SK6VSEcvUEx6gDO608XGe49SxfTF5llwe+
         ilLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095065; x=1770699865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQGW9cQsVou0c1GIoRXi+a3u05FfBz2kEjjudveRXmo=;
        b=YDA8lJvzFsdnsNJ7LP6YWx+CchNI5gluf3FakXEOti7Orr3eT6OYeiGzLmXYObgyaF
         N7aYl08YoPxrkEopiv1FugRhFRLmbNc4Rdf3R234drGB6pNM59iPWNN7dDVDxMir05nM
         9TrbXO565VVc12KPTfA55vuD/23gXhrlOSoQy8fSbJcvH7CPfuET4hxbgTAXxUhAzESC
         qlJPmn6j+KJQCFRUwsJZ0Zttf+V/AKIbo0wRUuEoQX1mgaA61GZ0Z5a0IzUqxf14VaTo
         bySr19dmqenKVqWbG8n0OKnYocdXrmlvZew23yRI8znvHTFu+0mkn78b98LOr3U7TqY2
         jROA==
X-Gm-Message-State: AOJu0YwBUsKvqdHFW8w8MEa0VPwQml8W5mzyvKww0xh3NMqA1abHMce1
	MTM+BzdHsD3UJgCCqiSkxpGowDaAZsX/x/WjkhuFcldnpyilyBXKK+syrx22DyzK6e3YGaizCTl
	kADvD
X-Gm-Gg: AZuq6aKwT03WRFjZ74F+cTFCL0qYWObNLF6yAZzoG7cZKsRs8zrxx/SFdKVk7Rj4TBY
	ss6kFf8+fwTm3RQJ3GZm85BDxwg6OQq/mv6OVDTTkI4swBOS20S7XgD1gFoM6M2/Gm8+d9KwUq7
	bslSxHanTlPTYxOvgRYe6d1gRBCluWQCoVgTiWdWZ8vdHOkpz3OFF9UlI0iYiNTwxrQuIeYnTpE
	WalUZ5/zj40FJ/TL+5FtVE6JYg9Y96XUKXwVMSaSXhkQcSaO9NI+XR8aJLD06JcClJAiZuyHbUi
	VRm1Es5RYIipoLdVLa9GVV/ZSpv1UyyXsgjrl8HUWB9PcCV020mrXO8JiqCWgjLr7xHwFx/c1Ai
	JEqzxDy1J5gcj95LYQOe34f+DCVEcVz2luGx1qRVQbpirY4YQKRfapgYewiSoi5Z/6sqdaiGjKf
	ye6Lwsv3GwBJIrrLE97uR+6yKx9kueNXDJAFA=
X-Received: by 2002:a05:600c:8b61:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-482db4567cbmr199054595e9.7.1770095064822;
        Mon, 02 Feb 2026 21:04:24 -0800 (PST)
Received: from localhost (27-240-89-6.adsl.fetnet.net. [27.240.89.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da6a042csm149282565e9.0.2026.02.02.21.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:04:24 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.18 1/1] libbpf: Fix -Wdiscarded-qualifiers under C23
Date: Tue,  3 Feb 2026 13:04:04 +0800
Message-ID: <20260203050406.50802-1-shung-hsi.yu@suse.com>
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
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,suse.com];
	TAGGED_FROM(0.00)[bounces-213167-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: C4BCAD4886
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
2.43+ (which adds 'const' qualifier to strstr)]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/lib/bpf/libbpf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dd3b2f57082d..9c98c6adb6d0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8245,7 +8245,7 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	struct bpf_object *obj = ctx;
 	const struct btf_type *t;
 	struct extern_desc *ext;
-	char *res;
+	const char *res;
 
 	res = strstr(sym_name, ".llvm.");
 	if (sym_type == 'd' && res)
@@ -11574,7 +11574,8 @@ static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
 		 *
 		 *   [0] fb6a421fb615 ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")
 		 */
-		char sym_trim[256], *psym_trim = sym_trim, *sym_sfx;
+		char sym_trim[256], *psym_trim = sym_trim;
+		const char *sym_sfx;
 
 		if (!(sym_sfx = strstr(sym_name, ".llvm.")))
 			return 0;
@@ -12159,7 +12160,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')
-- 
2.52.0


