Return-Path: <stable+bounces-77894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED258988173
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 11:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DDA281775
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E61BAEC0;
	Fri, 27 Sep 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqc0J3IH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545918C017;
	Fri, 27 Sep 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429761; cv=none; b=IkHr2muecM9x4Kf9VqmzE6YsC3ElF0Fltn5HEt41W9sJcFis0FqhPAlJJrW+VsWCGD53ZDe0DjP8IV8W/ZApLWSC3o8R5BANplAY4veUn3VsApMarCrB0zmOjhnrfX+PhHBDoYfYO/M0F4uvLUoEXehxmqvpY0ydjLESCNmsAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429761; c=relaxed/simple;
	bh=eVciTcpsHtAZGOTgTHd20Rq/MWjkf5aWXV1FSiqpq6U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XnJnHehiY+mo/1EeD2H2MhOr+H1wJVPiVxtC1VBJd2fuU104oJosRMlR365Q5A7LMxuWz4wCeZWpXvOSkOfljiNW3krwfVN6OtnaTJkTiWwmWnPTA8IQ6YR4/ixd/15RVnEIAm1nDSi+YOzZIRbKth8Lc8rLmLaVCQqXVZz5Aac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yqc0J3IH; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4582face04dso17822201cf.1;
        Fri, 27 Sep 2024 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727429757; x=1728034557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/T5vuF45xvtZpHqUulQB1LIDXs1iBkFmXTiWVqtQC8=;
        b=Yqc0J3IHLgCaCj5qcvlXRpnjU0H3yKIcAWjuX9tflHAtwKk/N3E351hsy4Xut15dT/
         KrPrRo0fHBClZJOyxNOcUn3FmsBHZUMmJ2DTOpm5S9QxlS+3FA5KYZI+2Vz0MBzW7uz7
         buvnFRjZ1W2L2ycNFPUEOlvY3GGua+py5+Ik7POqIqNxEWCszr4RGmsEPV97l9qgnVsi
         Gq7etMgIR1EKULOfLvLKDxaArbysy5Mjwh9BnODaFZXEIcpz3HmRb7qNg7EIvDC5XzG5
         LxaW+6wn/8Bus5pdiFNo5KF4dvumzeIUx7qf7YW9+Qf+A0rz3K2IxCDelNXvmbpLO+Cb
         eOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727429757; x=1728034557;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j/T5vuF45xvtZpHqUulQB1LIDXs1iBkFmXTiWVqtQC8=;
        b=s0gnN54rDQjplyifCwBXBPww67eAxtwGgPeUDyZURze5X7VNu7f6t82qgk5IS08OT7
         WyV9d0AwfK0rLbv3peBTw237KEGczsvJ5A7wlEP5iWVI1SH4hIqkdCpYBBlvkhOG7jnS
         NDSaiwjXYyP7cvKpZv7sK7t3yPgrvySoirhypAUiVZRx/wVlb221ZY/a+X/dI7Al3lfA
         gL43s65CeX1GWARTUyp8Hx++BIcJliprmqUsJHMqd30eW55OP4S9zsla84fbYtB0gvsU
         9FeegedYBivzq8q4mC1SPxjzgpY/E86FBdEewZZI96zy43FyWSN3u7hwftte/qy2uoRs
         p4vg==
X-Forwarded-Encrypted: i=1; AJvYcCU03hACcZ18ZdFi6ZrT8NhhX6QHOaEqYQA19EcCYUHalIHcS41sv5IMh8E9iaUWCjnGgoQNBMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGHQi3Vw4vcsVQGyaRP/BVqEewEV2pksCgtlxpp1P78/3t6Yzl
	jV/6QWaB5t6xTQmEegHyYk8BshvKnY3AhmmVil7AHRbtAdX3kX09
X-Google-Smtp-Source: AGHT+IFvuqLk0pDSsS2e502GBJqZgOsLKcOMi4dt8alPdN+8f2ILQPEhWrtHUdZ6kytYSsGewI9vLQ==
X-Received: by 2002:a05:622a:34f:b0:458:1e37:f82 with SMTP id d75a77b69052e-45c949a3b08mr88344701cf.18.1727429757520;
        Fri, 27 Sep 2024 02:35:57 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f33946esm6251561cf.68.2024.09.27.02.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:35:56 -0700 (PDT)
Date: Fri, 27 Sep 2024 05:35:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ben Greear <greearb@candelatech.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Message-ID: <66f67c7c5c1de_ba960294f7@willemb.c.googlers.com.notmuch>
In-Reply-To: <1a2b63a4-edc7-c04d-3f80-0087a8415bc3@candelatech.com>
References: <20240925185216.1990381-1-greearb@candelatech.com>
 <66f5235d14130_8456129436@willemb.c.googlers.com.notmuch>
 <1a2b63a4-edc7-c04d-3f80-0087a8415bc3@candelatech.com>
Subject: Re: [PATCH v2] Revert "vrf: Remove unnecessary RCU-bh critical
 section"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ben Greear wrote:
> On 9/26/24 02:03, Willem de Bruijn wrote:
> > greearb@ wrote:
> >> From: Ben Greear <greearb@candelatech.com>
> >>
> >> This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.
> >>
> >> dev_queue_xmit_nit needs to run with bh locking, otherwise
> >> it conflicts with packets coming in from a nic in softirq
> >> context and packets being transmitted from user context.
> >>
> >> ================================
> >> WARNING: inconsistent lock state
> >> 6.11.0 #1 Tainted: G        W
> >> --------------------------------
> >> inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> >> btserver/134819 [HC0[0]:SC0[0]:HE1:SE1] takes:
> >> ffff8882da30c118 (rlock-AF_PACKET){+.?.}-{2:2}, at: tpacket_rcv+0x863/0x3b30
> >> {IN-SOFTIRQ-W} state was registered at:
> >>    lock_acquire+0x19a/0x4f0
> >>    _raw_spin_lock+0x27/0x40
> >>    packet_rcv+0xa33/0x1320
> >>    __netif_receive_skb_core.constprop.0+0xcb0/0x3a90
> >>    __netif_receive_skb_list_core+0x2c9/0x890
> >>    netif_receive_skb_list_internal+0x610/0xcc0
> >>    napi_complete_done+0x1c0/0x7c0
> >>    igb_poll+0x1dbb/0x57e0 [igb]
> >>    __napi_poll.constprop.0+0x99/0x430
> >>    net_rx_action+0x8e7/0xe10
> >>    handle_softirqs+0x1b7/0x800
> >>    __irq_exit_rcu+0x91/0xc0
> >>    irq_exit_rcu+0x5/0x10
> >>    [snip]
> >>
> >> other info that might help us debug this:
> >>   Possible unsafe locking scenario:
> >>
> >>         CPU0
> >>         ----
> >>    lock(rlock-AF_PACKET);
> >>    <Interrupt>
> >>      lock(rlock-AF_PACKET);
> >>
> >>   *** DEADLOCK ***
> >>
> >> Call Trace:
> >>   <TASK>
> >>   dump_stack_lvl+0x73/0xa0
> >>   mark_lock+0x102e/0x16b0
> >>   __lock_acquire+0x9ae/0x6170
> >>   lock_acquire+0x19a/0x4f0
> >>   _raw_spin_lock+0x27/0x40
> >>   tpacket_rcv+0x863/0x3b30
> >>   dev_queue_xmit_nit+0x709/0xa40
> >>   vrf_finish_direct+0x26e/0x340 [vrf]
> >>   vrf_l3_out+0x5f4/0xe80 [vrf]
> >>   __ip_local_out+0x51e/0x7a0
> >> [snip]
> >>
> >> Fixes: 504fc6f4f7f6 ("vrf: Remove unnecessary RCU-bh critical section")
> >> Link: https://lore.kernel.org/netdev/05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com/T/
> >>
> >> Signed-off-by: Ben Greear <greearb@candelatech.com>
> > 
> > Please Cc: all previous reviewers and folks who participated in the
> > discussion. I entirely missed this. No need to add as Cc tags, just
> > --cc in git send-email will do.
> > 
> >> ---
> >>
> >> v2:  Edit patch description.
> >>
> >>   drivers/net/vrf.c | 2 ++
> >>   net/core/dev.c    | 1 +
> >>   2 files changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> >> index 4d8ccaf9a2b4..4087f72f0d2b 100644
> >> --- a/drivers/net/vrf.c
> >> +++ b/drivers/net/vrf.c
> >> @@ -608,7 +608,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
> >>   		eth_zero_addr(eth->h_dest);
> >>   		eth->h_proto = skb->protocol;
> >>   
> >> +		rcu_read_lock_bh();
> >>   		dev_queue_xmit_nit(skb, vrf_dev);
> >> +		rcu_read_unlock_bh();
> >>   
> >>   		skb_pull(skb, ETH_HLEN);
> >>   	}
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index cd479f5f22f6..566e69a38eed 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -2285,6 +2285,7 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
> >>   /*
> >>    *	Support routine. Sends outgoing frames to any network
> >>    *	taps currently in use.
> >> + *	BH must be disabled before calling this.
> > 
> > Unnecessary. Especially patches for stable should be minimal to
> > reduce the chance of conflicts.
> 
> I was asked to add this, and also asked to CC stable.

Conflicting feedback is annoying, but I disagree with the other
comment.

Not only does it potentially complicate backporting, it also is no
longer a strict revert. In which case it must not be labeled as such.

Easier is to keep the revert unmodified, and add the comment to the
commit message.

Most important is the Link to our earlier thread that explains the
history.

If the process appears byzantine, if you prefer I can also send it.

Thanks,

  Willem



