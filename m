Return-Path: <stable+bounces-98721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07829E4DCA
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFEB167EC6
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 06:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5E194137;
	Thu,  5 Dec 2024 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwLb0Phl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFA17C208
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381685; cv=none; b=hJO5r1Ip0RSrEUFFVIM5diYD2XHAOAuvT6N4+x7BpkhQbLbys7XIEClpKzql79NZds1F4vWR8/VrPhpM37cOZ7a0/cfZ3fUcw04F3gkaEFD2i2fCqTno4wqiKs8s6cWyNN6rY/Rm4axpEUwEweuFT0MVTO+IdKceR88iURiI+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381685; c=relaxed/simple;
	bh=Es/bQsUNfsccyLrM69xOfULX+iKhu8csnkljDpRSG+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8YhhmF97ftPCgM+HZPHBNyzrwZ1qXt37icUn2+N1dqV68pGVfOH9tXefpleTiahJrEqKGCGbF3/O+eLjudswEatgVHvJCQoGR5InrtYSikemgLDJTTVN1/EAKtS1cOmTX9AJMpEyGEfH3iRt4gnScB5w6e2I+77MJ54gFyiGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwLb0Phl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so2982051a12.1
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 22:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733381682; x=1733986482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIHo2yLXrzwpIw6lVddVk4SO8TV4Kw85+LvHuGdUxP4=;
        b=HwLb0PhlXFUM0jYJ8I1U2RWOG3guHWJoR6V0QNdpZ1c6J2nG7hKVsWf7E/Y5y1jkF8
         9vuh3bIvLbQBmaOVedkVdBSHUUL8wrhMFqZU2VhNWLCI78RFoWGITITkg1hezME7EbZq
         1OaLvgfr2U2IEg5SC/go+6ZgHcDCH/f/opisaH216/ihn2NokW0qEcBdvcplZiW15OuE
         7r23Iuvh8svxql0CPgT+e4f0dN+a5JC0QZlzztCKuEatjs6DELKTIZXCmDWJj6kHoILL
         5vujluos94104KaDFOPd1iw2Edu5N2PWbwh0KdPXwDwYY9sAhc3ZwIE66it1mAiGxiu9
         XXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733381682; x=1733986482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIHo2yLXrzwpIw6lVddVk4SO8TV4Kw85+LvHuGdUxP4=;
        b=Yww4Vyro/A5eNiDiOCoQmNHmRpw8A/6ulJ7Dsidet+pAoymMftU8stcmoCjq3b5A+a
         IWwuoCTIMs6lA+WG3IR+B2ySxy7dfIkx/uaMSvsvN7EAX6CRNkvS4AekygEPfrmkroQb
         86VLWjs/9Po8qCzQcxX3ufFmNYih2EKa8MB/wI21A9pK/Qo+26WWWlRasGbYSxFEkcFR
         fUrS+0SQ8MkawbBE8QsIGNyKhg9acCcvymQ70AcQ+OSVugTmPIE9cD7QUUs1yXFkl4jk
         4w5MJtc41jho9STgnXbB4KLewnS8NpksMTbS/WnOUkC35yT/mjEEUhU4FH8zlcvrb0oS
         dLZg==
X-Forwarded-Encrypted: i=1; AJvYcCXQaq3E8QDKBisJSdu2N5aeNTE57IS9DPZV3HuU0X5mG5Cl285U9oh3NT8XMRDb29jCWA7TBcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7LQ3NMTJJiDaPWBlbFXBkEqsUmBFejf5cnCPR7wa3MSgKLjR
	a4Mn5mWolC693SA38DHeRsORuERRlfnQHGjPxPPCpe2q2a1IST+3
X-Gm-Gg: ASbGnct3J5soOLGM4Mi6zlsSO9gfG0366E2D/Lg6Y73KyJND5phorrJHvBj+QvpunEQ
	Z5/tCiVcRw9xybIc0THFEe45IeIiv4xP7PSxGS5Kpt1H3dXs/rL585/x30iF8TD59Gk0cNyJcVB
	qndVjxp/Fw4jJiWBBSg79mp7s+UJe3XkTmLAnBHqwG3yqToRpX/3wzgKXcil3s+Ar1JlMjYGSNy
	kXrl4mquI2IvNA4Etmk0Qo5P0fHwOA4j6iKtqXD96ce9q04xdGMPGEexxR8o+GIClstm752yQbZ
	Q1u9w28tIg==
X-Google-Smtp-Source: AGHT+IH6anWkWudh7AVHKWgrEdneswsosymW7E5AR1/lhYrcXtaGsD6JHZXNB5Y/gpZcvoGm30Z8KQ==
X-Received: by 2002:a17:907:1c21:b0:a9e:b08f:867e with SMTP id a640c23a62f3a-aa62188ef0bmr171304266b.16.1733381681500;
        Wed, 04 Dec 2024 22:54:41 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4db2dsm50023466b.9.2024.12.04.22.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 22:54:40 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 1FAEABE2EE7; Thu, 05 Dec 2024 07:54:40 +0100 (CET)
Date: Thu, 5 Dec 2024 07:54:40 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kees Cook <kees@kernel.org>, stable@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: please revert backport of
 44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d
Message-ID: <Z1FOMMxv8bVt8RC3@eldamar.lan>
References: <202411210628.ECF1B494D7@keescook>
 <4ef74a1c-a261-487b-891c-56c44863daea@tls.msk.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef74a1c-a261-487b-891c-56c44863daea@tls.msk.ru>

Hi all,

On Mon, Nov 25, 2024 at 10:26:12AM +0300, Michael Tokarev wrote:
> 21.11.2024 17:33, Kees Cook wrote:
> > Hi stable tree maintainers,
> > 
> > Please revert the backports of
> > 
> > 44c76825d6ee ("x86: Increase brk randomness entropy for 64-bit systems")
> > 
> > namely:
> > 
> > 5.4:  03475167fda50b8511ef620a27409b08365882e1
> > 5.10: 25d31baf922c1ee987efd6fcc9c7d4ab539c66b4
> > 5.15: 06cb3463aa58906cfff72877eb7f50cb26e9ca93
> > 6.1:  b0cde867b80a5e81fcbc0383e138f5845f2005ee
> > 6.6:  1a45994fb218d93dec48a3a86f68283db61e0936
> > 
> > There seems to be a bad interaction between this change and older
> > PIE-built qemu-user-static (for aarch64) binaries[1]. Investigation
> > continues to see if this will need to be reverted from 6.6, 6.11,
> > and mainline. But for now, it's clearly a problem for older kernels with
> > older qemu.
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > [1] https://lore.kernel.org/all/202411201000.F3313C02@keescook/
> Unfortunately I haven't seen this thread and this email before now,
> when things are already too late.
> 
> And it turned out it's entirely my fault with all this.  Let me
> explain so things become clear to everyone.
> 
> The problem here is entirely in qemu-user.  The fundamental issue
> is that qemu-user does not implement an MMU, instead, it implements
> just address shift, searching for a memory region for the guest address
> space which is hopefully not used by qemu-user itself.
> 
> In practice, this is rarely an issue though, when - and this is the
> default - qemu is built as a static-pie executable.  This is important:
> it's the default mode for the static build - it builds as static-pie
> executable, which works around the problem in almost all cases.
> This is done for quite a long time, too.
> 
> However, I, as qemu maintainer in debian, got a bug report saying
> that qemu-user-static isn't "static enough" - because for some tools
> used on debian (lintian), static-pie was something unknown and the
> tool issued a warning.  And at the time, I just added --disable-pie
> flag to the build, without much thinking.  This is where things went
> wrong.
> 
> Later I reverted this change with a shame, because it causes numerous
> configurations to fail randomly, and each of them is very difficult to
> debug (especially due to randomness of failures, sometimes it can work
> 50 times in a row but fail on the 51th).
> 
> But unfortunately, I forgot to revert this "de-PIEsation" change in
> debian stable, and that's exactly where the original bug report come
> from, stating kernel broke builds in qemu.
> 
> The same qemu-user-static configuration has been used by some other
> distributions too, but hopefully everything's fixed now.  Except of
> debian bookworm, and probably also ubuntu jammy (previous LTS).
> 
> It is not an "older qemu" anymore (though for a very old qemu this is
> true again, that old one can't be used anymore with modern executables
> anyway due to other reasons).  It is just my build mistake which is
> *still* unfixed on debian stable (bookworm).  And even there, this
> issue can trivially be fixed locally, since qemu-user-static is
> self-contained and can be installed on older debian releases, and I
> always provide up-to-date backports of qemu packages for debian stable.
> 
> And yes, qemu had numerous improvements in this area since bookworm
> version, which addressed many other issues around this and fixed many
> other configurations (which are not related to this kernel change),
> but the fundamental issue (lack of full-blown MMU) remains.
> 
> Hopefully this clears things up, and it can be seen that this is not
> a kernel bug.  And I'm hoping we'll fix this in debian bookworm soon
> too.
> 
> Thanks, and sorry for all the buzz which caused my 2 mistakes.

So catching up with that as we currently did cherry-pick the revert in
Debian but I defintivelfy would like to align with upstream (and drop
the cherry-pick again if it's not going to be picked for 6.1.y
upstream):

I'm a bit lost here. What are we going to do? Is the commit still
temporarly be applied to the stable series or are we staying at the
status quo and we should solely deal it within Debian on qemu side to
address the issue above and then we are fine? 

Or are there other cases outside Debian making it necessary apply the
above proposed revert to the stable series?

Regards,
Salvatore

