Return-Path: <stable+bounces-131881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49843A81C24
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 07:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9441B63358
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 05:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0011D90C8;
	Wed,  9 Apr 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZGVUCCD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9B81624CC
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 05:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744176740; cv=none; b=ivK2ztB+pa+43k3Cq6bKSHlLD0WYSicwciT4xdzixYRb/NO+vsqkE0x71Qwi33TVJjD0LZLTVOxIz7k9lU138+mjEDd9sNDb+X3x2zdpDORTp7CCU8bhBbckALYBNIqQFIBQVOx8TXR6dHscPwEN7KJae34WEoNbN70EUVToN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744176740; c=relaxed/simple;
	bh=2iFpcjMuEBHc6EEiX/UltOrfSiESXXtv+Vrk/DWljdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elzXH4fTLJu1GqGSkbzJa4iz854ecpIL24xPvyREqsP5NixAAlZH9NLnFvLC8B78LLcAy54h7LjNGQ2Wqc0IrOqNpLRcmm3MjPWrRpDhMF8Mp2+aPT20vKkxoXfsHXyvbXS/PUs+dhEygDsRAYUIDkRlkqyaT3dDi8+e7wotWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZGVUCCD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744176737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqN9Zfb7zsWPAApJSbDsVLc/6LelOdZ+0v2KH6pBb6E=;
	b=hZGVUCCDPIEX0idTt59HM2ON28DIMXGwrNNa6d5A7bieUtpD8DyHBlThdZhlIV6oCWi0nD
	36Iub+hqM4CK3999voVHwkmoHbcSJnU6nNJ/egmvnSkHoNSg9V3yyJymtc5LQgnABEzDCp
	I3CZ7EHV6cYV0o0QGE46PqR3alt7GRM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-hfap5Ij6M_GJJban5Oh7dA-1; Wed, 09 Apr 2025 01:32:15 -0400
X-MC-Unique: hfap5Ij6M_GJJban5Oh7dA-1
X-Mimecast-MFC-AGG-ID: hfap5Ij6M_GJJban5Oh7dA_1744176734
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391425471d6so2342428f8f.3
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 22:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744176734; x=1744781534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqN9Zfb7zsWPAApJSbDsVLc/6LelOdZ+0v2KH6pBb6E=;
        b=EwI/RsGahTVUN9qWNR37LxkRqWPBfNBGQkTisxG++ESF3nFdvem79zkslXuBW9zAE6
         HpFEkSfhTREiQu7tu9Q/9m8hun0hD8gfONIXmch3xqvEjCiS8wON41YYXv4n8aNCXufJ
         vC9bdZQzlrPiGd9e9SRRCfw6v/+wFpQLLNlaYBwxBSQbFGxTMYBlK/SvIX0CW8czDHDm
         LqDHRBJOo8mbjtbIonT4p0o8dbbyEdK9SkK5nyORzU+8qefXvmrRAgEvPOIGbr1s0Oo1
         j9X4wykWF2/Frl7UkyPtrAS8P/3KENCTEn+uFaeeXD+di4xK+wHY99F/XVik83mwBEh2
         ylRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBpQ/w7q85X36FXVs0/8EQqjiNVBKRKRrNHk7FlEZnagFc38oKWkAIWdtXcuWiue5LeFzoKkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS1RZkJc1/RqJiCgeQUTtOc5asiSbl2Z98cuYmfGHIxM2wZxlP
	Jy2KEHCs1qWPtDL8RBEGqRr5+VUHASjiS28nQu6Nb58iPb+1Grgzh9ZP0QTZDDeqZ1732t+Nb8j
	aEzG0qOfO98/pivsVPCrrWTsdgyav0ePFquZzKcA1uqSEWPVggu+rLQ==
X-Gm-Gg: ASbGncvuGqOyYEavYIgJKDbJkwo0YgiY5ITJ7CoDhbBcQzexbxhHloryxOaO6HYbVpR
	WR2VqijdtxKMzJY/cz7iT8j7RhPtdG2+jPs2DfTpMzXALSnh5bdvai1nxj0rMQk/Lcwp98Fa3nr
	zF92Coo6Stdaq/5uWoHQ2FyzSpsinCPh45VRWgMBpiJz6iwGVlXf0tYVU077a+HKRldYjNE+vau
	IBn7ib9ecIN7ENqZOSl1apirznCgBsvPsMh0CpKvMEn335jw4zaLmvYxgNVKXQJ6UEsnup9oqfu
	nW0hhe237X796+5BNnaOF2wk+344boNSkz8dPXhUl/yX5ro=
X-Received: by 2002:a05:6000:4023:b0:38f:4d40:358 with SMTP id ffacd0b85a97d-39d88525ebcmr801331f8f.9.1744176734497;
        Tue, 08 Apr 2025 22:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHFPdvMlkiXcaHT/+np9HKiWfjLVNoIGsBWaLbzFDwMgEMDrzSpCUsSKwEhafjbiP42cKtig==
X-Received: by 2002:a05:6000:4023:b0:38f:4d40:358 with SMTP id ffacd0b85a97d-39d88525ebcmr801314f8f.9.1744176734140;
        Tue, 08 Apr 2025 22:32:14 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.22.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893775b9sm579664f8f.35.2025.04.08.22.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 22:32:13 -0700 (PDT)
Date: Wed, 9 Apr 2025 07:32:11 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched/deadline: Fix race in push_dl_task
Message-ID: <Z_YGW8IrRQfhfdM8@jlelli-thinkpadt14gen4.remote.csb>
References: <20250408045021.3283624-1-harshit@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408045021.3283624-1-harshit@nutanix.com>

Hello,

On 08/04/25 04:50, Harshit Agarwal wrote:
> When a CPU chooses to call push_dl_task and picks a task to push to
> another CPU's runqueue then it will call find_lock_later_rq method
> which would take a double lock on both CPUs' runqueues. If one of the
> locks aren't readily available, it may lead to dropping the current
> runqueue lock and reacquiring both the locks at once. During this window
> it is possible that the task is already migrated and is running on some
> other CPU. These cases are already handled. However, if the task is
> migrated and has already been executed and another CPU is now trying to
> wake it up (ttwu) such that it is queued again on the runqeue
> (on_rq is 1) and also if the task was run by the same CPU, then the
> current checks will pass even though the task was migrated out and is no
> longer in the pushable tasks list.
> Please go through the original rt change for more details on the issue.
> 
> To fix this, after the lock is obtained inside the find_lock_later_rq,
> it ensures that the task is still at the head of pushable tasks list.
> Also removed some checks that are no longer needed with the addition of
> this new check.
> However, the new check of pushable tasks list only applies when
> find_lock_later_rq is called by push_dl_task. For the other caller i.e.
> dl_task_offline_migration, existing checks are used.
> 
> Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> Cc: stable@vger.kernel.org
> ---

The new version looks good to me.

Some final minor touches to changelog/comment might still be required,
but Peter maybe you can do it if/when picking up the change?

Anyway,

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri


