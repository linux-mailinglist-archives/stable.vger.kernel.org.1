Return-Path: <stable+bounces-121680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB56A58FEE
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0E516B57A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C8A225768;
	Mon, 10 Mar 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGS+nSgi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0293223322;
	Mon, 10 Mar 2025 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599747; cv=none; b=S6SblkQO8+5TW26j2KxKaPyP17fPdY+FPULxqowfKaSY58rerxveaXQWJk3IhUa4TgZcWQm8CfDlL53iPAyzq6hvv8YrsT/2slhC5TE+nVRp8w9FxKtNOIlTXPyY2JTUaPuqptLHiGmVBEHWHQjGmKjsVTXBNo/ZmIWfE5Fi1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599747; c=relaxed/simple;
	bh=NQHT5InkDyXgo08L9DDc3BqAK61davpXyErhFl9ZHZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ofiZ5JazYPm8GjeNdpACYfuLGDhfUrv1aPxtUx/fMHHhHUBcPWTvZUC8FTBUOMfUYG0Y4TuWgCnvLSAmQa8vMfQ0vEQybUNioJL3qyMoIR+6Z1BOcXxsD7U0MtRDGCXPB5jjbS1zBB/8un7iZ8ne8pLwOzznr/up95/JoUG7xOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGS+nSgi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2241c95619eso7559315ad.0;
        Mon, 10 Mar 2025 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741599745; x=1742204545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VWz2km1p8A5Qrb528dwkKrCW4fkTzMxBmqo/9LnHk4=;
        b=hGS+nSgijMCamFdU1iPVCGXuFRMoS5I2pNS0V141BuIzI1VqLBSVdV0b+MOH/igmRs
         U0o4o7kC+lSW9/QN/b63w1T9VKYQfzwB64AU89MzEKRV/gT1kPewOtnRhYT+qFg2RkWU
         DbSzPUf0rl1VWMQvMgKAihyK7pzJL/ZaksEBSwlDmCOrc862X0yLSDw2x3Kv5jratt2+
         Zkfw44aAl7AvAKoi55hQX7xBIrT12XMFvh1gEiD4EFib76Oe1r21k9Gj9cQlJ+PdK9TV
         3mth4upAdmrjubH7JM+6sXb4v45ZfSY2IxbfL9u9f5UfNVvm85G1QRJQoaWKi7kX6K3A
         blyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599745; x=1742204545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VWz2km1p8A5Qrb528dwkKrCW4fkTzMxBmqo/9LnHk4=;
        b=sBFNPsjR6VhfULx3n/VVKOj0YR2m0A5BFY5YyXEVeTFeLcC2CgAZvj9x3LzIPSIO7d
         hcvJ4QnApXtoXO2AhZr3HudOVz3jsyLSBNSDMDxphFa9h9MG2DRi6jopaN/QDRkzr6uq
         TqV16On0MADqcO4h+QGgk553bWV011juBERSx4UzaP78dMSIyKeb5bSIPvY09kAhYum2
         yxrpDsRcYxqyTfhUb063RBej5mskCrYC1OLn/ZG92+ypdjOl67DwHlJ4+fffdXTdppsS
         kUQ7Kn42trmLPvtnpytbCRGuP6HYwidBznexdyaKrbKwSaK15O2FIVXMX6Shagu5hUkI
         nYwg==
X-Forwarded-Encrypted: i=1; AJvYcCVxnImqKaTafNpjxeN0oZXiS+aLUQZCbNOzOdk9B9tMGjrhO9h2z3c5d8UP1g5BiLgbrBBY0ZdpiRTtXxU=@vger.kernel.org, AJvYcCXFHzFQRX3I8VwoeIzGPsXW7Fh3M1/CDA9QDis81yquYOkclqsE5AEziMdNCjXl2gFj1Ur9Nb6T@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Pu7xEMOJzneJlFFiwabWz7ndjxywb2BZYeYW9v7bPUGbLuLT
	FMysflH/YsngEd39j522nch/cVWNpdJQhUBtpX+9D4loDWK5ngdF
X-Gm-Gg: ASbGnctC5A5AFWjFgD/8g/31yoT4x0gmlFz59W+YvrhkwU+vRNN27wrnpvuD76eGsFH
	JIzG9gxkOc6rpP2jcv+7EAoE05wJyCrzLpVduD/bNSCl2cpOCN4HlZ3XGZVRzzaUcknsJqRjsW0
	RQ8lwKNrAudAAOr6f07JyiTVeRRe/ClWnOuIF5m58HAsTyB4ZG/OuMEhuoAX2FHBMpy6Alzh1KH
	c8bggenaBklqq2rHrrUZ5VEG0dn3wGAtfRIuPQGotVLNjWJ6RDJcAnVw8ydNwOrwBkuSRpW7wRs
	544BTyCD+/HlPwLTtsDG6lPnjD+vzdmNK1eTZWEQMrc6ET+3YB7VutqYI7CG1g==
X-Google-Smtp-Source: AGHT+IFo0zr5IznfFqV/6Ax1xUdw01T8Ui1VTflInlSacqsAlrf5cMCvN4QODRufJlVGOpwF2k+jhA==
X-Received: by 2002:a17:903:2302:b0:224:1212:7da1 with SMTP id d9443c01a7336-225422a8e8emr49856275ad.13.1741599744843;
        Mon, 10 Mar 2025 02:42:24 -0700 (PDT)
Received: from localhost.localdomain ([182.148.13.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91971sm73285915ad.165.2025.03.10.02.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:42:23 -0700 (PDT)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: phasta@mailbox.org
Cc: airlied@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	dakr@kernel.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com,
	maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com,
	mripard@kernel.org,
	phasta@kernel.org,
	stable@vger.kernel.org,
	tzimmermann@suse.de
Subject: [PATCH V3] drm/sched: Fix fence reference count leak
Date: Mon, 10 Mar 2025 17:42:16 +0800
Message-Id: <20250310094216.3821893-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a5f389b1c08847fb658f4120b205521e4a8ea0c1.camel@mailbox.org>
References: <a5f389b1c08847fb658f4120b205521e4a8ea0c1.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Sorry for the delay
>
> On Wed, 2025-02-26 at 17:05 +0800, Qianyi Liu wrote:
>> From: qianyi liu <liuqianyi125@gmail.com>
>>
>> The last_scheduled fence leaked when an entity was being killed and
>> adding its callback failed.
>
> s/leaked/leaks
>
> s/was being/is being
>
> s/its callback/the cleanup callback
>
> s/failed/fails

>>
>> Decrement the reference count of prev when dma_fence_add_callback()
>> fails, ensuring proper balance.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and
>> fini")
>> Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
>> ---
>> v2 -> v3: Rework commit message (Markus)
>> v1 -> v2: Added 'Fixes:' tag and clarified commit message (Philipp
>> and Matthew)
>> ---
>>  drivers/gpu/drm/scheduler/sched_entity.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
>> b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 69bcf0e99d57..1c0c14bcf726 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -259,9 +259,12 @@ static void drm_sched_entity_kill(struct
>> drm_sched_entity *entity)
>>  		struct drm_sched_fence *s_fence = job->s_fence;
>>
>>  		dma_fence_get(&s_fence->finished);
>> -		if (!prev || dma_fence_add_callback(prev, &job-
>> >finish_cb,
>> -
>> drm_sched_entity_kill_jobs_cb))
>> +		if (!prev ||
>> +		    dma_fence_add_callback(prev, &job->finish_cb,
>> +
>> drm_sched_entity_kill_jobs_cb)) {
>> +			dma_fence_put(prev);
>
> Please add a little comment about the dma_fence_put()'s purpose. Sth
> like "Adding callback above failed. dma_fence_put() checks for NULL."
>
> Then we should be good I think
>
> Thx

OK, thank you for your detailed feedback.

Best regards.
QianYi.

