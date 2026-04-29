Return-Path: <stable+bounces-241949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC9XGL528mkHrgEAu9opvQ
	(envelope-from <stable+bounces-241949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:23:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F5249A8D9
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75FA03032DDC
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0053B47FF;
	Wed, 29 Apr 2026 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIFWi2ab"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AEA3B38A0
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497752; cv=none; b=rCCENj8xLnq1dUJ5/JBpKi6jo3XOfibSyId/37BQSrF0PNdy85JBRwERmcGhj8i4fFCy+i7O1gSuJSNeN174Np8qL3y1ATBLnEfZNZOGPdpa+BHxtUzrH6hYVDA23BThsFRHj/eJ+dBllKo+vXnGQXmdWU0dc3FCS3LehjxVRMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497752; c=relaxed/simple;
	bh=MVF/NUnwt4T8A9Ip9OQGyCJsA+8dvd+yvSjTW5P6IKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awhFs8RC7G60TnkUKEgFrSfxtWnn+zI/mtAkXzEEd0cQxOup7bwlkkVNNBUzOwfl9hDP9izCDdrl/ew29ONdYumu1FI9QU+cZGT7QNJqDGUc7PYYtwJRAaNKsXcxak810F7sdC+R+2+XgC6ZzBiTg5C/V5nfxyen4Txv0JKbBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIFWi2ab; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488d2079582so2005975e9.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497749; x=1778102549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykJFzTkCkC0C2lj+ZZ4uY5vhivTKu7ETItTHYfKS1Gw=;
        b=UIFWi2ab7YFhQ2LV+a156gUoBxfpDHXG7ZOYnc09jLifryHqjSZOaxgLbBioeDQl2e
         OR4YaoEE14sx6InmcPwiK1/MPuX6rBEgyj7kYqbYWh779kRx56eXfLgydHG+G/WgEqlp
         V4MK6Klj9UZyDfcPicwZmLM0lrQqaCs6X+dtQriNh/7c/MUvWsQuUu/fioopNiQ2WkqL
         789zFK6kgPPzJkKFKMz8UfKO1Xe4VIpvEe20LzP4af08MjqciXZKF4jo8xM6ICm+HsY8
         JhXCGGiAkzMlNhLlk+ThUwOKieO+eXMyq/c17oo6cjeXBMuktJQhDB0lZuD9y2dvuRRb
         2HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497749; x=1778102549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ykJFzTkCkC0C2lj+ZZ4uY5vhivTKu7ETItTHYfKS1Gw=;
        b=al0TdaZtTaOE9Mvhdi3v21gUMa8SayzeZqDwicva/qatnYQK3TwJNF9e6q6fGCyXcu
         UYgRhodTld4vrVXpHM7d+JjeB9e1R4Hmm5pWgThxvRD+9TDqcQvfoTvSsBVMOJ0nTRet
         DpmL3CaH8Hxk9ciFy3hlFtwmKhCNgRhsfmzbOYi8rYp5wbZLf7dwjHOZw8UF39MQy2Zv
         FGqxj9hXTpaVIUOn9+XTYIvcBUPTsjo09BUqIaTRVS+kBSmoZk630awZxv5jeaI6e6ZI
         bOhzQgBTxMyUV+5WM4/50v131HML1O46UFBgXOExzkGLG0T+CaTaOc4urooOmVbmnJuR
         2qgA==
X-Forwarded-Encrypted: i=1; AFNElJ8iN3UPBXYoQTLrgGSoktxD+PmBVnWPVnKcbjKem3GZNMnukqL2+w7fEzFTNnOk56FD5JL3kVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6pHdp67QT2Vcq9VR+RBQqe2xTXkQt2kCHZBuZS5P/hC79g0bj
	FrfXxCDA2/eQIP4VS8fOPSgrkiIzto9cUJpIJKfGl+RYlcfCJwSAe7ol
X-Gm-Gg: AeBDiet2heuVZGUT/uVn1ZyAj8Ij8f6gaov75t9A6Et8H2lEdzYLsIPDH/JHxq0PEGW
	Az3sabnbCfVBkBlpow9L9Qe2sRgA32SKWi/A1ARnI28myfPu8nIPsopcYsa++9Ed/wl70d+Uqye
	zZ7doHzTA67iAMSdhOBTyOnz7z2SDFY1QA+W+B3auLopdYG8jJ2aaWkcyfr2uwXWiOnSi3yTK60
	ymbnXV7K/vr2f+/vaUSvZ9/MlvlpRHhqQKDas2gHDSvz/uo2oYorix3tQdRXsZAWa2L8YQVen8J
	v5CEdX9XTebbP7dP4bOUDA+mGXsGInwECHoL38IQ+n41ztMe7/15Wk4/Z1nOt9hBhxNHIt8Py/f
	2dk4GWr9SGgZkpc6rWzrEf9zUaeLNkxqphy2D6trI9bmgHAZeaqlphZN+H70d1I3D+5orGf5TdH
	htp1FvHWFg/uRomTLi88UCbtOmovy2RRGPUgBSvq4=
X-Received: by 2002:a05:600c:8b22:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-48a844582c3mr4663845e9.23.1777497749079;
        Wed, 29 Apr 2026 14:22:29 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:8fc7:44bf:8aca:ebae])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a7c3057f8sm26200425e9.14.2026.04.29.14.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:22:27 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v11 2/4] selftests/liveupdate: add test cases for LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
Date: Wed, 29 Apr 2026 22:21:15 +0100
Message-ID: <20260429212221.814107-3-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429212221.814107-1-luca.boccassi@gmail.com>
References: <20260429212221.814107-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D3F5249A8D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241949-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,soleen.com,vger.kernel.org,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lucaboccassi@gmail.com,stable@vger.kernel.org]

From: Luca Boccassi <luca.boccassi@gmail.com>

Verify that LIVEUPDATE_IOCTL_CREATE_SESSION ioctl which provide a name
that is an empty string or too long are not allowed.

Cc: stable@vger.kernel.org

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 .../testing/selftests/liveupdate/liveupdate.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 37c808fbe1e9..90268d86684f 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -386,4 +386,46 @@ TEST_F(liveupdate_device, prevent_double_preservation)
 	ASSERT_EQ(close(session_fd2), 0);
 }
 
+/*
+ * Test Case: Create Session with No Null Termination
+ *
+ * Verifies that filling the entire 64-byte name field with non-null characters
+ * (no '\0' terminator) is rejected by the kernel with EINVAL.
+ */
+TEST_F(liveupdate_device, create_session_no_null_termination)
+{
+	struct liveupdate_ioctl_create_session args = {};
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	/* Fill entire name field with 'X', no null terminator */
+	args.size = sizeof(args);
+	memset(args.name, 'X', sizeof(args.name));
+
+	EXPECT_LT(ioctl(self->fd1, LIVEUPDATE_IOCTL_CREATE_SESSION, &args), 0);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+/*
+ * Test Case: Create Session with Empty Name
+ *
+ * Verifies that creating a session with an empty string name fails
+ * with EINVAL.
+ */
+TEST_F(liveupdate_device, create_session_empty_name)
+{
+	int session_fd;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, "");
+	EXPECT_EQ(session_fd, -EINVAL);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3


