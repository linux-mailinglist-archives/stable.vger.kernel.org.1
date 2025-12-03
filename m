Return-Path: <stable+bounces-198204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 87035C9EE0B
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA4F33458CE
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A72F5496;
	Wed,  3 Dec 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RDrzF7S+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3272F5A36
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762213; cv=none; b=cLUXzuVg+Q4FEKJBoyPv4DktJ+dYl6Mt4dU5rZG2tI69CLZiBSDt+WuwjvVK/56MVDW+B47Ia5Bv+TKjBe0ObQFlr9M4ZdH0Oo+Okl9Dp8P4Jdne6cW8Rsu7Jtdid9KU2nvG3k1heBb6agBSw7GLPuML5SS2J2C6HKvaniocfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762213; c=relaxed/simple;
	bh=6CPDYjvsBfV3Kcd80YC7yRDSERboeJo3FZe5VW1pFCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKvTRmQtOE4Am9M6rc7GOpDDqwGfy00/cTOpDqigkrGL2PmYjh+oIwz/I65DcxlWYXtwF7lPO5IgIIY7OWHkYHvi8Bo8rfxRrWfhxPcZ3QrQA0BjdEpagcu/WLO248T3uz27xFMBDN4IUs3bdlgqE2q00AEeEgEkiTbVXesSdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RDrzF7S+; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-298144fb9bcso65847725ad.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762211; x=1765367011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zG5ObQTvL5bWOa2rL3As4NqAHq0IGlQkowqc9ibYGAQ=;
        b=IrXQ6ohTQu/nQpc3dGH9X0NPnu2q64qcpnYsby0Iu0kOzh8J2DbktCsAd52DED3NRq
         SvhFWXBocuwVPdX5bb2JmReCCVxdOl1LhB7jx2eIDsWbch//4i2Qroqqpt4n23akuKDS
         qHcwq50Qd+aP7qIlUPgIvnKHZGWnsEM95mYIlcHeU9EH52Pu/hC3MY3LyvGa9Ulkwu51
         DwyA4md9yUXcY891msHOOpmUZ31zB6UQ0sOA41J0thoDGfrZU4VZLusece71ot44GJnw
         fBxtR4+i5Y6SCHn/PyegnWxxz6Ew7oyfaeu8ZHR35ttrEj/E9XzWsf508IXxCM+094hh
         Ol0A==
X-Gm-Message-State: AOJu0Yx4p18ffoC3ukyPM0eEHe8GwmwEFv5Vpn2tkk2FHkmq7e4MkfSA
	TM3zzISFfDEacaxvFRY8kaTJW8yrTbrY4W/0AaiLo8UQWDfC1+0AX+Es4LLgEZjRbl5i7xIeDeL
	NC8I2Ei7g2t7IznukR6WerWUWOUq0puop2j8N7mSdi70Y9Jk1YrbdJOcG8TPpBrpcKf5BSsg/Z5
	HzcROEpbzJ9VWCJIuhUjXJ4bZimIPN6o4mVVTqrLgYTbxOHP/WxCbEWtUSWm3lh9h3E3JUOfVVx
	/FiY0ojSjE=
X-Gm-Gg: ASbGncvIEvonsK8Fgl82TtgPCS2tQHTonYBdsTtmQeH85KQmTXv3tYf8TTzQoG+9Sxt
	oju9b5KzTQIy9KgLAXsb8aYS7pkRVqOB3LTgi5skEffUIaDX46Lhjo4gkch0brPuwWlR9nGQ77f
	qokjtt9hcyiMJD0c4YGupKspzf0n0CzSs2OHWqR6KxkjvKvDbl8UfbwtgqFEFzI4zQiHW9+cU89
	qFx/UyM9ldhZwwRo2bswL8ursB3Ia0efMUl7LHg5sPAhDTLz1f5lqMT293Og6yniFZpbi7Ixo8g
	QfmowsWTo5IG9vAmjB63dzh/cAcQoCEJOfcAwS/bqTaB5S5SwmyhqXpS80u9Dhl7+8d03Fn0LAC
	cx9lOSJv8KtF3/TAto0THrybomFSZapkR7Z+QwD0BUbG5rZNxbBWwa8rVRMbvbP5DVbSE7ZimFo
	G5umz/+fS2yqfpYaTD1bBn6jD+f660LVDMmyV5J1j338kw
X-Google-Smtp-Source: AGHT+IEO6M4EBZgvW6zFMNoRoHa5DzsuaAt4Bg1VIf8ijVt1C4hz88kYYQ/zdj6SRqeca/FuQFWZfinMXgS5
X-Received: by 2002:a17:903:987:b0:246:7a43:3f66 with SMTP id d9443c01a7336-29d682d7bcemr22698335ad.7.1764762210898;
        Wed, 03 Dec 2025 03:43:30 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bceaac314sm25223555ad.29.2025.12.03.03.43.30
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:43:30 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e4b78e35so1277921185a.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762209; x=1765367009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG5ObQTvL5bWOa2rL3As4NqAHq0IGlQkowqc9ibYGAQ=;
        b=RDrzF7S+U/fsXbSOW2mHGkPI4c/dhEacqtxeabgXKZh0NRO/miYdEevVZlQDIBjGPz
         6Kgy73myU/tp9pFxCxaEdC0UVLC5UFffsZcPEOdqnct3PcIKMyjPEyOKirdd+LN4UcWn
         SetzctYQvombdU8HifKyEQd2Y7jayoVWzHZjY=
X-Received: by 2002:a05:620a:40d4:b0:8b2:d26f:14a8 with SMTP id af79cd13be357-8b5e47a74f9mr206606985a.9.1764762209459;
        Wed, 03 Dec 2025 03:43:29 -0800 (PST)
X-Received: by 2002:a05:620a:40d4:b0:8b2:d26f:14a8 with SMTP id af79cd13be357-8b5e47a74f9mr206596985a.9.1764762207862;
        Wed, 03 Dec 2025 03:43:27 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b65bbsm1284727985a.33.2025.12.03.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:43:27 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Chris Mason <clm@meta.com>
Subject: [PATCH v6.1 2/4] sched/fair: Small cleanup to sched_balance_newidle()
Date: Wed,  3 Dec 2025 11:25:50 +0000
Message-Id: <20251203112552.1738424-3-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251203112552.1738424-1-ajay.kaher@broadcom.com>
References: <20251203112552.1738424-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Peter Zijlstra <peterz@infradead.org>

commit e78e70dbf603c1425f15f32b455ca148c932f6c1 upstream.

Pull out the !sd check to simplify code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20251107161739.525916173@infradead.org
[ Ajay: Modified to apply on v6.1 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 kernel/sched/fair.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f5a041bc3..9a7aa83ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11589,14 +11589,15 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
+	if (!sd) {
+		rcu_read_unlock();
+		goto out;
+	}
 
 	if (!READ_ONCE(this_rq->rd->overload) ||
-	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
-
-		if (sd)
-			update_next_balance(sd, &next_balance);
+	    this_rq->avg_idle < sd->max_newidle_lb_cost) {
+		update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
-
 		goto out;
 	}
 	rcu_read_unlock();
-- 
2.40.4


