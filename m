Return-Path: <stable+bounces-230664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBi/NbOTxmkyMAUAu9opvQ
	(envelope-from <stable+bounces-230664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:26:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4513460A2
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CE1E31424A5
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FB93EDAD7;
	Fri, 27 Mar 2026 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdOOhDVs"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233622D7B5
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621134; cv=pass; b=muVa7UZJzgefAtBLhZbc+87+xL9PNrbwj+HMz3NYDoe5/Kfx+ZAkT5LIRxt8m8RrfIWYaPgpt9byEXYsmt1g2GVKMsVzk4Udx1UjnvDfpDjR3O3/9/yUMUbX2ifLFrQMwPBjlhJkQAnk4ws9q4g1cM8bZD6V0Baxb6UNba0X/sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621134; c=relaxed/simple;
	bh=XBeNYYAPuvTVLfkVsUIH7at1IDW3xkmATRGk64v9ems=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sq2Yk8dleuAz6ndGUcAxMwcAUqmxz7Pxw2T00jqE8vlgnbD79bwwbRsdqeTRrnkf0YssR72L6pDOBm8VjPEpZLd3lph6WOEXhX7tFau9K9tdpiZPAgxwQXU8ggQVTzA98mN7spbzPCKGMrDJ/VpZJoUDQf0xQtqVA+/rTCiWb9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdOOhDVs; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad019bbd4so2737333d50.0
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 07:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621132; cv=none;
        d=google.com; s=arc-20240605;
        b=Ot+9lz9fQJCUDrUf6EQH9pGRhVDqmJQi5NPVisZPuWioN/lOdTadzkNr6NjiJADs2c
         pOL2RRM9Ec8uqClpDwm7D17lnP9UtJZ8+Liom1MPDsA0Inm6lfgANu89yDQaRZvdP7Ed
         v2OmTOJzR2YYn+LklJAqCwBKPsNM3+PEQ7a5ZE4TSfBjEqyiYAtwdfWLrzwuvGABzMOn
         GH9zNgvPU3EjcfOi7s0GyeWBVGgaMsHfv+3GEVqFOFv2k+erP1qA3Ec1jfd2328VvFK5
         M5lCjr7eEAoBJXRStIrmY2jm0IolpnRBqByQRHH0+4jQ5jHDIwivzPGIDlHC+aJn/KSp
         vqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XBeNYYAPuvTVLfkVsUIH7at1IDW3xkmATRGk64v9ems=;
        fh=21F0eGBrLjMcvlzG6eW2JD/0dMwCuJ5KddzfWHkFXHM=;
        b=Apd3mBx7PDM1+O6vewSYASG9D1lZez3xk8aoexG9EplVJatURj5PUv8snindziQgkk
         noGYvFxu1jAnpRr7z8RBBST8A8WEunJ2W6d4iJD/5RBWvypGBnL/CWsDqMQptPN/1U4c
         4jSuVm4w1vquxREatxlXSZkhqq1Hu1xf/j3QA5NGF5e8ANv8Q4WzH58RHtiOS5CC5/W4
         m+wcYANev/iD60xlB4s+tPi8N+ber9ik1c348iZJr5dDRg+3l6eSJhBtKHC9jMGxVEDw
         3zAfaZdGx8qjJjp1AGqgeqJr7cZxVWQx/HGht4/cZZw5sZGUdCOTE6uG5xRqsfpfj4z7
         bLEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774621132; x=1775225932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XBeNYYAPuvTVLfkVsUIH7at1IDW3xkmATRGk64v9ems=;
        b=LdOOhDVsY7bavNkRLtlLOv+XSgwGyO60kx4bNMSRUxnveeDB4WdRLsU5ADkodNf5OG
         AzCHWddaw56SPz5STyl/Zo+Cp4yHuqkFY1OQ89L3HrzLEkKmRVfQ/xepw8SpQd5ISdi0
         lFlO+OPouK18Gu3MtnttfxYR5imiAjjSaMLvQfXht+EYpw5MjDDObmDvm35A32GlmNN7
         SLh5Uo7bI6Q1XrlXPz4Goo416512nctTcfBwLwbwRWWpJ4R3qbtinC1EKT22XZm8cWXL
         hT/6XgukYsQ2piLVpObOE0ji8KKnfeAdotCycPSK8XUCI6yAA2LNFaR1VJeT5uuBBXiM
         +V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621132; x=1775225932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBeNYYAPuvTVLfkVsUIH7at1IDW3xkmATRGk64v9ems=;
        b=MqY4k67zMEJX9ShptbnIB/Y1IwWDhR113+IOVTFKQP8408J+SZGUZaYepsx4vYtxHx
         sgdiLYYHGKsWy90BKrkxdVtOwzjnQOPiD7+guN5YyLWRvIUFMD9S7/stbXYaWXDCvfr0
         VMHy0d8McG/BenJRyxQiofsUixlsdjCoptklHu/Tz6cANx8PnW3ve5jLKXNvMHQTvHSi
         hjb0lQzzo4OqelgPUMRjk1lN0f3zpUscHzhLtYaouamKBvJrZuo16GKtAzhVQZOlSOdg
         26jTWkJLBKYD7Yavasg513mVDjTfiGSYG6bVhRxJm5CzY4X2BsZ1r9CVAFW9QnnpdAGw
         HHzw==
X-Forwarded-Encrypted: i=1; AJvYcCVXluJHoh7K4jCUsj1v4VvwrWSCzV0i93zKKQNE6Wlypb5n1a45K3umACgfiC2OpEdumbpaLkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNYydp0m5Iu4BPXqspo52hgqaW9QUdDH3pnv0FEcO/32X83QD
	LxDfcHX4kOm/l5DXv+TTqHccRhmgcSh4sH4v9qkeyjiyS35f4X0CvJdewkcq4LAvPidzypANbTr
	efWxCNyExtzWwOoml3ElYqgk2KKND8ho=
X-Gm-Gg: ATEYQzzVWvpoFflp2AgurzOXmeroSdMGIdb5Q9d9lpGQu8KVycsUm1pC7WrmeHHRlcH
	KLXGOrH4E1M29zqfTVgyQKrVx92Rk3dMolfsGD5fbT9mY4fUf8NtXbVi6qAIOiRKey94K+7hD3P
	C0ABhWMG+iBEksliUUImu7KLkpZjfJOVBg3Mmz6DaSeAaa4L7kuu6FRGZKl5s+WWOmTDHD3scP3
	0d4E69xhIxl4o5fY1huf+YpSFVhh3LQNLF71PtoLOeimbMxyg6sdMcOQUQbcqnE6jIzmmbsa8mw
	Wv/Ep3FAIMvWycseTAXIDYNK9xmhqnwBX2rhAqc=
X-Received: by 2002:a05:690c:dc5:b0:79b:e346:980c with SMTP id
 00721157ae682-79be346ad82mr15997857b3.12.1774621131864; Fri, 27 Mar 2026
 07:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877bqxsin3.wl-tiwai@suse.de> <20260327120149.18076-1-nonameblank007@gmail.com>
 <2026032724-reveal-oblivion-e2db@gregkh>
In-Reply-To: <2026032724-reveal-oblivion-e2db@gregkh>
From: NonameBlank007 <nonameblank007@gmail.com>
Date: Fri, 27 Mar 2026 19:48:40 +0530
X-Gm-Features: AQROBzCKNRLstHR6F4FP-syhuDsHhOD5gFeylEfoElrad0J6z27hgVliAz8oEkI
Message-ID: <CAJ9UwXAYD2PwdBnt=hFKkbKUTm9kY8zXacAgE6zXDKOLhBKmKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ALSA: hda/realtek: add quirk for HP Victus 15-fb0xxx
To: Greg KH <greg@kroah.com>
Cc: tiwai@suse.de, linux-sound@vger.kernel.org, stable@vger.kernel.org, 
	tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230664-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonameblank007@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kroah.com:email]
X-Rspamd-Queue-Id: 6B4513460A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Really sorry about that it's my first time and i wasn't aware of such case.

I changed it because of this,

> >
> > Please use a real name or a known identity for Signed-off-by line as
it's a legal requirement.
> >
> >
> > thanks,
> >
> > Takashi
>

I apologise for the trouble caused, and would be mindful next time.

Thanks,

Sourav


On Fri, 27 Mar 2026 at 18:16, Greg KH <greg@kroah.com> wrote:
>
> On Fri, Mar 27, 2026 at 05:31:49PM +0530, Sourav Nayak wrote:
> > From: NonameBlank007 <nonameblank007@gmail.com>
>
> This doesn't seem to match:
>
> > Signed-off-by: Sourav Nayak <nonameblank007@gmail.com>
>
> ^that :(
>

