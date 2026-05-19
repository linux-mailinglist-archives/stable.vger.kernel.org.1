Return-Path: <stable+bounces-249587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFtDNu9hDGpXggUAu9opvQ
	(envelope-from <stable+bounces-249587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:13:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E614D57F5EF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61D0A300AD6E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF423340401;
	Tue, 19 May 2026 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9dY94Yf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EAB3403F2
	for <stable@vger.kernel.org>; Tue, 19 May 2026 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195916; cv=pass; b=PPGA4fwqWAgDbW2OsWq9DDp1DCnkxQHM7wiypN4V+3JuEpiP1U0iuKFh1x0SZ0rBt9Ga5LfnRY/VTlXeJSrHGZ6sik8EbRghQHO50CxdA1H2Kh+UHDtf+vRfQ0pQFdwHcOB8NNpY5B+g/U/wFfEoclHo7kGV9a8Y53K7RF+4XHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195916; c=relaxed/simple;
	bh=iaGZMeTECKLgSkXvhPAEh2PSUA5sCaWUAcRY8LGcVek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBeN5qENp8moA+2MFuK4HT4UB79d2ycJnyxPs1/44G6JjqnJnHvuZ1TbPrvZ05igtjuW4PJ4BVX7x1y86+9F+gqAy2/qjt9YWO/noEhm4SySXWcaBHnrIfgJVGbZxIEZCBsgH/S2HmI1M610OoL4Z6+f6B7AxNHStAZGVal4MLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9dY94Yf; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dd73b7c757so1734248a34.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 06:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779195914; cv=none;
        d=google.com; s=arc-20240605;
        b=XA6FTrO3k1wtiTjdFLoc3G8gwDFz6jCOoSY/+Kxp6R41uYsWa4VmgScPaD4xplnDR/
         BM3WvLQK9SMrmfjFYXsSTPKUliy7PFFrAX2MVMLtD0nHw1N73OTPH7inCffmeEnUZEsU
         dOIkJ9IG5PD1oPo4DOG5gKfb8lnfAO5Audr1dRiLzLlMoDI6ZbvAZQY5xYS/PvaCyFaS
         UssE8luHrV4Ynvj78MXJmwrZmBeKlldQZCUKWI7ih5kZam2noSfgSK/G12apgBroj7Fp
         UEyH3Ept3mrjV51MQoQuPxQtIfoXLDSmuN6XOP0Gf5i+DZpAfZkAn+f1Q98n6KqWLAfr
         Ze2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TjyeZ+mSATOr/oLHbZdmIDYIxgcfoHII5fmcydeHYjc=;
        fh=ltOybDYxq4CHgs9xj65K7x+cCIWA9NHEk3RaA8pBAd8=;
        b=c4Ca2mKjWtA2hlA/QknqNSzCq77XzlEb2HZTmJ4IJoFd3MAw/uT5CzkJuxBQdNQQ1R
         qt7HmtPVtoYPQAMaN8zB/yaQlU3tc5qqZWzfHx9yRT1v6s9lebsoEO+wMfEVe1SOukJr
         jMkW+u65lqjoA3WDBVxxraEHXeITO9+JsDKsY3nKJyshOH20liRWmcI46imNZ3/zwpYg
         ErnH3iaGVziuSnHsuO2ftz7d9N+C991J6S5EAbJKPH1MTLu1pXY+mj/XerjO9MBcoGpO
         LrdgvbXgtI+B9KHH20MXa+f23IhEz6Cx1ym6TlJAo0pNlAAM1XslRWxqQvT3bdwFPIEX
         Lh/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779195914; x=1779800714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjyeZ+mSATOr/oLHbZdmIDYIxgcfoHII5fmcydeHYjc=;
        b=f9dY94YfPV6xzUBEpSIYvLRVOkNNmpoXIWmggyBiGkCaQckXoH/YmKlRPAvRSKCBEL
         Xp1XxRgJpFFTIjVlcB2j/znmnYMDkrBXxz0/Q/m0ZWiPufTxp1Bc7Or54xxMo6mBcGj1
         zrrzONEpH3em8VZ3Pu3TmmurStVt8CPQM8LloHADQSZ7HxhroyUO50YHZ2NXt9fMQCY2
         TeS2jiWs5R5KZhF2Zm5ESW80cP9hDw8v3rquImaylb4Kukj+wUg5egpndM4drYh+Gs2C
         OaCYQ1oo2lG0fi25405DErU89s5BTVG//pRuHJcklToMD1FsTa1ptvcb+VfdLJm9neE6
         1CRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779195914; x=1779800714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TjyeZ+mSATOr/oLHbZdmIDYIxgcfoHII5fmcydeHYjc=;
        b=RfrvMe787hneiIr5F8NQ3u8gYG+BsrQfECdy2nOnyFGSiKTBLku29n/KLNvtT4XlMj
         EHwVXo1WY18Iv85fLFpWDCWVP6PnrdvbjXUb2rPB8l9j/UClB2HEmjGCG9QyuOfR/8Rl
         BzdPFQkRI7LcHv2GMzO7F8plfVEB1gh7MyjmeaPRp6r+U2rmJQGW2QDNqAxKDFdz4jcu
         eFTB7e0C7dJnZaFCUABCw9g6TpZWh2eTrpXlxHiLZz861vdnXogWmVVTd5BiS3qsR0JK
         4CPqteRq6ecVnqoD8Eur5pHAfLROs4NfRVVIjcw2ze89XkEEr87z6U0LP3cVGfkflDh8
         GzLw==
X-Gm-Message-State: AOJu0YwPZ+FJ/jmFjpoQ3jX2tbCnexB3ZM8zxAQXQi8SErJ+a7oHvhWX
	Ng5c5o3LS3GJXlkn6nHRw/1N7feZ6hWb/q7laQnqI049BaQcOk6AoO1ejLU0j6wgvRhuuG0YkYP
	VYNEq8VKpxvSrzxPVBDO//niWGg7d7No=
X-Gm-Gg: Acq92OGhoXuxLcby3KomTa/ML3vauLaZbxFi63e1ysWCiCRiM//COPiK9vZh5S2AYPK
	EtQYqkNRTzILK4mNkmyB2UKgG1UV3XDnkvpG7sgrxDZ1hekXd2Vbq1h1UdHoE6+WU6Pm+0TPQmf
	yCgQ2CYEsTPPnaDXJ9HCNJRux4CKCrNUmhKPJWz8JObdBJ9zqnVyr9VpKpA3ooG1DVcIDesspNV
	a9dExMVZhjmdKZRVUxLaqMoRiPFjXi0H6dAsbC86F6HUA34kO6NIphzBryyW4lMU2st8YA9VCgj
	o0DOkIRzZQ==
X-Received: by 2002:a9d:454c:0:b0:7e5:b3f6:c6ad with SMTP id
 46e09a7af769-7e5b3f6dde6mr1978777a34.4.1779195914046; Tue, 19 May 2026
 06:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 19 May 2026 18:05:00 +0500
X-Gm-Features: AVHnY4KCjg5xnLKDTpF_UzV8orViAi1sRvhjRQeLBblOdok117UByI2OEfFaxHs
Message-ID: <CABXGCsM_YJ+UY86yFJF-jBcbQXRoc0qnSw0saaGWnaSYWG0mmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix recursive ww_mutex acquire in amdgpu_devcoredump_format
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-249587-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,ffwll.ch,linaro.org,lists.linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: E614D57F5EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 29, 2026 at 7:37=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> When dumping IB contents from a hung job, amdgpu_devcoredump_format()
> acquires the VM root PD's reservation lock via amdgpu_vm_lock_by_pasid()
> and then, for each IB referenced by the job, calls amdgpu_bo_reserve()
> on the BO that backs the IB.  Both reservations are taken on
> reservation_ww_class_mutex objects but neither uses a ww_acquire_ctx,
> which trips lockdep:
>
>   WARNING: possible recursive locking detected
>   --------------------------------------------
>   kworker/u128:0 is trying to acquire lock:
>   ffff88838b16e1f0 (reservation_ww_class_mutex){+.+.}-{4:4},
>     at: amdgpu_devcoredump_format+0x1594/0x23f0 [amdgpu]
>
>   but task is already holding lock:
>   ffff8882f82681f0 (reservation_ww_class_mutex){+.+.}-{4:4},
>     at: amdgpu_devcoredump_format+0x1594/0x23f0 [amdgpu]
>
>    Possible unsafe locking scenario:
>          CPU0
>          ----
>     lock(reservation_ww_class_mutex);
>     lock(reservation_ww_class_mutex);
>
>    *** DEADLOCK ***
>    May be due to missing lock nesting notation
>
>   Workqueue: events_unbound amdgpu_devcoredump_deferred_work [amdgpu]
>   Call Trace:
>    __ww_mutex_lock.constprop.0
>    ww_mutex_lock
>    amdgpu_bo_reserve
>    amdgpu_devcoredump_format+0x1594 [amdgpu]
>    amdgpu_devcoredump_deferred_work+0xea [amdgpu]
>    process_one_work
>    worker_thread
>    kthread
>

Friendly ping. Pierre-Eric, Christian, Alex =E2=80=94 any thoughts on this =
fix?

Happy to spin a v2 with any review feedback. One thing I'm aware of:
the `Cc: stable@vger.kernel.org # 7.1` tag is probably unnecessary
since the regression only landed in 7.1-rc1 and the fix will reach 7.1
final naturally via drm-fixes; I can drop it in v2 if preferred.

--=20
Best Regards,
Mike Gavrilov.

