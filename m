Return-Path: <stable+bounces-211700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPUqLTUgeGkKoQEAu9opvQ
	(envelope-from <stable+bounces-211700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:17:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFA88EF3B
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE231301778A
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2929BD9A;
	Tue, 27 Jan 2026 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEraHn0i"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B076284890
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480240; cv=none; b=qFYklJFlxL0ycq7i8phYMJ1/sKcPCRid27trvEP9NklD4+7NOLxaCIRzvlmBEZP/G/jIt/tPfvr4F2mNJ5ofqd3dm4P/ewUygselE6FYuMUhu1UQT08UXSrzJNg9KsdjXKrfG8rZ0fGT0Z3qaQeXK2lhIIl1RcJrqq+yPktJekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480240; c=relaxed/simple;
	bh=25VI4oHzP0aWx8/NOg1WDXR3gKRU4PGxsQh/AZJv+oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaLdeYeVvglS7W0QiBhHPszDa432Zc6EN2OuzDTaFSklLAXiY29sWFbXO7Y+OrHg5kpOO1rzzAUU9xq3nJKgMbjRsK/XJSsXfsbsmnE9ZPIonJIhTL1USCj0MY+w/2osPqg80puqF+xcYRrv4reGfakzQ59UiliI5Maw/28GHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEraHn0i; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b71515d8adso4995372eec.1
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 18:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769480238; x=1770085038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BfFqoZAmKuiZwAth/3GTp8/RM+Lu+El376s9oBouTo=;
        b=cEraHn0iMeeUSywo7mhbU/OoSTubVRHiwDmMQVgLp2bk55y0K54MCKGxf0tnUnvMZl
         Jzqqc0NWdvzQCpekIrTTVxjNHtUn842Kh6wCT2nvyU80qQEwl6Ovr67C8P3m/TRk7n54
         PaojKD+r30kN4BodvbItJD74wPK1f1mGZAo1oqpqjcvjQM7hgJxpMFrouKZbOR0SfHbg
         XOpAHkIO5aD8GyhuLd7igcjEl2oMgmaLf8xyvCfmpGf0AfxxEJMChjRfW/8zFuYVyAXL
         UJaYW3LMnLCTZNpKpX2vgpshw9eYkJ7U2UwPspiCyh1FkQal31Uk4uSGU1Jo1VInPGx/
         NJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769480238; x=1770085038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7BfFqoZAmKuiZwAth/3GTp8/RM+Lu+El376s9oBouTo=;
        b=duDOcXkisy+V+pbEq0El7V2F8MZXCYLc/0LSHLLxbpb4Rxka9/5EqWuV8RtO1OPp89
         isbw73AYC3PfXxBMFqi12VNu8rCXO+GJUgyPsBHlFuiw9SZ6cpts1sGFe1uNqoChkqUW
         EJcm4ZWLIGt1jlIPyCPymb1KNtlEoWdhtgyHYH071PVflxPa+GglvQ6CWZTc3bEwJBVH
         Y50d37fNs/h3H3jKCyN8wd9QKvchKIQ0BzbYfbsYiuJ3kVApSbRX2DIrb/wIOTlsSc79
         oYkaf3qWH0f8Ipwf/Fu6mMpvuvI7efbZ4PbbJbLHYKGu1tcIRB8frVq6AkWw+rTUZD97
         gJpw==
X-Forwarded-Encrypted: i=1; AJvYcCVqyGa3PqQHSzBK3N6Du6Vrczk3DaF/HjCwhgmY4nxq+WVS44afAvii3xwVogu0omKeCYHNOCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9dJngbaDV/7AqaZVuWzqggb3cmPHF8lbjM6XWe7YAegRqwdn
	G6z1QkGbjKq5CJKN1Gf38XOPbLa/6e7Ni/AaSM+6+X4h+xGdeCTMIHwL
X-Gm-Gg: AZuq6aIx/6yXl2WiUCsV83PZZNKkTkpifj6ASPDC+G5ScLkND2T+NX5yCrUnzznSRhw
	pUQhc5E/sYJyfry2eOa00KYATeu36gjoaQUwQMZ9t6Q/2vB2lHp1cKvxE/ZHUjDuaAgx+xXWgcA
	AW1P78lktNrUjqmhrFtjISpFFSjJjqrnkXLuVmmHnW58H1l81TSxC7Ubq47q1z+It6T2tjlxOCr
	mrysoy5QAyp3/x/J1V28r1gxdAAiPh3vtFcQwwnD918wbBKEDtRFE2/p1dQGSqvGNTvYMvkqWSN
	SEAJgvG+dE5LFdOzakDM6lDWnhEdi7BqKOi0mTBsrE6mYdQVMqLID4j8GwjdIWdYprMLTGJFEv2
	LtQTaoORsSmIUrB/AKh4CRhnt1L4JQ/WEtAtiaT4B/GwDm3Q9+lER9y8fOldmWQF2yCLHxdN/OH
	qXhw8=
X-Received: by 2002:a05:7300:e607:b0:2b0:4b5b:6820 with SMTP id 5a478bee46e88-2b78d98ec0amr146038eec.26.1769480238323;
        Mon, 26 Jan 2026 18:17:18 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa2b1f6sm15490271eec.32.2026.01.26.18.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:17:17 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: dianders@chromium.org
Cc: akpm@linux-foundation.org,
	lihuafei1@huawei.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	mm-commits@vger.kernel.org,
	realwujing@gmail.com,
	song@kernel.org,
	stable@vger.kernel.org,
	sunshx@chinatelecom.cn,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	yangyicong@hisilicon.com,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn
Subject: Re: [PATCH v4] watchdog/hardlockup: Fix UAF in perf event cleanup due to migration race
Date: Mon, 26 Jan 2026 21:16:54 -0500
Message-ID: <20260127021711.1180952-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAD=FV=WVtFAPZ3=6pPnOV=vbMhFwfH9LaZ5oNgAKtcj5hA0q2Q@mail.gmail.com>
References: <CAD=FV=WVtFAPZ3=6pPnOV=vbMhFwfH9LaZ5oNgAKtcj5hA0q2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211700-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,huawei.com,vger.kernel.org,kernel.org,gmail.com,chinatelecom.cn,linux.dev,hisilicon.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0BFA88EF3B
X-Rspamd-Action: no action

Hi Doug,

Thanks for your insightful follow-up! It's great to have the openEuler vs. Mainline 
timing differences clarified—it definitely explains why we hit this so reliably 
in our downstream environment.

On Mon, Jan 26, 2026 at 5:14 PM Doug Anderson <dianders@chromium.org> wrote:
> OK, so I think the answer is: you haven't actually seen the problem
> (or the WARN_ON) on a mainline kernel, only on the openEuler 4.19
> kernel...
>
> ...actually, I looked and now think the problem doesn't exist on a
> mainline kernel. Specificaly, when we run lockup_detector_retry_init()
> we call schedule_work() to do the work. That schedules work on the
> "system_percpu_wq". While the work ends up being queued with
> "WORK_CPU_UNBOUND", I believe that we still end up running on a thread
> that's bound to just one CPU in the end. This is presumably why
> nobody has reported that "WARN_ON(!is_percpu_thread())" actually
> hitting on mainline.

You are right that in the latest mainline, schedule_work() has been updated 
to use 'system_percpu_wq'. However, in many LTS kernels (including 4.19), 
schedule_work() still submits to 'system_wq', which lacks the per-cpu 
guarantee.

More importantly, even on 'system_percpu_wq', the worker threads do not 
carry the PF_PERCPU_THREAD flag. is_percpu_thread() specifically checks 
(current->flags & PF_PERCPU_THREAD), which is reserved for kthreads 
specifically pinned via kthread_create_on_cpu(). Therefore, the 
WARN_ON(!is_percpu_thread()) in hardlockup_detector_event_create() is 
still violated in the retry path even on mainline.

The UAF risk stems from the fact that preemption is enabled during the 
probe. If the worker thread (even if on a per-cpu wq) is preempted or 
if the logic assumes the task cannot migrate (which is_percpu_thread 
usually guarantees), we have a logical gap. By making the probe path 
stateless and using cpu_hotplug_disable(), we eliminate this dependency 
entirely.

> If that's the case, we'd definitely want to at least change the
> description and presumably _remove_ the Fixes tag? I actually still
> think the code looks nicer after your CL and (maybe?) we could even
> remove the whole schedule_work() for running this code? Maybe it was
> only added to deal with this exact problem? ...but the CL description
> would definitely need to be updated.

The schedule_work() in lockup_detector_retry_init() (added by 930d8f8dbab9) 
is necessary for platforms where the PMU or other dependencies aren't ready 
during early init. 

I agree that the commit description should be updated to clarify that 
while the issue was caught in a downstream kernel with shifted init timings, 
it identifies a latent race condition in the mainline retry path. 

Regarding the 'Fixes' tag, since 930d8f8dbab9 introduced the asynchronous 
retry path which calls the probe logic from a non-percpu-thread context, 
it still seems like the appropriate target for the "root cause" of the 
vulnerability.

I'll refactor the commit message in V5 to better reflect this context 
and remove the emphasis on ToT being "broken" out-of-the-box (since early 
init is indeed safe there).

How does that sound to you?

Best regards,
Qiliang

