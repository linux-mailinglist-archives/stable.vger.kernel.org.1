Return-Path: <stable+bounces-200974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35578CBBEC9
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 19:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04D64300443C
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 18:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921472E1EE5;
	Sun, 14 Dec 2025 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQxn+Jix"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BD026B74A
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765736951; cv=none; b=pyvl9yf6JHhXd1HgQ3ZfF8Qant7AhRuFqCwVh65LG2bOaGxhVaesHrJ8AlClKcuA3+FLbv6KMvc8bT8LhA9qSfN/3n2OkRABw+CdyCb+Of5urVXez7VSQhKY/d7xkdMj4nY9Ybh0craQAndX8cDKTUYk4gm/9iY2vi2dN9GWlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765736951; c=relaxed/simple;
	bh=/8isi1cKHZhAhrD8kVnVCU5d2bq2C2Qe2cEca+QwxXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFs1KWnMfZgAvs8HpXblBIUl5nguknGZed4vvpIByrNUuyDS3USJYuNWkQbdrB/2MlpaMAMonGGiY7TrCQvF8+Kjb5QHroL9/rCpY0KOATZrlgy4MTG0PM989RlmtMTcRiBKV5PcBwshVTn4SJyLLIEH4WWb7WLQmHEWFVZ+zeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQxn+Jix; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47797676c62so2551955e9.1
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765736947; x=1766341747; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UXKngzqm+2esFum9rKImGD1y+Fv/z9dlaOgfVk605ww=;
        b=YQxn+JixEYeLJxm04jU9ahwbMbYXd1b2KFYSDAX8UZegtnvg4BzpnEHmXAYbcY9uHw
         iKehzxDbQXptzQPJfzkfqS6qYe1RxXQToLMW5YOLRHwg6Waj9XzVpjuE6IiUAUJfrffV
         n6hYnRU8MfLFFXS+fcFROJZaVJ3yQflida//+Qx0tCbhV4W54WqQqTkaJyoPvgauXs/e
         zmB9kmKc+FhoVji8B6S7Qcz9J+3fIV+miDxpGWi7DgIzMJFm9XOcZIofQVRoGT834tCW
         +0+GHSmU7zZ0na216Y1Ha9/AXEdHyxNx1t/EF71wwl0DAHBCPUPEnied934Ht2Pt1FI3
         97BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765736947; x=1766341747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXKngzqm+2esFum9rKImGD1y+Fv/z9dlaOgfVk605ww=;
        b=iuG+qU7Nm5JO9cTVOhBn9j9QJKBLyfekNvrtW9IHU6gmrgKKRjvBmpBVs/ww+6TIJL
         ljEZTO0u3ayyQs2J/EByZsPez+LrXit8TTQr6GNdIBeuf4+uDRFnaH0nIOv8BjUayM3o
         slExIh+19O1qalTrR+EYSuozz8dUW3Ze+u1Fz6AZ9IHEVt8RsL4cIAk3/7o7iUCtK9Uh
         nBFsxYclnI7DfRw+gxrByYYLlpuLhyHvd33RkjJMRYUuOGM3KPXY95uKYz9PH6k6iJjY
         QZof634ubMl3/BqJjnB7OT/dIH2/5wwTPYBKJo6I+bGriaCZWreJfz0MBsesX3P/bV8x
         xW5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ocf8Pi2YZPzIR2F4qN92NP6d9+7zGx5FhvjzLzSqK0Onl1cgqdpoWL1EJjJx+g+PUwr4c+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCERhBlSHEmhrTV+qP/Ueb55sBTp6aTo2N+25OvFBOBGUoDxLR
	pG8AfoEm53XUQJeTw5McjpJFW/PMKf0Vow/n41YDEP4xzZEVWoMW1q9w
X-Gm-Gg: AY/fxX6lbkx2Yn6WLzdQfrxGN9t7v27XTpu/GYDShN1rC32xk4nJoH67l3IirDcSlvP
	VI+6jt4RimsejcFkKsQ8Az5FHXu+3yi++OPG467c94bdFeM3vuGCsXMYyDsviJbLyCjK3OPJpDQ
	30iDsh7gjmZ3vlq/dwgsrTidwGQKAR0Bpo6xYPnwfe9Hw8CJqkt4H24lOat7Go0wB0uufp+UeIm
	EB4BBsFC4XD6qaiDYfYXJhh6p2y135FvYYEypy7xE+KGHhTzOFLOa8bqEIVjbT3NaRFQdliygs5
	5+xsrz8KU8YmKdQMrHaf3lWazpcCVCWEpum0Zo+2XHK6ZpwjRFEatBDP4+WOY3cfjBNUF1q6a9G
	4RfEJqO1o3xf/GjxdRoB053ICQMoB+C4mjRrm8fiF0JkONGVJ4y2EwMSxqRgUGm2qQy5+1tK+Ua
	M5A7z9n6zTtQgC
X-Google-Smtp-Source: AGHT+IEUyGCBMjMVwm3ua7eaTqXkvOVXl13Mvkk9VgTU35LOdR1nVLR/ra92ekgflA4AeDVRF/vjFg==
X-Received: by 2002:a05:600c:8115:b0:468:7a5a:14cc with SMTP id 5b1f17b1804b1-47a8f904148mr51973905e9.3.1765736946494;
        Sun, 14 Dec 2025 10:29:06 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:10b6:92bb:682a:9a0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f39ed88sm145050515e9.4.2025.12.14.10.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 10:29:05 -0800 (PST)
Date: Sun, 14 Dec 2025 20:29:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Ma Ke <make24@iscas.ac.cn>, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, tobias@waldekranz.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: Fix error handling in dsa_port_parse_of
Message-ID: <20251214182903.jliq46n6ulbrwoha@skbuf>
References: <20251214131204.4684-1-make24@iscas.ac.cn>
 <39ba16a9-9b7d-4c26-91b5-cf775a7f8169@gmail.com>
 <20251214161023.5qcyyifscu73b47u@skbuf>
 <CAOiHx=kp-trJ6OVoC-Vc54=pquYa5wU5ZCSyLVkyNATbbadsVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx=kp-trJ6OVoC-Vc54=pquYa5wU5ZCSyLVkyNATbbadsVw@mail.gmail.com>

On Sun, Dec 14, 2025 at 05:14:04PM +0100, Jonas Gorski wrote:
> On Sun, Dec 14, 2025 at 5:10 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > Hi Jonas, Ma Ke,
> >
> > On Sun, Dec 14, 2025 at 05:02:33PM +0100, Jonas Gorski wrote:
> > > Hi,
> > >
> > > On 12/14/25 14:12, Ma Ke wrote:
> > > > When of_find_net_device_by_node() successfully acquires a reference to
> > >
> > > Your subject is missing the () of dsa_port_parse_of()
> > >
> > > > a network device but the subsequent call to dsa_port_parse_cpu()
> > > > fails, dsa_port_parse_of() returns without releasing the reference
> > > > count on the network device.
> > > >
> > > > of_find_net_device_by_node() increments the reference count of the
> > > > returned structure, which should be balanced with a corresponding
> > > > put_device() when the reference is no longer needed.
> > > >
> > > > Found by code review.
> > >
> > > I agree with the reference not being properly released on failure,
> > > but I don't think this fix is complete.
> > >
> > > I was trying to figure out where the put_device() would happen in
> > > the success case (or on removal), and I failed to find it.
> > >
> > > Also if the (indirect) top caller of dsa_port_parse_of(),
> > > dsa_switch_probe(), fails at a later place the reference won't be
> > > released either.
> > >
> > > The only explicit put_device() that happens is in
> > > dsa_dev_to_net_device(), which seems to convert a device
> > > reference to a netdev reference via dev_hold().
> > >
> > > But the only caller of that, dsa_port_parse() immediately
> > > calls dev_put() on it, essentially dropping all references, and
> > > then continuing using it.
> > >
> > > dsa_switch_shutdown() talks about dropping references taken via
> > > netdev_upper_dev_link(), but AFAICT this happens only after
> > > dsa_port_parse{,_of}() setup the conduit, so it looks like there
> > > could be a window without any reference held onto the conduit.
> > >
> > > So AFAICT the current state is:
> > >
> > > dsa_port_parse_of() keeps the device reference.
> > > dsa_port_parse() drops the device reference, and shortly has a
> > > dev_hold(), but it does not extend beyond the function.
> > >
> > > Therefore if my analysis is correct (which it may very well not
> > > be), the correct fix(es) here could be:
> > >
> > > dsa_port_parse{,_of}() should keep a reference via e.g. dev_hold()
> > > on success to the conduit.
> > >
> > > Or maybe they should unconditionally drop if *after* calling
> > > dsa_port_parse_cpu(), and dsa_port_parse_cpu() should take one
> > > when assigning dsa_port::conduit.
> > >
> > > Regardless, the end result should be that there is a reference on
> > > the conduit stored in dsa_port::conduit.
> > >
> > > dsa_switch_release_ports() should drop the references, as this
> > > seems to be called in all error paths of dsa_port_parse{,of} as
> > > well by dsa_switch_remove().
> > >
> > > And maybe dsa_switch_shutdown() then also needs to drop the
> > > reference? Though it may need to then retake the reference on
> > > resume, and I don't know where that exactly should happen. Maybe
> > > it should also lookup the conduit(s) again to be correct.
> > >
> > > But here I'm more doing educated guesses then actually knowing
> > > what's correct.
> > >
> > > The alternative/quick "fix" would be to just drop the
> > > reference unconditionally, which would align the behaviour
> > > to that of dsa_port_parse(). Not sure if it should mirror the
> > > dev_hold() / dev_put() spiel as well.
> > >
> > > Not that I think this would be the correct behaviour though.
> > >
> > > Sorry for the lengthy review/train of thought.
> > >
> > > Best regards,
> > > Jonas
> >
> > Thank you for your thoughts on this topic. Indeed there is a problem,
> > for which I managed to find a few hours today to investigate. I was
> > going to just submit a patch directly and refer Ma Ke to it directly,
> > but since you started looking into the situation as well, I just thought
> > I'd reply "please standby". It's currently undergoing testing.
> 
> A patch already, that's even better! I'll gladly stand by :)
> 
> Best regards,
> Jonas

Patch location (for tracking purposes):
https://lore.kernel.org/netdev/20251214182449.3900190-1-vladimir.oltean@nxp.com/

Ma Ke's patch unfortunately does not compile even in v2, so:

pw-bot: cr

(although "changes requested" is a figure of speech here, in the sense
that I don't expect a follow-up patch from Ma Ke)

