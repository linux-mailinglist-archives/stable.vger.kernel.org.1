Return-Path: <stable+bounces-136977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4240AA9FE00
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 01:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EACA467436
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBF3214A95;
	Mon, 28 Apr 2025 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqjh7bvF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221C35966;
	Mon, 28 Apr 2025 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745884780; cv=none; b=eht7skXMYBo/FIfMqZos9hKo3NZVNI6YhdV55hOlh4IBWaMUIJ0t2Ux1fM+j45YPpsqslc2zFriEM+xE95S93w4FtcPRP875gf5q1Tl3GiaewVjqWFSJRmFg4HBjEd2wblby6NwsthTsSu3L/Sw/+NDDirqfbd8wYpdANi0ILKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745884780; c=relaxed/simple;
	bh=dwjOYKhNu9ectViomXMruDUC3aGQX3Yq8FWUHkxR+GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVN3/D9iWQrT2mSMeXu60DujGrt6pbZPn/9zgf18v7hJrW11UlGW0KMRQO8UcWofQUChuVu3Rw4kA06sKaJKLrpVyWb1u8VKjrpxPN3k1Y3mxIdbxjzpmSD7ChraK0eQDGziwSW/6b4fAGiz2QLZ6xsLByTSFyy2Y+ZICh1tOw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqjh7bvF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3081f72c271so5090055a91.0;
        Mon, 28 Apr 2025 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745884778; x=1746489578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RsuQSMGH+Nxq35AjsUShs6H+a1PazjIafsb4arH8+U=;
        b=Fqjh7bvFkxU7dwCfIrzX+aZRwYuKuidkLLlQ7H2dBAcsniUoZKRTALeZwu7npNOC1E
         dQEXykuCrMVzcZRjQTL5xmf39nx2xOVWuJWchWNR0hOf5gUIpWEsYlx+uFAYPcFDAz8m
         g4FB0pPtNRDZeDmhWSvfcw1zn99XybRRMBzza0uxD1c4tRzYoFNLbo4ynF51ol4meIKw
         8r/WnECWo4fXWwaRSjmJ6x7K2RpgAn+MQup0kwW1NdV0f+6amDu3Kyz+BfRdGNBTBSS8
         n7BwXVZx9PQrSq6tGCbo7hwWVkwgfZXpGU8X0zkzUxiegR82ZHOIt//bAcfyzohP2yA7
         xVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745884778; x=1746489578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RsuQSMGH+Nxq35AjsUShs6H+a1PazjIafsb4arH8+U=;
        b=XdHcBRjLZCj+lQg4B+0kJ6Vqj18mNiWvPqW0WS2JirBw13CBSoD4hlCfLc33g8cnOf
         0wjANuDYAUfROdGLA1M4HOLcavNAf88q1fZe5tLnItko2Mhz1d70ojeVCLj3MHRUxwQf
         i3Zi4JeVEmOC483ifldvJmEMIatsOhtIvnmSmQCkO73P0cOGGv0gz7DJGufQwe7T3tgP
         VoYCSX1ynpjwhrRMB0s3h4iF99carGvdm1xBvosmVdApon5tPx12h8T/M7SptvpuPzS8
         EF18sll5SXt5oapaJc6g3xTdpO2UHoHO92Zinp5nnVJOHgK1pJw2B+WeYpUI8INqCJ+j
         n0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW3GgP8A502PL18LNbOBMSki5/8NQYfr3bP7oq6hxAJ/Uh8NKMA4n/bT8UoIEQGvhMZPBdkNbfv02w+6PU=@vger.kernel.org, AJvYcCWROLSuA6A2TXRrKiC0gKfBeLoMVVv9IiPMXU5s1ovQ38m53mV/fqTf6mu0NSxUFoCD0U+S4M0d@vger.kernel.org, AJvYcCXaldsO22PoZIJfv+GK0u3xHLrzGP8oLVvxPA35zaNPBw7Vt5/uwylRbiAR2CKjH1Kponaf3TJF@vger.kernel.org
X-Gm-Message-State: AOJu0YwqN4pGEfXUv3lF0aqlba+/d04dyt5YbkQpaDQvL+srDK18mgyj
	vAjHO6sHaAHfpD932KRpH6j0ECUzx9pO2d79SB3OsPpZNxqY57hW
X-Gm-Gg: ASbGncu4ZDsasBVyy57AjTHfjv9RViFC3jTX6AOGpWM3t3R+YCWx+EP9U27mxJHkmDy
	cA0fE90Q+4ZwCcv+zttB48ePZbwtMvivGm7mKVfjauAxfLWH1VJgV5iXKfYBByGLBWq/7ubCLQL
	xYgz0RVUEN9aNWobexN1acKkvE7ewAf6TSvm/pJxUZnb+/71byorz4H3ciifSirOZQC0zYsr0pz
	PaEJudY5nL2i0BTnrK73huc/JqEuxKWmhIeJf1qZ8si9S9n8zDrbX1S5zjJREaDfaQKEEYzGVSd
	IVaZW5vD/FpWLTzDoGbA0LorbKd/UFJ7lfook4HQMomR
X-Google-Smtp-Source: AGHT+IF2GazQWo9ab/vr8knHLM0gAcqo0PbD6j5eNNWUNBV1632zIxlbixlsSjq85xTX99OmfyebVA==
X-Received: by 2002:a17:90a:8a88:b0:30a:214e:befc with SMTP id 98e67ed59e1d1-30a214ebfe5mr1984804a91.27.1745884778074;
        Mon, 28 Apr 2025 16:59:38 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef098157sm10779310a91.26.2025.04.28.16.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:59:37 -0700 (PDT)
Date: Mon, 28 Apr 2025 16:59:36 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "Alan J. Wylie" <alan@wylie.me.uk>
Cc: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <aBAWaAubkkTH9FAK@pop-os.localdomain>
References: <20250422214716.5e181523@frodo.int.wylie.me.uk>
 <aAgO59L0ccXl6kUs@pop-os.localdomain>
 <20250423105131.7ab46a47@frodo.int.wylie.me.uk>
 <aAlAakEUu4XSEdXF@pop-os.localdomain>
 <20250424135331.02511131@frodo.int.wylie.me.uk>
 <aA6BcLENWhE4pQCa@pop-os.localdomain>
 <20250427204254.6ae5cd4a@frodo.int.wylie.me.uk>
 <20250427213548.73efc7b9@frodo.int.wylie.me.uk>
 <aA/s3GBuDc5t1nY5@pop-os.localdomain>
 <20250428223436.48529979@frodo.int.wylie.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428223436.48529979@frodo.int.wylie.me.uk>

On Mon, Apr 28, 2025 at 10:34:36PM +0100, Alan J. Wylie wrote:
> On Mon, 28 Apr 2025 14:02:20 -0700
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > I doubt it is related to iptables. I will try some TCP traffic on my
> > side later, but I suspect this is related to the type of packets.
> > 
> > Meanwhile, since I still can't reproduce it here, do you mind applying
> > both of my patches on top of -net and test again?
> > 
[...] 
> 
> With those patches applied, I've run 5 or 6 SpeedTests, no panics.
> 
> There's several WARNINGS in the log, though, about one per run.

My bad, acctually I reproducced it with iperf (TCP traffic) using your
reproducer. I saw the warning/crash within 10 seconds. With the fix I
sent out, I didn't see any after ~10 mininutes, so it should be working 
probably.

Thanks!

