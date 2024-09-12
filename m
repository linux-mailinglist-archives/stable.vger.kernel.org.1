Return-Path: <stable+bounces-76007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A133A976DC2
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 17:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6A282880
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A91B9B24;
	Thu, 12 Sep 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq1jFHvQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F81B985C;
	Thu, 12 Sep 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155017; cv=none; b=fQ9x2MMPk+attc8vZ+C2Ehc2bzko2vz3RmVdmcE+05qdvaH9VO5z7FMMJrmZ89soGzFhmg0MgoULrjeww+Z4lYyXUpEQv5Fg2+J3YC6lHdNYUsAxJzESX8ejipxZNmobgSL9AhoDMS97eTQFBDHfrN98FECDDje2f0X8PeVtyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155017; c=relaxed/simple;
	bh=qQTOg+IJOsn98zT3QvgYk5c7hbSOupBE048v9/P95sc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ooF24X51+5TfijH7T8FiB9xVcN3BYRZUVRA5RLYmV/mhVJevkJAxEOdJ5EnW99TEWZUApn17pRW+x40NTajj1dvYDkRLQT9QOBz5w5iXspKqcM8Wuue/EhrrHHqcp8i/oYndnRvF+z3gmULmZOe2/jbHh+FOB1YSdDMuk++OFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq1jFHvQ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c36ff6e981so7934776d6.1;
        Thu, 12 Sep 2024 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726155015; x=1726759815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzQ//Zmwg8ZB3RFvD+IfKswXS2rr/GeMASlwd0TM1Ns=;
        b=gq1jFHvQfbUsq8gygCpAzO9VDAq2BIAqfaKaMd+R2HkhcCR+9kSIKgfHGzg7x3Suhh
         f5lgMGRG9fYIYD6uLGOgp8g4D6Tt1jFx14vh8FutwlxG2L67E0ylpar0iRXZvgKQEhSd
         NkbNnyNTAsu59XF/lyRfW1YXM50ThYyYI9TOC9pELUy3cuIaw/kGeu7lHqDNsE6pcXpU
         mxtsFfodTPnUq8WE5vECig/kKMGgy/yF4sM3W1GwGcx0QlWCWVA0cF7pZR2E++slwfie
         VLFfIkca1otLSuQrrTacFJ/1eW1NZa3BRsCFdIGH4VkTB2UwfUJUgBrVyHWpWnlSlay1
         JBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726155015; x=1726759815;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vzQ//Zmwg8ZB3RFvD+IfKswXS2rr/GeMASlwd0TM1Ns=;
        b=q6lZnBjSzjOd/K5TnKDw2FIaIRiYAN1rZJDgeWVu7n1nWNs6n58C840WJiuBK6AgRi
         F3sIwlQg5aViN/EE8mLVMdE3Z48je+9V4q8T2luqdxKTWjha0nPbnsE1d7FRE4acbCdS
         Mci29Tsu3Q1gxn01z4KLCcjopoXxl0PuhkA/SI9QWqNeBPc9Q7aLWN6/h1I6bsawuYnZ
         EHWCWjBFbxnbAEDO1eTRbkOdjkwwRwhDizUTu8zmaxlDGr3MCnYLf4ktbb56a6NYaLlo
         FDFf47KoiPyeuoL3gI4fVBcLC3SsIbhOnUeNTfojpWcjPhb1bgvBKGs3WIGbjmRdSLjh
         qkow==
X-Forwarded-Encrypted: i=1; AJvYcCUca8trnnHZ9qwjQdQZsHUQVPJWMWR2cVeBfa8594Xb5bcT0GZ4asQuCRPoaUTmlfc65U4mWbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmYl6Ao3u4u06PFMOEhN8lEQ/33VdRWKuWoS6WZtpzE0gh1nl
	+F0dKWNzWNLn/CZS1sEagwW04Db9eMxAht6pCM7GF4vw0n0KnUuu
X-Google-Smtp-Source: AGHT+IGOSJPDM1Xc7/132FHPEy5rq9fxzCfBs8p/wBVHlqoYcwnM2dw8dBo0wjMVSSH/FEQr6tuCpg==
X-Received: by 2002:a05:6214:5245:b0:6c3:6e5e:64d4 with SMTP id 6a1803df08f44-6c5736c8fdbmr52445606d6.32.1726155014803;
        Thu, 12 Sep 2024 08:30:14 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d8ccsm55627696d6.96.2024.09.12.08.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:30:14 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:30:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 stable@vger.kernel.org, 
 nsz@port70.net, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 yury.khrustalev@arm.com, 
 broonie@kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66e30905d46bc_15199d2945c@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZuLvCTYl3bhN9C6r@bogus>
References: <20240910213553.839926-1-willemdebruijn.kernel@gmail.com>
 <ZuLvCTYl3bhN9C6r@bogus>
Subject: Re: [PATCH net v2] net: tighten bad gso csum offset check in
 virtio_net_hdr
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Sudeep Holla wrote:
> On Tue, Sep 10, 2024 at 05:35:35PM -0400, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > The referenced commit drops bad input, but has false positives.
> > Tighten the check to avoid these.
> > 
> > The check detects illegal checksum offload requests, which produce
> > csum_start/csum_off beyond end of packet after segmentation.
> > 
> > But it is based on two incorrect assumptions:
> > 
> > 1. virtio_net_hdr_to_skb with VIRTIO_NET_HDR_GSO_TCP[46] implies GSO.
> > True in callers that inject into the tx path, such as tap.
> > But false in callers that inject into rx, like virtio-net.
> > Here, the flags indicate GRO, and CHECKSUM_UNNECESSARY or
> > CHECKSUM_NONE without VIRTIO_NET_HDR_F_NEEDS_CSUM is normal.
> > 
> > 2. TSO requires checksum offload, i.e., ip_summed == CHECKSUM_PARTIAL.
> > False, as tcp[46]_gso_segment will fix up csum_start and offset for
> > all other ip_summed by calling __tcp_v4_send_check.
> > 
> > Because of 2, we can limit the scope of the fix to virtio_net_hdr
> > that do try to set these fields, with a bogus value.
> >
> 
> I see it is already queued and extremely sorry for not testing and getting
> back earlier. Good news: it does fix the issue in my setup(same as reported
> at [1])
> 
> So, FWIW,
> 
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>

That is great to hear. Thanks for reporting your results, Sudeep.

