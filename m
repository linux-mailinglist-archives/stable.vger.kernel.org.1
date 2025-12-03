Return-Path: <stable+bounces-198194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6C7C9EDB4
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3947A34754C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CEE2F60B4;
	Wed,  3 Dec 2025 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="STLroqKn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A72F549C
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761891; cv=none; b=ApVzBhyepcpRTwy6w1xBMc7Xkqbce5Aw7OqU+uDEAmIoSYqic+1NGvwhjvN7O9VDniJ5TsRE6MfSGHUaH3lD7bXzpZ93VlAOsdJaLjFoQNmGImsnOEeD1ivesnb75uHvxj63qW+RbakMGq8qQdoEsrfl7jqQrAL+Os9AJ3aPN4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761891; c=relaxed/simple;
	bh=2i0Nr3FF86hxTZ+uwa8LSg7RhEJAMHkbIJrtE6kLfCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emuD9qa/r7LPY9WSTjmtDAiudYD8+eG5fDwxHJCEsp6TeynC8aVV85H0V0ALT2+NtVQarc3IHk2qT0xenky6J6DGRBcY6fneG3EOxrdcCsQvufmPsZXfDRaOfbf79xeqUM9eBOKPrx5voK6N9iA8LkQLt0PnsvdC2CS3q9FHlJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=STLroqKn; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29d7b8bd6b0so1850795ad.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764761889; x=1765366689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5hKdYszeQOOdLcK2HxRZCwJUCsOXMz/ue3SXkECFJE=;
        b=Cga+vvZF6N+iIU9HiZgZP13ThDYddMhXaXlG4sB6IQ2nFP/F8cXQHF+5cAYLeGMEZd
         OhM4egfSVKxYqTe12uDgx51OQWHCEmeYsYVRkLwzIE9KgwuJ+2bsMex/ZmfKXJngH9Kv
         P1IwSDLJAfYzXc9s2YBwp0Y5R21OkdDgtlQWkz/ERPuYf2VHr4O7fI6NNsH8cP+bh6om
         +IQ+bZkavUTn3eAz+nmDvUVGnaZw5sMqlxekPjqPGNmjxGnbKfs60IFQMhLyS/+cuWxl
         5opRAj5lxz0Rqv0aEGJdEo4zLBvAIkaWaGyk5qXcJ9nhlxTPOwA8xVJC3DVAQUu3SZcc
         T0Hg==
X-Gm-Message-State: AOJu0Yxp02FCs5PqdR4Oo+TtQtLYfcrc7nPmNOucyFUXdThNOVLWfijR
	Io4gVbKJtB+0pCAmNC83GQyd6/DSvV7r2fu0XJbIvipKHUVoxgMPWvBZaGTg8loWCwthoYGmK1S
	wvmFquWm08ulWpRjqYLnHHmtw0HegE/1H4RdsDF18EMCZ2YvU8XGDHGJdY1rB0s/KUtSixNDwXH
	a9Jzizsyc/veUg+1/EFp84NYm5BsGU4kR3nfqwgtu8uIta6Fs8wun5aKpSheHlYB6uTeBGWH1x+
	Hbhk1KcGEA=
X-Gm-Gg: ASbGncsA1VTUhjn/K1Hp5NTS4euqVmdt825EodOQuQhksCVtHhXZD3dGp4DEV/ZnseP
	AosnhTeqlEY3pnehTLzEkWEJJ49pjtFDvbaiOmGh+Q8IaL2ndUYRerUTMAFLjwsC0UM1tfUKw8n
	woP6KGfMmb2kj8LaZAxbsNr37pBdQuWpxZLBwYVkzPePjWy52Pnf5pVEWbJSFrm9UubqH2cEFDp
	WQ0Yxs2EhjLzRWQWmsfTGvHuCBa3BJbJ57QM3kfsc48XxLoaYSssq6+hRhCdC6B7NkLSjFUI57Y
	d08qPrIufsxrG9uSBB9W1fd7j+o7YR1ImIfoOpCP0Hyn6UrIaweZMlpbcvQ0IpvAbt6MDVa5+aY
	G1tS0VIJkZOe2qM0pF0i3P30P6KYe21viV7IwraKziERFW/a5AAAhQOT7BFsdMK/Ktt203nAbhr
	IVwrgOa1EhGX9tI044jvfro9WwoYMw34Wsu50PkMl0qn3T
X-Google-Smtp-Source: AGHT+IFUa3Nd5TarWvVtNNAXeCGOTlkuf1z+QYqfwFEqa7pjy+iaVmFL7hvuuHai6P3SzuUDt8zWrfZsXRVG
X-Received: by 2002:a17:902:dac1:b0:297:e1f5:190b with SMTP id d9443c01a7336-29d5a5d0ee9mr66026815ad.22.1764761889022;
        Wed, 03 Dec 2025 03:38:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bceb0d309sm24618855ad.52.2025.12.03.03.38.08
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:38:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-11bd7a827fdso1029588c88.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764761887; x=1765366687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5hKdYszeQOOdLcK2HxRZCwJUCsOXMz/ue3SXkECFJE=;
        b=STLroqKnv361Ygg4J8nI65gyJxGR3L0MtGYeB7d0NWYmHSyoWMjVjHoYLM+vr5aNIf
         lxB2LBf+5wVEkOXiMVGrUEvGL1Vih0/BmouS2vP8+rF0EBjcd7MRT9fAvFwznaeuGhFu
         5xNHLx4SpXmK7S31BLa2yO5LcCphCo2T7WcLI=
X-Received: by 2002:a05:7022:6299:b0:11c:883d:1ef0 with SMTP id a92af1059eb24-11de94870femr3672964c88.15.1764761887014;
        Wed, 03 Dec 2025 03:38:07 -0800 (PST)
X-Received: by 2002:a05:7022:6299:b0:11c:883d:1ef0 with SMTP id a92af1059eb24-11de94870femr3672933c88.15.1764761886322;
        Wed, 03 Dec 2025 03:38:06 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03c232sm83169465c88.6.2025.12.03.03.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:38:06 -0800 (PST)
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
Subject: [PATCH v6.12 2/4] sched/fair: Small cleanup to sched_balance_newidle()
Date: Wed,  3 Dec 2025 11:20:25 +0000
Message-Id: <20251203112027.1738141-3-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
References: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
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
[ Ajay: Modified to apply on v6.12 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 kernel/sched/fair.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7ba5dd10e..b6637954e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12895,14 +12895,16 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
+	if (!sd) {
+		rcu_read_unlock();
+		goto out;
+	}
 
 	if (!get_rd_overloaded(this_rq->rd) ||
-	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
+	    this_rq->avg_idle < sd->max_newidle_lb_cost) {
 
-		if (sd)
-			update_next_balance(sd, &next_balance);
+		update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
-
 		goto out;
 	}
 	rcu_read_unlock();
-- 
2.40.4


