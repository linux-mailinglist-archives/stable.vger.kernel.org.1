Return-Path: <stable+bounces-198195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7CCC9EDB7
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348F83A61AB
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C92F617D;
	Wed,  3 Dec 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cNXKv9Ua"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B822F5A1C
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761892; cv=none; b=m0KhabvuZ1xLAojdqXglRuIq08885DvXTD3zIKaCCFyfZn+7/WfJNfurngsjKutuJBDINc8lWjUx7kKpei/t76786lNZzdu1cjhzG7RbCBrzt/20of4934HxfxZOJzwC73JSJOXQ9kIIQgI0cRIPvIOQxFFi+X5oJoqsPcaPBwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761892; c=relaxed/simple;
	bh=/IlEpooVPRR4biFYwUdCr22YNedtY02/izr3qt8kbDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReNCxBlUhEjt6LpzyGOaWn111U8MuIbAJwXX5SosOoPSQpv59v0j3wXcI/ahJMmf9nNaAn2zU/esLfKDCZ56NH+37EzIr90IptNutC6lvRFXVQjvO8FKks4Dq9pc6gMPY4PlqW0D/ycidRRWOGRYbEHrpBd8QAhpJkpYAfqudxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cNXKv9Ua; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-8b2148ca40eso788605085a.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764761889; x=1765366689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLfHsULW/WFUBHVOGU/nqYd2laF33Pp/+LBFX8T/D0c=;
        b=XqkEfIBORFwyRzuYZ/42wwlGlKn+JCD1Wj1kJkBqwg05NBVD60SjZdfzl6PFoicaCL
         IL7uYjE0O42vTPCdNOWi29Sd8jT8cLepiU4l3Nvke2CwFFBX6ZJf5ZIzAm6z6FSBYTx0
         NRkSoSI5vjJLPqBui21Hh2fy+kOsi1oq3MV6X2t2opqrAR2+Fcz94nvrxVYLuaFZJoOP
         qW1khmJaw+naWqeCgJHIvSHEl7v1KvUVJ1SSP1kZt6exZpmOsWwab1IjVok8jB0x1eTA
         6wbsNuLUrGSviuwed/WSOZezMFeh6ah2dxRs8ra3nZtT67fCDgRQvNyD1/mnUwMq0l3q
         fMxw==
X-Gm-Message-State: AOJu0YzRTrd36qLr9e+gGiw+ie7SBa8kP4yjcDkq1+C3zVGGJ8QWohEV
	EbCax01MH5GFxMLKi4W7bPoiL4IH43ENNHr+l14W651pMYs1eoKWWhvg7DfhyvqZWn7YnjGt0yN
	K9m6W2/g2MVIG+ofzdS6yD4i1stGJytFfif2bN5YMdFR58Pp6cmBYtk9ThENb8V1VfMKwo5qG2z
	GCE0X5p0XFuznndXepxBGlMr43+Bltf5MkD/rClUEcMlt+WWZ+k+etUntyDeDqC+9ou1ShgdPBD
	1euSsGVTBY=
X-Gm-Gg: ASbGncvEhlY3QOIUtMTwN0c7lT/k7ji243R1M5mumBEG2D+yuBlBpc5v2IRnYKwAIbT
	DrcqHWSw/PuKgeaSUwBS7on512IaG2cEdpHpeFpZo36TYCU8A937NMxwkBUGMs+OMEpMU22kNJj
	p6NJAd9cizpl6JplhSsxyECfdN58C+MGCxCoq0c5Vbvs4ChKYS4aP8flNDlf5p2TPkXawJBymkf
	/xwEbBA644KzOil5WOCDY+wDGJwysJs4nRQl44RdkiGh3QW2XK6P2e0P02IRxf+v5Er5AXJv4CS
	BvcgkA4fhLk4+hjGkQOa64qgRujEHBN08ZS6BK8J+sBwQVhTFAKTYcpLJpms/ypUhE7OBnDpJid
	lv0VXh3QniQ4B/I8isOwdpB8r4qJXwY/p144fxd4K28IsjyTKG1zlAKDESJf60OJh9Ddv9nMnH/
	I/dnGcqcDSM4PQer47Z6b35kQKYXKjh/LhpEluYZjJGQ==
X-Google-Smtp-Source: AGHT+IFXHNl/9S542TY790kfYGnSj/3DfzfXP4gQtBFq9VxiqKFan0Ibjc5/HTPKcxw5Oaj05ajbp53fS5Ml
X-Received: by 2002:a05:620a:1786:b0:8b2:d30c:a30d with SMTP id af79cd13be357-8b5e47a1638mr230463685a.13.1764761889489;
        Wed, 03 Dec 2025 03:38:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8b527e53358sm195357785a.0.2025.12.03.03.38.09
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:38:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ba4c6ac8406so5327675a12.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764761888; x=1765366688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLfHsULW/WFUBHVOGU/nqYd2laF33Pp/+LBFX8T/D0c=;
        b=cNXKv9UayeM9Kp//+A/iNLVmRBnMSHyGtCtjAOUbae+h7b3Xot2jaeVYD8FCHxD+39
         R3ytN5PSprHQ8FwV9lFjNhnVndkydax9UnMPaUT5fTeAiieKyxYHG3gRCqIeCCrwj3Uq
         eGYXbGZFZuzAf6gSpJH1FNbYdqPUzT66XarIw=
X-Received: by 2002:a05:7022:412:b0:119:e56b:91d1 with SMTP id a92af1059eb24-11df0bb9dd7mr1558625c88.2.1764761888153;
        Wed, 03 Dec 2025 03:38:08 -0800 (PST)
X-Received: by 2002:a05:7022:412:b0:119:e56b:91d1 with SMTP id a92af1059eb24-11df0bb9dd7mr1558586c88.2.1764761887489;
        Wed, 03 Dec 2025 03:38:07 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03c232sm83169465c88.6.2025.12.03.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:38:07 -0800 (PST)
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
Subject: [PATCH v6.12 3/4] sched/fair: Small cleanup to update_newidle_cost()
Date: Wed,  3 Dec 2025 11:20:26 +0000
Message-Id: <20251203112027.1738141-4-ajay.kaher@broadcom.com>
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

commit 08d473dd8718e4a4d698b1113a14a40ad64a909b upstream.

Simplify code by adding a few variables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20251107161739.655208666@infradead.org
[ Ajay: Modified to apply on v6.12 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b6637954e..ae5da8f34 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12219,22 +12219,25 @@ void update_max_interval(void)
 
 static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 {
+	unsigned long next_decay = sd->last_decay_max_lb_cost + HZ;
+	unsigned long now = jiffies;
+
 	if (cost > sd->max_newidle_lb_cost) {
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
 		 */
 		sd->max_newidle_lb_cost = cost;
-		sd->last_decay_max_lb_cost = jiffies;
-	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
+		sd->last_decay_max_lb_cost = now;
+
+	} else if (time_after(now, next_decay)) {
 		/*
 		 * Decay the newidle max times by ~1% per second to ensure that
 		 * it is not outdated and the current max cost is actually
 		 * shorter.
 		 */
 		sd->max_newidle_lb_cost = (sd->max_newidle_lb_cost * 253) / 256;
-		sd->last_decay_max_lb_cost = jiffies;
-
+		sd->last_decay_max_lb_cost = now;
 		return true;
 	}
 
-- 
2.40.4


