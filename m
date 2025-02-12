Return-Path: <stable+bounces-115079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51AFA331F8
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 23:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1595B188AE00
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCD220459C;
	Wed, 12 Feb 2025 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHHc6gqq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A32036E9;
	Wed, 12 Feb 2025 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397918; cv=none; b=jur8AowIyCaIq21yMYsl02pC9SiXu6CuhtpabZzdMVr80q4Qm+8Ks7IcziEtNfem96FRDbWSzazcV9/bqlOMITSwKYxp5ZiDoX5lC4Mpfgbarx4pKEjbRQ0n/WRFnUsP1bDEzddX8VoahPFpxtM1m09Zac44z4364VsZMI8Fwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397918; c=relaxed/simple;
	bh=jR8Imfk+/emEWwggsHjMSSH2I2/loBmnfcLAq7i43J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp8bDyg6ahR8zJddTwpQa8nlbvy9myOSJYK9Fwz6ODySy42NLBFysPt9Ida3pSTp6D3oGu5pd1QCGSXz7uQxyYcWPKAjLoaLV4bdcVLjSAM6Z1qFEXvuSCgc2+5PnGduBHm+eRLPfbzlAI5SC6flye6sNUBqTuAtrlTe2g+EDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHHc6gqq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so487690a91.2;
        Wed, 12 Feb 2025 14:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739397917; x=1740002717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eOj7jdTw739Z3O2EZLYaX1Zcx8m73qJ0L/6aXVbYUg8=;
        b=YHHc6gqqBNNabsum/bvF0oe4s9UnfgWG1ikRlI1fc/lJIhSPJTKYJh7SD/DfJn00A3
         wbrCE7D1FbVoiUnad3xThd48jtQDvpnFOgM+DyZOqBGGH0+NLJr4rCuspERaGB0KU36n
         5s4LrlXQUOSsYIJBww+0dE0S9nt+jsZu/AyFTRPbGX0l5+sn1ZM6gz8g2WJRuB2maWPc
         jr8GZQxBFLAIwk/gu2OXWDuStmrOCj6fQKFj8sQdezLXsdJVsN9ukc0CA/Py+EHTXSLX
         5O9P8RnPHlDY6PxxZmxv/K0kWoW4AqP5flqg6puP2jeNDoBkI34EXe7PlOjb40Bizj+2
         ONiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739397917; x=1740002717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOj7jdTw739Z3O2EZLYaX1Zcx8m73qJ0L/6aXVbYUg8=;
        b=F7u5mXRS1YYSXImgQ1rFLofa7e1LdrSw/ObL8W257DTQDoH2IdpJsSZy3rknrXyNZm
         zaBCVSCr+WHfuvpTfXLyZqNvxxEV/H/XI1XlfTA8tXbogYSs5/95WcDlalJtumO21NV0
         LFB4hF4qXPD7Sz+4tl0ywuDU1BYMxx8UhUDznkSghHq/PQdiIGRplI6+CbnKthwV69vF
         o/DdT65MC2jrJ9OwbJR22nwuKkOuvOVMz0CLXBEICsehTraJmk8qzs4e6GOadeFgI3od
         YdRyYAV5bgWW43fBE21im8tyFa9vM106uOQzusZS8J4ADCmkYuKwgH/CwZGk1dmrHBXl
         huFg==
X-Forwarded-Encrypted: i=1; AJvYcCUkiGEHO23WBXa8/lGcdOvPWqR7mhc41BBY40EPMy3YplXVwrYl5v5dpoHozBLYoFJ4AHPccYgt@vger.kernel.org, AJvYcCVhNfHeMXsGqJgr3Kd1XyvTKSt7SGx8MowMUlIVQI/TT1aHxq/A/ulBa29Tk/uU+MrwT88v9/cY@vger.kernel.org, AJvYcCVjeMwTNHovn0yPtX7F0dxRCgPh16L9rwD/ZN4g/aNxvB7xAkifJ1mbEVgVlmeaizEju2aH8HytXbccBE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EN5ltyJ/Cv4gUdCAUbkDuQX9Pjag1xgpX59nPtGDlAvYO2nz
	LGH1QC4iMjZj93C/CmrAPn3iqiIlK4a615+Z+CTfJmtfs21YU30=
X-Gm-Gg: ASbGncsy2kcD/t2n9fLJ3DpDV8TnKricerLe7ddzMaZ0cBPue2o5jkX0VtlolZtAZmV
	X4tr6ZoF+nPK9z7EGSOwE6onV/RL/ezty5hJ/6a3rhbHEZnFaWLcXZcKJV//K8xq4FNI6ZfMbqO
	HP5typw8J6FGue0JEkg6mkb/QlLtKllCL+dAQPN21Sne230WruGymC5E/r8r1QSUJCVv4FxrJkf
	CRV7euRMexJ2E2uw/6oIJ/YbhEHaPetbv/mGtYYVxnc05CxzUjyRLhvEjSBwVDqFT0WSYywwXW6
	/U8ZoGTi/c/QZZA=
X-Google-Smtp-Source: AGHT+IG1z2oLYiVi3UzGihjXVQjsvFy9qEGl58dn4cNX1dguRSWp7c87vBdUozrJtk51epj/oWk6dQ==
X-Received: by 2002:a17:90b:1f87:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-2fbf5c013a6mr7053062a91.13.1739397916637;
        Wed, 12 Feb 2025 14:05:16 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf999b5ddsm1989562a91.37.2025.02.12.14.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:05:16 -0800 (PST)
Date: Wed, 12 Feb 2025 14:05:15 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: disable local BH when scheduling NAPI
Message-ID: <Z60bG180MW5gQ9oy@mini-arch>
References: <20250212-netdevsim-v1-1-20ece94daae8@debian.org>
 <CANn89iKnqeDCrEsa4=vf1XV4N6+FUbfB8S6tXG6n8V+LKGfBEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKnqeDCrEsa4=vf1XV4N6+FUbfB8S6tXG6n8V+LKGfBEg@mail.gmail.com>

On 02/12, Eric Dumazet wrote:
> On Wed, Feb 12, 2025 at 7:34 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > The netdevsim driver was getting NOHZ tick-stop errors during packet
> > transmission due to pending softirq work when calling napi_schedule().
> >
> > This is showing the following message when running netconsole selftest.
> >
> >         NOHZ tick-stop error: local softirq work is pending, handler #08!!!
> >
> > Add local_bh_disable()/enable() around the napi_schedule() call to
> > prevent softirqs from being handled during this xmit.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 3762ec05a9fb ("netdevsim: add NAPI support")
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netdevsim/netdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> > index 42f247cbdceecbadf27f7090c030aa5bd240c18a..6aeb081b06da226ab91c49f53d08f465570877ae 100644
> > --- a/drivers/net/netdevsim/netdev.c
> > +++ b/drivers/net/netdevsim/netdev.c
> > @@ -87,7 +87,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >         if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
> >                 goto out_drop_cnt;
> >
> > +       local_bh_disable();
> >         napi_schedule(&rq->napi);
> > +       local_bh_enable();
> >
> 
> I thought all ndo_start_xmit() were done under local_bh_disable()
> 
> Could you give more details ?

Not 100% sure this patch is the culprit, but looks related:

https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/989901/5-netcons-fragmented-msg-sh/stderr

---
pw-bot: cr

