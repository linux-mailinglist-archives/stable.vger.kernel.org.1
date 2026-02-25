Return-Path: <stable+bounces-219145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH1kNLxknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7E1910EF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E594309F695
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0352129ACD1;
	Wed, 25 Feb 2026 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RaLl4MSl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51929992A
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988124; cv=none; b=dmImGEm3KHdBnxyHoMYd7zErcC1XQyqAN/a0IMstsR9kMfUbCnoJB57A8M4CubwMwAs9bsjYlpf9sPHhGzM6cgRiwWw1bZYsFD3PPhLebwSXGnt0B8L4XPjxkBCVE1Eu3I7WzjkbZSdF6haPsz92Yn8GmGEQUw/fJktpbloyg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988124; c=relaxed/simple;
	bh=RUBhdIZudKtf6TcU7irZAYknwV+hEDUn1nJqmoAdviw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKDqula7apHcH8r2PgN5QDXyXxuPnEWxGSwSnwCvwQU6O4qKJwlDPlBpHoHRUWHxghg0tzMdpT4GkLS8QJMaNu3c7O3ovToZMd+mx+IAi7/EA/67lojSqXpvOVs0LWNug6kKBWsn5d8t7mngUXJU3D5kefm8PU2rP8wYvB5QK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RaLl4MSl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so37600225e9.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988121; x=1772592921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m6STu43RYoC1t6P+Y+x++RPg9P9zdPeP5/mygAwMzc=;
        b=RaLl4MSl+EfKpPnULulogx4S4bNtW28qCzy48qSNwT6FzGVffKx5L5N0SExF7KTznp
         wPnyH4vMgS4J+URhBihrca03shtiP+FkHQ7a+R6qS2dSbYGYr6G7C2k581T2iMJtD1am
         RBLWA/XrcA29YtYlTFX9lRJrGXWQEaOvZXM5wfGIVLPg+9feCgXnywHFMw5LvfSytJho
         VUpedhrSCMNO77shZN71/niRBhWAuXxmghMHjIR55GtbxxggYtZelKaXLLInTJ1fIxV4
         ReLuWRPm95N3ZcRmajUkVl3KMYlsJ5wGBgf50tU6tn1fVl7lF30VIA9bFiVr1FeeUO+Z
         PsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988121; x=1772592921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7m6STu43RYoC1t6P+Y+x++RPg9P9zdPeP5/mygAwMzc=;
        b=ReobD5CnQ+ZmlDBSKrJcFMiUYS1lcNyz0tYQ5EduagPIdK7VUBJvzHEpvM0BEJL2Kp
         D4JhJt7vkO16ZejqkXmRix4ypEVW54o9pgRdAWZRrNWIaCzJW5BbP+R0gkDAP9nN3jbe
         fr+UKwDwX6JHVfzq7dG+et6DdrIpjDRzBwmGIWqM0IgO2px+MVuRosIfoZ+MQX79tFVJ
         Ae9CSCYqwe11+Tm8L5wa9v2BJSvFgu/EQdPtgzY+v9eeuIYNuUF3sfJDYrXqiT2aud3i
         zdgnpxhsQ6jAalGPbVxwmDA4PFqBaJJduLO4xTRRRTKMvcDbDjB7BhFf7zufv4b4DRNU
         eZhw==
X-Gm-Message-State: AOJu0YxldDNcV5/g/ZSWOSVrVlB0K/Tw7VxbWjBZm/FuEr8prkyFBWA0
	MwPog21IJELL9U59BWbBlkHXaKrJ/bmg9bsqCQzMX+Vt1oJQD26qzhCRs0ASDT+Xb/KJJlfucPt
	YBbHh
X-Gm-Gg: ATEYQzx8MzPWd7TrMC6snpRu6lgVHhyHIPFFt4ESOFDfFwQPKDsH3Zjw5IhhYd+9E5l
	K0ZrEqx8EZKVfYMTWhG9dDD6yVi1kn2DTO9oLuG1fT/oYjxqaanOWRQZ31mOUmQuV757RE/LlTr
	iPRBDQZZ2AwnuxuOUcmReYOK3QHlWQEquUGHYo9fLkabrTOCPks+BD/2Cdk7ftYTgoYQXWn4aq1
	93iMjCXAhtjybw5iJ5Pzgn9RUSHXrvKSMf+D14hhqWREVXhgzQJqdN8C/em6uKYS6hB6YtSa9gi
	IXwhjMW0wrr96uXRwexwcf3x4UEW6T3cz559pVixVTSouSLoSIbSGsGoPZy3JZEVtudtX3nLrqX
	EfPQADPRgSX/+8DBM5NPM0SII1K27K1aOsRMPXrWGYH0xgfPp+I+nu1o92GEOZ4zngaatyuTWCy
	pWY/bSMuLM0JdN/6q3PL/y3r+2dQ==
X-Received: by 2002:a05:600c:a06:b0:483:badb:618b with SMTP id 5b1f17b1804b1-483bef5a23fmr13995055e9.24.1771988121515;
        Tue, 24 Feb 2026 18:55:21 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5e568sm118290585ad.32.2026.02.24.18.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:21 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.6 05/11] selftests/bpf: Monitor traffic for sockmap_listen.
Date: Wed, 25 Feb 2026 10:54:43 +0800
Message-ID: <20260225025454.17398-6-shung-hsi.yu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,fomichev.me,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219145-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.937];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DF7E1910EF
X-Rspamd-Action: no action

From: Kui-Feng Lee <thinker.li@gmail.com>

commit b407b52b18505a7c09a77cbab022ec6cf82dc5f0 upstream.

Enable traffic monitor for each subtest of sockmap_listen.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Link: https://lore.kernel.org/r/20240815053254.470944-6-thinker.li@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: c047e0e0e435 ("selftests/bpf: Optionally open a dedicated namespace to run test in it")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index a6d8aa8c2a9a..85654b480aef 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1910,6 +1910,7 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 				int family)
 {
 	const char *family_name, *map_name;
+	struct netns_obj *netns;
 	char s[MAX_TEST_NAME];
 
 	family_name = family_str(family);
@@ -1917,8 +1918,15 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
 	if (!test__start_subtest(s))
 		return;
+
+	netns = netns_new("sockmap_listen", true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		return;
+
 	inet_unix_skb_redir_to_connected(skel, map, family);
 	unix_inet_skb_redir_to_connected(skel, map, family);
+
+	netns_free(netns);
 }
 
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
-- 
2.53.0


