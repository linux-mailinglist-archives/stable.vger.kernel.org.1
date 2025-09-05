Return-Path: <stable+bounces-177792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD8B45381
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA25C1B22379
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28B927A11A;
	Fri,  5 Sep 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="aaN+h4wA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88701278E67
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065138; cv=none; b=EoOzv6cmvIG/Yo/Vmu0xWkO3a63yd9DS5EExPpsFi/JS1Ks+930hR4xxbFufN3bZs7kqRd01Uyiw2dYC9QbaVYmOeqt8XHHTHAsiI7oYyKnWvgKZMCNBKuBaiad+6V1c/LXSAPVExSp0Tz/CFXzEQI8XkfIr1Yh5Dy0czS/4Nak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065138; c=relaxed/simple;
	bh=DQzqJSkZtdf2m9T83N17crffKyn7mU69jfmQVqs9XxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tU4CfDd5MSRerGeMbjH9+9b69EYPNRNTYCOH7XbRJiPw9rZ9uIS9NdMTTzdWbaGJmjUHL1Q8FpI+b1gb1ACHYCSj0S5AUon3fQ5Pj1oyS3x8liwRHg1iAwVAHcwRs429VQ9XuCIflb62GtS68tLd1Llil6xmvYdXkJUiPQNP1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=aaN+h4wA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61d3d622a2bso3976616a12.0
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1757065135; x=1757669935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8Lga1GkOl1oDiE+1dVHrqOvB9vstlkU/NOIqsz7Q7A=;
        b=aaN+h4wA3465qC28QM+eRTSaoFHeaqr5J2+wDrPvQWbMFgiVrQ4j2Xl3NNrJir6jdo
         uzn2pUdfqyTKKRAaC0vtJfR7ryLmwkNYJf+cHFLSvRG8+Dq9MCpdfN2wGAK5BoQAbjDI
         hjAlZ6TaqFDbJRC+Xi/titBmvO1CFV3b1PS9HiuOawloLfQJcwlCOKRNrra7LqWwWokb
         sIWPmfUkJCO8/Z9kW0zD/KtkZBv9d20Mx1SGfMEQFoQJqzbsTzXPwa7oL/W5WAOVHmL5
         W3vXMZszXAgjKY7f7FCzvjZLGcR+6nGsWIJH/vekLIJBHnGInswjV+rmkryCdFzMMdx1
         KIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065135; x=1757669935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8Lga1GkOl1oDiE+1dVHrqOvB9vstlkU/NOIqsz7Q7A=;
        b=jdFMp0jSHuA7bkkyNjX9ku9tVMqq6vM+BWWggoReuPxouo6tJkD25EN2FkF3/TXyJ4
         C1ghyKF8hT78AsZghkhNpd5R6pdH2cjgDO1fOI3eY6MuIO8UDifq3fiSY2DrFZ19GdH9
         oIRfFB2Z3tQS4Xm7weNuRqWsXBaLj5Iyp+5MMuPzoWKducRFhDotCyyhzBvftDVXYpX7
         Zxvk6Gbm4WNM5Oz0dBccZcQX8QzftlA5h4JBMZNHlnekNp0E+V4qIcjlbXaQd0h8rzGF
         KttI4oLizdxCyMGFz5zlXqsof7P19JOj4nOjupzycej1iblBCsmzi1D1rCEhO2UXyjsr
         MQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWKKMh7OX/dxnEQ9a3UfKRGRCOhyPecDEEixrxdTa1zuCW8U+L2HUy3pOLRpBP7L6LbytKG250=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVj8JFzTEYSEyU7Ne0KQjtRJ+CHP5rybPrsGBKPTicwOd1FtA
	d+da4Rw9y7fZS7ws745M4fAxwwbhgmxG7xhl0ISQ5Q8cgCqZVixXHuw5Ku/lMCz39II=
X-Gm-Gg: ASbGncuTkMmSy0ENeu/Xarxw1zJO6rWJMedNIU0hlGhLP4jzOTaeNhreXWMwWYDVEVK
	kR0mnNZyhFFdMrGVj9EkWUJ1kirag68GH377MW4oCqWy5WpP52JUQH/voY7mUz9BBDlgjquktEe
	BREMvWhPWMmBLpM623jw05r+eLB3yqJNdXlHbSXCWjW+Ac6OUmVyqCl1s7EWbkMZoMBtXNzeCB0
	HvLMUmDv32MMufG5wmuMDrliMHc3BtLVhrfBGKG1eh+eyE4kplSZxw5Jy4+8BGG9Pd468eksgzC
	IC6Lsg9cy+r6ZiQ8uQeTufLIdzSjsDUGepT3edMOqKWsk2o5wSwxgyoVBUM24D9gB5M907xObKU
	90fwsUQEK/4ytgleqaE8ZZ8qLtOMBhscd5/ShDwpQrwNWcjE=
X-Google-Smtp-Source: AGHT+IGybuK6K/kujLTwnL+Fz49sav06Z8CCw7Z9351OYmVQ4LWXK44fzX23p7+KrdEaFzCMcOmACA==
X-Received: by 2002:a17:906:b24e:b0:afd:eb4f:d5d2 with SMTP id a640c23a62f3a-b04931b6715mr240740366b.31.1757065134805;
        Fri, 05 Sep 2025 02:38:54 -0700 (PDT)
Received: from localhost ([149.102.246.23])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b046df9a44dsm561055366b.70.2025.09.05.02.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:38:54 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	stable@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH] mm/memcg: v1: account event registrations and drop world-writable cgroup.event_control
Date: Fri,  5 Sep 2025 12:38:51 +0300
Message-Id: <20250905093851.80596-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250904181248.5527-1-disclosure@aisle.com>
References: <20250904181248.5527-1-disclosure@aisle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch __GFP_ACCOUNT to GFP_KERNEL_ACCOUNT as suggested by Roman.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 mm/memcontrol-v1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4b94731305b9..6eed14bff742 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -761,7 +761,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
 
 	/* Allocate memory for new array of thresholds */
-	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
+	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL_ACCOUNT);
 	if (!new) {
 		ret = -ENOMEM;
 		goto unlock;
@@ -924,7 +924,7 @@ static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup_eventfd_list *event;
 
-	event = kmalloc(sizeof(*event),	GFP_KERNEL);
+	event = kmalloc(sizeof(*event),	GFP_KERNEL_ACCOUNT);
 	if (!event)
 		return -ENOMEM;
 
@@ -1087,7 +1087,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	CLASS(fd, cfile)(cfd);
 
-	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	event = kzalloc(sizeof(*event), GFP_KERNEL_ACCOUNT);
 	if (!event)
 		return -ENOMEM;
 
@@ -2053,7 +2053,7 @@ struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "cgroup.event_control",		/* XXX: for compat */
 		.write = memcg_write_event_control,
-		.flags = CFTYPE_NO_PREFIX | CFTYPE_WORLD_WRITABLE,
+		.flags = CFTYPE_NO_PREFIX,
 	},
 	{
 		.name = "swappiness",
-- 
2.39.3 (Apple Git-146)


