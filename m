Return-Path: <stable+bounces-270223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JK/5EKZPRWq8+QoAu9opvQ
	(envelope-from <stable+bounces-270223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 19:34:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2766F0618
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 19:34:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hF98tdGx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270223-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270223-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B0B302A696
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099D549251C;
	Wed,  1 Jul 2026 17:33:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435F382F1A
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 17:33:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927229; cv=pass; b=abYiD4TsmU/T03QHAaBB5u528/VT5X15U5YJ8uPRS0qObLaLSmnIy537nGuheua+8PT0zOf/IsBeyJn7I629W8yxxEsEeV8Itz1d50k1OIuogtCLfkf1xxi8m/tOmVtv9c3Y5XKRLO0KJqiJHlfDTZFfB8zeA4nKosUuukk0pw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927229; c=relaxed/simple;
	bh=p5R67W3mQFUj88EQqP8gtF/p9rFiSzUfpWVxgBJBTzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtXb1n/NcqBsvoCNEcJHcDtgIJFTV1SHZ/lb5mw8Ao3n1Gww3s15mPV4aaU7aa3Emuhmv4xvmKPwI2MIfvzHqh9avr4aDBN+Sn0rZotJ4m+xkuCtJwHrCBZ3auYpSbhoPooIQfPDJsNRqfteskC375KOFzOPbCwOogGAGc1u6E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF98tdGx; arc=pass smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso618598f8f.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 10:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782927227; cv=none;
        d=google.com; s=arc-20260327;
        b=U+ARGmIwLH9P3LnCUX8EUD7GnHbmDQBxEaSfuEKl5jgpcPtSVKblB+QAfZ2aNu7S26
         G6jYdMK/wqyeNBj3Ph7riLvNuLekeMJfICcvCV8UojIiSqau4I+if4I33ufyMc9wj679
         A1g34GgpGnzPraW9AQX3N5SppckPid2k5+nA+ZetT1LDDhHHelYAYqy8I7ARZpxrDVCB
         8laNIB1kKFWmRn6my74ADJsyGvLq7N86El4xOE8xYSPQT45Tibdhqgi5py/52KcZ8tkW
         GgZCaKWreMDRxmjkHFS31zXXoRM7LzbNdRxZ2S/fe7DZAbt0MkbjY/Ex0/9rLEmFcfau
         EVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BLYniQWTkrnaZMuzcboN6JdTfeobG7HIxzFb5zfv/DI=;
        fh=2bBSIV9fjhOUGPjaC3O4C/pIYdqVSzBzJXIcf67DQfE=;
        b=INyV/fbBRc1NVUKKAGjZ3t7dsCXXvTPK7Piht6CQ7eDPC5voC5YbMpEloVtzhofxJB
         rjGSZBO/v0i6nGFVrBlQr/7sA+n9ZzxRGzd6TdUv9m/edmV5vPUNLmHwlTO5+7N/VlqG
         OwR4xmoKx4gLIdeQou9BfteGzExExk5bTQfRd1WNbyY0bSvTlTisrb6ZZXOz5cZzatCt
         wLfj9T2ANLbj3urZh0sx/GYTlUvZ6DxOrY1U5QIz1RtIBxQXTkJv6mO1sV2bOjDDLU/T
         whNxiSXu8XiCAR/Pt/1BMhEpQOKroxKb572ktvqlwwRHxydip8lL5PHt56f/SEuxzKN1
         dVcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782927227; x=1783532027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLYniQWTkrnaZMuzcboN6JdTfeobG7HIxzFb5zfv/DI=;
        b=hF98tdGxMGoDxdpgvHB37c2b1GxURIUIEhT3M6rmyoH2ElaKOujbRwzZkc6VYmDlAg
         bhZkqRBpL+1r2OOqY3RIxeC/VS+kbx6RRIdoVGdVpTwUtnC5MWD0L/bcwcjw59ZqI3ZK
         ZT7uCZx2z0GdhywvHTTaiZGnzWGqt3FP33oPCIT8E18M7ewO8vx5D+fkbbcPJgvZqFZT
         HMkUWQxN02pG5OvJey9yl0yKg2rkGVps67nUOB195b9pCVDT/xTb57l6MMReKF4Y0+3Y
         p2Eqj6jxSDDTY35JkiRSNV9KGrAbA3AMT0TAVWuufC8aTuk1MH7mTkX9AlLYNYaFVlSq
         aslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782927227; x=1783532027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BLYniQWTkrnaZMuzcboN6JdTfeobG7HIxzFb5zfv/DI=;
        b=Wm94F4nd/JcukvI5nxDCZr21bd1WZEkgvF7fd8PCGPpTb9XBg4jRwl251zaOqm5KBO
         Ef9Q59/2qjqy67jTiiMtPqliekMcLGrebbtisq9gQeXkgD5EMIqsyYkr/9GLR1/QC18X
         HHMmlT+Jd52OD/7DXWU2aqrMqWX5MftHSBy9p2PsI8JbUQaA8vXLDelxTy3ATxb/kJNO
         xk37wF47s+UTxwp+1pTEQCb4jeB1Xfn7ID463BU12LIlYAw+ewxLW6pIVQMbRcJ+kx1S
         nDQdmStMD8OgppjxCKqc1vO6LrNewXt7QJHeK/azttGELSLyOFn/Dp6tj0M05oyjYTPR
         FbQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNVIGDAqed3Jc3ys/d42vfNbHxDRJLBVGIWy8DB4Bt+zRfgy+g5qJQgboMnlcKVKM3I8wYWvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbozRq2W7XT3yNjmLCRmvDhPh2sxiY3JMrVVRCfP0ZBsWisOdH
	1A9H83aXQcpMVU6iB+JutkaM3/KcxHPCfpdjVbMl6gI6upCyyxrJFlql4GBxtbju50lxI46Kbc3
	R9MvDTzabPImWxSM422uDnTy0jLbTyxDyhs4u
X-Gm-Gg: AfdE7cnJ1DmAMiGVgkBreEeofKgvsoW3Q2Is/Az5o+5n88x2lWM9LKQDIJBRiC37Rd2
	Vwb3fL+4FZUOFklN7yshrSBgBX47/04FEkS5GQmSzCVPtWdHvRg5RCgZmF2z7UegRmEF1sztqGB
	EKgRZeWDbRWRmCI8ovi9bRQ5LHSyEwwUE43oduI004L6UT2usYYvk4Sj/qtRDOuEL6GwP4FcNJy
	eBvft5uOayCwAsnCub6Kq3ftPtwvT1vyM0XhMq309q0TCzVSTIZqbJJmd0nV+FutLJL1bQewlaz
	BOOEZ4D2EN1MF7COQrTZLJx9WkEO
X-Received: by 2002:a05:6000:4694:b0:477:80fa:f462 with SMTP id
 ffacd0b85a97d-47780faf939mr2424022f8f.35.1782927226685; Wed, 01 Jul 2026
 10:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629112032.20423-1-jiahao.kernel@gmail.com>
 <20260629112032.20423-2-jiahao.kernel@gmail.com> <CAKEwX=MniM-4-aV17aH3UiDd_Xd2RH743fFZaxEnYX9qvnokeA@mail.gmail.com>
 <fe15eb9f-0b6c-dcaa-d0a7-5f08c3f92bfb@gmail.com>
In-Reply-To: <fe15eb9f-0b6c-dcaa-d0a7-5f08c3f92bfb@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 1 Jul 2026 10:33:34 -0700
X-Gm-Features: AVVi8Cdct_XjHaPzkM59ofcoatqWxjHDMf7QaZzgYToPCg0_6braxznx6KIBQEo
Message-ID: <CAKEwX=MH+0yixjrbTR3aOE7V0MH=GAP9yKzHGqHizNZm0DBbZQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: yosry@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:yosry@kernel.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:stable@vger.kernel.org,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270223-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F2766F0618

On Tue, Jun 30, 2026 at 3:51=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
>
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 4b5149173b0e..9d4f19fc440e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1361,11 +1361,12 @@ static void shrink_worker(struct work_struct *w)
>                  } while (memcg && !mem_cgroup_tryget_online(memcg));
>                  spin_unlock(&zswap_shrink_lock);
>
> -               if (!memcg) {
> -                       /*
> -                        * Continue shrinking without incrementing
> failures if
> -                        * we found candidate memcgs in the last tree wal=
k.
> -                        */
> +               /*
> +                * A NULL memcg ends a full hierarchy pass (except when
> memcg is
> +                * disabled, where it is always NULL: fall through to
> the root LRU).
> +                * Count a failure only if the pass found no candidates.
> +                */
> +               if (!memcg && !mem_cgroup_disabled()) {
>                          if (!attempts && ++failures =3D=3D MAX_RECLAIM_R=
ETRIES)
>                                  break;
>

With Yosry's suggestion:

Acked-by: Nhat Pham <nphamcs@gmail.com>

