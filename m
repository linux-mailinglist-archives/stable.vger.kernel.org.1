Return-Path: <stable+bounces-219146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPlPEqNknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A951910D2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 552C13078135
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D595299924;
	Wed, 25 Feb 2026 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y5fVMV7m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649A296BD1
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988128; cv=none; b=CK4twGVugzLM8hbmVKGWgIlPBTp7wGFG/ry98XWdAc3m8op+J6uEJoyT0lYTz8cRhB3SS/IwN7woJdzYJ2+E4jcqE2qe+FJjhWJpy0+KyK8Ky8I7W+wunRg5rCDHdLAuIkZ54TSdQYkUuP8RwLJqFym0+/YJ70G07yhtyMoU/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988128; c=relaxed/simple;
	bh=S+4TQ5/YC/2PcydAziFmdI14y6dDjPfagQurttaHqsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osIyFgdmRp/hNdBNXvG4JjUrazieEAl1uiTDrVKXzKC/Y3CFAcSs4NwJ48E0twOPH95Pm8ZTX/MHqSFuqZpv6BQbiIyu0iAJpVfbVV4QvGRP/bvSnKoCZ7IySs4ohNJm5udCF0lifquhWSphNA2fZ/mJYLHEeevsb1XaCjSaAoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y5fVMV7m; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483abed83b6so26971955e9.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988125; x=1772592925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5Neq+npwHu+wU3QpOvrLQyRZOOEc3jYfR/KKApGTCI=;
        b=Y5fVMV7mpizoicb9BLCe0kQ76DfAUpPQ3wtN/Zlx6JbtBPu3LCiODb/LOE9cIT0W4f
         C7bhKBR24cVVsCxVWmztkEsA6cs2l8SfsycW1ml1h7yxPdJ6lAe+v2qfXsqIUbsGq5hD
         wTLcrA/xqjkq7eCLXbijv3qt1escl3bYtFx1LqTy7gAO6oAryewEict05zfRACmeJ/+f
         VWBez/wy9D3P3iO5Nnzn3Ua7irEKMIYjaPDmuqqY56+TbQHtqxuiReufF0hK2BCwSxYD
         K3EaIg0EiDaIdXQ/tyPy5qqntrajsb7L7aO0+01h9KjxnCvOK45AxoNLiDsOZgJZK8Lx
         +54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988125; x=1772592925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B5Neq+npwHu+wU3QpOvrLQyRZOOEc3jYfR/KKApGTCI=;
        b=hRiKTe/XvIRB+pipm5Hb8Xlqjyak1mcwp/y7Is60qZ9DzADuKLlDQhnH40bFqfNe7e
         ANHdUhfZ/rEoNgvFkjiwhDJbby5eVBOLcoy25mkg6HuLtCEe8yc+9syGjjNGb2t9PqQI
         I+sFz1oIAZtDezRn5+D1BlSIaO4vSlKimYz1kY+6Z1/33hf4oh058v2lxVjz6An265UK
         XxaKKWa4f5ElNTJLE3JR9gURmFmqLDEnA1ShNP08q7QwR4XPtaFiR7qwJlNQ9zt1Jz8f
         nsYsCD8N8529xm6iwu5i0p5Ahsszb3WdDl32+i6RrOssfkrG39PlaOq6FE0wZzb8fPnG
         2+KA==
X-Gm-Message-State: AOJu0YyTh3kxsgJpbLidBlvsyCbpULH+UDHBC5vWCPSiGP6ms0Wp+dit
	EJM3ERDKrvp0Aj+zKhXPPvKE/y9zn/rNsJ6Xbe+aRD1hNypTayJF7NZp38Xh6MCRKn/Jc7oyS9z
	hi0ZV
X-Gm-Gg: ATEYQzx3Amc+Yi0lXxagrWXcpd730pGOfkKk04nylazzxU4GYBsxpwj9W+/poIpVGfI
	kq5lKJl2h3kLOvjAbl+KjVneVrS3hFsORa1RhskT0fkvJfJUrhsmXb9/8DrHhTYs6iLkpfhAZoa
	/WJ5OPSAYEWSX8uqAd98qsQmG2k50VkW+mwR1RyErBjp7b1CnvFiC5xXCoOBpXIpUiFjnwaE7gI
	lXnOPE6p8T5v8sqTvdc3JkjRj3ugnUE1npITdLHLMO54HlmnrXzD0zZTocsiGI/MQnpxCalXwtn
	OnTER1o4oFqm0ZS/F8ai/cuMEC8/GlDF6u/lYn/fllhflMI39Y0ONFlEBBCO5o1ScuNdc6VPXB7
	3w5kHN361YPU8XOtuPTjyDKqMt2z2sogR9rJhSZhWlPhiz9ErM10Dw//WHRck/0B3szTquu8dMX
	UWWZQoN0c0ORALUbaCend8zNfq6UlX/3DcZjcP
X-Received: by 2002:a05:600c:1c22:b0:483:79ad:f3b9 with SMTP id 5b1f17b1804b1-483a95eada4mr247017295e9.28.1771988125052;
        Tue, 24 Feb 2026 18:55:25 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adb97cb8f8sm16796395ad.78.2026.02.24.18.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:24 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.6 06/11] selftests/bpf: Monitor traffic for select_reuseport.
Date: Wed, 25 Feb 2026 10:54:44 +0800
Message-ID: <20260225025454.17398-7-shung-hsi.yu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,fomichev.me,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219146-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.936];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,suse.com:mid,suse.com:dkim,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2A951910D2
X-Rspamd-Action: no action

From: Kui-Feng Lee <thinker.li@gmail.com>

commit 69354085975ac61632ebceedebbeeeb0272620b8 upstream.

Enable traffic monitoring for the subtests of select_reuseport.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Link: https://lore.kernel.org/r/20240815053254.470944-7-thinker.li@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: c047e0e0e435 ("selftests/bpf: Optionally open a dedicated namespace to run test in it")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/prog_tests/select_reuseport.c         | 37 +++++++------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 64c5f5eb2994..036d4760d2c1 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -37,9 +37,7 @@ static int sk_fds[REUSEPORT_ARRAY_SIZE];
 static int reuseport_array = -1, outer_map = -1;
 static enum bpf_map_type inner_map_type;
 static int select_by_skb_data_prog;
-static int saved_tcp_syncookie = -1;
 static struct bpf_object *obj;
-static int saved_tcp_fo = -1;
 static __u32 index_zero;
 static int epfd;
 
@@ -193,14 +191,6 @@ static int write_int_sysctl(const char *sysctl, int v)
 	return 0;
 }
 
-static void restore_sysctls(void)
-{
-	if (saved_tcp_fo != -1)
-		write_int_sysctl(TCP_FO_SYSCTL, saved_tcp_fo);
-	if (saved_tcp_syncookie != -1)
-		write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, saved_tcp_syncookie);
-}
-
 static int enable_fastopen(void)
 {
 	int fo;
@@ -793,6 +783,7 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 		TEST_INIT(test_pass_on_err),
 		TEST_INIT(test_detach_bpf),
 	};
+	struct netns_obj *netns;
 	char s[MAX_TEST_NAME];
 	const struct test *t;
 
@@ -808,9 +799,21 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 		if (!test__start_subtest(s))
 			continue;
 
+		netns = netns_new("select_reuseport", true);
+		if (!ASSERT_OK_PTR(netns, "netns_new"))
+			continue;
+
+		if (CHECK_FAIL(enable_fastopen()))
+			goto out;
+		if (CHECK_FAIL(disable_syncookie()))
+			goto out;
+
 		setup_per_test(sotype, family, inany, t->no_inner_map);
 		t->fn(sotype, family);
 		cleanup_per_test(t->no_inner_map);
+
+out:
+		netns_free(netns);
 	}
 }
 
@@ -850,21 +853,7 @@ void test_map_type(enum bpf_map_type mt)
 
 void serial_test_select_reuseport(void)
 {
-	saved_tcp_fo = read_int_sysctl(TCP_FO_SYSCTL);
-	if (saved_tcp_fo < 0)
-		goto out;
-	saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
-	if (saved_tcp_syncookie < 0)
-		goto out;
-
-	if (enable_fastopen())
-		goto out;
-	if (disable_syncookie())
-		goto out;
-
 	test_map_type(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
 	test_map_type(BPF_MAP_TYPE_SOCKMAP);
 	test_map_type(BPF_MAP_TYPE_SOCKHASH);
-out:
-	restore_sysctls();
 }
-- 
2.53.0


