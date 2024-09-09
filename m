Return-Path: <stable+bounces-74041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4D971D8F
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64BB2841BA
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5F820B04;
	Mon,  9 Sep 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vu3k6qUm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026C1CD02
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894542; cv=none; b=e+3NFvB49Euk8Hyn/6EqUEyCcqQEkzjwQdKVSwzi7cr/uAp39BzeR1d4m7Q5p8/4yXA8MLikKTl7budmpG3xq0HQ2Qg68BsSp4K2x0YybGPOi51LuXP3RbLYmh1+Aq6H2vCCUYUTmyy594zaqSubON7Ej10iJwLrLu1daymx9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894542; c=relaxed/simple;
	bh=xPcRfbUDnlRSH5p507wqtYBgZjtSxWo7rAqcE2R7yk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAmI676+Hcsa5PfCqLeIIqoRoy1G940Vq3N9snvJpgX8yad8H62x4UULGvsNKmGM5YAx8rWdnHi6y+GsZd7PpD9fJeWzu65YQIs+daZKTm0ttjXl7S6tg6lJoh1hQ6VLSMPwcTtmryp5K125j9bnjpr0XGlWrqdEAtUgIlomW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vu3k6qUm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20570b42f24so52588275ad.1
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725894540; x=1726499340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJhTFlfxhKbPWqyjtraK3mWFbHY7wyyFUxYrQtn7EAI=;
        b=Vu3k6qUmlRQzn5WTg7QeLLu+0nES5f13OH2rfp3IvCN/aiQJsPb2z24JQfQAzOMTZ1
         DK3W7tgGZBLY9XD8GXYXDSlbBm3e50/+hbQN197Vktn8Nx8huhF4yowLT89uxM00fwRd
         wpgzgr8H2olfcCdV3awmADYvdnvGfAnWSgIIw5kMcco4ldZgyvXo6cvcYmVW56qzpjEm
         H5WRQUNm67YDMhZzhxNYd5RPjCYDvjpKw7WKpGepBZvhmTw5z/naXXYuIwu4VQ6Wfxrl
         RV6zKh4eMuY3YMQ5BK55k2Xc9ThC/KEfRB5m/frpjcg2mpXqFCBCVWC+a141UplUWeYS
         G6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894540; x=1726499340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJhTFlfxhKbPWqyjtraK3mWFbHY7wyyFUxYrQtn7EAI=;
        b=vB4WHNhw0Q05eSe8dyVttBGDtnBmlNOmsUD/jWRCVDTOu77MAYGtM+Z0UUBgEXv+f6
         ugcLoDKBTQySGNme7CDcZFvycEYqiW5rJmA/sFttH8XwbBsK08S5z/6JsI2zmmulV2fx
         j2tHLRib14cNnI8UD1pXEYmNW9cGl8W1UokQAjRQSJzHvXdRarOc0nUwUOwGtHW4BM1K
         +t66hZ0gxeSAAygmS1pwLt6yOGSmH4EOeaJwgt0X8CNWXx215rfGLfj6A1ZDVBfUQQ2+
         sRi0gERJTRYw+D5Aim6h5MMUeyMPfPtE2rUNcpcWwFyn/qbgfAgdaeXg6yKfZ//fw0q6
         v4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhiApEzNTcStI1Ryz8O5IGBBXWLk427D+twPiYGIAqCzqGjv/zuhzFVvE5v4It3xwGmvqJKoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIUxwP92lGpbfygqn9U2FK6HW6f998nLfB5A0ZqvxkXA8FBpR
	BYiN3dRAEvY2hb8D5kYRGd96QJJTQbBaIXJs2+wIlzvMdJYGOhA9XXQGAetAuGo=
X-Google-Smtp-Source: AGHT+IE4GDDZJbyQG+6N1pXP67MaHd57oGUInS3duAH669gz/mZd73jCuJO9cuvk4Qq99/EbkTfMqQ==
X-Received: by 2002:a17:902:d506:b0:207:1828:82fd with SMTP id d9443c01a7336-207182893dcmr38404705ad.28.1725894540291;
        Mon, 09 Sep 2024 08:09:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f416b6sm35173015ad.294.2024.09.09.08.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 08:08:59 -0700 (PDT)
Message-ID: <be5fc442-6378-4592-bd17-2756d04e363c@kernel.dk>
Date: Mon, 9 Sep 2024 09:08:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring/sqpoll: do not allow pinning outside of
 cpuset
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com,
 longman@redhat.com, adriaan.schmidt@siemens.com,
 florian.bezdeka@siemens.com, stable@vger.kernel.org
References: <20240909150036.55921-1-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240909150036.55921-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/24 9:00 AM, Felix Moessbauer wrote:
> The submit queue polling threads are userland threads that just never
> exit to the userland. When creating the thread with IORING_SETUP_SQ_AFF,
> the affinity of the poller thread is set to the cpu specified in
> sq_thread_cpu. However, this CPU can be outside of the cpuset defined
> by the cgroup cpuset controller. This violates the rules defined by the
> cpuset controller and is a potential issue for realtime applications.
> 
> In b7ed6d8ffd6 we fixed the default affinity of the poller thread, in
> case no explicit pinning is required by inheriting the one of the
> creating task. In case of explicit pinning, the check is more
> complicated, as also a cpu outside of the parent cpumask is allowed.
> We implemented this by using cpuset_cpus_allowed (that has support for
> cgroup cpusets) and testing if the requested cpu is in the set.

This also looks good to me.

> that's hopefully the last fix of cpu pinnings of the sq poller threads.
> However, there is more to come on the io-wq side. E.g the syscalls for
> IORING_REGISTER_IOWQ_AFF that can be used to change the affinites are
> not yet protected. I'm currently just lacking good reproducers for that.
> I also have to admit that I don't feel too comfortable making changes to
> the wq part, given that I don't have good tests.

Yep io-wq will have the same ignorance of cpu limits, so would need the
same love for when someone asks for specific cpus.

> While fixing this, I'm wondering if it makes sense to add tests for the
> combination of pinning and cpuset. If yes, where should these tests be
> added?

Yeah certainly add tests, liburing would be a good spot for that. That's
where the feature/regression/bug tests always go.

-- 
Jens Axboe


