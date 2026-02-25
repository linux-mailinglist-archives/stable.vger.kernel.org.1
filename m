Return-Path: <stable+bounces-219148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDCYNMpknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:56:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A7C1910FE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2BDE30CB10E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EDD29992A;
	Wed, 25 Feb 2026 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gd/6Nw5S"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F78298CC7
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988136; cv=none; b=DF+mYVCp1Q/kGYoOqwDNf+d30edo48dzSXAPXCokuoLccF9hLLWYg6bHAJ+h6xkBCtRURdFT6vd6f+PsuoKCCYgnk8spVResDoxrD/Aaq8f1lqy7Mg5D04x95l8IW9pE/DUKGy3qizW2rGA75H7Vh4TtqamBknVbTQbE2e1/Fxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988136; c=relaxed/simple;
	bh=o1h/u9FhjjWVtur33TA+KKvXLcTL5amrasnwRCvki9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBHMlEabsKEiJo1tIY9TD2ErZ7zl0aoQFYBU+QSEFCJE8LR1PC6sPTi1VbK2JOLbhdu3oeSb39aG6ov5BkKQsUDwI1QbKSugDazORCqHsrmpw/BHw4ClCZmDqJN0xev2EAq6zgv6v4shvvLEja4U95W8o3OTNLZ0DNPkPoDRybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gd/6Nw5S; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48370174e18so33564035e9.2
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988133; x=1772592933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue9w+IK86QxKn4sY6heQYTaIr0+bmZDWqfW5vRRrm+E=;
        b=gd/6Nw5SZMg2kfeg5jZP/zDCiythiJa1G2JLFbJ09p0Bj6ZUx0MK7z0LwcJChjp5n5
         LxshbBM3KRQQHCl7zcICxJ2wUd46ZCi5HmDnSrFTvwj/WWgcctp4H+C4a7X05utT2aGh
         KppDQw1+Zg5zUycnoo/NDyO3AN7DHh0lherSDBiFheZwfrwNsspfe0r1L7SWrz9CUaEs
         axJRYKZWQtoczBEsw/dcIis+89h3gMDWPXeCn5YoaRNYtkyHSCIoj6sdaxEwm5Tq72Co
         /vVXd8u4MylpS0hq7khILZ7a0wFBE78Kbb+kp9l+3/E/4/Mc/yTwGQweKB/k1et+T8uo
         N14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988133; x=1772592933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ue9w+IK86QxKn4sY6heQYTaIr0+bmZDWqfW5vRRrm+E=;
        b=qAzEggdjcUsZOyUbFxi4lzgd3G1o8qgsqljRtQ0iPzBiw1g41lcNlKXErludBf9H7C
         C8855jCM252denwTeX971VlipJelsXGf1bzZbQWUY0Oi58PN8UPsyTbMZJ8AtHQLJfHQ
         EyfHUoaxSiv85KGbmPEefi7Vggl1KRxux76EMEPyy6NV1cM7XCjOX6FFBipcdyQgnniq
         mzB1O+U73+YOtv9XC8m4N0r5DgAhq1yuKGaY0V86ISpLL5fDaxvfX0eRmHsxB5uq8Cqe
         Qqn+RXV/A+4mAhdMMfvslvzbOcvxdprt29ggA8wyqdUqqr3ilJ7DcIrL9pp395wURW0B
         aqeQ==
X-Gm-Message-State: AOJu0YxK8qtXm+j0OvJiZzxPKjodtS9BSwseO7JojTUVZPR5f/vFKBul
	WXorpDR6kxtb8GDOZQ4nioUCYSqj+ZT0pB/GmRSaHnz1E3IC/IlJQd/T5lSjbRG2gC1TeIhrh1e
	cGilW
X-Gm-Gg: ATEYQzwJ44IWp1vMxBiUqxTPb8CbEpDL/56qKEJp/qN92iBSR/0iuHfKTmvfh9cryep
	GCDjQPrATPXTcGgjOkEkRBdfhnl70qO/iUG0+6Hj0rfOmnV2qBbcil0fB6KGaYNC1jMX+kgtCpK
	udRQdtokQJE1vl3RKEhr1L4Pat6oZ6eXKAmVjeKan14RxS8Kpan5zA88SiophRqrUXtNZgJi0AK
	nh7S/b1bXuUF0qrpW817wCuabtk5+i6n+2h/ABShnP9tvrJmrc0MLS2u0AkEoV1cnOp4JDRabyT
	cTNl/lr6mF5Ud4dpOKFBh29GPuR0Oc0+gO25vkkqPL8KaNsbFhX3JPXLHyGgS8sItw8WQV4leHN
	DTSWrLN3yec6M6fYFzB00P+5kGqiB53vBTWLkHomRnaOBfTdivld8XTNUnj/NSdHsaUju0j/RNn
	nMgPch5m+3lqDI21Xdwm/h9lo1Dw==
X-Received: by 2002:a05:600c:1910:b0:483:badb:618f with SMTP id 5b1f17b1804b1-483bef5aaaemr12535645e9.25.1771988132955;
        Tue, 24 Feb 2026 18:55:32 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd692b99sm12233308b3a.24.2026.02.24.18.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:32 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 08/11] selftests/bpf: ns_current_pid_tgid: Rename the test function
Date: Wed, 25 Feb 2026 10:54:46 +0800
Message-ID: <20260225025454.17398-9-shung-hsi.yu@suse.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-219148-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35A7C1910FE
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
index a84c41862ff8..05e8678632ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -96,7 +96,7 @@ static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg)
 }
 
 /* TODO: use a different tracepoint */
-void serial_test_ns_current_pid_tgid(void)
+void serial_test_current_pid_tgid(void)
 {
 	if (test__start_subtest("root_ns_tp"))
 		test_current_pid_tgid_tp(NULL);
-- 
2.53.0


