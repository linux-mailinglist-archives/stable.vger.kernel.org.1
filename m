Return-Path: <stable+bounces-235860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNarHpoK3GlaLgkAu9opvQ
	(envelope-from <stable+bounces-235860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:11:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 293413E60BC
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C3CB301106C
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8D4382F03;
	Sun, 12 Apr 2026 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5QnWk08"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B81381B0B
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028289; cv=none; b=km5P+jlCWoyKjMJhiXQsybxS3hNmNapAiA+4X+Ey4Y9qtFbHoaiWWAtb2XB/cx4abNy6H4sO22QPnIoYNBD6wEgKQnKMnW8yyE6NjjBBKT3cfNaRvKj3ycVKVi41X2T/3oSdwpzKxw2+5ij0uTo1ZF51FqDks3H94ZiABkBMVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028289; c=relaxed/simple;
	bh=NlwwelYA8uSHgqW88Xvl+l0Vc3NtEotDqvYvC1ZDl1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3feq5w7QSEW+3B6hliFxKAJcMBxyJuDqrLDSw6FoXRYkHeU7Q9Vp3sg7acpdtSvCjxQ3w4vyOe7CPK2FEGbdFh8pLTQo2f0/Xi/UQKSd1kXI0Iux1ia5LmODraii869D1L2zzwqy4vy44pBZuG9qAbCehWjsnOhBsz1QGoMdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5QnWk08; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1271195d2a7so4543926c88.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028287; x=1776633087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LD0U2JI3+b32qBu6y4JGUu0pIw+boTDqwL9bnMsDgY=;
        b=q5QnWk08pxUh8RrwESnSPYaFeJLQO4wnd5PENxDPbRSSyaccQXe/NO+M79pp4ZnwSf
         VnKueaY52ChdMz6klUNk5ZdZSDlAzejMUqbUMPWOweNx7s0Oj4XMwon6ZuXOEzChT4w9
         Pa3ubqmrxkCXxTVkfNaZbN8+BGj+DRkKv73BwiPXETGqL3MP33NdSWs7xM0TjBLVLXSk
         +/RM/epXOa/Tr+c5iDXnxeCoLdqr8IHgfiMMiuc+hIcleUY/nuRdmJKf9cO0SSvF4XBN
         LH2/yBHeUSa7v7pIE/JuRdN0cJf/WhoH3T83uzadwMa7CzUROAwYyapSyu/pVHcM0Vsy
         SPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028287; x=1776633087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LD0U2JI3+b32qBu6y4JGUu0pIw+boTDqwL9bnMsDgY=;
        b=fssCKG+T2SN0vESLhS4XqlJI6CjzgEsn6dPxLJpli/I+9ibQJTP/meqdDVufQotU71
         XUQsSPR+2Ulq2CR0Hqk6SAQ7Xug1NGv6O620I14deQW/VPCp0uc9TxK/crFciZEqfxsF
         3l4zwV82mvF+5zRw2z6W4xSeoFsOMJpuivV/5ZB2i6BEHtq2WOSdUA7AaCjI/ARZb0GZ
         M5i5QhCDWLbzGy9JnhaG6wZ9+xhyClj918x8NQIjAR1jcPv75Xz8jHhqVA6v23nzikK0
         JcbgQ7YrfORHbh9FRgtTFhKDjTvzJ4y5Tfx+GqolZxiBksXOARnIM2sJPhsH2m7P6nAi
         qfsw==
X-Forwarded-Encrypted: i=1; AJvYcCVKR9BF8ZFcDd4RYkoPSqBkwZy2ZKjkJj/iPHFw7sf1wZMSGomMdl0TZJEAcFOO2XkPmtrNBY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFRH/Bzv19sMPzGrE2vOtnUdVZkw38VyCmMMEZKd+eSkosdzi
	SUEdK5tSgmxYrMfs2trMpv3S2E2MVgeQXTMBDC4y+VKwaUWQL1U+WOAS
X-Gm-Gg: AeBDietzQJgPmBfDrAPvpp2Dr/vtF5GszshGuh+EjDaZVS3IxXSlKu2QZaw0mXipZb3
	8Xa9vg6V4B5+cBa6BIh4NecmeA/JN0oiQbDmm6P3/ddTkbkTty1WH/cvugn11OJj4wKSpwn6PE6
	l5S5l6coWBJ5SMq3wIVSG5+A5v5/7QVtnKNeg/InSIeRDIfjOHhhEhfdQbJfSToxCbbYZrZdTW5
	axDBLs3wCyxzwOpx5b1KiFy9+hAR/zHnDt5QH94th3ORbRTQ+GADFWqsTnh294yr9lNE/DglCdj
	q/bJJpyywOXasRIUAiUNekr+7/9z13IbFNR6peHdebkH6Xu7b2KHhpDLnoPCpZcCVET1xoZ0Dmw
	21hg0KgL1GLPqpzH99MBOgtwdd5tVgqciQzi2g7mBkgbugHMcRZ0moN3nDqNgXLuPZwYj+9k8A1
	Z2fd8D4KuLXDE45EhXA3UpNzaqPv407XtW9paKvq6hN1E8Lb3xGBNfHZ5xupFPFdZiYPBfBER9X
	+WG
X-Received: by 2002:a05:7022:6629:b0:12a:713b:896a with SMTP id a92af1059eb24-12c34eedc16mr6821236c88.17.1776028287219;
        Sun, 12 Apr 2026 14:11:27 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb141sm11520856c88.12.2026.04.12.14.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:11:27 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v10 05/16] platform/x86: lenovo-wmi-other: Fix tunable_attr_01 struct members
Date: Sun, 12 Apr 2026 14:11:10 -0700
Message-ID: <20260412211121.2220556-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235860-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 293413E60BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In struct tunable_attr_01 the capdata pointer is unused and the size of
the id members is u32 when it should be u8. Fix these prior to adding
additional members.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: e1a5fe662b59 ("platform/x86: Add Lenovo Capability Data 01 WMI Driver")
Cc: stable@vger.kernel.org
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/wmi-other.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 1e06b894cfcc..50a03f5fd6ab 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -546,11 +546,10 @@ static void lwmi_om_fan_info_collect_cd_fan(struct device *dev, struct cd_list *
 /* ======== fw_attributes (component: lenovo-wmi-capdata 01) ======== */
 
 struct tunable_attr_01 {
-	struct capdata01 *capdata;
 	struct device *dev;
-	u32 feature_id;
-	u32 device_id;
-	u32 type_id;
+	u8 feature_id;
+	u8 device_id;
+	u8 type_id;
 };
 
 static struct tunable_attr_01 ppt_pl1_spl = {
-- 
2.53.0


