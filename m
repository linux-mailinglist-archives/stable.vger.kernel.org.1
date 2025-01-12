Return-Path: <stable+bounces-108343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412C3A0ABB2
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 20:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398FE165FAB
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82C1BFE03;
	Sun, 12 Jan 2025 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mcg0qrdz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231B2CAB
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736711505; cv=none; b=gqG3nsTIBNfvPeWzC2UJBUa4UR/wHoF3WnmDg+CU2SdnfZKZvAX20FWip9rVUqkUXb+OIhtvqFjCr/7HYi1RCF8yIqfINZkB2jcWr8XXfvP5oV57aTmUl9IjNg6FJU4qJqcV2hfm5benIjJhXTQUrR+e/745aRUXcak5sKJBCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736711505; c=relaxed/simple;
	bh=iKegnR5u8GemV9dZOBedcFWVF6+XAWzkf85WMVOVydc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIfOZLSAsST3dsRUVvS4qLXq8bczTF/BPS87AVr7DaelcDK5hHvV0Poq/UvzbhSajiI2nF1DZ1UU14NWr8ATJYIaj+egLWrfRbh/NPZzQIt9aVxi25li7zhPW0iUPI9G2Esy/Hh7lttTQtvCvlhubjfY7U8wEcuEdb631QEkDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mcg0qrdz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec111762bso666800666b.2
        for <stable@vger.kernel.org>; Sun, 12 Jan 2025 11:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736711502; x=1737316302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jqoj+LVFeljDEZ9wmZBYUohOcDraiuy5uzmq7gbdpmQ=;
        b=Mcg0qrdzC2ReHLINiRo9mDB7Z3e5kJA3ZqOZ6fB5vx55tO8ixNHaGBmHLXBj+DTj3+
         IsVIz57PhXAW33h3wKWUp8Ke75dSltlksWFrg4BNPTJp+8pijzWgFI+MsUrCEM7vzqEU
         7zngtSfAHu0iWfm4hQxsX38BovaZqPY1La927GXlH8p6YIXdTvjUREp7UY8J8ZfANLhn
         SriNGPySJFch2BcgSZdslELdxcJ4qCEDUXT39O4yqS5RWAAKfOD5DwafQAXtE+6tb6w8
         jI1UBwXzUVqXF5VsXuwrXlALsF9mmecTTrCAa7KkKfIh+s9dVKTpNM8UBlldaCQDnQrf
         KEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736711502; x=1737316302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jqoj+LVFeljDEZ9wmZBYUohOcDraiuy5uzmq7gbdpmQ=;
        b=fEeK5rI5MVnALTFWHPs/dn5FOQQcTIe3hanadnihf7ICFi/A+56wED/Jw841bWwctV
         lSnlBCaRx+ZVzgs1NQ+QET0Eo+9eQ1H3DeCq5Qx3ZTAyq7IL+To08Y39rViglVrv9lil
         HmIDX7plYf5CY48jFzBPN21aMl7xsXsnQr66W5utRyeDTgkWsREWoi1mFIC2igoB/Wfo
         gP3HenErVec04/dL1HEAAidrIDYw5zYlOyRcCefKjD0mjoQD4JC2OzvL9RbvJ/KpBeDr
         +DNr7sKRYfhgtL0PpKNHgB5yHO2YFOkzNmzABYfDyrSWFHptK/VU0AWEic0xf228ycxZ
         O8sw==
X-Forwarded-Encrypted: i=1; AJvYcCW5QQv6FRkCVv9pQbuuzgSU3WirqPLix9Tfl7W1++vpmMUKsdFSMbUen1LKahtl0uTLVusEsqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNR3y8+CtKl3qsivaAQRCF5+ORZKPcj8Dm0SlNsz4e61+51R8
	Xc865s0++HiYGOsxi06SjWzjZvGMU0BUhRdl1DtSQ6LWCPTanvmqxe3IJmnTZg3keH000ZHrTIc
	DVQ1Vv8XAO3kLqFJbH91L+yi3VCWFag==
X-Gm-Gg: ASbGncsDwW3NyeRYa/6uaJJw2HfCtOuVeUyrJAuFmYQ6D9sLELLQTKFOFOjkfGSk7ZY
	Gva+BOwopmZ6/ILWvZSI5SiI6nKALY/J6A0uP
X-Google-Smtp-Source: AGHT+IHXZ5qLhl39esDy0/pbwRi5e4+RVMT3cpj7huONOyCSzq2iZdIJl3yahjMR7BVkbFfemwK5TWaWMJksp2mve7I=
X-Received: by 2002:a17:907:781:b0:aa6:995d:9ef1 with SMTP id
 a640c23a62f3a-ab2ab6a84d3mr1724087466b.12.1736711501851; Sun, 12 Jan 2025
 11:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025010650-tuesday-motivate-5cbb@gregkh> <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh>
In-Reply-To: <2025011215-agreeing-bonfire-97ae@gregkh>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 13 Jan 2025 05:51:30 +1000
X-Gm-Features: AbW1kvatlKEHF8E1md2dmbmZbsJItcE13h58uxanXtWre8LbEZm8I2szFyLGARU
Message-ID: <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode of
 operation for OAR/OAC)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>, stable@vger.kernel.org, 
	ashutosh.dixit@intel.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Jan 2025 at 22:19, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 10, 2025 at 12:53:41PM -0800, Umesh Nerlige Ramappa wrote:
> > commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream
>
> <snip>
>
> > Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA s=
tream close")
> > Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com> # commit 1
> > Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > Cc: stable@vger.kernel.org # 6.12+
> > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20241220171919.5715=
28-2-umesh.nerlige.ramappa@intel.com
> > (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > (cherry picked from commit f0ed39830e6064d62f9c5393505677a26569bb56)
>
> Oh I see what you all did here.
>
> I give up.  You all need to stop it with the duplicated git commit ids
> all over the place.  It's a major pain and hassle all the time and is
> something that NO OTHER subsystem does.
>
> Yes, I know that DRM is special and unique and running at a zillion
> times faster with more maintainers than any other subsystem and really,
> it's bigger than the rest of the kernel combined, but hey, we ALL are a
> common project here.  If each different subsystem decided to have their
> own crazy workflows like this, we'd be in a world of hurt.  Right now
> it's just you all that is causing this world of hurt, no one else, so
> I'll complain to you.

All subsystems that grow to having large teams (more than 2-4 people)
working on a single driver will eventually hit the scaling problem,
just be glad we find things first so everyone else knows how to deal
with it later.

>
> We have commits that end up looking like they go back in time that are
> backported to stable releases BEFORE they end up in Linus's tree and
> future releases.  This causes major havoc and I get complaints from
> external people when they see this as obviously, it makes no sense at
> all.

None of what you are saying makes any sense here. Explain how patches
are backported to stable releases before they end up in Linus's tree
to me like I'm 5, because there should be no possible workflow where
that can happen, stable pulls from patches in Linus' tree, not from my
tree or drm-next or anywhere else. Now it might appear that way
because tooling isn't prepared or people don't know what they are
looking at, but I still don't see the actual problem.

>
> And it easily breaks tools that tries to track where backports went and
> if they are needed elsewhere, which ends up missing things because of
> this crazy workflow.  So in the end, it's really only hurting YOUR
> subsystem because of this.

Fix the tools.

>
> And yes, there is a simple way to fix this, DO NOT TAG COMMITS THAT ARE
> DUPLICATES AS FOR STABLE.  Don't know why you all don't do that, would
> save a world of hurt.

How do you recommend we do that, edit the immutable git history to
remove the stable
tag from the original commit?

>
> I'm tired of it, please, just stop.  I am _this_ close to just ignoring
> ALL DRM patches for stable trees...

If you have to do, go do it. The thing is the workflow is there for a
reason, once you have a large enough team, having every single team
member intimately aware of the rc schedule to decide where they need
to land patches doesn't scale. If you can't land patches to a central
-next tree and then pick those patches out to a -fixes tree after a
maintainer realises they need to be backported to stable. Now I
suppose we could just ban stable tags on the next tree and only put
them on the cherry-picks but then how does it deal with the case where
something needs to be fixes in -next but not really urgent enough for
-fixes immediately. Would that be good enough, no stable tags in -next
trees, like we could make the tooling block it? But it seems like
overkill, to avoid fixing some shitty scripts someone is probably
selling as a security application.

Dave.

