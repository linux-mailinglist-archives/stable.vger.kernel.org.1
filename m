Return-Path: <stable+bounces-253865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEKvL5X4EGp0gAYAu9opvQ
	(envelope-from <stable+bounces-253865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 02:45:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F71D5BC283
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 02:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF81C304A6DD
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 00:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797FE214813;
	Sat, 23 May 2026 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIMpXNCH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C81F4174
	for <stable@vger.kernel.org>; Sat, 23 May 2026 00:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496844; cv=pass; b=RH7DYbgE9srtia6FoMhzfDK+B2g28ULLVHG/p5cPFV2/HfAxm+DVM1zS7+oRwtCzW67zaT39k7gsIYk3kvgSZW4bAPuPMJNjA7zeyn4gG5a65pjvdSLsqA3n3qjRD0+CLkVMpUh7gRW7855tMBv/80qoUC7udEuoRcu07vukcl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496844; c=relaxed/simple;
	bh=DzImTxEIdLT7uoHzI85KHDAQ5RrAcxR1yc9QoxOoDBU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sjvRhi+SPRUiQfKw/5Q68DF77z4lwQMAeW+PiNR4X0ElDu6WAJ0rLTO4oI4igWJ7LH16t+HtQABoMvIk5B/E+iOuI74Js1Ho03spJXvcins7g0z002h4Qk/XC+2UkqSqrDWkP0rAwb54cq90qKpNWuUO9YY0315I/oqFgmzVNEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIMpXNCH; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bda62f13d90so644774766b.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 17:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779496838; cv=none;
        d=google.com; s=arc-20240605;
        b=ihCSdfiNIJVVgVP3yMQ4LrMTQj7etrFFpin9RZIm9gJwUuwEHDFBY+EelyQijf5D5h
         BSMg3DRtHzgKe82IOy8BfPJl8de4yxQiLdzxc/3NEiwxjsjr3J/WCBjkOWl2K32L1+aY
         AEP18Cy9U9pzwNCA94mQC8xrK+4yP52R9xOskgbEE/dXLKWFigx1cWbcuS6RjQQ3W1WI
         IXcNTQtASJ9sCqct9rrJs83Hr0ld5z9mZ3LKES8bnUhtiRQwlDpfa5qtqqov2pWDcWBr
         mJxiQL2ijs/IOG4zUOJ6ZL/nEXOUnyXqv3Av604PZKWVlSFhQcKh295bW1XM5XVW+ryx
         7GiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=DzImTxEIdLT7uoHzI85KHDAQ5RrAcxR1yc9QoxOoDBU=;
        fh=G+UOajs5fTt3b3WKl8aYem2FAuYbUvUhl0bozpeXreY=;
        b=ig2xirUx5nwr+0rx+BlhgGRkcY0U5/dD0SATvFrq0vajkE/8DE4X50s8Sk+6SZY/3I
         G4ufo1YZq4d01YTx038BYguqgzytkK1X/pM47gdc8GUrEWIxmusiX37/ldEnmNQQCAYj
         1dTOWDuY3JcIC4aVabqNKASmcH6uZBBWtyK/26OFjnug3Z/iUc89R0Z2hpbJzZSSXPgr
         zaX8txrL9w1TPzB4OTbVls4sI4eKqgDyDgaUvxIIbatgb4G++/HiST5eWrqqpYjQ6+sa
         /DI6l6+Z3CXZ9sHns9jMBdyOBcDpVA6j/ecYe5V1JbP0vWvV/TU+C7rtTFYOu8X/Epv4
         JvSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779496837; x=1780101637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzImTxEIdLT7uoHzI85KHDAQ5RrAcxR1yc9QoxOoDBU=;
        b=bIMpXNCHxQK0qeDM/HE5qa1FoK4ujNYSgSghrulReXq0Xa3e9sJgwn7K0AIGFeWJpB
         m8EmEKUZX4eCFlyAvkYLTsB19S3LpBF1Bi+8PjCHhoM4kDNA6i3h2TPhsexang+qMugU
         2JCNlbvYvGO24kZSnCrsrTHIJfD+MUoCdYEmeO2O41Xh5o0+9gJtY1QZxJklZokkCcXR
         PAYd8wPNdEPLdVRcpJGygWr2VDC1SaozJyJwuRxUyKwYJkP+98gNBAeEr2GCY4vQOHO6
         ZLvnfpuupfMYmx3PEw6vANE2oMCXW7VXkWisB68Tt2FcR+iqwGbMsyhIyvFhY4txjAqB
         29OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779496838; x=1780101638;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzImTxEIdLT7uoHzI85KHDAQ5RrAcxR1yc9QoxOoDBU=;
        b=ZHI6ihbwP4obHSZdtvNpvD+mGhOPvuVFyo7yMF0BvcamVIfdarsk9bWMCLX7rM21Ob
         GC9lt31bRSEMB2uCElYL+FSRmknYPOAINmm9l8Htok24TaENudjy4T2XVQFOC6y2qCD9
         QCq9GwRlSP0Czny6GcMEkypKojv/E0SLCROM90mwP/tlL4BD2EazEyLsoxVH93jQpHWu
         tdplzXag2SqIFNlvlCwKcBqlG9Uz593D0NA++8CbvSd7/myAWohXtOYNreLkmi1JXPPc
         6INdsnRksOLfjl21epz6tj+H/o+KThx8MViXVrmLjGAGEdPiDNxyg2atTi4DXzIxk6U3
         UGoA==
X-Forwarded-Encrypted: i=1; AFNElJ8ja9v70t3NU/LsU2cGkjBJA0+MmF2zTB0dC4tlfx0W+qW9fCaKK1IMvSSp8pHvLnQX0XdpW4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE9WFG1rTjfpgNNiN/4gLDkAuHd+Ah6mKGJDNk7I30duV2jqGn
	c/QL10sFtp8B4pwWJDELaT7woNDhIyIPHlxawT8up4NGkeEb1Uklm9M4VqLklCgYpLLNMQ6Y3IN
	f38eCqs64RYFmBhUldXsvFgm1Ob2gDCGwmQLA
X-Gm-Gg: Acq92OEXd++nLY+zOKBQVn2x2h+1xt2Nilgmy9wR8qPJGf11mUntQh8XiWKDk2iw0hG
	R+sxi5PyRqnrlDjCAcxfVlS3Rj9TVaMCsRgxEF5l1J0FKqSzLwL4wEgcwmRJDS4NCU6018wK0NF
	sUwaHJpZfgCgZqhifmDOTFWQ9vOGWRmbusUulHm5LvChG3+OIC7J0sOskQ53ULVKb0dIAOl8r/n
	qUxtU/orvZ080jU0sVnBt+ydjgBN9Bk2AufhFWe/g0hsV6gOnF7zTSycRrLZF/5YlaDnGChK33u
	Xa3diZ6XvBqG9K/ibwq0R+3GdQI7tWhdYxGbp81vvTV21qfz1g==
X-Received: by 2002:a17:907:1dec:b0:bdc:fafe:bf66 with SMTP id
 a640c23a62f3a-bdd263c9230mr293031666b.33.1779496837246; Fri, 22 May 2026
 17:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Fri, 22 May 2026 17:40:25 -0700
X-Gm-Features: AVHnY4KUuDYdbAhs4DxPRoruchoX4HF4FN4Q5Flh4ze1fOCs2dB2rccyA0BbHhQ
Message-ID: <CAKSQd8WP4sue4Pzf3yK67iMUkPth2xG1CrpUko__JF80i39=ZQ@mail.gmail.com>
Subject: Re: [PATCH] x86/tdx: Fix zero-extension for CPUID emulation
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "clopez@suse.de" <clopez@suse.de>, 
	"x86@kernel.org" <x86@kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253865-lists,stable=lfdr.de];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ludloff@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[ludloff@gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5F71D5BC283
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 03:14:54PM -0700, Dave Hansen wrote:
> CPUID (the instruction) is defined to fill in eax/ebx/ecx/edx.

In the original x64 spec CPUID inherited 32-bit op size from
the pre-x64 days, and although established leaves might all
have followed that definition, the ISA per se doesn't prohibit
an implementation that allows, or defaults to, 64-bit op size.

Having made that statement... the same does go for MSRs.

> Those are 32-bit registers so the normal register rules apply:
> "32-bit operands generate a 32-bit result, zero-extended to a
> 64-bit result in the destination general-purpose register."

...in PM64 ...while outside PM64 and across mode switches
the upper 32 bits are explicitly undefined. Needless to say...
SMM and then VMX and SVM had to violate that to function.

> So a properly-behaving CPUID implementation will always end
> up with the top 32 bits empty on the four CPUID registers after
> a CPUID is executed.

True for a "32-bit op size" implementation. Maybe insert that.

--
C.

