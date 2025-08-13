Return-Path: <stable+bounces-169379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06291B24991
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B032728448
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6FC29DB73;
	Wed, 13 Aug 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AkyiuBeM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45B1F4617
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088342; cv=none; b=kMrirob+S/FkN2mWeNLiIddgyQhXeD7P4oihnmqT2FvHZHLpUG7dCuvozwessDhBsas8ZrmRDImrbR0I1K3qZIPFJlVTMCQHGDZR2QeP0JUABiRS0XsE+SShXuPWtbFWkBZP//wI9iUNyqv+nhOXHnM3Kp7Qx0ZelOG0AblEBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088342; c=relaxed/simple;
	bh=z4v/k+xEazihCbibG96JuAuBlCh9t85TYi3nbMjXIcQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qX/IQj2DOjsnobRVxIOxpsROgYUq3hs4wQ6GdkOlwTRRyp6rNrrU3g9iUUR5ZcRbziUUSZ9TmXiMAmEFEBy1pUC8PJaQpDER6ng4Nn7G+TLB+8r17TmPuSQkmO8oLoz23rtGKgVLflWIbqxTUYEGA46k5l6VUVyQFWUBHgN2CdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AkyiuBeM; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3226307787so5302815a12.1
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755088341; x=1755693141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOOchsUjzM3+ZVjtt7sbhib6V5OcY3gPPFMR9Tn6POs=;
        b=AkyiuBeMgQiurJxbPmV5NB6ixysB5Te/bCM1j3Jiy2gRqukqfng6yaoZIRbcyZi6aI
         rXptZDTv8q9xkG2Ec+f2eiyPYcKTADoKIhbQIKmvyQmrRIyV8RS5uG5nugqTrssmYxWC
         AIUDwSGEPXteuc8JGHBqFfsrwj54Sk1N47/1o+48UUpWy1+mqzvqFo+SCWeg1yrK7DXP
         t21SToUsrnbun2Kq0IsNzBmp5MzChWhH85M8+DILV8YeDSnQGgEtxFJEK9uRckUFt+44
         jmPJv8+nBZ8tdIl/q2H6TAY1sAppXDlL/eGDlaSUFuULlopmTbHnlZKLAhJUWU+r8qTp
         b/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755088341; x=1755693141;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOOchsUjzM3+ZVjtt7sbhib6V5OcY3gPPFMR9Tn6POs=;
        b=VduIRcmf0SCk5Pr1tQiSX5hNOqvXZnWUeW8kz5MPCVO2QdNAWHAJV4pbvSJHZcnWeg
         rNqP+UX9G8GXNWmlkZf7n384HRfEc2scF6IN1/0MCWmy0mG6i3L2Rbt6nLDjZ9DSG7Ia
         FPN1k8ELk9z21aO8J9td1IAa31NlE0X08fEEFxUCop8NIZaBY0awfU7z6VGTJrpWWZBt
         msanydfbMl3DoHh/FEuBcz9DDUZfkzyndyn8ndUz4obFxLQCEn/5OEzrMzAFI+G5ZpR5
         oJORfu3G/xKHEDZGs+eq6AU6XWlD+T6BI4sRpa3fFQzqiqgElngjBxD7C7amud80QYKt
         Wzrw==
X-Forwarded-Encrypted: i=1; AJvYcCUoKknHGgyW4AajTLK56R5L2V8bR757FKIeOvL49RxlzrsB3KKKk9ApFqW4Iw6v3UrbVCbsJFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7D+5gbkQHK86ROJK1KlZ5OSQ7FoLHvb8sG29E5kp5F636rlXM
	f5AW9GuC3767HW0EgkvF/cLRskCZtXKvSgKgWUwcGB7TM95dadiIfFukH4rEym5dHYA=
X-Gm-Gg: ASbGncu2Ec8f5vFRLWzk5DnYsSQrsxVGTqI2PV20wMPpdAq0mJdA1OBRZLtk8AUa2ny
	ok3oV7AZRYGdZxodxHCeMSFKU+p6jadTNxpDtpSPWuiOG1gl4QS3BGAmaJdwI4X9JtdooXobf8q
	r/r6NzUi+/1W8450Yc5itSw64Ya+Zjd2FCpreUm7nexnKGF0OeYVPlfec/XQbSoIznykua1Sfwz
	LhZPjl3bPzaI3BZGIf8DZepFM/CsgdWiVbPZeJOWoxruTQklokMrvgpdpBPM3QJ9q/idjhh76St
	6hEHJDro1vXef2H1LA/FymKMkPe0eV3xzYyEfYK3jIX+hkkEefu1KLxhfI7i4WzJm4sE6U2h0Zh
	ja4qfgOqOnfsTqmvVYVyPemz0ng==
X-Google-Smtp-Source: AGHT+IHT5scgbby93gh1/cl+pL0WzlubhAl0HAVwY7hiL1W8RJkliPiwTa9RyjSOretmT7Mzh/VLUA==
X-Received: by 2002:a17:902:ea09:b0:240:9ff:d546 with SMTP id d9443c01a7336-2430d0b4c7cmr38502445ad.6.1755088340685;
        Wed, 13 Aug 2025 05:32:20 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232553e4a2sm82418a91.4.2025.08.13.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 05:32:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Julian Sun <sunjunchao2870@gmail.com>
Cc: nilay@linux.ibm.com, ming.lei@redhat.com, 
 Julian Sun <sunjunchao@bytedance.com>, stable@vger.kernel.org
In-Reply-To: <20250812154257.57540-1-sunjunchao@bytedance.com>
References: <20250812154257.57540-1-sunjunchao@bytedance.com>
Subject: Re: [PATCH v2] block: restore default wbt enablement
Message-Id: <175508833916.953995.11740099334208966785.b4-ty@kernel.dk>
Date: Wed, 13 Aug 2025 06:32:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 12 Aug 2025 23:42:57 +0800, Julian Sun wrote:
> The commit 245618f8e45f ("block: protect wbt_lat_usec using
> q->elevator_lock") protected wbt_enable_default() with
> q->elevator_lock; however, it also placed wbt_enable_default()
> before blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);, resulting
> in wbt failing to be enabled.
> 
> Moreover, the protection of wbt_enable_default() by q->elevator_lock
> was removed in commit 78c271344b6f ("block: move wbt_enable_default()
> out of queue freezing from sched ->exit()"), so we can directly fix
> this issue by placing wbt_enable_default() after
> blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);.
> 
> [...]

Applied, thanks!

[1/1] block: restore default wbt enablement
      commit: 8f5845e0743bf3512b71b3cb8afe06c192d6acc4

Best regards,
-- 
Jens Axboe




