Return-Path: <stable+bounces-179648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A301BB58475
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 20:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1684C4C25
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BB82DCF6A;
	Mon, 15 Sep 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VyAopmCP"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D82C2354
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960471; cv=none; b=idoGHJ7ZKD84XfzpoTzxh4tyPUrAVw5vscFxeYRP4m4DF6i1B40oWN6FpQPJCCPBzVBY3dVxndrQ5yIuU12Celhb3IkdLekC8JZ2sfFCVzTld59JVq3Xn+ZLF1NCNZ/p3sejrtXnPq571z200wlTk/PBp3KVra/K9iGy9FfOwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960471; c=relaxed/simple;
	bh=0aDdECbcFnvzK6gvTk++iDWF1gYYmeS5TIpHZBB7Yb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtHXyFVNP76v91t3+Y6eiiI/yNGWFSaoaAacmGlzuoIpOWjkiO8WsVq2WDNGZDXeNdM3Uia71SUapePG8p2Wi3Ejz/SmNxz3FtjD6O1RXahVTZbtq7kUptUdyMbF7a5K9f2jTfhtHJui425GnWkVX2JdFVKAWiEtOAewbiQSdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VyAopmCP; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d60157747so31903277b3.0
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757960469; x=1758565269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+GliT1Pd8d53HWEdMQBU1YHyq1rnSI3P+2j/fil2q0=;
        b=VyAopmCPFu7azUOHo0iM0H7C1iay8VW3m34YkV5/b7mkIrzNgdYj5gIB3MfbOgXNdw
         An1WLWvxpwHETRBOl6tExv14asHr/pcrwj+azTUyrRbWDdskINTs5rsmOapntNqNXL95
         t81vuvAhPUOVXnTPbrGYMDEg5e3GgK/d72EbDKkpXRHbEahmQtKj5f/MPk/JGqiHY7Pq
         En+4QRjrwFfGtSEBIVtYCHLnbd1yI+elNGt3Lf9l0fJMxlbjMhQIfYtIIsyzRsBAdvNH
         TG6/v5FypG6rdlO1ex/QEMEoZhYXH47Yn/9WI67xG2S1GDFt4p3nCwKGtO8N1hyud4OA
         XhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960469; x=1758565269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+GliT1Pd8d53HWEdMQBU1YHyq1rnSI3P+2j/fil2q0=;
        b=eLeTdkadIWB72ZW1RwbDk0xhdG4DrGD+lI1s6zXDwfqy/azaCEALQkrkWLIrRMVKCt
         qmW9LqSECIKhB9ei+Iuyuc9raH7eMxNlTVlWh+jSiMhSWDowjURiLM+vvaIrw0ZxaBy+
         aKDa8z91II5hFuCD4DI/YOZwr6Ex4KHEOzIZSubvUZ8UmdQECO9jmXnUPONWrQ44hBMB
         RxuY/aq6DxYnX9DYwg1Muvrh1gtcXY6+a+Yl78o0+nb7LN8jaKJATllbRsJMqh3VvYqi
         ycBQGTupKwuZeR5QdBmypVXjDnOZwd1cMd44YGmhbJeSWKKJeMNYPRhVSYT+lKxMizqR
         5Q1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXO281xlICEnDn73ibUbLZNIvurbAEMgZZBPcz6Mr1nOaCzPxotFe0WhkbSOorkMvVuaFyz9d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoomXjqUl+3ErIgS0jXcQkS8XYZFg4IRe/xHW0IfJxc2nW6gN7
	N9SyabQ8QeNGnzdgpOaHMhilwuQ656zjfQH2vekyBnvsv9D+JG23jDjqYAvBIe2UHh46W8lgATD
	8ED54uD0YgLCCZvkk04Zi49U43vv6ygHiHnJu+8Lung==
X-Gm-Gg: ASbGncvCNssf9hTUWvXrQhXemfx24YOwAosJeJNtuYKkrKPXrvg8Zx37Yx8Smp/m8yB
	/ce9QRRciV6kqGdpEUThBcMHev9bNOKJZiEJ5V7AFRAWcD0H3q4n6qeXIL7yUHP8ebnm3PrK5aA
	mViEmJ7eXsNAaxQGC1c4YfxcfBH+QM0mWPQd6hLsr0OPPRrel9Txf8sM1xHCgKYOVgMBhWJp00V
	Vx5zdCxd/b9aP8=
X-Google-Smtp-Source: AGHT+IEDp5ZYxkbjon4yCrRZanz3ywO+1Dqvmg43vzDGc4l+oL6FL33NrpAa1korZr0/WJwLYzGBFv1kfMtD4v4LVjo=
X-Received: by 2002:a05:690c:9c0c:b0:71c:1a46:48d5 with SMTP id
 00721157ae682-73063480b69mr133022797b3.21.1757960468639; Mon, 15 Sep 2025
 11:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8957c526-d05c-4c0d-bfed-0eb6e6d2476c@linux.ibm.com>
 <BAEAC2F7-7D7F-49E4-AB21-10FC0E4BF5F3@linux.ibm.com> <CAHSKhteHC26yXVFtjgdanfM7+vsOVZ+HHWnBYD01A4eiRHibVQ@mail.gmail.com>
 <240A7968-D530-4135-856A-CE90D269D5E6@linux.ibm.com> <20250915142612.1412769A80-agordeev@linux.ibm.com>
In-Reply-To: <20250915142612.1412769A80-agordeev@linux.ibm.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Tue, 16 Sep 2025 02:20:55 +0800
X-Gm-Features: Ac12FXz4gtGN6Jqt9p3sI4NDKpM8RKfj3WgCz5dLwYdzbiuc_wRBtKzbSNJCafg
Message-ID: <CAHSKhtc-514tQoyCSukK1sLbDbc+Ne_TnwEks-h+gQWv8ZKHOA@mail.gmail.com>
Subject: Re: [External] Re: [linux-next20250911]Kernel OOPs while running
 generic/256 on Pmem device
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Venkat <venkat88@linux.ibm.com>, tj@kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org, songmuchun@bytedance.com, shakeelb@google.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mhocko@suse.com, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, riteshh@linux.ibm.com, 
	ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	cgroups@vger.kernel.org, linux-mm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 10:26=E2=80=AFPM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Mon, Sep 15, 2025 at 07:49:26PM +0530, Venkat wrote:
> > Hello,
> >
> > Thanks for the fix. This is fixing the reported issue.
> >
> > While sending out the patch please add below tag as well.
> >
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
> And Reported-by as well, if I may add ;)
>

I'd like to but I will resend the whole patch which is used to address
another issue.  Thanks a lot for reporting anyway =E2=80=94 it=E2=80=99s ve=
ry helpful!
> > Regards,
> > Venkat.
>
> Thanks!


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

