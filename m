Return-Path: <stable+bounces-253625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WElXDB1ID2r5IgYAu9opvQ
	(envelope-from <stable+bounces-253625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:59:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C095AAB4A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81DC63004621
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89110368D7A;
	Thu, 21 May 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kv3phExO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37533F54B7
	for <stable@vger.kernel.org>; Thu, 21 May 2026 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386385; cv=pass; b=ioXDbxak2uEvo3lXuOGNlBZBdH6CJi5phKRZ4ta2jRxHbu04qB0bm/3nRAatTy4nRDCFvmWrAV4/bZr4PHkXkD1giQNxgNKoJ1QuhFXfwRV2AZYxtdBBv6YmQV29g0DHJjDi3mH3EJOgmVm2gZQWaDy66k8U6bAgpS2dIaZylEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386385; c=relaxed/simple;
	bh=2XlcrqYwh/tcTuBrkPI/x13X9seNIkqUvfrzLePc1OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YN3ulWoTcH3U/Uv/zVHJW4LU2qC+E3/k5gy8H7tP0haASp9jxr6NMAUR8viNCnrGSrRlz8J1YSGhe2prHgNhEApj7yxIluNRTt8s7msmZQBxLkGVtOaZRQCxKwGI0+S9gzXyZswq7sVou/C6LCG1eRbKpGVMAPzuQiqAuI2gXSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kv3phExO; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1353c2f35cfso19028833c88.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 10:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779386381; cv=none;
        d=google.com; s=arc-20240605;
        b=Xi7npjum2dKSrI5kJPu3ZCrjfYgwRjvLNgaoZyq1lScrY2IbG7yXMYMa76bTr1lR+M
         0jTltM6rCKV173wRK+2YMNPVzd2AgNgk5YfsXV2CNoVAiBJCgDMawU0TOuEnP/LpJAjl
         jtRiRkMMuTYpdyb+m0ZfCY9WgtxZNxs2qsDMAHOzDKYk+6ut332UlLIxYKcm7l4QcxCU
         qz4RQnPQv8LkAI5FQ/Saa2+3xAQtvmpTugXtj/UtlpuP8WUnyHAMErXj5+39IveAAs4t
         E3UDcJcdSmQTMEJZ+XR+hMOdrq94RjQBQXtliAOzNknMb/doCUyaHMpZKrGouDU7BbE4
         2/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2XlcrqYwh/tcTuBrkPI/x13X9seNIkqUvfrzLePc1OM=;
        fh=A2XY8r+xd+yI6ksxatOEAJwLQaqi+BmHzBIBkhN3RS4=;
        b=Yty6hpwdk9aO4mNCknlHbTyIVdFvO6uygBktJZCwv4VzBhNolZweWajHMcnA9O7Gyy
         cojH7wdl0HiuOUi0b0hoRd/aAFgMS3psEZurS1EyMHYTw4I3Gjj71B0fJr+S+aP0Vg3G
         reQ92TkFgDS0ZA0bdnihaULJq4KjC0dIplWtWcPq+zflK8KBwcS+iriLnzyRMpK2BeB1
         pdL9Ru0PzF4qa4+fOZhBPe8RBgM2kLbhh/xOcEbKt4JEkqWYVLBremR7Y0af8zCzzzRC
         GGbWb3uLqxX1nilIcwe23KeKvx/TZHJCL3PwGqmR0uyUVVoo9wW0TYja4k9K6kmtKAXj
         MT5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779386381; x=1779991181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XlcrqYwh/tcTuBrkPI/x13X9seNIkqUvfrzLePc1OM=;
        b=kv3phExO1m1VF2JL+2poDoL04F7pLIXx2QC1l9OUC4WNWj87+cDJJ3dKWTs2sMkALH
         ZHIzVlsDqZRLATk7HOjZm46UahAGY8tP3DCKal67M3yoXyrALQspwgD1D8t9air0LkHc
         UZVxeXOUw4WQJHKgO5MQuinWq6nRP/Ao2+dNWSjM0/DexiDiuK3mFEsaHU4tlrot3B7U
         +MBWXFeqbTuR29Kl/gihTdo+4FjdFI+eSE6t1UBlwNR5oJ+lMsukp4U8vSCb8gtCYTjE
         hldG9nYDhpXsDrkIov5TYbqHYnlTxB423PADIBz3GI8gxtKZPTN34YZrXwuRo4Kzwh56
         HHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779386381; x=1779991181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2XlcrqYwh/tcTuBrkPI/x13X9seNIkqUvfrzLePc1OM=;
        b=LyoE6tSBoj49/iuHi5gkFCdgfypOfB4lF1p1EHfScrnnSNqQSBk8f8LNnOHMBs3R/L
         MTWOCjwSIayIyz0K9va6zkdt+O4KGIPWtQ1shdzhI87myY4cNvvZE6C2RdKQTXNmmK85
         vvX1lY9KqdSgg/J6yFrqxZTKtpJd3lGh+tcFLl4RufDz939xBY5VetLuBaGAewBe1gqt
         bxW+nXYwsgbqRwJCgIDvxovUaMDzYmt1cEKsZw9wE4wqewyCchiON/oidy7pSUZGDxFf
         0X2ASBcLO0pyXLVoPF6YpqklLAlpimwOgYCAXBGP8YrxzQbone1y7m8L3icRh+T4nou6
         IN7A==
X-Forwarded-Encrypted: i=1; AFNElJ+8MR8TiajPFsdiOXTL7ZKLp3YVn/jFrhUsKcvQSqyubiEs72gMSQRze82VijCTWzlq0JXCvxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhn3KsIxkDgZfMDESvEc669/prmTJqwV9fki9p/PrXa7ylT6c1
	ogGYxW3Ir7vR03jr8IOfiEvuETDo/dsSWMARP5C2wBiSHgE6NOXprCX+Ps02oGQid33HQH1cdhI
	p49fffZYJdN7H/08/Xdi8jVdBZGkTcvwzKSNBhIc=
X-Gm-Gg: Acq92OG/MB88n4f097TzC8CgNEaZmz/NuN62lkj29MLyvhWraEYEJetlvStoumiTzOO
	Br/3W8GL1P+OmPvOAnh0SncMWknxsHgKDIRV/HixXkHniyedGizKZmIZBkSq2sxCAonyOVvbjyw
	jAhsixMT1NHUviIIKVhZ0n85JRVrj8vPu3hvYTt9dbCXq3B43kU55plfJ6EOO1FIrmDp92IRjTQ
	SSf97Gv2pvUJNuh9f+lTFx8+5yH25KyQJfExvKGyHFSJcLOJ02nPBHJq9XdHvsqWEdhUixMKhmc
	+vbpLZPZs0m+Vt4P5rjSbETywgJVZ4uWuVm58/LNR9dgZ/VFJPg/IaRQXPad/b12lMgzLvwE+Zx
	xfb23H9Yixh9h2I9d19/dio1nXX823A6kXPH0bowulc7jPg==
X-Received: by 2002:a05:7022:f908:b0:12c:6da8:856d with SMTP id
 a92af1059eb24-1365fb53575mr16057c88.26.1779386380625; Thu, 21 May 2026
 10:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162134.554764788@linuxfoundation.org> <20260520162135.687777470@linuxfoundation.org>
 <CANDhNCpZWMk6GWubK8+E0rxKUqtuhOtrjqxunS=Kmho-UbR0UA@mail.gmail.com> <20260521-sched-proxy-6.18-drop-sashal@kernel.org>
In-Reply-To: <20260521-sched-proxy-6.18-drop-sashal@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 May 2026 10:59:28 -0700
X-Gm-Features: AVHnY4L2di6RLsg6hTSyZtoiuJUxzmHc2ryKHNDbKyp5-1JHqVFZiuqAbMqAzb8
Message-ID: <CANDhNCo2qx4fHB6sKUyYLjBDuWpL_i_6b_6odg5_q5rjn9m-rw@mail.gmail.com>
Subject: Re: [PATCH 6.18 052/957] sched: Make class_schedulers avoid pushing
 current, and get rid of proxy_tag_curr()
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253625-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jstultz@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D8C095AAB4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 5:56=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
> On Wed, May 20, 2026 at 11:32:26AM -0700, John Stultz wrote:
> > Eh, I'm not sure of the urgency of this going back to 6.18-stable, and
> > I'm not sure its worth the churn.
> > [...]
> > So I'm just not sure this is worth the churn/risk.
>
> Dropped from the 6.18 queue.
>
> Note we have it queued for 7.0 as well; since your note here only
> named 6.18 I'm leaving 7.0 alone for now -- shout if you'd like that
> dropped too.

I'm ambivalent there. I think it is fine for 7.0 and that has a
shorter lifetime, so the risk is bounded better.

thanks
-john

