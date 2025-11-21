Return-Path: <stable+bounces-195474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1F7C77AE9
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 08:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 58BC92B1EA
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781413314DA;
	Fri, 21 Nov 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLlR6q/G"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4B32FA2B
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709744; cv=none; b=otkPFPqGUGyjhmX+tDwDairC3QGekixN32kv8JipYn/kqmf8sLHjkYC0eNTjrDQJ6yOkn/pIh5UMHm10sUVBWWYiBHs+8DDZQjx9IdO5XPA7phbDHTfAJd5muvpXUk9fFJKqjmLFpb/tE0MFQoD/tGh/8WhJUYaThH/CPsywiJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709744; c=relaxed/simple;
	bh=ySLfQXo1dbGgAcRXcfcligNniGhIdzsrysHnlKsOdXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5YYa46t8hSZUej4L1WwRT0NNDwErvcDmN0jko5o25+uHkA8NvQ9ijY8ybUaZixacMVAg/Xr2lwpw60EdrRoCssuc2+bm8bQ05intsk/itm2WbH7KShhNdCPdaN+C0M5qCwhF/vGHnC8iK3d1mp5BnmbkaJ7syWk0/AOsSsbhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kLlR6q/G; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso2591468a12.3
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 23:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763709740; x=1764314540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uXe3NiNtXd09TBAnyXOy9PFKvfckYekcVcmJPAsWbKA=;
        b=kLlR6q/GYph6YNc3pW2fcaCIS9BR7FtlaLrQb5XstSZbNEIfIxN8eYXZmIFg/5sDY7
         cyEeal4KRSCt5joTi0rHl0GoKfmmqrD9lkhNhGQoFXzINsYBDuigPCjpomcyFME7ERkr
         6BZ3O/y3fJJyjzqNM2wVD3YLCuHGoymrH9VrvZYs70+frqljW5zGW5Vds7DkVC2Z9g2U
         6kUHojxzvC2Aw+lDZhr6aIUUY3KZdRbdqfnh41nRgMT7hHHLWOY51ztCuVu/ZpORJ/oB
         xGlV270RG19FNoIjmp2UobWvTEQHFzSqTw87VEN5CQE+QqJW6txcKOX57Y27SGOLYXEw
         lrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763709740; x=1764314540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXe3NiNtXd09TBAnyXOy9PFKvfckYekcVcmJPAsWbKA=;
        b=Q0SabLGkmanzL8vfyaWMVuNWDmJ33xQhJDO+ha7paj8HxkhrnZzlgxvJvy/duVeBpo
         7QVy6IHYmDTofcthhPFx+2pt9sPLbR6U8vifHk39w0wkZ+CsCEU69HA6LXFIKDmGwY4x
         DLy7la362u5G9P85DnRZ6A+nWs1JRd/K5UlEddik7GW6TIgEDC0u92eziZ1x7rWqXZzu
         b3WFvBszorCm81K0sR7webpSqi6nnE+1X7wN4hWRlutDcEoaqYV93gegkGo/SQKja5X0
         SXLl4hNLOwNqZY6crQe7It8nq1FhLStcIvs6gAOnYkr0/ss7eH6zNcB/Jae/7e67cHD/
         KQpg==
X-Forwarded-Encrypted: i=1; AJvYcCV92RQZzInO6OHuLC5VPs7oeYXor2NBhOX0kDow5VlO1PVDCL9BMg6OZ3bsOQN7IwyDCNZxkTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS89ibhyjkC/4Pfs0a+h5+FwhL6lgo5mndWYuF8tcx6xrLS5+k
	Qtl1N3aOTMalt/yOVl34RDjNiPlfnIfNSCQSug6i2b4vnwNMI7d0SMIQZ8qM5570Qv79s0VIksI
	833Kk7TWvS7I2n0YeySa7Nrp4bU4XAbrUnonv/L/DCA==
X-Gm-Gg: ASbGncv1iMc0pQ1usUL9Zx40OpVGnqruYrwiG1ikenIBRaUF9JUIoOum5jmCOgRs3Na
	Uy8l3cmFDSHF73okw9WlA3mTr1zuaNZBA6+JcGZtUyPhoW+uxFHHY7ZaXT9aiFkSnDcTdGtVTkA
	jTBC3Js8gogpnaZUS53lW5do1ZoBBUtBH94YjeGdVtin9UOoNvYGpeUDRnlyUSQiy5K4jSEG6z/
	CbqeUAvU4ziKHOUBsmwM7xVacOMP8Jf8JNE9dSACmdWDCLsiClTu8afBxE/6M9dp9go9+Wg2Pxs
	QlUVjX2DTf3uWRrifVKIHYVL
X-Google-Smtp-Source: AGHT+IG4pcNLrDM5DFik+IbRdmayjl84fVKRTwjmeW0u8QWj9awEZHXjGuAgK6EmlJyE+Yn21YGkJAlurTcHgk94Xf0=
X-Received: by 2002:a05:6402:2714:b0:643:e2d:1d6c with SMTP id
 4fb4d7f45d1cf-6455431d30emr1179091a12.4.1763709740284; Thu, 20 Nov 2025
 23:22:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <s3lyjszylckzg7mfefmysve2tsm53kmorgxly3nln4r6xha264@rct3fyk3d52a>
In-Reply-To: <s3lyjszylckzg7mfefmysve2tsm53kmorgxly3nln4r6xha264@rct3fyk3d52a>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 21 Nov 2025 08:22:07 +0100
X-Gm-Features: AWmQ_bkMstmn2slDmBsoamS92mlNB1KLBAs-OU9TYoY6UxE1YIMQSR6PAIKupGo
Message-ID: <CAKfTPtAq_90WkSbL-vg8Uh46WNjzqVApjDHF+htgdNBApRFM-w@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yu-Che Cheng <giver@google.com>, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 08:03, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/11/21 12:55), Sergey Senozhatsky wrote:
> > Hi Christian,
> >
> > On (25/11/20 10:15), Christian Loehle wrote:
> > > On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > > > Hi,
> > > >
> > > > We are observing a performance regression on one of our arm64 boards.
> > > > We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
> > > > Rework schedutil governor performance estimation").
> > > >
> > > > UI speedometer benchmark:
> > > > w/commit: 395  +/-38
> > > > w/o commit:       439  +/-14
> > > >
> > >
> > > Hi Sergey,
> > > Would be nice to get some details. What board?
> >
> > It's an MT8196 chromebook.
> >
> > > What do the OPPs look like?
> >
> > How do I find that out?
> >
> > > Does this system use uclamp during the benchmark? How?
> >
> > How do I find that out?
> >
> > > Given how large the stddev given by speedometer (version 3?) itself is, can we get the
> > > stats of a few runs?
> >
> > v2.1
> >
> > w/o patch     w/ patch
> > 440 +/-30     406 +/-11
> > 440 +/-14     413 +/-16
> > 444 +/-12     403 +/-14
> > 442 +/-12     412 +/-15
> >
> > > Maybe traces of cpu_frequency for both w/ and w/o?
> >
> > trace-cmd record -e power:cpu_frequency attached.
> >
> > "base" is with ada8d7fa0ad4
> > "revert" is ada8d7fa0ad4 reverted.
>
> Am getting failed delivery notifications.  I guess attaching those as
> text files wasn't a good idea after all.  Vincent, Christian, did you
> receive that email?

Yes I received it

