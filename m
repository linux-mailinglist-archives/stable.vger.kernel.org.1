Return-Path: <stable+bounces-237822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGYvMW8o3mmSoQkAu9opvQ
	(envelope-from <stable+bounces-237822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:43:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF203F9849
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51EF330233CF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C13D9DBB;
	Tue, 14 Apr 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfUlFGtV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AA311C01
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166337; cv=pass; b=kDVu8wA+460cXZc6AtellvCkePfC6cgUbCN9cWMB4Ww0euO7T04Nf1ySuN0mQiyCrdqW367LRLzoZ/LEfKsHYQj4T7nfTeAwToHWyyfMJC9m0oLZ/gkw0M57qSlES0feGPxrLEKd1FM+Wbj+/zWZKr4vJEztJRR39csJNOIuKuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166337; c=relaxed/simple;
	bh=lKY/EklFM+5be35Y3m02myuR6oeB0yZ/lLUv0J2WmQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ2qJbREQd9gCppwEe98twiua9BYtJs9x1Md2ZAXIbugLrN++vjHHekf/UWjMOCo2C+syTsRiGMsoYpKsuwlhyO9lnjaUFn4nGbLYLlx4q4jQMGlUdC4MwfGa5c8GXgoAmKemgCerKRK2MsvxBxwkaDDY0/V+SnuHjVm002htWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfUlFGtV; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65006c99d38so5510491d50.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 04:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776166335; cv=none;
        d=google.com; s=arc-20240605;
        b=UkwoSJzUOx6jiHX2l1cFAHznDxrxKDYY5eFYwWZ2ER6bTkQ322lpiKoulCpzWiQEh4
         6aAyw9i3Kyu/7TSq5QCawtrBaByYn4624wxpgXqQXRJ2ctJ07TO82i+f1Llj2/VbDfjZ
         LmzTu7ysWel7ZWakF8da+Jo8FEn4DEpl1wEthQnup6TxLWGpFXRLolP3q6wB08NyXjpV
         gnnr3No9t7eWv00XSbZ/kVuv3Yhq2N8Trn6s1JJybrr0/KQL8S45Me23xVnNPEtaHvfo
         RKw2HxDvU1YvfVU6hDZ96ZGaoceELfARi3nvPLOA+uNvkNXlpoHr+UFF0o6pRIshOgzs
         p4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+bTIS9Ff7oNz+BUqaUlih568fHReftNV88TLzUyJwng=;
        fh=QMyu7e7CF+hHItvnEMHXywjVSimkDJKkkoQbDDvxJ7g=;
        b=HxDyKYTZc54JKqgprAOW+Vq/YPDrTNMay0PPsLmuM5a7cn5o0vjzR48xTG6Ek8Qd/N
         mU5AxR6k+1024/kgoZ9nfu2zA8/XY+5vd1Kj1AGMG/PRZUaihRoyxXArl+zyFOgJVgS1
         bOERAs1BbK5EM7WNRnCQfNDmn4qiogKqSlmjuBf4wM43xpRBX07vhIRbbdj0xPm7Xmla
         DAQUvco/ZOppU/JcMzXkntVAaOBIx5Sy8ALwTpb0vE7jIjlPe2436WgmK4AwJkeIkp6n
         i2jPHhCqU9QdSqYCWa5nRE3P5xLkouLGEhRcmJCwyeRQVRCfvkAj5r68XMJTLU80PdDy
         1BuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776166335; x=1776771135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+bTIS9Ff7oNz+BUqaUlih568fHReftNV88TLzUyJwng=;
        b=JfUlFGtVj0ePoHtdAWBPfZHKVD3ckwKg+n9gZtlljLGffGWsVHaoxC13jqetyWgBi/
         ktkTg+tub7CRzGMjt0Y+BswfhuhMxVYdUINYbPQUR7MBnwwZEJk27LT312PGaR4GhM/E
         0639cbyoWB8SB7riu5U1HBG3v2scxDOK/P/OXhEhoUd6pU9PF03R7LA4RP0+k0ZCm0cO
         xPHFZ+7PqXfFyttf5Rc/r6IOuvdu4xmudq4cVsa3vnN2adzrWdozqhY3kKB9XZqdhys8
         WIIpISfVOEyBYojqFeGBlVazBVoZyc6NABwgwZ/AmlO3Mzyl7vZFwGi1pq0kYCx12dvn
         DTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776166335; x=1776771135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bTIS9Ff7oNz+BUqaUlih568fHReftNV88TLzUyJwng=;
        b=W7NVVXOP2ke6DJqLV5vnSCRPDMHrtAF9wTTaMrrP58zO8e9wABDkhs8l8hYv3og8jQ
         jL15QfgUeVjZE45dRQh0lgowl2tYwy9XL2ujiVUTGW5MfadItWtUgfmf7PV53d3wvV1l
         xZBomCxXoqAPQfWXk6zThlOEaDHnC1p5Q+X4ZlOZ5dU4VlL73csC/Gb2nEdfLp4nj6UL
         yj9rFaZcitlX0JsZ7Q7VwY9LklgQ1nv5goWo7B5QA2rYbGPONQbQljpTv1/MDejv1KuF
         nsDmUJqCufcvR7T3zoRZ7ZGAs6/x0ylZZ/sN89YIuvtxIKKOckJp2rUBtGxR6NoIzZ8E
         m4QQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Va93Fn/gMRW2JERcjUaBPKiO7q2a9WqIRbtA/LaLePCnCpL8IFnKWeSrJQLoeVf4gPH9VWqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzv0sy17+nHYQTH8/U9rXM0akREIRomsAeYhruxQ/SH7db+ODy
	KArsaaawIuWwsVCqCsuOp2SrlQYJhQp1+R5ijfzUZb0kBfIFjwpCja24YFbaZcYgvcaB7ZUQ5WP
	5PtugE41Y459X1c5wJSQcpawyGVDRcUg=
X-Gm-Gg: AeBDietkk7SQrSoispf5ipc50j2KXxleh6Kh7NCSOktx8A2T7Hf40DtnTHFiYBUr8sT
	F6oLP5nNP9PoqZWZ/Mq5f49C1sEJoiF/hikrpHEemSB6gqEJih+u1HoDISGQIznrW44LDzaLJJ9
	lYVRTxbLCGJXDiLQrVwe0NTk5qyKon5wGIaAVG3qW1BCSn8CtzfcTt4wRC6IS+NjLCZsb92En2a
	TKiVCNtuWr48l0a0RxMY1QRQFjEs1xBabDWlHtDr9mv73VXQCAcmBGEj+6o5mCpTV1XwfWa6Zhb
	DVc4VSP8zw==
X-Received: by 2002:a05:690e:480b:b0:651:8a68:fb78 with SMTP id
 956f58d0204a3-65198b424c6mr11727973d50.42.1776166334829; Tue, 14 Apr 2026
 04:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413141759.2970973-1-lgs201920130244@gmail.com> <fr4y8h4f.fsf@damenly.org>
In-Reply-To: <fr4y8h4f.fsf@damenly.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 14 Apr 2026 19:32:07 +0800
X-Gm-Features: AQROBzCy8qvUI8vREcwULIsW07vz8KcvpopsqIhu_hpiQ_vDXUWtaN1qguAj5A4
Message-ID: <CANUHTR-G1X5OBXQNiw8-mXGiugnuP8ryHcsrMXLKcD4VefuKmw@mail.gmail.com>
Subject: Re: [PATCH v2] md: fix kobject reference leak in md_import_device()
To: Su Yue <l@damenly.org>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[damenly.org:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-237822-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.257];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,damenly.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3EF203F9849
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi Su,

Thanks for reviewing.

On Tue, 14 Apr 2026 at 09:29, Su Yue <l@damenly.org> wrote:
> Why not just:
>
> out_blkdev_put:
>         kobject_put(&rdev->kobj);
>         fput(rdev->bdev_file);
> out_clear_rdev:
>         md_rdev_clear(rdev);
> out_free_rdev:
>         kfree(rdev);
>         return ERR_PTR(err);
>
> --
> Su

I wonder if that ordering might cause a problem.

After kobject_init(&rdev->kobj, &rdev_ktype), kobject_put(&rdev->kobj)
may immediately drop the last reference and run the release callback
from rdev_ktype:

static const struct kobj_type rdev_ktype = {
        .release        = rdev_free,
        .sysfs_ops      = &rdev_sysfs_ops,
        .default_groups = rdev_default_groups,
};

static void rdev_free(struct kobject *ko)
{
        struct md_rdev *rdev = container_of(ko, struct md_rdev, kobj);
        kfree(rdev);
}

So in:

out_blkdev_put:
        kobject_put(&rdev->kobj);
        fput(rdev->bdev_file);

it seems possible that kobject_put() would already free rdev via
rdev_free(), and then fput(rdev->bdev_file) would dereference rdev
after free.

That was why I changed it to:

out_blkdev_put:
        fput(rdev->bdev_file);
        md_rdev_clear(rdev);
        kobject_put(&rdev->kobj);
        return ERR_PTR(err);

so that the cleanup which still needs rdev is done before
kobject_put(), and this path returns directly instead of falling
through to the old kfree(rdev) path.

Please let me know if I overlooked something.

Thanks,
Guangshuo

