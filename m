Return-Path: <stable+bounces-95326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF8F9D7814
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 21:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3307282144
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 20:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20BE156960;
	Sun, 24 Nov 2024 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIRt6Y7e"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC5163;
	Sun, 24 Nov 2024 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732480116; cv=none; b=IM5AWSf5YOjJxmnP3SrsQs5E88CK7wZjq/vCbpDhXY8MklaMSOX1awnlNpf3xbaHioQzWVBYGNeLoVm/0x8hAn8YtEm3fsdGpR17u2hlqu4TJ8WXW2KBGjzqv9yCUvey3peZ5x82kwAqdVDItZxo/AeHJq47UFzWxK8SShBX1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732480116; c=relaxed/simple;
	bh=0Je9YPam0AieU+g/MAjzikhB6nBC0viQCKBhZr7Q3YU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Td0kCEqP5mCKz6+R3qLUBV2V0aRjOjfTmUyLii12KolelUJP1BgUmUvk2pzedwAziRJhJfp59GlhdQxR7jQd1FtT0v+b3qRCeU0VLSUrcXfrRbOJFdSc7W5Ri0oTz5QGR9gVgwnsX2/WJNXg8YpHUJoLQu/G8eETjbLDEQhUYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIRt6Y7e; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d40bdbb59dso29684576d6.3;
        Sun, 24 Nov 2024 12:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732480114; x=1733084914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Az3U59pd8rnLpI+8mN2vKBtnG79d4T1IBg4APDcgsBA=;
        b=UIRt6Y7e3qmVgu3dWSFD/TjjSbXLJlg9TkQ9bQzZCg1TFksjGkO0tcCxjhMEE0S0tN
         d2/JxNq48VJndmfTVUo1cIefcZtT4OJVV1PeiGd/OTjwnrgDNxJh3iVKKckDEB949r6V
         AMEj9n/AW9qB2dMKZ9Tps2ZTrO05OY67RC9p+W3RTvhHIHsQL9ZNsbgDdKLHgvZKSs/L
         +p78jB1VW7AaZ0hB+UQ7xQBb96ejP6o87D3DDenhbYKUFJ6cn4brjYe6hoBkujWjRtkP
         bheo7cdzII6ncggFsC5SXc6nBJZj6ZWjE2dYSM7DRxcL9sKhDnnW0a0VjSQFiItyZhFi
         dJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732480114; x=1733084914;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Az3U59pd8rnLpI+8mN2vKBtnG79d4T1IBg4APDcgsBA=;
        b=EQakIxLh29oiSt/EwVVIECvDHfUHKONCkaJFDrP4xOIgDK83lLfJ55SCwsYnyHlH/c
         OYpzWrHFAWvOQdwLxkKU/EzKKuCwpEZiHEY/Hu7NePko1xYCzmnJ4twHHNHBx8a/OV+c
         S2vw/3i2DKTJXZezgYKeY47i276LfIKsW0/j2Y20A+LLWVT8qrYZfYSOsRdjrzBvH2ye
         P0/AWec6iMzqJZWalDg5Ka5kb+pngcBbS4tR1KJrhej8FwgQ+7+jilZq3rsrBJfLBcUP
         qcPo8RJsiWS4Hv9ktqrdNCuPVf/LAAG6xYBCgP0Hmg+SsTnOjzmTewXSdlVfp+Dxd/Hb
         rcrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO8oN0nwe9imMVL5U12BEDOSkA93u0xyGUIlGsMjCNbnFECXsLhwSzT6RsfpK6SSQ3rpPt6vs=@vger.kernel.org, AJvYcCXtTxFA2Ty2PDyqCzGU7czJqTfl5MEgOFjRaV8wg1knbulocgXHldc/ZivygkDglAbUq01k2yL4@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYNHdamFVcLF2MQXHyXePECKTQL3lSUE5ez0P2BVsgnS/2Fi8
	kJRRMASNFz41c7XqsatJVMD72asacyHMAn20Bi1RarXjZ8VLtzVH
X-Gm-Gg: ASbGncsjBXojZKYf+lgvdS4o2wVyTmJLiQza18zihgYftbgpKUZYpG49tWSNSYHNi1W
	fzL9eOCq9QjlFgKokjO4SZSQlSDKqMU/ZPoZhHBcr9h8fQePRwv1k/z/1cQboo8mMshCejHtCT1
	hiJh5RYJLYJWP7rQjlYi/QRX8/U657vz5TCQrCE1Mgo80EptCtrB3n6ZLaQNexnZ6XJ+0lqKEjJ
	KwkZ6wx38nXarLW/Gzr6fSA1H5eCUSYJO0TYYP44o+u7uLFoQRQG4IKVxhWJMmpvVQvBzSjBOlV
	7l6CG6evJ5jxHjEh3w/pkQ==
X-Google-Smtp-Source: AGHT+IGpt1b+FnQ2WR52hOg1PAbzA8Qfe9WcYSEkfRqTfRRnoVtfrqsNqaJIyYC1piiapvi0lbWqdg==
X-Received: by 2002:a05:6214:252a:b0:6d4:246a:7362 with SMTP id 6a1803df08f44-6d4514b4545mr185037816d6.42.1732480113637;
        Sun, 24 Nov 2024 12:28:33 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b23b1esm35098756d6.85.2024.11.24.12.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 12:28:32 -0800 (PST)
Date: Sun, 24 Nov 2024 15:28:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, 
 Ivan Babrou <ivan@cloudflare.com>, 
 stable@vger.kernel.org, 
 ncardwell@google.com
Message-ID: <67438c6fe292b_2f7566294d0@willemb.c.googlers.com.notmuch>
In-Reply-To: <87h67xsxp1.fsf@cloudflare.com>
References: <20241011-uso-swcsum-fixup-v2-1-6e1ddc199af9@cloudflare.com>
 <87h67xsxp1.fsf@cloudflare.com>
Subject: Re: USO tests with packetdrill? (was [PATCH net v2] udp: Compute L4
 checksum as usual when not segmenting the skb)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> Hi Willem,
> 
> On Fri, Oct 11, 2024 at 02:17 PM +02, Jakub Sitnicki wrote:
> > If:
> >
> >   1) the user requested USO, but
> >   2) there is not enough payload for GSO to kick in, and
> >   3) the egress device doesn't offer checksum offload, then
> >
> > we want to compute the L4 checksum in software early on.
> >
> > In the case when we are not taking the GSO path, but it has been requested,
> > the software checksum fallback in skb_segment doesn't get a chance to
> > compute the full checksum, if the egress device can't do it. As a result we
> > end up sending UDP datagrams with only a partial checksum filled in, which
> > the peer will discard.
> >
> > Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
> > Reported-by: Ivan Babrou <ivan@cloudflare.com>
> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Acked-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> 
> I'm finally circling back to add a regression test for the above fix.
> 
> Instead of extending the selftest/net/udpgso.sh test case, I want to
> propose a different approach. I would like to check if the UDP packets
> packets are handed over to the netdevice with the expected checksum
> (complete or partial, depending on the device features), instead of
> testing for side-effects (packet dropped due to bad checksum).
> 
> For that we could use packetdrill. We would need to extend it a bit to
> allow specifying a UDP checksum in the script, but otherwise it would
> make writing such tests rather easy. For instance, the regression test
> for this fix could be as simple as:
> 
> ---8<---
> // Check if sent datagrams with length below GSO size get checksummed correctly
> 
> --ip_version=ipv4
> --local_ip=192.168.0.1
> 
> `
> ethtool -K tun0 tx-checksumming off >/dev/null
> `
> 
> 0   socket(..., SOCK_DGRAM, IPPROTO_UDP) = 3
> +0  bind(3, ..., ...) = 0
> +0  connect(3, ..., ...) = 0
> 
> +0  write(3, ..., 1000) = 1000
> +0  > udp sum 0x3643 (1000) // expect complete checksum
> 
> +0  setsockopt(3, IPPROTO_UDP, UDP_SEGMENT, [1280], 4) = 0
> +0  write(3, ..., 1000) = 1000
> +0  > udp sum 0x3643 (1000) // expect complete checksum
> --->8---
> 
> (I'd actually like to have a bit mode of syntax sugar there, so we can
> simply specify "sum complete" and have packetdrill figure out the
> expected checksum value. Then IP address pinning wouldn't be needed.)
> 
> If we ever regress, the failure will be straightforward to understand.
> Here's what I got when running the above test with the fix reverted:
> 
> ~ # packetdrill dgram_below_gso_size.pkt
> dgram_below_gso_size.pkt:19: error handling packet: live packet field l4_csum: expected: 13891 (0x3643) vs actual: 34476 (0x86ac)
> script packet:  0.000168 udp sum 0x3643 (1000)
> actual packet:  0.000166 udp sum 0x86ac (1000)
> ~ #
> 
> My patched packetdrill PoC is at:
> 
> https://github.com/jsitnicki/packetdrill/commits/udp-segment/rfc1/
> 
> If we want to go with the packetdrill-based test, that raises the
> question where do keep it? In the packetdrill repo? Or with the rest of
> the selftests/net?
> 
> Using the packetdrill repo would make it easier to synchronize the
> development of packetdrill features with the tests that use them. But we
> would also have to hook it up to netdev CI.
> 
> WDYT?

+1. Packetdrill is great environment for such tests. Packetdrill tests
are also concise and easy to read.

I recently imported an initial batch of packetdrill tests to ksft and
with that the netdev CI. We have a patch series with the remaining
.pkt files on github ready for when the merge window opens.

Any changes to packetdrill itself need to go to github, as that does
not ship with the kernel.

I encourage .pkt files to go there too. But I suspect that that won't
be enforceable, and we do want the review on netdev@ first.

One issue with testing optional features may be that packetdrill runs
by default on a tun device (though it can also run across two NICs as
a two machine test).

Tun supports NETIF_F_GSO_UDP_L4, so that should be no concern in this
case.

One small request: to avoid confusion with CHECKSUM_COMPLETE, please
use something else to mean fully computed checksums on the egress
path (which, somewhat non-obviously, would be CHECKSUM_NONE). Perhaps
SUM_PSEUDO and SUM_FULL?


