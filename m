Return-Path: <stable+bounces-204767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14910CF3B86
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 320CF300F72C
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648222BB1D;
	Mon,  5 Jan 2026 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="Vwoocke+"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF27217F24
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618418; cv=none; b=As9Ia1QEC+MZND9tyWQRFeD6trpVyjX1KfvsEOlKNuxZLH6fdaum16tIr3+F/RB5Jw6EYHGJDWmxQjapxP63HuK66kpZGmVJeih6SgaQQ01Yy+DK/Aklvv5comM3P4bpmXeVqtX1JkAXKuzfP53lPn2bYhckmkwFGff0Se0iC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618418; c=relaxed/simple;
	bh=GgWUC7U2r18ePDy7uMAn7mVxakP9810scIVN4hgpf0Q=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLOUdHJ0AYY7UBqTbpU3MjxXUKXFx3n1Erxx+b8+Xy2CtoHNhfe/bYo4kcQG1W5ZaDo85tgaShCIqwxYT5/Ov3vCChPIxN9BvB+2iIF/wZunr0QtsKhFlkBXJ5Tq4niPzq8XhIRTNhjktk5+NyOrp4uYTrt7w0Bwo3nL6hdGln0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=Vwoocke+; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56021b53e9eso2890297e0c.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 05:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1767618413; x=1768223213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JcsdamT0npxmVnjOT89/rj2PHxja3dzwQ1na+A1qRDQ=;
        b=Vwoocke+VTbuCGyGwt3hq7yt0swu5xPfLMls6mepOUe9nb9rk+mYx7MhbG9PndwsOi
         9zJOLr5WgLS90tX/3ZNxBDy6TO533QcTxYYs4TNlEKOi28aY8K8PH9RHghmQ6y7hW7LV
         7kriwzWBKNEqBXsUvUj7XMrcLVnCubD3gMvhKaHA3ii+h4nMnLyKDY2mXZHOOqBZ+6qY
         FkU2aIYEwvCIMDQ3FFE5MECeoFzKd8bSSGVjUnV/YM7xbvPQSYpSZZl8pPwgpnlBO4/e
         +wQED5fXuVJWtBZ0Oe5vAmaujl9N998IMUlLQv50fP7sF7SvB4YPtkya9Oy5aICiIZ5G
         4+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767618413; x=1768223213;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JcsdamT0npxmVnjOT89/rj2PHxja3dzwQ1na+A1qRDQ=;
        b=rGTUHQNSFt0QuIC4+/ltqXYH+/xniQ4GA8TREQunm43bCi5/vQdJ2jAhIh5smLgvUO
         dpxjJOJDNWINYmardBf0gcvmL+cy38vXGknYNAu3zIo22WPymJsXVd3xBrkZXSFLzEOW
         ouYPoTJ0w9L1PrXASu2Rvs3+X5Kr9S2O0TwmwwO60cisRZfTGfmGl+xhAn0loPxjlLZ3
         A7nGoPPGctKikYit2rN6FY4GpfM7E4xV9umVWmW1XWkORHqO6lJ230eGU/Nc80b/X+Vc
         tynPMYc7nazVBBI7PLRYbyNoXloMwjH2687qDIbYLmfFjgtk7lCdCagQvCNPMhlht4RZ
         JO3w==
X-Gm-Message-State: AOJu0YwqchVs2vJqVBS0L4720g7iJl0oLljeN+91BOMyFJd56bwMrGet
	xG555okh/1JdHfyq8w/4Z9ehBWtYFBjcDrIX3FtX+6RXtuP3Tmg5k9hz05mitIT3+20ShjmkEq0
	sa/jd0xS8FUlWRzWsJCktlbFVOjD3lA6yhuXXPfzO
X-Gm-Gg: AY/fxX5mh+72U+Uk+aFzvZGG/fjNdFtPaDwiF9BGPasI9uNQYJjByxhZOfJftgIuJFF
	LRbQIGCZ6ssd0Cx2L3hG7WYOHZlG6XO7L6ZIqmoKfNKllLsBWBOU1lPIcwR9yoz0Ia+RD3eRaf3
	RHzkUXj2vocG5D4R/7JBsYYua3r4bwu+A0nCxy25c+3aJHXfU0bM6OUSA/teTAy/9ScWw/hkES9
	MIBLmgqDMhLIgBnU1zrLTkQ8OdTqJ9kTe7SvzvJ6hZyAFQ+ZCoqsngGZu8A3ej+HWzMWVcMckKB
	QQNi4A==
X-Google-Smtp-Source: AGHT+IGWZkWj0tsLWC/Evt2rB+Y0kgPDAiL03KlAqgCFM9gN4ebFTcRigZMRjHtwi3UaF/xE40XauhOVZrSvqVZ6Tcw=
X-Received: by 2002:a05:6122:180d:b0:559:7294:da85 with SMTP id
 71dfb90a1353d-5615be31c9fmr13422251e0c.12.1767618413379; Mon, 05 Jan 2026
 05:06:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Jan 2026 05:06:53 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Jan 2026 05:06:53 -0800
From: Petr Malat <oss@malat.biz>
References: <20260102193457.270660-1-oss@malat.biz> <aVuXkUjzIb7BC5vv@bogus>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aVuXkUjzIb7BC5vv@bogus>
Date: Mon, 5 Jan 2026 05:06:53 -0800
X-Gm-Features: AQt7F2oNVhGt_t8EatKJ-e2h6BDfE2WZzzSZxj_UOwdou6F8QIeVeve_m2Sn4uI
Message-ID: <CANMuvJnNibYjhGCCUG3X1TRQ1CHwxtiois6mp6C8oQDAE44t+w@mail.gmail.com>
Subject: Re: [PATCH] cacheinfo: Remove of_node_put() for fw_token
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: stable@vger.kernel.org, pierre.gondois@arm.com, wen.yang@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi!
On Mon, Jan 05, 2026 at 10:50:57AM +0000, Sudeep Holla wrote:
> On Fri, Jan 02, 2026 at 08:34:57PM +0100, Petr Malat wrote:
> > fw_token is used for DT/ACPI systems to identify CPUs sharing caches.
> > For DT based systems, fw_token is set to a pointer to a DT node.
> >
> > Commit 22def0b492e6 ("arch_topology: Build cacheinfo from primary CPU")
> > removed clearing of per_cpu_cacheinfo(cpu), which leads to reference
> > underrun in cache_shared_cpu_map_remove() during repeated cpu
> > offline/online as the reference is no longer incremented, because
> > allocate_cache_info() is now skipped in the online path.
> >
> > The same problem existed on upstream but had a different root cause,
> > see 2613cc29c572 ("cacheinfo: Remove of_node_put() for fw_token").
> >
>
> Please let us know which stable versions you need this for ? I assume it
> is for stable only, but it not clear from the subject.
>
> Or do you want this to be applied only for v6.1.x as 22def0b492e6 exist
> in v6.1.x ?

Yes, the problem appeared after update from 6.1.158 to 6.1.159 due to
the introduction of 22def0b492e6.

I haven't run into that problem on other branhes as they have 2613cc29c572,
which is the same code change, but just for a different reason.

BR,
  Petr

