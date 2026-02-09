Return-Path: <stable+bounces-214896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKF5N/WtiWndAgUAu9opvQ
	(envelope-from <stable+bounces-214896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 10:50:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ED310DC55
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 10:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C25FD30065E1
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CDA364032;
	Mon,  9 Feb 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkrESqaO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5A353EC2
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630642; cv=none; b=jjZP9r7qBZEBTT3EuORgsuD536JZacIRRT4uzx4Ck1atBN5HjUKweIAQuv/gMH/Xj+dnawRpUc4s4zIyvtUpYyDjcDntX4+MwqdiRWPOt999JAz15YsikcodRW7ivOKb2ZW8Tq7aXl5kX92SAGBDFd54jdkplZtjSxp6dtfb1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630642; c=relaxed/simple;
	bh=G0AZtPKM9LqmL8+9X5WtJjbdlbwoTFZvZ9q6vhURmcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rw3H1noVelxAICLMLxQRGZXm80L66hHKw3lcFlOFONEw7oOw6xjQToo1JjtlmmdtBUOuMzg5VWT3HInRE6480HvqIZTm/NLg9II6KuhrIC41bQcL6mX55IshFf6XGc+be2bgkibAKq8oER87GYAXX9o2/Pd6EHwC010baBDoN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkrESqaO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43622089851so3427247f8f.3
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 01:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770630640; x=1771235440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3Fl1LdKzLTKTPiN1YZNuSPUICwP+bYYrhH9RATSKdE=;
        b=QkrESqaOo2uIYUQEwMF7O1u4QzRqqiSn5/5X1VnxFmhyw6qP93+e8lmjeeyi/sZE8v
         xZEsSmrlfYXCoFP23EPEsXR61m8kLjdqDpF84S9JU8mKOGh48aPJtvAn/Bdh77n5YdIS
         59ZuwsOEcWaHAXyan48s10JC3O4nWZrs6i6+r/9g/12gllOIenR/Y49A8k4h8lYJ90Aa
         Ou37v4UpM5s6zXTxlANh5ZbyFyt6Hr/n9d4+Z1XUQJcIo8hDhXWn8cceuxy98wXJKHhT
         wysYEsCeOpF6InYOYS4x9c95sXciZCVCnoiv3j6kcav5TrL954V+5Ud4flW6RNMCmyTu
         eQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630640; x=1771235440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G3Fl1LdKzLTKTPiN1YZNuSPUICwP+bYYrhH9RATSKdE=;
        b=hluBud5IKgnVIJlZ/nsHeKn9DCbGrCZIfsaJB5UvwIeH7lXZ4SvpidJ+66UkrqbTlZ
         nfBXqbD1X+nUSjU88G83DDOhbOsTF5SsFT2rzTg461mGvEYX2OjqI5KCEsqjc9Brg0Oo
         GhQAjBYxZKozfNDcpPq2y4hqndVX86sOnF77BmdNvQea0uYFfZerIscPz0EwUOCuFnxf
         u8WWyE6Kw+rGRmmwtbuKihTptKPQygrAWaUVCr2ncz1y5zdFaPqPvJgB2W587RXxtAvZ
         VOHVMNEG9sUiup8jB0tYRrLTiGPTbsm7/euapXMwAb2FPh1VIX9LzZ33g9XgECwApvVR
         Z/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3e0T4M8ILP/Z/FuIgW/Aw5vO+0hkZ0Lc84NnHqdyokebh1SGeuxq5lD6Fe+CZd/MBKh2CF1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAESeaSJvF9A7l2dPzhaQV/L3OPsdxuCgQq+dRJXVxNWinfdQ5
	ouhkdSZlzpDV+z2skwCaRHeUP0slQWHIwZ6Xds1vay8MKu0wj/gYG6Cx
X-Gm-Gg: AZuq6aI64kSYwq8weI+VF2YZEpt5b8RWCB3BnCe+ewvcWzgSfPan71lqMgeuYC9krTp
	UiPzqghCWTTPJP+zmMuvOeF+Ch4oCvjGMdOUK3Ynu6c9fYCeH+tpJ9tQQRfhEIoZ+QR46Fu7GHe
	6rAmOrPlzNmGxocRSKeWP/hfkMrSNpKB+33BkpQrIOvKVtJ8RTmaHUlFDIg14cYLjR9QM1zqG0K
	4x63pYyofTgJ+U5M2UW56/A5jWlsV/5v+ontnRrNfkqJe2SikBbAUD1GfHhAN8/UdUjEIq9Ve5n
	JrAw5nXyF3rTqgZ9GiqVT2df7zibsch4ubui3azEyxGm3j9iuczLmpdGSTeln+/lw3kSB21Mn6p
	4v8BVUMeFxNXN4cY4dIjz7epi33TMGS5S9QeEmqEyH0zd/3wZn/9mE/EEC0e1jQqzpj9/nscQXt
	Ij+b/++QgZUBkGEGIbRtHIU/pd4NZ4LLoaERNw5wADnttmryh4a6nI
X-Received: by 2002:a05:6000:3105:b0:436:42cc:25ec with SMTP id ffacd0b85a97d-43642cc27d7mr6508644f8f.9.1770630640051;
        Mon, 09 Feb 2026 01:50:40 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-437699bc1cdsm11376577f8f.7.2026.02.09.01.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:50:39 -0800 (PST)
Date: Mon, 9 Feb 2026 09:50:38 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Gui-Dong Han <hanguidong02@gmail.com>, linux@roeck-us.net,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler
 optimization induced race
Message-ID: <20260209095038.50e62eda@pumpkin>
In-Reply-To: <000915fc444a6e1f840f3d4ed6493058aefe850f.camel@decadent.org.uk>
References: <20260203121443.5482-1-hanguidong02@gmail.com>
	<20260207104308.1bc31102@pumpkin>
	<f6710a1f44d2b32df1cb9b09cddc6695bf76eec2.camel@decadent.org.uk>
	<20260208114810.3709364b@pumpkin>
	<000915fc444a6e1f840f3d4ed6493058aefe850f.camel@decadent.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214896-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,roeck-us.net,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,decadent.org.uk:email]
X-Rspamd-Queue-Id: 80ED310DC55
X-Rspamd-Action: no action

On Sun, 08 Feb 2026 23:33:31 +0100
Ben Hutchings <ben@decadent.org.uk> wrote:

> On Sun, 2026-02-08 at 11:48 +0000, David Laight wrote:
> > On Sat, 07 Feb 2026 12:43:29 +0100
> > Ben Hutchings <ben@decadent.org.uk> wrote:
> >   
> > > On Sat, 2026-02-07 at 10:43 +0000, David Laight wrote:  
> > > > On Tue,  3 Feb 2026 20:14:43 +0800
> > > > Gui-Dong Han <hanguidong02@gmail.com> wrote:
> > > >     
> > > > > Simply copying shared data to a local variable cannot prevent data
> > > > > races. The compiler is allowed to optimize away the local copy and
> > > > > re-read the shared memory, causing a Time-of-Check Time-of-Use (TOCTOU)
> > > > > issue if the data changes between the check and the usage.    
> > > > 
> > > > While the compiler is allowed to do this, is there any indication
> > > > that either gcc or clang have ever done it?
> > > > ISTR someone saying that they never did - although I thought that
> > > > was the original justification for adding ACCESS_ONCE().    
> > > 
> > > They do it sometimes and it's precisely why these maros were added.  It
> > > makes no sense to me to look at what these compilers currrently do (for
> > > some particular versions, optimisation settings, and targets) and
> > > extrapolate that to the assertion that they will never optimise away a
> > > copy.
> > >   
> > > > READ_ONCE() also includes barriers to guarantee ordering between cpu.
> > > > These are empty on x86 but add code to architectures where the cpu
> > > > can (IIRC) re-order writes.
> > > > This is worst on alpha but affects arm and probably ppc.    
> > > 
> > > No, READ_ONCE() and WRITE_ONCE() don't include any CPU memory barriers.  
> > 
> > Look at the alpha version and the arm64 LTO code.
> > The latter changes the reads to have 'acquire' semantics to stop re-ordering.
> > Needed for LTO, but the thought is it might be needed in other cases.  
> [...]
> 
> Oh, so they do.  Sorry for "correcting" you based on my old information.

I'm not at all sure that the field which just need protection from TOCTOU
and load/store tearing shouldn't just be marked volatile.
ISTR that part of the original objection was that not all accesses needed
it - but the static check code seems to be enforcing that now.
Marking things volatile mostly stops the compiler doing CSE - which is
exactly what you want here.

	David


> 
> Ben.
> 


