Return-Path: <stable+bounces-217874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGbsNFRWnWk2OgQAu9opvQ
	(envelope-from <stable+bounces-217874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:42:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62288183297
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB493042B5E
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E973644BE;
	Tue, 24 Feb 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BVS2Zube"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C023B632
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918704; cv=none; b=IqeOsnQcIVA/wXapK0l+m//VcRISTkafvBNR9vznY9EBVKL1IOl1mor2iUHsRnS5eTqxa+n5uTjQqyumuA1LXxyKkAFeX8yXeNpt0SsTE88gu5nFPekusWfTJHlewKuNPaqDnUaDU2KktY5ea9TfY2NYpJadlf3XSN/9ns009Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918704; c=relaxed/simple;
	bh=Pv1FNyK/2YIIogEkegogUfRGv3G8HGzDG8FtxBQOWP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3nKFhYbQ/Baw4r6JM64wrILwpDrsPV3I8hY5HKhziEfvjqPoXjyefdLUPAfh2d0L0vW99v3p3nsLyVucGRSGXFMLTfklpTW4u5Efp9dOZ5pLRAYd1ddrOuXYj6x/w6DYmxiVyYk1DktH1dSGKZNQ03Bhdu0BcPsIWW3s8E96gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BVS2Zube; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48378136adcso31044145e9.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771918701; x=1772523501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjXDqNkKvLLm+oAIVrWeGRB99zSGgkjCEMggqBuUoEI=;
        b=BVS2ZubebainkbLcNZj4eCZhUKGAicdM5cmn68xL0Bn1BjAQ8P8+1emh8d+oLyCmbQ
         gQXzg56ymvtFdzw1hrJZTtwx8Ng20PNZYTSy3CoWQHRMUKoHkfYfz30+0HJgkiRFYdKN
         HMwduNzHnMA+VWGvKB8drgP8RR92R8Q/8mZXQluMpqRMnkHc7YosJpFyZH5XsAJ6fvXO
         dJqERzsOcsWZaQLdOzFSe8NwfUclerMFvetcVzUiOGjBye2qZJnnjjmXv7XLey68jf+t
         1YV8Hsuuymbsu0AwOKvzG9e4ZWgG/HOESgcq3VU8JjMEWJM1u+pUXN/4jdo0C6p1SIpz
         V0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918701; x=1772523501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjXDqNkKvLLm+oAIVrWeGRB99zSGgkjCEMggqBuUoEI=;
        b=HOImrPHo7aKP56S7e6Hde3S+QbnELERhd17K1aDSLg8Zjb4/QYPWNcc47GXnHUrZeF
         WsyL6k1yqU346XSx6vKlZpgoX2bMESG0RrILWKVpvF7KokYGSUHUoCyzLlRacy/gY0Ko
         FvCWCzWy98A+pqGZVTZygCYjY6rT9KGsJAKhBpLZ7PWn7/qJjeS3YpkMhbckgmtIGGL6
         1GrsneQFdTxdw17qWxbe/wqGL8Fnd6cAEa6hgzCIYj6nV4voUC6Fz8eDkcqdH/GcXCFR
         ZIqxbZlGeHHqryhoxqrOSgK91ybdggg5Tn+HOkJVZbhea3kiEZoV/SsC583MZ+1+s0Gh
         eW7g==
X-Gm-Message-State: AOJu0YxVMc3yy3Je2j7qVhaDVJlOt7yfxiEgUDA0FqUB8w+1sWicFWXx
	yaZk7YCQ10y8zqUUMnk5Eu1xZ3h46FxxUVJrELlcy6c4YBX3YF/JnRC73xrN0avf/g+wQqfDzoH
	DmFiB
X-Gm-Gg: AZuq6aJUASMzm0No9DhinPWrZHReDQELvx2jove2I98bpleWJKw2aT48JhmUiN456xg
	ZoDQsStnFo82Wh1iOzRvP3bkHONtdfwWfDay8oD59lcN0fhk3Mryf/Wo43E4xoH99pZ6M8ybXHA
	wF1Dv3IHiv4/tGLMKaeTMxOnMs9xMXkiifT488yNt1TkTpNvO3yqEnoTRDwBR3HReO6PkHsj2hB
	jXWZHfuo6HE/Wz9TvQmLQuZPsEhvnqZq7gusf3fWNwlFrfCcgnBTSIxZGRpOauQaypSinuRJBCw
	YubgWMoJoR8E+mxkPJAeKZZNqrNsPkxs2R3ADD/d/C5vgpVHLfvjkMDWQ0h6oxy545Q7PxJrUOj
	aWjXfztvs0ZpoM02yHQuPMGWdyLWWNwyuqmgSK8PZXimnJzgfjrXoq3VAXZnaLLyCEfnPMKW7VF
	kkWaN5fofCNZeTWVeuGCEGQuAVrw==
X-Received: by 2002:a05:600c:1386:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-483a9605a62mr212454155e9.14.1771918701199;
        Mon, 23 Feb 2026 23:38:21 -0800 (PST)
Received: from localhost ([2401:e180:8d81:8882:61cd:2a32:531e:d806])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af93a7bfsm11419648a91.13.2026.02.23.23.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 23:38:20 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 1/5] selftests/bpf: ns_current_pid_tgid: Rename the test function
Date: Tue, 24 Feb 2026 15:38:02 +0800
Message-ID: <20260224073810.85945-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224073810.85945-1-shung-hsi.yu@suse.com>
References: <20260224073810.85945-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217874-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62288183297
X-Rspamd-Action: no action

From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>

commit 4a06c5251ae341224e4010795a4db080857545fe upstream.

Next patch will add a new feature to test_prog to run tests in a
dedicated namespace if the test name starts with 'ns_'. Here the test
name already starts with 'ns_' and creates some namespaces which would
conflict with the new feature.

Rename the test to avoid this conflict.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Link: https://lore.kernel.org/r/20250219-b4-tc_links-v2-1-14504db136b7@bootlin.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 6cc73f35406c ("selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 761ce24bce38..78020ece6a29 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -220,7 +220,7 @@ static void test_in_netns(int (*fn)(void *), void *arg)
 }
 
 /* TODO: use a different tracepoint */
-void serial_test_ns_current_pid_tgid(void)
+void serial_test_current_pid_tgid(void)
 {
 	if (test__start_subtest("root_ns_tp"))
 		test_current_pid_tgid_tp(NULL);
-- 
2.53.0


