Return-Path: <stable+bounces-126950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9106EA74EC9
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FE33A6531
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C91A08B1;
	Fri, 28 Mar 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRxisfrX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D63C0C
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181380; cv=none; b=VsyJqufC5bg7YgwmbP1HYu6Sv7RXEjHCDLUUJHuL41zDw7/lu6ZOTpmk9HOJluZaZBjq2boT5IBbaZLEXkBmxxgdngEjWu1+KzYvuW8wN2jESf0pCWmIpr2GZaFdlKnun/p+plZhcZmUsfUUs8pbGbq5vBsTHTyE2vfB1qpFdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181380; c=relaxed/simple;
	bh=FA4sFTKSq0PTrHNWzq8d3A53QRh7G+N70/Y5dYnUgZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGe0xFlD6s4srvV1hiX2L6SfLkITaFLU29q9OhumCE5/SX3LmMZoWG8CsWm/HSnVwqxXfJJ2+DOh11+Yzxmo8WxPWwpTi0monM8ODrJ+Mi6KJvKUWq5XoYg2me5uNBOaf+xMONvz4ifh3bmhxdoBPhePElZgzrD82lePl8TmKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRxisfrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38205C4CEE4;
	Fri, 28 Mar 2025 17:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743181380;
	bh=FA4sFTKSq0PTrHNWzq8d3A53QRh7G+N70/Y5dYnUgZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRxisfrXoCGsYnWTX/i4+Zzffw6l5QUpzfqcjNVWQNwlWo+3sTuow7oGbWFPxLzDD
	 xgvp0hfa2BSqGvDWsvTJs4vyOoy8Nae1xj2/2ADx2VKPRux57tiTHAqQw7gbR+/G3V
	 xecdcUMB4Bfy6Zuy7HqtjAj0LpPxTk7sNOsZRv9XrPLRA0dN/DLgkYPDUaVaZcoNZX
	 bZh72FhOoX3N1pW5yaoQfMvxKFY16zuYalQC9+alhtI+R22LD/dbIYISHJidn3wIYW
	 no5w84WHWNn90F26YEQd9Dnwy+pzt/01t//OoDl/f1iYx2gYeeKjwb6VzFr0trCofJ
	 5CqNVzSoisGSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] gso: fix udp gso fraglist segmentation after pull from frag_list
Date: Fri, 28 Mar 2025 13:02:58 -0400
Message-Id: <20250328114546-f312958172582e49@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250328052315.1205798-1-sdl@nppct.ru>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: a1e40ac5b5e9077fe1f7ae0eb88034db0f9ae1ab

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexey Nepomnyashih<sdl@nppct.ru>
Commit author: Willem de Bruijn<willemb@google.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: af3122f5fdc0)
6.1.y | Present (different SHA1: 080e6c9a3908)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a1e40ac5b5e90 ! 1:  a211317985866 gso: fix udp gso fraglist segmentation after pull from frag_list
    @@ Metadata
      ## Commit message ##
         gso: fix udp gso fraglist segmentation after pull from frag_list
     
    +    commit a1e40ac5b5e9077fe1f7ae0eb88034db0f9ae1ab upstream.
    +
         Detect gso fraglist skbs with corrupted geometry (see below) and
         pass these to skb_segment instead of skb_segment_list, as the first
         can segment them correctly.
    @@ Commit message
         Cc: stable@vger.kernel.org
         Link: https://patch.msgid.link/20241001171752.107580-1-willemdebruijn.kernel@gmail.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
     
      ## net/ipv4/udp_offload.c ##
    +@@
    + 
    + #include <linux/skbuff.h>
    + #include <net/udp.h>
    ++#include <net/ip6_checksum.h>
    + #include <net/protocol.h>
    + #include <net/inet_common.h>
    + 
     @@ net/ipv4/udp_offload.c: struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
    - 		return NULL;
    - 	}
    + 	__sum16 check;
    + 	__be16 newlen;
      
     -	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
     -		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
    @@ net/ipv4/udp_offload.c: struct sk_buff *__udp_gso_segment(struct sk_buff *gso_sk
     +						  ip_hdr(gso_skb)->daddr, 0);
     +	}
      
    - 	skb_pull(gso_skb, sizeof(*uh));
    - 
    + 	mss = skb_shinfo(gso_skb)->gso_size;
    + 	if (gso_skb->len <= sizeof(*uh) + mss)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

