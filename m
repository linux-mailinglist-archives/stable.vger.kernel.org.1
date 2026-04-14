Return-Path: <stable+bounces-237966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMpEETie3mlrGQAAu9opvQ
	(envelope-from <stable+bounces-237966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 22:06:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5C83FE3FF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 22:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D68CB302398B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 20:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219EA221D89;
	Tue, 14 Apr 2026 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ack8CKSh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwyiF/RQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC16B39FD4
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197171; cv=none; b=i1EdHxGtwTDhKcmZahCOagPoaqmyACxcI7v/kjSedknKUq9jlCyOmA2Zim4GBHj4N+Kh+NyV0Y080bs59Tg6wab0C/ZYgTglzRp/YFEf+E7mP6mHivtS0lAO6ulTLNKWk3908pLSbttlXaD7Nm253OJ21fPCAsw2bZ2jqfgH8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197171; c=relaxed/simple;
	bh=Dp0+Ssh1K3boeKKgn5yK72BHQcL+OqEVaNq1MEz8SWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce3DQv8fxIbM5IH0HFsNr3ThU8qxSa8FnbGykJdHAUsRWeLsoWNKR4BOX6lYUI2j9PgTctALhRZ1eCx1y0d85pKDDD9Dx3P5CNYYQoWoiTI9q+v+XIpwHreRYE2UMXEvdqIKxCDSXiLViwYSOCBLdWqLf43atTDlkQmx6EVPhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ack8CKSh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwyiF/RQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776197169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEXRhk5IofRA90cdU2Hp7IbZZuVGkK6cyhq8G9bcFWk=;
	b=Ack8CKSh6FOBSBv8mYVRsGqJYr0tLsslhBssW7E+c+cs5CK/GYqvHzRdc8MiAbT9WGLh9t
	LfT1RDaWdVCKUUMINN6uA0Y4SMWFp4dvBWlLE1DaFfaoVVEx41NOurW2JBj0q1J8DflEXR
	aIPCv60K6nvagnCOx5ZRbmr7Bbh8CmE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-VFMFtaIRPNK5w60IozC8ng-1; Tue, 14 Apr 2026 16:06:08 -0400
X-MC-Unique: VFMFtaIRPNK5w60IozC8ng-1
X-Mimecast-MFC-AGG-ID: VFMFtaIRPNK5w60IozC8ng_1776197168
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b323c43fdso106013871cf.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776197168; x=1776801968; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEXRhk5IofRA90cdU2Hp7IbZZuVGkK6cyhq8G9bcFWk=;
        b=JwyiF/RQAkoJ2Xw9Pfcpm03a5bTOYXmTIhLGNZ3pCoDpd0El3Jh1OIp1GxbEtsbKT8
         1Fe6GkDEE4HrrYsWFL8n/t5IJe+ekb709W17s8rl8Rao2c+kV1e6WyMRDjOoF5IsPQcV
         HKFskQvueTb/JxblRKrKBHmxhCMB5xGSHSxmqs6BCBxt1oK20DDfiPIe6KMc54EPa5e4
         n2YiQbC7+yhKDFBuy9XZOGZlTF49qYgtP+fp6EwYa7rTHPNifUppNFaIfsaIQqWcgQsE
         P9f+yASndW4Z3VP9ydQgRNQL34X+1omnvVcZBw2SCcsdW+ZpjlH0SWYEmU+NAZvOqICy
         sS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776197168; x=1776801968;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEXRhk5IofRA90cdU2Hp7IbZZuVGkK6cyhq8G9bcFWk=;
        b=sWp36VR52KhWF0km3i1o9hYgtesfxYFt5ck8N9mIJRnV1J9UpY316HrZOPZTP3Uhd3
         Wq+Vv5GYxTekXva2f+B8uugajVsWjNg+ed5oOpe/Grkm8hf5hptZy22pIMn0WLpN3Res
         yd0Ip746N2PDMjMqbqRjBihH4rL8DkqeRGd66MBnkQhY4ZrrCkUWgbrfRsL/EdyPBrAt
         QL/hq2+499vf5+b+JMUJ0dpMtGpdIX/pVuEW69tQjPm8m1SE1E5Kqe61ieUnSx0s4bpS
         92DwY3i5sEAiVTgRiVQ5Fhg1WJW3AAWSNkM2qLVGugKFTUSWYnwu4nh4WM+1U4PqzL1/
         XoDw==
X-Forwarded-Encrypted: i=1; AFNElJ9r8WU1+AUWubIl22ZwTx22psNMWfib63fl7BrzzgVnhnoH/ozEpD6Hvz3cA3RL96TV0kSMMfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jqbIwCh1O/ZzuIY3+06QoVnGCfzfJ0S60QGG3MA7jmVIu4yz
	fOZn/qeuOmDrYS7B8B93xT0Im8BNe0LG0mhYX0LWigVcxvP3YMpsABEC8F7wMwsYbtrntJ8YQ58
	kv+AQEBL/BaBhEOzT9x29VjJOaERT9R27o5HWXBrRxYafsEWtXsNuje79fg==
X-Gm-Gg: AeBDieuiBXWU7D6sslZvEjo6QZy8ltFj7/1CYazGYt79ptIJWsoLrO5Ow7vdMPdm3u5
	Y6k4FYHxPn2Dz6umXkVZMYbQfxsipSFgnPd5Mi3vagUT9BIWQHOrQXsYcRdsgfUaziuUVDpL9Iq
	PG4QmXsy0XVNrMIfU3Ukh+mKT9MDwSBeoiu+uzwvBRmVrYfiovglWVZ6RuhKTmiRwTh9fleUYQu
	tRw4atIxC834pBro0MX91b7mkDCNzuMsHYiJm4XjwT261BkUkhOvnSV1V6JayCVoeh5V8h9UmDP
	YfGyqOFEcme53K2QwXmF62hd0Fs12q/1x5r6gtAYwm7cJSX7UTulQnjF0Us2/1+/BuCy/rlAfof
	Gfr8cNMG6QUnsfkcVZpMM
X-Received: by 2002:a05:622a:513:b0:50d:6865:82c9 with SMTP id d75a77b69052e-50e135a3d50mr37242461cf.10.1776197167770;
        Tue, 14 Apr 2026 13:06:07 -0700 (PDT)
X-Received: by 2002:a05:622a:513:b0:50d:6865:82c9 with SMTP id d75a77b69052e-50e135a3d50mr37241511cf.10.1776197167167;
        Tue, 14 Apr 2026 13:06:07 -0700 (PDT)
Received: from redhat.com ([2600:382:8116:76c6:c5b1:9485:5da8:de42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50df2f4fa51sm69907041cf.5.2026.04.14.13.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:06:06 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:06:03 -0400
From: Brian Masney <bmasney@redhat.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-mips@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] clk: eyeq: fix memory leak in eqc_auxdev_create()
 error path
Message-ID: <ad6eK7wQF8M6sRLG@redhat.com>
References: <20260412124247.2494971-1-lgs201920130244@gmail.com>
 <ad0c8y1u5zAhheJX@redhat.com>
 <CANUHTR-9HYnCuavM9O_wcVg3VuDyV4zQH4P9jYhViBj_PbYV9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR-9HYnCuavM9O_wcVg3VuDyV4zQH4P9jYhViBj_PbYV9A@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-237966-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF5C83FE3FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 07:49:31PM +0800, Guangshuo Li wrote:
> Hi Brian,
> 
> Thanks for reviewing.
> 
> On Tue, 14 Apr 2026 at 00:42, Brian Masney <bmasney@redhat.com> wrote:
> >
> > There is a leak in the error path here as well. I think this code
> > should be converted to devm_kzalloc().
> >
> > There is no devm_kzalloc_obj() yet, however according to [1] that should
> > be coming soon.
> >
> > [1] https://lore.kernel.org/lkml/20260330154108.GA3389518@killaraus.ideasonboard.com/
> >
> > Brian
> >
> 
> I may be missing something, but I think the auxiliary_device_add() error
> path is already handled here:
> 
> ret = auxiliary_device_add(adev);
> if (ret)
>         auxiliary_device_uninit(adev);
> 
> The auxiliary device also has:
> 
> adev->dev.release = eqc_auxdev_release;
> 
> with:
> 
> static void eqc_auxdev_release(struct device *dev)
> {
>         struct auxiliary_device *adev = to_auxiliary_dev(dev);
> 
>         kfree(adev);
> }
> 
> So my understanding was that after a successful auxiliary_device_init(),
> the auxiliary_device_add() failure path should be cleaned up through
> auxiliary_device_uninit(), which would eventually invoke the release
> callback and free adev.
> 
> The leak I was trying to fix is only the auxiliary_device_init() failure
> path, where the function returns directly before that cleanup path is
> available.
> 
> Please let me know if I overlooked something.

You are right. Sorry about that. My original suggestion still applies
though to move over to the devm variant since that'll allow you to
remove the release callback.

Brian


