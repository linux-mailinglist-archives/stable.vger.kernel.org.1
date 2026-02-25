Return-Path: <stable+bounces-219143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAnVHp5knmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE21910C4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FF77301E497
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C60299924;
	Wed, 25 Feb 2026 02:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dQFsT+de"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2029AAF7
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988121; cv=none; b=kJHS1uLhQV6gsvFCT6ZYZeYYLSoep3JlvGb+MyVtaMHnmpzMxoge4xIHjni/wHb+R6uUlCrcckr4iF3y/SxkVobLoG8EJflsyGHosxuZYxBBUJU8NBn8CX0AC0DEnM+lS0qt1bkndH9Sv5kXI5+KeJJFtiMdmFiTLZanlmEcWj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988121; c=relaxed/simple;
	bh=j3uQBF1eQ1S9KJnBMWSQ/K8kCLuKrP4Lzq8yyq5bPUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLL74lWNt2AmAvs8s2sMSti6zAkig9mwf11EoNyac0p1oZkyQGdPkFKScYzDMY5vF1Yzj3PUNJFRSfk+R6YABSbJqFWqrvmTJ5ecrsMqzo9ZuZ/LFZHJY/9ZM0kQdknIyvMrsGgcO0e+Q313xzBUz8f+HLA+IuoUf754sqivE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dQFsT+de; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4807068eacbso48156585e9.2
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988118; x=1772592918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tyk43jBLod9dth8dDw0juDFmfIsnkkelgNAC1dDyb/k=;
        b=dQFsT+deCbKKpTKGPPC6pt0YPbPO/eKEuvtBkwS1mFKPO0f6BlLuR0n6nb1qM5D6KC
         R3YZLAqLHt0XMSU7IIakujrjrjOqUcswysICkm8bbnKOuavvtiBpZ778FKjFwIXHhO36
         yUzzx/JmJcJ2BN57iMXzV1tqgwqq1ffZOwkhBRpFV4d7ab3RJXNZBUL3cKat+Em3HE8B
         AgLhaM20tqLxR8rWvzOgrxSZ1K9P/PfJR671pymtr+wnyfaNWuZFdMHzhfoPYZfCIbce
         yVR08S6fP6+5qcDcKKDfRjgVydbwbw0IUXr34M0ijHZ2fU7KZEpnZ9p5QAkeSplHClD1
         gREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988118; x=1772592918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tyk43jBLod9dth8dDw0juDFmfIsnkkelgNAC1dDyb/k=;
        b=e0J+kc+Yr8WhF2Xm4zY/hDY0IVvdywsIC7T+yl4Q6N4JwUrXTQ0nGVQv79qufxk4bg
         Hkbp9XZ+Q9qXucRHHyMpCZRdu/FeKNEo35uoeG8IbuoSQGj4dabGqQlEp7qK8t6jxU4r
         usubyIv71M1JMCwfMYSa75nlLbQTJGdBsdLQjxHzfJQSCBqmCwj6gCBBCHfatbaOLVka
         Z3yjw2flSzQwMIJKnP7umbTRrzKg68StWdWFbQge9H+ET9EExfxEdB4PCSaJJBtCL9o5
         J7lT+0bCJzlZFCa2YN1XIzTWEvESkYUJ35SG2NioAHPALvehyg0twwzwF2ZD1QnzR5f/
         RA8A==
X-Gm-Message-State: AOJu0YyBxPmN2cBdf8lKtA4Qfb0/qJ8BaaJKL8+CtVGI+2mANmsu5R9O
	csOYKwDoSWSpTpAm5jOD4P/X9cD9mUzPFxvSliYmvAGOTfY2P/HOkGXPy7ZfuQo279gn8aKEZF8
	tVpF1
X-Gm-Gg: ATEYQzzydYJzwgJO/UwfTeK5RtEGjWBtmiIxW1sOKWZldGlZEHoDzhj0814GNBOEhV9
	zkU3czG9RfTsqw1WgNi6ITEcCFQ1C47DaWxadrQ0zAwCSSTnyo86jQBEfLLM/XnoKcDafQ9Vhie
	JR76s7o6hp/MhP4axK4R7IUhoe9gYxfsFFzQXblUv+o1yGItPJwiD92EEB2/5IdktmRnEZrdOOv
	xgMMemJ82oc9A+sCwNjElKcb1eZoD+ZgubtZ7u91eXjFsnz4KJrc4dt+SgEWbf7bC2gqrcAVg39
	SyY6w9tRpvxdYJ+qjshXewA6TKcCTPawjXptuhsPyjeDucBseHU3AX9KZsxi2eEOTZTFhWZrIjk
	yocVgbhadS4M+kvzBlqa2A7ko3ts0IPRrJYGqHSLhtHDLeX2YqB4x78BeHZzmma3qknT1IkSuex
	3vWgi69txAJDUxh4QVFFpk5CQBMA==
X-Received: by 2002:a05:600c:6206:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-483a95b71b5mr264072735e9.13.1771988118157;
        Tue, 24 Feb 2026 18:55:18 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adbd3f8d60sm12378655ad.38.2026.02.24.18.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:17 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.6 04/11] selftests/bpf: Monitor traffic for tc_redirect.
Date: Wed, 25 Feb 2026 10:54:42 +0800
Message-ID: <20260225025454.17398-5-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225025454.17398-1-shung-hsi.yu@suse.com>
References: <20260225025454.17398-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,fomichev.me,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219143-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.929];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email,fomichev.me:email]
X-Rspamd-Queue-Id: A9EE21910C4
X-Rspamd-Action: no action

From: Kui-Feng Lee <thinker.li@gmail.com>

commit 52a5b8a30fa882c4d363f7679b7db4a093550ac1 upstream.

Enable traffic monitoring for the test case tc_redirect.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Link: https://lore.kernel.org/r/20240815053254.470944-5-thinker.li@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: c047e0e0e435 ("selftests/bpf: Optionally open a dedicated namespace to run test in it")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 5a6401733587..656c06ff7614 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -67,6 +67,7 @@
 		__FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
 
 static const char * const namespaces[] = {NS_SRC, NS_FWD, NS_DST, NULL};
+static struct netns_obj *netns_objs[3];
 
 static int write_file(const char *path, const char *newval)
 {
@@ -86,27 +87,41 @@ static int write_file(const char *path, const char *newval)
 
 static int netns_setup_namespaces(const char *verb)
 {
+	struct netns_obj **ns_obj = netns_objs;
 	const char * const *ns = namespaces;
-	char cmd[128];
 
 	while (*ns) {
-		snprintf(cmd, sizeof(cmd), "ip netns %s %s", verb, *ns);
-		if (!ASSERT_OK(system(cmd), cmd))
-			return -1;
+		if (strcmp(verb, "add") == 0) {
+			*ns_obj = netns_new(*ns, false);
+			if (!ASSERT_OK_PTR(*ns_obj, "netns_new"))
+				return -1;
+		} else {
+			if (!ASSERT_OK_PTR(*ns_obj, "netns_obj is NULL"))
+				return -1;
+			netns_free(*ns_obj);
+			*ns_obj = NULL;
+		}
 		ns++;
+		ns_obj++;
 	}
 	return 0;
 }
 
 static void netns_setup_namespaces_nofail(const char *verb)
 {
+	struct netns_obj **ns_obj = netns_objs;
 	const char * const *ns = namespaces;
-	char cmd[128];
 
 	while (*ns) {
-		snprintf(cmd, sizeof(cmd), "ip netns %s %s > /dev/null 2>&1", verb, *ns);
-		system(cmd);
+		if (strcmp(verb, "add") == 0) {
+			*ns_obj = netns_new(*ns, false);
+		} else {
+			if (*ns_obj)
+				netns_free(*ns_obj);
+			*ns_obj = NULL;
+		}
 		ns++;
+		ns_obj++;
 	}
 }
 
-- 
2.53.0


