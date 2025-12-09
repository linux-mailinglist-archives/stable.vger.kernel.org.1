Return-Path: <stable+bounces-200492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1340CCB14CB
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 23:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0764A3012767
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 22:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0AC2EBDF2;
	Tue,  9 Dec 2025 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="nf3TBRKw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629572BD11
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319772; cv=none; b=hhy6bb7a3UHoEUhn/2InmYXOCZois576hVehF7NTZHx+RgNO9znSgc83Bpl7kDo0/7s3SiIx0wSjYGt6rk2D6xn87oNaRELJHrNP2P+p2TTqEB9c/RG84VC275147D+oVdhG4iG9s+H6z+jntqxqUY0ty6fMxntlrUG5Fp+IgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319772; c=relaxed/simple;
	bh=1GfgVhapWgGpkPQS1glpXT8EeTUtczYpWBuPImq24Kc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Ft5wORBbBxuXlHErgV8yDBJEMFYlTD1jbX4mkHVDG9rZokLmzAa3su41IEoy/5VepK3Eoe7PcVC//99Zp2Fh9qvPvlAuRt4nkyFtBkpDeqJj44ZLRhI4Z74qWpNkJ01TiVXVtqp4F4C7qdH4iQRhQbhO7a77svrYmj+ncLkaKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=nf3TBRKw; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso26139385a.0
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 14:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765319769; x=1765924569; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMDjrbgm3fd7/vhfQib/L2JYfPytQjquusIcJU5ydyE=;
        b=nf3TBRKwxqJUN6U+gCXLrSiISy+omCJJ6Twrm3vxAt6pRlI+sQYdK97fjtj4yuB6Pc
         7RDEct3OW/6R6eSWdaISeYsl3KDhdERoc1oCYpzEWagO8ZbWswDQt6dFE9p+N/e13DoL
         vg0a1gRMTXKrevnjb5tOrZjVHWnHj6TuH1W09GLqGAm5CBqBvxmbaPThpSClAr/xeHmg
         qedBxoh7jV53SuovCa9qaOv2HLJx/kLTVcorXC1TLHHIGTAfOOyXXamK0MqyJa334xws
         k9MdESPkxBgiQBXOY9d69PkqCwIFWc3WQwNE8BxejON381bJggUwm9mgmkC0MnNYD80E
         tKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765319769; x=1765924569;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMDjrbgm3fd7/vhfQib/L2JYfPytQjquusIcJU5ydyE=;
        b=r01V6AsWXXJA2SZZuBWPbbrCDhGVealYOfTNP/ydRGHq/5+Z7IhXZbbXgbUvGTe1zR
         JU01jr+g6g4Tk2jBNmVX9mEO4ohIWpyNTrXyeCkkYOGgKur2NzL3AaMWIN5F6ajL0Sii
         wsA2QoWIwPlDBdoAHgozQ6iiGrzfp69i666je8LVQmClrau0nTLYGXiJtPnSvDjRxs5F
         g/odfqQBWK6bGx8BUn5QQf2uAg1aKfn80NYkY2J5YNOgr/1nCSkITBcpy4zt3AXDZkOZ
         qMxv9i2CGY0Qbb+xNcTVtLQNMoFGArnGAsh8GMu8CSpURNUAgJAst2M0VZoYZxdHvWDP
         ZOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0KAccUXu28M+uS5kCAYc1ossY+iu/8/SiZLngb/kJwhHGuBHplto9SIsoX7nYfn4tN5g0swM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdj5iWwQgiIr6MBcrJ8fKlRud83ngr9OSKyNWe5AS9MxSsbTU
	EMnjJ60I7Uxb+FN/3DO3M4URGwGV2KDEBYLaj0e7cbt2xjZs4h4iDUMUUi3yWSz8EJs=
X-Gm-Gg: ASbGnct7MRY114t+jyUAOKJj4SwRGArLppwlQvhsTH15RZAieCoW1pbXRObT5fVw7KH
	3PTV2GfytYiyqzvpobAh4ZVZaI22Go6wjUsEW6ae7f0kQEAEosyY3LVv4rAiZprlkLl9H/j2Nx9
	YKU9P3pNnc/M+uN4W802/Mx8q5odfQ1Y3YAODhg9AJifUbcqzWNjG2TYjXKZiq4UIOh8B5+p9+T
	t/7wrt82TjhCCYBmLxvk3wNnl0nNeh1TN9OzpNk0XYr6woYulqweQEtNzOGLppu85OmHRD8Bq8E
	p9XdzvQ+4alomo9ObYJKNstJBfRypBMtp33tSB8wrcDqUYjUhrXFgKWz73GmFONoLPAhvLmKHSG
	jfV3s805JbPFnjEVdlsFCSwBYv0lsobURKdc0SkWyMSJNpgvkeWsB/5ZMQu/y5SJvL0G13gJ4B0
	p5wDOEijapg8k=
X-Google-Smtp-Source: AGHT+IH1jG12E5R/nTMy7dymzHYKkpW1KBjpQvlMRwy0j7dR++9cpTTnCImcH7gDvx5+yn0+N/TlWg==
X-Received: by 2002:a05:620a:290c:b0:8b2:9b48:605e with SMTP id af79cd13be357-8b9cea84f9cmr416559885a.38.1765319769122;
        Tue, 09 Dec 2025 14:36:09 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ba52550233sm2700885a.14.2025.12.09.14.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 14:36:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Dec 2025 17:36:07 -0500
Message-Id: <DEU1MPG44IHN.LPC4M5HCMXWQ@etsalapatis.com>
Subject: Re: [PATCH sched_ext/for-6.19-fixes] sched_ext: Fix bypass depth
 leak on scx_enable() failure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>
Cc: "Chris Mason" <clm@meta.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <286e6f7787a81239e1ce2989b52391ce@kernel.org>
In-Reply-To: <286e6f7787a81239e1ce2989b52391ce@kernel.org>

On Tue Dec 9, 2025 at 4:04 PM EST, Tejun Heo wrote:
> scx_enable() calls scx_bypass(true) to initialize in bypass mode and then
> scx_bypass(false) on success to exit. If scx_enable() fails during task
> initialization - e.g. scx_cgroup_init() or scx_init_task() returns an err=
or -
> it jumps to err_disable while bypass is still active. scx_disable_workfn(=
)
> then calls scx_bypass(true/false) for its own bypass, leaving the bypass =
depth
> at 1 instead of 0. This causes the system to remain permanently in bypass=
 mode
> after a failed scx_enable().
>
> Failures after task initialization is complete - e.g. scx_tryset_enable_s=
tate()
> at the end - already call scx_bypass(false) before reaching the error pat=
h and
> are not affected. This only affects a subset of failure modes.
>
> Fix it by tracking whether scx_enable() called scx_bypass(true) in a bool=
 and
> having scx_disable_workfn() call an extra scx_bypass(false) to clear it. =
This
> is a temporary measure as the bypass depth will be moved into the sched
> instance, which will make this tracking unnecessary.
>
> Fixes: 8c2090c504e9 ("sched_ext: Initialize in bypass mode")
> Cc: stable@vger.kernel.org # v6.12+
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>


> ---
>  kernel/sched/ext.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -41,6 +41,13 @@ static bool scx_init_task_enabled;
>  static bool scx_switching_all;
>  DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
>
> +/*
> + * Tracks whether scx_enable() called scx_bypass(true). Used to balance =
bypass
> + * depth on enable failure. Will be removed when bypass depth is moved i=
nto the
> + * sched instance.
> + */
> +static bool scx_bypassed_for_enable;
> +
>  static atomic_long_t scx_nr_rejected =3D ATOMIC_LONG_INIT(0);
>  static atomic_long_t scx_hotplug_seq =3D ATOMIC_LONG_INIT(0);
>
> @@ -4318,6 +4325,11 @@ static void scx_disable_workfn(struct kt
>  	scx_dsp_max_batch =3D 0;
>  	free_kick_syncs();
>
> +	if (scx_bypassed_for_enable) {
> +		scx_bypassed_for_enable =3D false;
> +		scx_bypass(false);
> +	}
> +
>  	mutex_unlock(&scx_enable_mutex);
>
>  	WARN_ON_ONCE(scx_set_enable_state(SCX_DISABLED) !=3D SCX_DISABLING);
> @@ -4970,6 +4982,7 @@ static int scx_enable(struct sched_ext_o
>  	 * Init in bypass mode to guarantee forward progress.
>  	 */
>  	scx_bypass(true);
> +	scx_bypassed_for_enable =3D true;
>
>  	for (i =3D SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
>  		if (((void (**)(void))ops)[i])
> @@ -5067,6 +5080,7 @@ static int scx_enable(struct sched_ext_o
>  	scx_task_iter_stop(&sti);
>  	percpu_up_write(&scx_fork_rwsem);
>
> +	scx_bypassed_for_enable =3D false;
>  	scx_bypass(false);
>
>  	if (!scx_tryset_enable_state(SCX_ENABLED, SCX_ENABLING)) {
> --
> tejun


