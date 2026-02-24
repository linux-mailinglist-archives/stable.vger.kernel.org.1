Return-Path: <stable+bounces-217875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF0eBXdVnWk2OgQAu9opvQ
	(envelope-from <stable+bounces-217875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:38:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C681831FF
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99469303C581
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FFB284894;
	Tue, 24 Feb 2026 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bhWRZ5z9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D72877E5
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918708; cv=none; b=mYyrfMxwy40UsK6BtXJuEA8ES+3ZvhPhQ1DUZ8UpC5qxdhj7TZRJnIgv725zlqRkKfzCduWzD/VjZSm4kbwjsGcMq+8pXEwZbRGv4Lv1G96Z/HjikcVporFFNn6IdfafkE6u3998cgoCLE8kUFPhR/S08o8YFC8BKcwPanuHUR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918708; c=relaxed/simple;
	bh=b5OPq8aMHcHrGzjbNFkXCOx/AfMNvY2Wg24bAf2hkAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoPZJuQkbuzpsEgBRUNhdkBAMPAuJiyaA+bvOQpi7Urcs2ulnewoVX+HAJSrgbgpkRx7W5fB26qy6DHgoapIUv7QMFu/c2AOW5NHaE9/ukGaxV2E34znwS/i83AaJXfKBGyzw2CGyPunOy8INzTLGUyrO0JHeZxhZaqLr0i60mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bhWRZ5z9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-436e8758b91so3499473f8f.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771918705; x=1772523505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERD3/3UTXqQZsEErM9IgTPjx25lteWreXaNIpFJ808A=;
        b=bhWRZ5z9DPH83drd3G2bRQh3nKOfACe0X55iEXBse2TDlILqmEs4nR9WF99yKuuFJE
         47aeb8STxKi81L7SFX3NE3WaKVMjS+yOGPPfEt8y64ncJHvbmEdvklZbNt3kCMvWOKrU
         eL0dUlcIgR6iPpJNnT7g9FetDQ1MEicmOcMgMhjhjfcOm2nbnyzIvGnZNcNLwX2OiiFm
         z/9Z9jb5/Px22RienSEQbc3VEZwVPIAO0Gg1Z6XQwrf2Jq+TT5I4c6DrJDsQURFe5Ckh
         Bg+ucFox5OHUjN3MRYvzUBYPylhf3OpIvH3XLqlqoXG7/R/CAuv0WOYOExps96KfF9NS
         YzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918705; x=1772523505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ERD3/3UTXqQZsEErM9IgTPjx25lteWreXaNIpFJ808A=;
        b=RlmRDB2nKA410xfWReryZBvhFkYETdFHuE2MKWAmnaX0oquB55tGZKVyZZ52WMemY3
         3TUEl5ZNvPNjAjARS13BENSHefn5OfSzbdJhHiGOnpOmYl72EmRMMEAtEmhaM0J3+RVz
         rJZ9vu5Kt15Hnfq8J5YKAkB/zJCZTkuRsmdjQtGIA2zgXW9c8RTzv0WkKe2uWFUtXAdZ
         FlBwOsjsy7F+1zAYPV/5Qi/GYyAV2xl1wVXtcyXkp7V4QRuMuYdWYW7BJlpU33BlWdgR
         3Fxb5pZW7qfjV8gsaUMJLpAW0uLZVaJyqCV4VmsSykqHumygyXZp7Wm4EP51E29GcBFY
         XrIA==
X-Gm-Message-State: AOJu0YxOCtc2nbBIcZqgcbs04gECRaW1Zkf8g+/aCEz7e/ku7H+WcF35
	A+rT7xj9AHXK900jVhC5rW8n1lZP1jEKLJiooIq9HyzfdiopMPuVF3PFjhDQZ50WbNjSa9SZY9Z
	GLNim
X-Gm-Gg: AZuq6aLXuxIP5J66UOzYYA9r15osaETTFMYor00W7c/BJZEbX9lRjryFoLcdyDIzM+I
	fbyIfIs3YUl8VmNnWgInBR8FAiLU+uTt4NmGZ44rv+Av3IwtdBPTtPBvlUoU8G1NjqMVymgpVq1
	y4E+0Ui3v/EEn7JK/Rq5mXBrHBCRX4WTIKK3p46pngkCrj0aKmTz/sWzhfjvMYPfSY5UQtoTty1
	4DEB1AXL1+QFClQAwfLWmJJ5O3G+AQHkaY+e9QvM69ZI95UngxALUEoeMn1OqsagJRrj34WeqMg
	LdJXdd4kEhsWyE1KRRSdTTqa2dhpGQ8rZG3NRkTOCHKiHSUL6Oet7M5PrgJaPjOODAV7sKorNh/
	gK2E39h1jXpRx0ATzQemL2T/ac+IzeeA1p0CDqGAdPbnVORvgZoxJ/XECzpZs77yH3AbtMCalFb
	PFxJAQWxu1VwcSECHZnQGJ52SDUw==
X-Received: by 2002:a05:600c:8708:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-483a963bcb0mr191221165e9.31.1771918705026;
        Mon, 23 Feb 2026 23:38:25 -0800 (PST)
Received: from localhost ([2401:e180:8d81:8882:61cd:2a32:531e:d806])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750591e2sm94641105ad.91.2026.02.23.23.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 23:38:24 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 2/5] selftests/bpf: Optionally open a dedicated namespace to run test in it
Date: Tue, 24 Feb 2026 15:38:03 +0800
Message-ID: <20260224073810.85945-3-shung-hsi.yu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217875-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8C681831FF
X-Rspamd-Action: no action

From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>

commit c047e0e0e43560bf73ae47f7cfd5772f690b6d48 upstream.

Some tests are serialized to prevent interference with others.

Open a dedicated network namespace when a test name starts with 'ns_' to
allow more test parallelization. Use the test name as namespace name to
avoid conflict between namespaces.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Link: https://lore.kernel.org/r/20250219-b4-tc_links-v2-2-14504db136b7@bootlin.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 6cc73f35406c ("selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/test_progs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index fa829a7854f2..1ac1e67798ed 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1252,20 +1252,32 @@ static int recv_message(int sock, struct msg *msg)
 	return ret;
 }
 
+static bool ns_is_needed(const char *test_name)
+{
+	if (strlen(test_name) < 3)
+		return false;
+
+	return !strncmp(test_name, "ns_", 3);
+}
+
 static void run_one_test(int test_num)
 {
 	struct prog_test_def *test = &prog_test_defs[test_num];
 	struct test_state *state = &test_states[test_num];
+	struct netns_obj *ns = NULL;
 
 	env.test = test;
 	env.test_state = state;
 
 	stdio_hijack(&state->log_buf, &state->log_cnt);
 
+	if (ns_is_needed(test->test_name))
+		ns = netns_new(test->test_name, true);
 	if (test->run_test)
 		test->run_test();
 	else if (test->run_serial_test)
 		test->run_serial_test();
+	netns_free(ns);
 
 	/* ensure last sub-test is finalized properly */
 	if (env.subtest_state)
-- 
2.53.0


