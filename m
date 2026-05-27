Return-Path: <stable+bounces-254622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKMWHocXF2px3wcAu9opvQ
	(envelope-from <stable+bounces-254622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:10:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1CD5E7807
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496D6307DFF1
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F13D79E3;
	Wed, 27 May 2026 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="p3PoEzqv"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE5382298
	for <stable@vger.kernel.org>; Wed, 27 May 2026 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897812; cv=none; b=tTGYBeUVGWnQPpnlCilq3Pe/xQpJMdVVrWO9VIG2JHQ8UsdJ7cpZZUuefJAsZ55VBqDMydpuUxKkR/sQ+X8su/Sstd6zLCTQiYY1R4MkijoYKTPFbisrL5xn63d8W3ED8qa25wc+jN4YjuCJWIBTMCx5CcFjvEWZ8rQHxW3XrH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897812; c=relaxed/simple;
	bh=jfHYVvAv2KLPbWszFU9UWn6gSBGjDMujZa9kYNQiUyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSdTIApOTihn90vYiCTOTZeT6GxEbD/UHKc5cVnogTgCM3oSOi+Jh60wYPjB4iMb5+rU3cZJfMYk2HJTdFXrSCQeCixQxVQiDgrsRfv5DyZX+EtzNkw5iqBPospbmVW6fbXGbFhtrcVyzZDub+dLaQMU9mBzeP98F9s4V0sk3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=p3PoEzqv; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-439712b3416so4155209fac.2
        for <stable@vger.kernel.org>; Wed, 27 May 2026 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779897809; x=1780502609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gntijPqsvuiGRryRGaewxCELZ5a6Qr0krHV7SCIDMB4=;
        b=p3PoEzqvIwCDKqu1d2DE3TstqFbMSY6eCzEUZ4nAjFKTII7VwecNYGybvd8CjXKkC3
         tsupMB/EID6Aa2HQeld19Q3tlb2tUw8wfiMKcODRX1Y6d6GEKvv4g6tprpxzq/YzwO2B
         gXeMDo5zxBSGLho53SSlLAn0B2rDXwcFzs+S5K939WEcgO5+DE0T0oJUZO4CSqnf7tA9
         8BxHBE+WPwFLpQd1aVCL3T89ed8GUP79mY17chmOQWYDx28TS7o2ju0jadAWemuyQJ3z
         PqJp2cEqb5XVt4hcD13u5AqmxVszUsy8oviQCzXSJbpOSiS1/WwddFRRuBDymuKCC6EI
         6hOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897809; x=1780502609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gntijPqsvuiGRryRGaewxCELZ5a6Qr0krHV7SCIDMB4=;
        b=A7wBPiDh94xZkFEiDeMA9JapxSsFHR9exYng9TRDBQ1QjcJbwlU1qOD7EUQM7CaNzg
         26aWP1v2prm6pdsCWdzoKDWdLwiN/6Bf5bpdaF0UkQRkyHlY1r86IteWDV4xXnYfKhJa
         7wZn0YzN/x3WL+mWF0JOXz7CWdtF7kSga6HakvUwsh4jk1J8I3qxO1II3WZwFtq6jsON
         /irPduCGQ5d55uNErILNdHmWuX07iZw4gDPR99+NQ21+KTWaHD/yTIk0IL7gg8p8e2/y
         MIJ21owmcJ3AmWbVj64GC3Hd2upoufTF65xJfMqXbgkkr6jwD/2E+B5dbZOp9ftHepWe
         0wvw==
X-Forwarded-Encrypted: i=1; AFNElJ/cJp8b4ksWeS3UeDVErHHr4ruMQtA0/iqK7Xy1vdkYWxTrwI5tWCjlEJHkvFi5fjYqpTEU4B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAsDAy3wAuwSKVYLJctO27xKfU7IiBZxizPrARngLvXQciV0i
	HXGZjZeeCtMqBnGBT465GQYVKgUz5+1Lepqn3yymBflFiWSe1a4KuHGDtvtmxXyo61s=
X-Gm-Gg: Acq92OFJpJTuajk5QInDei7VwNtgYCpWbmhYpq2maHX6+iR069PWqI39sTXhuwUWLIO
	w+dNAMUckbCc7rj8A6wV45y+6EaCTbKVrrmcqTxsqKdSkuf5XcfkxiUI/Wu17hZo/uedwLiE++B
	PvZHKwQKRepwxOfViQckXy///iGsxwPpxXMDZBIEpI1otBt9xzEGqaPKvXZ9EyK1jL49UggIBxy
	fSIDesBiXvKNAHcn73jJVjOGk6ZF2XGhauJ6w2Mlm+OkrCSEau4Bz/4xoUFQJNLirZ/5ZNmzdiO
	IsJgwBUceQbuawth1pxr2ygpCQRAF0aK+cPCdQkEv9KtJSVlj0LdCukBGjTfAJJ97xSSgiFKDiR
	yX23Oth31c84KCziRn6ii9NRbLSo8G8EZOjWztBPW3tcILrsr4xFADKHH/GNSSQAytWvNxMoRaT
	Rl9+N5HUHPu1dneD0uM+ZSDRUjAp3fgozZXsV9enV2q+/cAXIIh7ex/Mlr6HBCRlsAGhdCL9v8w
	tYAFBmM6e4zd/G6IlE=
X-Received: by 2002:a05:6871:4390:b0:43a:f95e:cf14 with SMTP id 586e51a60fabf-43b5aaed6f2mr14617454fac.12.1779897808999;
        Wed, 27 May 2026 09:03:28 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639f3609sm16097799fac.13.2026.05.27.09.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 09:03:27 -0700 (PDT)
Message-ID: <919d86f3-1164-4084-9f72-d3ead0522c5e@kernel.dk>
Date: Wed, 27 May 2026 10:03:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/io-wq: re-check IO_WQ_BIT_EXIT for each linked
 work item
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, io-uring@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260527143726.1272269-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260527143726.1272269-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254622-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: CF1CD5E7807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 8:37 AM, Runyu Xiao wrote:
> Commit bdf0bf73006e ("io_uring/io-wq: check IO_WQ_BIT_EXIT inside work
> run loop") fixed the obvious case where io_worker_handle_work() took one
> exit-bit snapshot before draining pending work, but the fix stops one
> level too early.
> 
> io_worker_handle_work() now re-checks IO_WQ_BIT_EXIT in its outer work
> run loop, yet it still snapshots that bit once before processing a
> whole dependent linked-work chain. If io_wq_exit_start() sets
> IO_WQ_BIT_EXIT after the first linked item has started, the remaining
> linked items can still reuse stale do_kill = false, skip
> IO_WQ_WORK_CANCEL, and continue running after exit has begun.
> 
> That means the previous fix did not fully eliminate the exit-latency
> problem; it only narrowed it to linked chains. A long or slow linked
> chain can still keep io-wq exit waiting for work that should already
> have been canceled.
> 
> The issue was found on Linux v6.18.21 by our static-analysis tool,
> which flagged linked-work loops that snapshot shared exit state
> outside per-item cancel decisions, and was then confirmed by manual
> auditing of io_worker_handle_work(). It was later reproduced with a
> QEMU no-device validation selftest that preserved the same contract:
> a three-node unbound linked chain, an exit actor setting
> IO_WQ_BIT_EXIT after work1, and slow post-exit linked work. With a
> 3000 ms delay injected into each post-exit item, the buggy path
> spends about 6066 ms after exit running work2/work3, while the fixed
> path cancels both and finishes in about 2 ms.
> 
> Re-check test_bit(IO_WQ_BIT_EXIT, &wq->state) for each iteration of the
> dependent-link loop, right before deciding whether to cancel the
> current work item. That closes the remaining stale-snapshot window and
> prevents linked post-exit work from stretching shutdown latency.

I think this change makes sense to further cut down on the time, but you
need to send it in for the _upstream_ kernel, stable only does backports
of those. Eg if you send this one for current -git and mark it fixing
the correct upstream commit (not the stable one) and add CC stable, then
it'll wind up in stable as well.

-- 
Jens Axboe

