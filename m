Return-Path: <stable+bounces-237965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMUkHT2e3mlrGQAAu9opvQ
	(envelope-from <stable+bounces-237965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 22:06:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B750F3FE407
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 22:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B88793071737
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7949221257E;
	Tue, 14 Apr 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCIEganP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsFAEeb7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F519CD0A
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197129; cv=none; b=nvRFzvrFHgOO909WvVWaL0ukgM96kaIAlqtbW4xxoYlsMVCNw3GbNac29l5RcHQ5Nymr+ij/b0HUIdsKLRljoTT5miXwXUIQ9NjnA3c3xQmtiEz0VQHibQx+PD5lpfTadVV1kWHiJPvhSNkRr1IY1TS53bnOzwTqy5DQmMoCSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197129; c=relaxed/simple;
	bh=aATsalV8/1i5L0VFh3YiF/WCOnaKmuUJPAwqHhi9cLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDWk8PBZsULt3j1HM/eFLrT9txdL1PkKYjYkEigL0KlqRhSMApQmGK81OzGxZ5avFEYAXG56RZ8CO0IxmzdHIY/M59PMF9p4xZQLawyhMdDErEmMd7yV7Csz+zIUXD5NwBLt42cbOoeK7r5xT1mhyYGJz4O3SrQ43BujR4nkgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCIEganP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsFAEeb7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776197127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HT80x0fa49gU1qS9LZMVanLH0BXd2Tg/W3HJgvxGomA=;
	b=WCIEganPs3ZHtiaBxmD9r25ZS30UnsnRLlMESZXMxnNvU4EPMYe70wqMnjAa1LGxRYY9O8
	CPN0jW1Kz+LUUl9Eqjb5bRbB1tGvzaLmYjfSNr34q6zm2MI0zCMZerv4E0f5JpanYXStYN
	jsqCSlkkCuM18MhhuodamErOY8Zqg4c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-Y6vLkTeUN3C1-lFDtnjMTQ-1; Tue, 14 Apr 2026 16:05:25 -0400
X-MC-Unique: Y6vLkTeUN3C1-lFDtnjMTQ-1
X-Mimecast-MFC-AGG-ID: Y6vLkTeUN3C1-lFDtnjMTQ_1776197125
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89fa878662bso116411356d6.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776197125; x=1776801925; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT80x0fa49gU1qS9LZMVanLH0BXd2Tg/W3HJgvxGomA=;
        b=hsFAEeb71FPX7kuYWvXNf1awhqcCZs9utsLMZXUCQEZmEhd8eSKa1Kiuo+DbcTJmDC
         VMDIChPZ8eiXuERXkH1dzJ6U7v/pGb0jAt+RuLbaYIjQUm/CicyolUltzaQxySAZDWhs
         gjuc5M+IdlGdupgtBeV/CA9EaGXDU2Ugq07BTCHkdbNX7OXPE+s879M/GTvVbMH9lPLp
         OVY9+GhBcZKQoG7ltBo91kzy8N6dBhmVmDfs0jFbokyR/Be38R7+A7yudcmjp/XW/aq1
         IkfhqUVtuc6l2P/Ixm9md8BIqeBqaXcwFCKH8cmfGPVVmRAtH1xJoxwGlBvMWNZP/HEi
         8ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776197125; x=1776801925;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HT80x0fa49gU1qS9LZMVanLH0BXd2Tg/W3HJgvxGomA=;
        b=M4F01Pg5XNx97R+Zcq7yPRnkYJfKEdZOPNqm/pvmkCpVNyiMv2l+7mWksXOr0hf+b+
         ceJZQbgsdH1ZzU1f6tjZfjd0aDhFg089Vjbl3XnDwmpT+s69wu7BQ1/3+bCOGCNS4hlb
         ejcbe73a2RPIBuk4AVHi7v/0jL36BnC2/KnKw3QqePv76AocEytAFjFoqxc+m+IH+WGT
         HlAme4SkCkhdnXtceoHmFZ//TbimuhMe+WPg02cL1EjC0UIB7k7Cpxej8JM457hVJ2wF
         VuxPdka4cI3YhLn+iTYI0sfJ3GE5shAMEpeXpdtOXZCcpPKdCjt74rl4I4r1s+He3sux
         tp+w==
X-Forwarded-Encrypted: i=1; AFNElJ/0R+ZVUjTaxYuNx+oKwim+Xfh7zDpyPR0Z/oY35UX3n90dMZk6nezpbYNHdm+y6Xp8IlFCoqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWOhoJWvjewcuuqJ3nipalhdqhF1HDsWH6reVqaZMD1QHnFGU
	PMmhx++3fto2DxFlpuj7V25iEYsswt+o3Hc2IBMLFfBzsq/+b9Rj3+xPDQXoxW28B3P/fGrR49n
	sr4+zWsjVwF1YYywKTgRGSHt582ahLPaZfnyGpDxsMNA48wDF7VJ8UChEog==
X-Gm-Gg: AeBDieuYSTkchkOU0kNv/jLZk4v2D5HbfmJEoNkOJX6rIz42I5ED8Mp8UhYMqIN5PzC
	eYES7NxFj6rwgo3uskNR0gZutabe/o9yT8YqhDyvclZYDi2FY416VykBLZlEYk9QFiTci8M2bnV
	Btmx68xZUM60xlQAE1t64E8LgdOYJh0WnmrhhxibGnX5mbcj2YjXC8UeA9TP2K5GXYwhO3b8TIg
	RmxdGVHHS2BqQOlbfzsHiXOKoj8A2wYu/ti1WEW4wUqynqHpCpk4oK5Bctfp7f1Q31qzf3NDALo
	GNxJ/8zQQ1nxegtZdl2s81iImgMZNCNXyt4ou0sHQWYMzu19nlSELguTTnTMIaUSZg2KGqcBDAB
	qOQ5cdL+LGk67avAPt1oY
X-Received: by 2002:a0c:e001:0:b0:8ac:a546:775f with SMTP id 6a1803df08f44-8aca5467d00mr158065236d6.1.1776197125077;
        Tue, 14 Apr 2026 13:05:25 -0700 (PDT)
X-Received: by 2002:a0c:e001:0:b0:8ac:a546:775f with SMTP id 6a1803df08f44-8aca5467d00mr158064646d6.1.1776197124557;
        Tue, 14 Apr 2026 13:05:24 -0700 (PDT)
Received: from redhat.com ([2600:382:8116:76c6:c5b1:9485:5da8:de42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849dbc0fsm133803046d6.1.2026.04.14.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:05:22 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:05:20 -0400
From: Brian Masney <bmasney@redhat.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] clk: starfive: jh7110: fix memory leak in
 jh7110_reset_controller_register() error path
Message-ID: <ad6eAM7a-5jzxC9V@redhat.com>
References: <20260413143643.3002454-1-lgs201920130244@gmail.com>
 <ad0d5fIAkjblQcIt@redhat.com>
 <CANUHTR8JCPLMAPfdjXX95tcPTqHWBy7k3GwOo7=BcjRxfMSavg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR8JCPLMAPfdjXX95tcPTqHWBy7k3GwOo7=BcjRxfMSavg@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-237965-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B750F3FE407
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 07:44:18PM +0800, Guangshuo Li wrote:
> Hi Brian,
> 
> Thanks for reviewing.
> 
> On Tue, 14 Apr 2026 at 00:46, Brian Masney <bmasney@redhat.com> wrote:
> 
> > There's actually another leak in the error path for
> > auxiliary_device_add(). I think this code should be
> > converted to devm_kzalloc().
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
> if (ret) {
>         auxiliary_device_uninit(adev);
>         return ret;
> }
> 
> The embedded auxiliary_device has:
> 
> adev->dev.release = jh7110_reset_adev_release;
> 
> and the release callback does:

You are right. Sorry about that. My original suggestion still applies
though to move over to the devm variant since that'll allow you to
remove the release callback.

Brian


