Return-Path: <stable+bounces-124080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD2DA5CE46
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F583A428B
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB3E263C7D;
	Tue, 11 Mar 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vDcvqTT5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC7926158C
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719314; cv=none; b=l8reXO1BIqssi4xMcAtMB/EQ75oxoC4GZlwDGXWgbW/7ANy20jqpnzHgv1BiZ0ckHPA28t2NzR9JsXJef3GD65kT4Z3j21XReO90FHu38R1cSWPz6yTg3d3whvGBhDy7kTMsbDKgRW4kCTAPn3enx346Dxl47M8pm3yUENBGbF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719314; c=relaxed/simple;
	bh=EncPkJBVWcN8WXbXElahvtiHZG+MP8dPouPE1QkeMD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RaKGqkJWKNAxy5iaWeKgLkhAHL3U/NAG4WEk9AeHPNLO5QFCtAppf7U8FhLh4dH8otsJMhG6Kzh1I2DHgIfEoO0AUAY1d1XqjZirXf+ePKUWl430fjJq1GvvlD1/+OtIKXt1vtaaoSbfZjGly2iY9Nf4e1Y+fbsrUQrnddTA+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vDcvqTT5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A59713F47C
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741719301;
	bh=hCQZEqVh+EmPaRJLEy+SxfX+ZToSFBe3fruw1XOExNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=vDcvqTT5F0VrJA6CLKzHZAiAePzHCZK8zqFlccglgzFJZgT2nAippy24FcfKS3+jo
	 /30xNV56v7pTMHqEziRCFpc0ALGZIlpGQdGONGPFxBXDF4+zYogBu51sfUwnLMKdnq
	 Zum1KI8PJ+joYYBwL3uW05cKIYVbrvm7dW2YNLP3ysd5DLdT0dEYv7PNAu0dWsrgyj
	 htIfNDlocbMXYkE8a7HEoZOMf6Qj9aI2N1MurIbLeXIZmljtmvPHdpLeAHj1JwR7jf
	 1XOCYC0ikQzpFys261EiakRxd3P/fcT8SPjnDdd6x8ke5qzBviG7FNqUiMjYJ6XHKt
	 jYrpUQXJS2iwA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240a96112fso178050905ad.2
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 11:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719300; x=1742324100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCQZEqVh+EmPaRJLEy+SxfX+ZToSFBe3fruw1XOExNw=;
        b=o+pqBsn0CScqYnOttF7r3Kk4u8xEIM2GoedTHReiNtvyaUX0aNQEAEMYzDuwu8RnhB
         NW7xTX97O1tKB9Aob6QrRqbmWHY3IH9E+leeH+wVnTkY32cW+9Nw5lCP7xRWDMyzOtIH
         E/2MV0d/dO3kp0gzxtpWjQKkJ2TusIv77OZ+U//xFUalXmhyUGheIx6VZXi6YahjspF1
         JDTCoKcT4ilI29+NksHSLi1qUEPGbLII/6QESRklgW/21z5uLeSFpy0ieQkWLnnpMcwe
         PdzuHs8IdPFv3Ul7bmhn+OpO/gMyRVQvdIrhALPul8snwiH9CgkTr+QmB8snHr1Wiy2x
         zwJg==
X-Forwarded-Encrypted: i=1; AJvYcCX4GoPC1w8dqSv2LH4CJyWn8vINhLKejqFXKusIsIB6tSidJrGgfi6PpzBv6IL/D/1WlwuBeHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCW17KO8erwuZWkc+wdCjrGkw6c+sZEHvyWFwEd3HFidX0rT8R
	/BwaaYwvJcspBFn5yQMolSeomGkZHApMnoS1ZeWOJR7RtRLdB/8acia66cMIL34SQ+IpgGvOIyX
	ga4S1mrmdavoK+5NQezdmw/RimIluYw5CPcIx/qpXbaMeV2vmtGmysmZumr2SJ4YOcyLoGQ==
X-Gm-Gg: ASbGncsVEYyHViQsctWlgElfJMX07MJ2eVKNvbfZDpM2wAu4MyEovp1wAZwjNYYGPi/
	5w6bgmDReD1IHlyOUh2d/QHLbGONPCFJBMxcTt0G3/GobmDEKV7LmPDBVKxmZVPLT8V1TAxkMxi
	5nVkCFlX/zGZEWgju3bpU1YVFxhgFqnBc/r2oBobJOi4ZZ2gJCasO0BUYUTpoKuEpOnKk4ktaHH
	0XVzRBJwE+lIDZmMMYaEgPuSUmbg9oR/mb1H8chsg9oECrxCEadquYQ2NtsMgp477WdFutFL6bk
	spKQKSCMvfUQHxSnchCgOLCqK/tg/b1S6UykXbg=
X-Received: by 2002:a17:902:d4c9:b0:21f:6c81:f63 with SMTP id d9443c01a7336-2242888a98dmr279835355ad.16.1741719300304;
        Tue, 11 Mar 2025 11:55:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2eq+MoFZ4FmTVgJHhWpqd1NsmZMDoQSLOqjxigrVZ919LPr2JQm+W63mXQfdH0H1EVS2lWg==
X-Received: by 2002:a17:902:d4c9:b0:21f:6c81:f63 with SMTP id d9443c01a7336-2242888a98dmr279835195ad.16.1741719299965;
        Tue, 11 Mar 2025 11:54:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:14a:818e:75a2:81f6:e60e:e8f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f77esm101765875ad.139.2025.03.11.11.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:54:59 -0700 (PDT)
From: Magali Lemes <magali.lemes@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.4 1/4] Revert "sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy"
Date: Tue, 11 Mar 2025 15:54:24 -0300
Message-Id: <20250311185427.1070104-2-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311185427.1070104-1-magali.lemes@canonical.com>
References: <20250311185427.1070104-1-magali.lemes@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 1031462a944ba0fa83c25ab1111465f8345b5589 as it
was backported incorrectly.
A subsequent commit will re-backport the original patch.

Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
 net/sctp/sysctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 7777c0096a38..3fc2fa57424b 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -441,8 +441,7 @@ static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
 			     void __user *buffer, size_t *lenp,
 			     loff_t *ppos)
 {
-	struct net *net = container_of(ctl->data, struct net,
-				       sctp.sctp_hmac_alg);
+	struct net *net = current->nsproxy->net_ns;
 	struct ctl_table tbl;
 	int new_value, ret;
 
-- 
2.48.1


