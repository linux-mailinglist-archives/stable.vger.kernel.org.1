Return-Path: <stable+bounces-214858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNjDDgN4iGn1pgQAu9opvQ
	(envelope-from <stable+bounces-214858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 12:48:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5AB108916
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 12:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F3EC300C999
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 11:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B2A355027;
	Sun,  8 Feb 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ZHYATC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C603148AC
	for <stable@vger.kernel.org>; Sun,  8 Feb 2026 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770551293; cv=none; b=UgsERxgdLtXfnSAteptIud9bmQIhF3Yrh4RaPWgpkWrfoimBsIXWpAH9MM3IfTE4ZMI3Wn+5g4YWMsH8ZDj2A7gd2DF7jMV833X+lyVgqpjuCsh8pyRwiRjfvReZBrYHPcdlXOCPE+Tnq9+XCHhARF4L+txN75/BVlTits6FSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770551293; c=relaxed/simple;
	bh=kOtJUkHc7QaeZVHQeI7ehTWWIzpadGTi8Vudy6UBKfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCnTvi9l9Y6dkGWcOYg++7X3Wy86u3wT1Tznsd1xQ2IPdTOFC+g+fqYPDwqd1cdXopBUItZk48USoLOGm0H5oULoMaJi5E4ky48VZKQhRN4xSo05ew1yFOA5qJSJnmgWuFdPvhXLqbsYNKUJaL7k6kGOdATHhGuuj/4e5pIe7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+ZHYATC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so39014635e9.2
        for <stable@vger.kernel.org>; Sun, 08 Feb 2026 03:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770551292; x=1771156092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYOGoHWlR/eu7M6OQ2kE1xOB0jjtOqAsLw5aYMd4kfY=;
        b=e+ZHYATCDil7QXla5wldWTQb5Mw8evJ/+FvxcrGSHrdNTuDDER64nn/baIwNuWRKoB
         uxYw4F656JSMrFLzkLVDUFakNUaS3yLpopdHzHX4HRMMLkC0vvFTNCh7x8FgbFORLMUa
         abizx0D8+ViJbwBL5JboCX+VjCINu+EFMCF185nPKRuPp8G5vxaxCwS4++e2BVm+hmoC
         tHjotq+FdEQV4C6v6VN4ey9rpmL6RNSCKI9OarUsfRf2+NwzhXTjJySN5sqGL8k+Vvpn
         XzWxZWF3/wHa54Fo40hJCGVbLYK735Qg+J8kWU3S2wuUBrUJv0T9CSyXoq3efM+uNNja
         l4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770551292; x=1771156092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vYOGoHWlR/eu7M6OQ2kE1xOB0jjtOqAsLw5aYMd4kfY=;
        b=tql1QKPM5Vw4SG8CRzypxlPWS3iNyxSQvgSCFimYRlXueViq/lNWlDQeRuwRvLlPZR
         U3xho+zZICObNU40JZ18mMJFt5RgIIYroyx5AX3i6qafckgAshWLt2b1nRC12Q+RwIlY
         Vu4j9cxXjepniz6TKdYCiconPS2pVwkDlWUT1ru2g+KfqiWTtEp1wl9SmF58Ni2MWAK5
         OfbG5OCnAFNjZVtR/VM4I4RW+a42XCuQbIi3euNEXHpMQVfjqvW7FwONxFayCSNmpluG
         ajBkrdrQuezWmdiupO1HGge4Q9gp7KaaiypAkRp0aCchudWPyKTufncSDr4srvvtancU
         VIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGPCchOEGmfzSdjv7b3UeACs7xsWc819eSom4pMtldy+gyOwmy8TDJzbPLym9ymSq24vBALNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOijYv9qH70SdV88KwGW3JgiAn44SFtD839ZO6rGteE60TLKcZ
	hu6URLzpQuzWBvReHd07PHlLNoRDJ59lrjIg0dSfQS8bbyWuSxR085/4
X-Gm-Gg: AZuq6aJ62N+6/XyudNPo8gk+SHgd8wzjgU+c01SYHwsweK6QiDM2WQ4/2vMfgwlrhnQ
	4rDLfEbF69i7caQu0R2JwQJSw/5VhYAwDuiUoK5jAFegiUbiD/d4+xxMdb9X1D1DG0ajBK9pq64
	izHsOcBRUXCo8NGC0YSqUtpjB6rnPsSqsmRrANRvh7/GvMcjZ9Jyph8kGIa89DGf2oa07qWv9vX
	v6HOX2tRklhR3evjhlVciYMQS8mQMVT+S04Fh9zNVbzoOtMbFJw4SWqzfqbGf6YOXM+NOo0yebe
	fJr4ENU4qI+LWR8awzIN/n/ZfcI+C1UiqvPxw5J57q0zFBtrUIVbfdZTV3tjOgHfBNyc9qg+hIf
	Lea4ILXaPgy9Bt0BnqyTLE+nuuq/OkWNyBeeLC6MtOwbNm/Y4O3z0ShZZIFRJ9GOrhR4U70WXiv
	sbmBehx3JJKy+dO512YLJCuu7qwqf22X47UfKY6lsgr0hGhalust27
X-Received: by 2002:a05:600c:c4a7:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-48320236645mr117866695e9.25.1770551291467;
        Sun, 08 Feb 2026 03:48:11 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d3e245sm276610505e9.8.2026.02.08.03.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 03:48:11 -0800 (PST)
Date: Sun, 8 Feb 2026 11:48:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Gui-Dong Han  <hanguidong02@gmail.com>, linux@roeck-us.net,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler
 optimization induced race
Message-ID: <20260208114810.3709364b@pumpkin>
In-Reply-To: <f6710a1f44d2b32df1cb9b09cddc6695bf76eec2.camel@decadent.org.uk>
References: <20260203121443.5482-1-hanguidong02@gmail.com>
	<20260207104308.1bc31102@pumpkin>
	<f6710a1f44d2b32df1cb9b09cddc6695bf76eec2.camel@decadent.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214858-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,roeck-us.net,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA5AB108916
X-Rspamd-Action: no action

On Sat, 07 Feb 2026 12:43:29 +0100
Ben Hutchings <ben@decadent.org.uk> wrote:

> On Sat, 2026-02-07 at 10:43 +0000, David Laight wrote:
> > On Tue,  3 Feb 2026 20:14:43 +0800
> > Gui-Dong Han <hanguidong02@gmail.com> wrote:
> >   
> > > Simply copying shared data to a local variable cannot prevent data
> > > races. The compiler is allowed to optimize away the local copy and
> > > re-read the shared memory, causing a Time-of-Check Time-of-Use (TOCTOU)
> > > issue if the data changes between the check and the usage.  
> > 
> > While the compiler is allowed to do this, is there any indication
> > that either gcc or clang have ever done it?
> > ISTR someone saying that they never did - although I thought that
> > was the original justification for adding ACCESS_ONCE().  
> 
> They do it sometimes and it's precisely why these maros were added.  It
> makes no sense to me to look at what these compilers currrently do (for
> some particular versions, optimisation settings, and targets) and
> extrapolate that to the assertion that they will never optimise away a
> copy.
> 
> > READ_ONCE() also includes barriers to guarantee ordering between cpu.
> > These are empty on x86 but add code to architectures where the cpu
> > can (IIRC) re-order writes.
> > This is worst on alpha but affects arm and probably ppc.  
> 
> No, READ_ONCE() and WRITE_ONCE() don't include any CPU memory barriers.

Look at the alpha version and the arm64 LTO code.
The latter changes the reads to have 'acquire' semantics to stop re-ordering.
Needed for LTO, but the thought is it might be needed in other cases.

	David 

> 
> > For these cases is it enough to add the compile-time barrier() after
> > reading the variable to a local.
> > That will also generate better code on x86.
> > 
> > The WRITE_ONCE() aren't needed at all, the compilers definitely
> > guarantee to do a single memory access for aligned accesses that are
> > less than the size of a word.  
> 
> I think in this case WRITE_ONCE() might not be needed, but it's also
> harmless and it's much easier to reason about {READ,WRITE}_ONCE() being
> paired up.
> 
> > This all stinks of being an AI generated patch.  
> 
> This is a follow-up to an earlier patch that claimed to fix the TOCTOU
> issue.  I objected to that because in the absense of READ_ONCE() it was
> not guaranteed to do so.
> 
> Ben.
> 


