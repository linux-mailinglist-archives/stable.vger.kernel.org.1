Return-Path: <stable+bounces-60662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F53E938C06
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 11:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A678E1C2125B
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 09:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B3216B3B5;
	Mon, 22 Jul 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XCboId1f"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041CF16B39C
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640307; cv=none; b=Edm774ZX92jo+wfVPi2Zs+YZLGGmyYeu3G1qAvMrFW9MC5gZki7uP2+7jeWx+p9WPnhjZUO+dxoLk6nw7/DEQ8+/1hYSv1UD0MGrjmE+h3UZqcMkE4sRXHvFHtu95lvFpAloZglzZIxQC3rWauUEwltseZxROXUL4DGaFBXNCtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640307; c=relaxed/simple;
	bh=lxzIvXphnUtmmMr5hoebSzv+0+H/IujItAMVJKh6eic=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovL7i6kUuDOg9+UcqndbBges+E84B4Ho3RJlMpRbKlOiGuel5ssYHNO0qU4vHl0pCbllw632ct5SQEvDprO6EG/YU1EG5IyuLF0sV7sss1hd8E2G16/mbOpS7ESSxsg5R0HMS3OyFzrvGzMdjIiQr5hMaAKkZkNLLyax84hwPfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XCboId1f; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 298B13F298
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 09:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721640302;
	bh=F1IRx0h3y03+MjLIKbmcC8DJYNYbLEiR3nTqq9MA1gI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=XCboId1fTdq0E1vPZAvo318YzYHpcmABYJ+TT/Tc/qQeUGg+V5dD1dvZED1l3UH/c
	 jHfWV4Rg8LQn/nC8DTHZCVoWUpOD302p//NqL4b9mFVWvKBnU+597Lm99PSyvFRZdU
	 8F/1LdfvxdVoLTV7qqmSQkK+1S6h2uNRNliqxEbzC/WG0fWZSP9UXyaMBLw6lSi19W
	 SES76Qa+BDD9AZ8uYyPLO4cRSAefLByUuVKb6rsosrP4wMx6W0CuApnhYkKwnhEkRl
	 lUAgbAYaXEUAby16aIU/uXLzIwE3ABiBTo+7dpoX9eMeIVLVi0dUA4pugQqHYFZRJ2
	 avoc6upOuSwLQ==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3d93eb9e6e2so3705678b6e.1
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 02:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721640300; x=1722245100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1IRx0h3y03+MjLIKbmcC8DJYNYbLEiR3nTqq9MA1gI=;
        b=wxfiUh2MLOPGHmCyhqB48pZ36SH4qQWcJP6Jr/dA5yA5niw1NqzHuyF4wGLVvQsn6a
         UTocB2BWuD3ywdIYFAqPtoASCrrxMK6Dscw1ystyL37fW+tPATKos2+uQNAxs1XOlcX9
         c+BWQxmpjwXYlCuO+qc/qwuluK24fHIpK5FszIoXVmW+bAyAafaf9nCwr3e8JEjPQEUp
         h2mGEqDmpqHijrIORm4d5g1CmnS80y+aoP06PMwBMSRrQ4DzErUFijGn1hwjLyZyJc7v
         f8rjFY6SjZZsoPaRr57ydqvTyUQvdflSSfW28OaGuZX6hY0y3ADqIPJjML2fGstIctHm
         zvMQ==
X-Gm-Message-State: AOJu0YyHACgFTDF38LgHYz6w1SZS40jvnZHflVBXzV4gRYR2EbCC3JaY
	0kmTeH8mQ4H6Vml8KonZ76AKhrIIXjtGRpNbCPpgyn/d+uortB0ZSNIxa2p1JuSPr8f4KO9BkQU
	golwYX2rWJR8u/WVJfL1YyVf22rRFYAmqU7CBNWwn2kFIRIHcQbGWcaTlwXVNmQ3HjgsxuRJPKO
	1sAQ==
X-Received: by 2002:a05:6358:5694:b0:1a6:a69b:b171 with SMTP id e5c5f4694b2df-1acc5b30266mr790204955d.15.1721640300391;
        Mon, 22 Jul 2024 02:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/kDKDf1k/aeA2cjNaGcyyIHrD8fkbcylMOFycnnWNLPAH0U5ToUNccTg/eVm9bXjs3tJqSQ==
X-Received: by 2002:a05:6358:5694:b0:1a6:a69b:b171 with SMTP id e5c5f4694b2df-1acc5b30266mr790203855d.15.1721640300003;
        Mon, 22 Jul 2024 02:25:00 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1 ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f319763sm50053775ad.158.2024.07.22.02.24.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:24:59 -0700 (PDT)
Date: Mon, 22 Jul 2024 17:24:56 +0800
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] scripts/gdb: fix timerlist parsing issue
Message-ID: <Zp4laDap4bfOjH7v@kylee-ThinkPad-E16-Gen-1>
References: <20240722091746.91038-1-kuan-ying.lee@canonical.com>
 <20240722091746.91038-2-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722091746.91038-2-kuan-ying.lee@canonical.com>

On Mon, Jul 22, 2024 at 05:17:42PM +0800, Kuan-Ying Lee wrote:

Sorry for the bothering.

I mistakenly sent to the wrong mailing list.

Please ignore this patchset.
> Commit 7988e5ae2be7 ("tick: Split nohz and highres features from
> nohz_mode") and commit 7988e5ae2be7 ("tick: Split nohz and
> highres features from nohz_mode") move 'tick_stopped' and 'nohz_mode'
> to flags field which will break the gdb lx-mounts command:
> 
> (gdb) lx-timerlist
> Python Exception <class 'gdb.error'>: There is no member named nohz_mode.
> Error occurred in Python: There is no member named nohz_mode.
> 
> (gdb) lx-timerlist
> Python Exception <class 'gdb.error'>: There is no member named tick_stopped.
> Error occurred in Python: There is no member named tick_stopped.
> 
> We move 'tick_stopped' and 'nohz_mode' to flags field instead.
> 
> Fixes: a478ffb2ae23 ("tick: Move individual bit features to debuggable mask accesses")
> Fixes: 7988e5ae2be7 ("tick: Split nohz and highres features from nohz_mode")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
> ---
>  scripts/gdb/linux/timerlist.py | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
> index 64bc87191003..98445671fe83 100644
> --- a/scripts/gdb/linux/timerlist.py
> +++ b/scripts/gdb/linux/timerlist.py
> @@ -87,21 +87,22 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
>              text += "\n"
>  
>          if constants.LX_CONFIG_TICK_ONESHOT:
> -            fmts = [("  .{}      : {}", 'nohz_mode'),
> -                    ("  .{}      : {} nsecs", 'last_tick'),
> -                    ("  .{}   : {}", 'tick_stopped'),
> -                    ("  .{}   : {}", 'idle_jiffies'),
> -                    ("  .{}     : {}", 'idle_calls'),
> -                    ("  .{}    : {}", 'idle_sleeps'),
> -                    ("  .{} : {} nsecs", 'idle_entrytime'),
> -                    ("  .{}  : {} nsecs", 'idle_waketime'),
> -                    ("  .{}  : {} nsecs", 'idle_exittime'),
> -                    ("  .{} : {} nsecs", 'idle_sleeptime'),
> -                    ("  .{}: {} nsecs", 'iowait_sleeptime'),
> -                    ("  .{}   : {}", 'last_jiffies'),
> -                    ("  .{}     : {}", 'next_timer'),
> -                    ("  .{}   : {} nsecs", 'idle_expires')]
> -            text += "\n".join([s.format(f, ts[f]) for s, f in fmts])
> +            TS_FLAG_STOPPED = 1 << 1
> +            TS_FLAG_NOHZ = 1 << 4
> +            text += f"  .{'nohz':15s}: {int(bool(ts['flags'] & TS_FLAG_NOHZ))}\n"
> +            text += f"  .{'last_tick':15s}: {ts['last_tick']}\n"
> +            text += f"  .{'tick_stopped':15s}: {int(bool(ts['flags'] & TS_FLAG_STOPPED))}\n"
> +            text += f"  .{'idle_jiffies':15s}: {ts['idle_jiffies']}\n"
> +            text += f"  .{'idle_calls':15s}: {ts['idle_calls']}\n"
> +            text += f"  .{'idle_sleeps':15s}: {ts['idle_sleeps']}\n"
> +            text += f"  .{'idle_entrytime':15s}: {ts['idle_entrytime']} nsecs\n"
> +            text += f"  .{'idle_waketime':15s}: {ts['idle_waketime']} nsecs\n"
> +            text += f"  .{'idle_exittime':15s}: {ts['idle_exittime']} nsecs\n"
> +            text += f"  .{'idle_sleeptime':15s}: {ts['idle_sleeptime']} nsecs\n"
> +            text += f"  .{'iowait_sleeptime':15s}: {ts['iowait_sleeptime']} nsecs\n"
> +            text += f"  .{'last_jiffies':15s}: {ts['last_jiffies']}\n"
> +            text += f"  .{'next_timer':15s}: {ts['next_timer']}\n"
> +            text += f"  .{'idle_expires':15s}: {ts['idle_expires']} nsecs\n"
>              text += "\njiffies: {}\n".format(jiffies)
>  
>          text += "\n"
> -- 
> 2.34.1
> 

