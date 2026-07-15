Return-Path: <stable+bounces-274927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IaDqOc+AV2oGTgAAu9opvQ
	(envelope-from <stable+bounces-274927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 14:45:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A40475E4D7
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 14:45:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sQO+FYZX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274927-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274927-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FFD530A08DB
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07325478E57;
	Wed, 15 Jul 2026 12:31:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527C47887A
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 12:31:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118666; cv=none; b=YJ6vn7kTrEoamRQERm/mxDgCfnbY8iywhmExfznFf7DfHTiU1tOr3/CiTUcrFsZzwQOpChHg5/BpxzKJ23K2lGHF3QX2vgwzXzGtEZDNFOWZuc/nAkpV1KbueytXDsLhj6iPsiY9FI2Y5plLNlG3TjekzyyOaNZaT064lgvFsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118666; c=relaxed/simple;
	bh=n69afPvxXMg5pJEtJyjh27rhLIgr92BGrls45LTgHSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cldk9qMD0uChO9HXssqALbOnoDojxeM13i8rhDCH26gMiqguHV4gsHVvcMQrU20tyM/osT7ESBi4czzk9foQsWFM60Kk05H3CospyLTOK9ayO97LbqcSrrgZkrL0SepTVx+ng7SJDjxoUFtRkBcC4LcQbFYBRK9PZwqkDDWsHH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQO+FYZX; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485ef63b68so4884416b3a.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784118664; x=1784723464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FL4DH6iSB8h5Gk2sonUHgNYBuRFyDX29syp4nQdWWD4=;
        b=sQO+FYZXlXwSVXQNNzCrbDjHIO/shqU9KIXF99Rh6myELdKJ1IO2jlm/yBFPePsTqS
         JT6S3Hj7KN8J2FO9Q0CFJH07ILf+c4OresvXfbwt0biaWf9VGTkLc/6PisFxqFmLTm2f
         yAD+w8ETJ6XSZt1BfvGQ4pZUN1MFxuHNBvBFg9jvbmtbWF2829+SZeLH0Xli5fJV6Hpk
         nwMIMZtCTrhvL/R44tEqWSlLiPoG5CbxqljpUeMCxFUyBVvIAlF/m49cty+i95VBAqhM
         X4T39CmwvT9eMTn5cWbz2IsNVip7AJSrdTor4FObMg6MHrSANNyTGRsCdje4LfQ4rxNb
         /E4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784118664; x=1784723464;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FL4DH6iSB8h5Gk2sonUHgNYBuRFyDX29syp4nQdWWD4=;
        b=kFat56hpXRVdPk0Os0cPcS2SwNTwEDCcUgzJIdBM59Y3z7TwmKPDJNqwXmzgUmsXZ6
         9bfMD6Pi1rlkszGM1GjYuIkzVALQogz4+9kNIqOQODy0g2KKmJHEjK8n07neLo+3EJqQ
         19Zi9eoW6yG+vQ9d1B67oOn2fs3CwJbOtKWlOxvy059tp/bfnvRYrorGku8ZMCAvPHSd
         MMlLLMFCviEtxV9ZSrn3YYEKiC+p3uhTbnJJuSa1lzB/HHT6Wfr9f3/+ZYXlSrJ2tcsV
         bHJk4/alqLcF6359CV/fG00dfsIx4XnJIbqBtvttKu7Ib2XCLbV9vYGn9nhz3UBxWGd7
         tfEw==
X-Forwarded-Encrypted: i=1; AHgh+RrkVLeh6WeaMGqPsUbEIgJ0WeIQs+4xyQfYi9W52fqDLYVJxPbnkkQPNPcUXSkcHeaahkGXvjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ylMiOX8UJrFGrTOiMZmCK/amcjJkuFxVuN/kgVwQskPg5cEG
	Qjny6tIoDU2lV0/ScsPZNlgiTf8HVmZLI3Htz8rt8b7JDgRa8N1qY9pS
X-Gm-Gg: AfdE7cnMgLhD5gyDOFzD98FffICapj9eRyrpQmSgLFEfKQTWQCkA0e978OY6O9g8RWI
	w7ZhHIP5BBS95gWm7jV26TS7tE7z4CRzdMHjMnoKXeQeZSnX6+fFk8+V6ikb6OKgAeMk3rKLH9D
	jjaSEA3fZFRxJN9OUy6HXQjVmGqgEjnku6wAG4aEI/J8k5BQrY8uKCqvkiJh3xNRowCBEQB5Ogf
	dd42lGaM0ifBTcD7mYCH8fLvh2NzfSlaOah/i/6eAjtXFftiV2c6N4UkeBGov5pnRZ1aPibKQ1b
	JGFjkF6Pt9KIsAqm+DeGMJeAHEZihhU4QHYvbOXcDdZOEM34OHRMcK+T9ABH6EHXgkiyBtr7qxE
	EPCfVSJznbcrzKZ+p6D/VJj+WSZGVK5B+KS5JsTnaRsnWG4PziwwEcY2fVF/XvNye6HlHXdQCGk
	YgExp5EnEzAwGTVUAz3BrfLNHQSgH98wuJgw==
X-Received: by 2002:a05:6a00:4612:b0:848:2f6e:e52e with SMTP id d2e1a72fcca58-84a5587a0a1mr6247775b3a.66.1784118663610;
        Wed, 15 Jul 2026 05:31:03 -0700 (PDT)
Received: from [10.125.192.114] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dade0sm3092157b3a.46.2026.07.15.05.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 05:31:03 -0700 (PDT)
Message-ID: <7a1fe347-7ca6-4768-9308-420bf1251f54@gmail.com>
Date: Wed, 15 Jul 2026 20:30:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] mm/zswap: Fix global shrinker when memory cgroup is
 disabled
To: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed
 <yosry@kernel.org>, nphamcs@gmail.com
Cc: tj@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@kernel.org, mkoutny@suse.com, chengming.zhou@linux.dev,
 muchun.song@linux.dev, roman.gushchin@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
References: <20260714081510.16895-1-jiahao.kernel@gmail.com>
 <20260714081510.16895-2-jiahao.kernel@gmail.com>
 <CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
 <20260714193129.f81711f516504b659d544741@linux-foundation.org>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20260714193129.f81711f516504b659d544741@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:yosry@kernel.org,m:nphamcs@gmail.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274927-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A40475E4D7
X-Rspamd-Action: no action



On 2026/7/15 10:31, Andrew Morton wrote:
> On Tue, 14 Jul 2026 09:52:59 -0700 Yosry Ahmed <yosry@kernel.org> wrote:
> 
>>> When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
>>> Therefore, the global shrinker shrink_worker() always takes the !memcg
>>> branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up,
>>> so it fails to write back anything.
>>>
>>> Therefore, when memory cgroup is disabled, fall through with the !memcg
>>> branch and shrink the root memcg directly.
>>>
>>> With memcg disabled, shrink_memcg() only returns -ENOENT when the root
>>> LRU is empty, which means the total pages are already below thr. The
>>> loop then safely bails out via the zswap_total_pages() <= thr check.
>>> For any other return value from shrink_memcg(), the loop is guaranteed
>>> to terminate, either after MAX_RECLAIM_RETRIES failures or once the
>>> threshold is met.
>>>
>>> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
>>> Cc: stable@vger.kernel.org
>>> Suggested-by: Nhat Pham <nphamcs@gmail.com>
>>> Acked-by: Nhat Pham <nphamcs@gmail.com>
>>> Acked-by: Yosry Ahmed <yosry@kernel.org>
>>> Reported-by: Yosry Ahmed <yosry@kernel.org>
>>> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
>>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
>>
>> Patch 2 doesn't really depend on this one, right?
>>
>> If that's the case I think this can (and should be) picked up
>> separately as a hotfix. Andrew, WDYT?
> 
> Please update the changelog to clearly describe the userspace-visible
> effects of the bug, thanks.

I am not entirely sure if my understanding is correct here, but maybe I 
should add something like this to the commit message?

When cgroup_disable=memory is used (or with CONFIG_MEMCG=n), the global 
shrinker fails to write back any pages. Consequently, the zswap pool 
fills up to its limit and rejects further storage, preventing memory 
pressure from being offloaded to the backing swap device.

> Also, AI review has flagged several possible issues, all appear to be
> serious:
> 	https://sashiko.dev/#/patchset/20260714081510.16895-1-jiahao.kernel@gmail.com

For AI review comments on this patch:
I suspect this scenario might only exist in theory. For zswap LRU to be 
empty while zswap_total_pages() > thr holds true, it would require a 
prolonged state where there are always more than thr zswap entries on 
the zswap LRU whenever zswap_total_pages() > thr is evaluated, yet the 
zswap LRU happens to be empty during shrink_memcg(root_memcg).

If we want to fix this, perhaps we could do something like this?

Yosry, Nhat, what are your thoughts on this?

diff --git a/mm/zswap.c b/mm/zswap.c
index b5a17ea20237..ca71b517a58d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1356,11 +1356,12 @@ static void shrink_worker(struct work_struct *w)
                 } while (memcg && !mem_cgroup_tryget_online(memcg));
                 spin_unlock(&zswap_shrink_lock);

-               if (!memcg) {
-                       /*
-                        * Continue shrinking without incrementing 
failures if
-                        * we found candidate memcgs in the last tree walk.
-                        */
+               /*
+                * A NULL memcg ends a full hierarchy pass (except when 
memcg is
+                * disabled, where it is always NULL: fall through to 
the root LRU).
+                * Count a failure only if the last pass found no 
candidates.
+                */
+               if (!memcg && !mem_cgroup_disabled()) {
                         if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
                                 break;

@@ -1378,8 +1379,15 @@ static void shrink_worker(struct work_struct *w)
                  * with pages in zswap. Skip this without incrementing 
attempts
                  * and failures.
                  */
-               if (ret == -ENOENT)
+               if (ret == -ENOENT) {
+                       /*
+                        * With memcg disabled the root LRU is the only 
target, so
+                        * we should abort if it has no 
writeback-candidate pages.
+                        */
+                       if (mem_cgroup_disabled())
+                               break;
                         continue;
+               }
                 ++attempts;

                 if (ret && ++failures == MAX_RECLAIM_RETRIES)


Thanks,
Hao

