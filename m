Return-Path: <stable+bounces-110106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26828A18C8D
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F1F188AE0E
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 07:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6812C192D8B;
	Wed, 22 Jan 2025 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="bqDGla+w";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="J55cRcJg"
X-Original-To: stable@vger.kernel.org
Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB1170A30
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737529752; cv=none; b=FqoCg9Clr9KICbMZeVrRByVpvX0GzCJns6N6tbNms+ieYMdRWgeanq4cZv0PzAu+thPKgcbE2l3LU/HomSjYEvVFOgOY+SN7dhKz91922XpMPRLHqV4dIUANjffd55RaO9d0wXOtpsNBJ03k+ir/xsSDMEfwujtnw7W/RbQIbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737529752; c=relaxed/simple;
	bh=6FAWOrv65gZPxsnXK4+4nI9KTLopDV8VIrMsSPOLjuA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kzsfNRmiQLUg2MfeDTP/4Ri1v5OqD3xLC4lPC1M8EfA/jx7YqeOduKx3gQvsPsYE7qM7bbObIQWR6tFg9B08+7qR20wfxlHBAPRf0bKmS9/igyAZqcLHlJcgfH+NzIeYG7mkM6hiQD273FW8zg5cj+tgHqWAr78sK7BgGzY1cEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=bqDGla+w; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=J55cRcJg; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1737529750; x=1769065750;
  h=dkim-signature:x-google-dkim-signature:
   x-gm-message-state:x-gm-gg:x-google-smtp-source:
   mime-version:from:date:x-gm-features:message-id:subject:
   to:cc:content-type:x-cse-connectionguid:x-cse-msgguid;
  bh=6FAWOrv65gZPxsnXK4+4nI9KTLopDV8VIrMsSPOLjuA=;
  b=bqDGla+wtNpVo1SJeaI2LvH0sUPohTXEaTelRGfHjUY41P4Yif8iu/is
   KV3Dn2yNJbAPvNWJOOaknLENwm/WjOrsYB2cUk4yI7EBbEobSSdLuVkwo
   z1Q7mie9llX5lAWhXs4ynK1GsGEP+VFD9PPTndc3Bhv56bhsRGKEWF9jF
   gUdam/4j17Ie58FaF4flWY1/UoBZkLWwGMmMbeyCuJXmsD5HWSRVtLoJr
   Fij5x23pQ5uOXtL0i6FUd+l0kHmcDJiPbXJOfpzQCZjxLpNBaTngB/QLr
   sfloNj1NoVEazWwUvhBY4nHErN3f0IQLW2IJ25jkXlBiPYQ2UoBVKjeUu
   A==;
X-CSE-ConnectionGUID: RyIJrW+LQTu03YBwiQnt7Q==
X-CSE-MsgGUID: qMXg8DUNRCG5m2MtPhu3Bw==
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Jan 2025 23:08:01 -0800
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef7fbd99a6so12171875a91.1
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 23:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1737529680; x=1738134480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q8ZhMGlVKwP+F2f8PpFfFoGKjPx0ClIlAp71dSOgdFE=;
        b=J55cRcJgvmsutYZjiFZL/HHffyUBNK2ctl3Uo/eqPZWGS4349loJmqX5sNW+Vi7F8O
         M25CqJVid4Ab/MyAfZDw7Us8EUygZTI/Ms1JoaSFlK9DSURWlJ24eN+P+eO6wH5F5Hfw
         y4KnOdHLdDe7NDwNW9NyZfimV8iigADQNMQGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737529680; x=1738134480;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8ZhMGlVKwP+F2f8PpFfFoGKjPx0ClIlAp71dSOgdFE=;
        b=lWSZ1EzK7wAUaWbGVfV9n1SWin+dspfhaJoXACBIjZ5RtAAN8SO0ArQLOx7UwYDEH3
         YfaZg+5UDkQ6oD2Y7XLL5NMw19+0aAXg+H6HnbHohYm18uGYu9WD2aX4NB+fYoeg+JpW
         fq1dfBME1ENyjlic7HXHMdOxJag2kuKATqTWcQbcMp7oYOdudNLkw0tO+aTtR4g2YGka
         3tJ32vaxiuJyUjLRmbhV7kFWe5pD8asHZ/BFyS833SVxUn405B2rEbshd86mhzIEO/XM
         i/y3gmacJV3HvRjZ8KmvjG1BklpwiSsMnhUislYQe2F14iAlgrg5NrTYHuPhk/StKOp5
         /0RQ==
X-Gm-Message-State: AOJu0YyisckTqZX5XlLlpTMJRh0kXOyrjv5soZD5qbErP/nwm6sYKLZm
	k4uFKmwkf6Fz43gryyhePOBEzC4s71v1SYIhM1teSGBXCU3pQeVlaU8Blr+vPn6CADv+hvAATw8
	HoNMbBBi7IqYPfyhlds3ZEx/ndDotMKMsIIXD2iVzYseFq+WtxiWYISXGOaKP65N1WdNRfcRdag
	dgI3qxebGmXOyteLcpAIFDlQxABh21IJQPe3xABuI+
X-Gm-Gg: ASbGncscJElP32UC4M/vJzbRHlolvISbX/h07Xx1jfrHst7jnQJ66Fw8gXL2KDlzKvt
	Y4eyGPp8aaY2oHo5+S8HOwBWe98hrvInNR4MIuDdqu5i/aG+sQEm4gKfbArBjL2y+TnlfMBwBOh
	5c5I8ciOr+PA==
X-Received: by 2002:a17:90a:d2d0:b0:2ea:7fd8:9dc1 with SMTP id 98e67ed59e1d1-2f782c9cb34mr32826309a91.18.1737529680095;
        Tue, 21 Jan 2025 23:08:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkHf9BFdaly5sQiJjAKQ7BFKDHWADnTphWDvloCjl/FFvfkuJfXKfu46Nw55Qxmfbx7Pl+NNULr33JWpAWRMU=
X-Received: by 2002:a17:90a:d2d0:b0:2ea:7fd8:9dc1 with SMTP id
 98e67ed59e1d1-2f782c9cb34mr32826292a91.18.1737529679857; Tue, 21 Jan 2025
 23:07:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Tue, 21 Jan 2025 23:07:48 -0800
X-Gm-Features: AbW1kvZzDZLQH1fBXhp-43_lujwyVFZwBh14M0oEnAr01z5BWxb8ePHbqKdQlVk
Message-ID: <CALAgD-4_rpg=yZ9+7a9E5mDkOdFsz8Jjx13Shju-SEO74nOjsg@mail.gmail.com>
Subject: Patch "net: flow_dissector: use DEBUG_NET_WARN_ON_ONCE" should
 probably be ported to 5.4, 5.10 and 5.15 LTS.
To: stable@vger.kernel.org
Cc: pablo@netfilter.org, pabeni@redhat.com, Zheng Zhang <zzhan173@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We noticed that the patch 120f1c857a73 should be ported to 5.4, 5.10
and 5.15 LTS according to bug introducing commits. Also, they can be
applied to the latest version of these three branches without
conflicting.
Its bug introducing commit is 9b52e3f267a6. According to our manual
analysis,  the  commit (9b52e3f267a6) introduced a
`WARN_ON_ONCE(!net);` statement in the `__skb_flow_dissect` function
within `net/core/flow_dissector.c`. This change began triggering
warnings (splat messages) when `net` is `NULL`, which can happen in
legitimate use cases, such as when `__skb_get_hash()` is called by the
nftables tracing infrastructure to identify packets in traces. The
patch provided replaces this `WARN_ON_ONCE(!net);` with
`DEBUG_NET_WARN_ON_ONCE(!net);`, which is more appropriate for
situations where `net` can be `NULL` without it indicating a critical
issue. This change prevents unnecessary warning messages from
appearing, which can clutter logs and potentially mask real issues.
Therefore, the prior commit introduced the issue (the unnecessary
warnings when `net` is `NULL`), and the patch fixes this by adjusting
the warning mechanism.

-- 
Yours sincerely,
Xingyu

