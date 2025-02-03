Return-Path: <stable+bounces-112046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6227CA26117
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 18:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDD91881C56
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2E420B7ED;
	Mon,  3 Feb 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="j5yT0IOW"
X-Original-To: stable@vger.kernel.org
Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64111D5159;
	Mon,  3 Feb 2025 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602861; cv=none; b=V+zSg1sOkmmjnjxquIvEY6PcXcTPqMLDyb1Us5D9zlEdwwIGShj/VGAH9xN/AcHtqigdVaRQc+37UDPoW2DHqwQwvsK0EB1wFRTGH6GAM1XPK5HWzhFNfKyoqWPWoFAp7AthA7c4Ef6PGMKG3qU4E94hvPZz66ZW9b2pwAYsoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602861; c=relaxed/simple;
	bh=exZJ/kq4tnfQIgldJRcpQlwvyIcfWDE3I3baCw7Vs/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQvPC6QInWM73G5P5uALStYs1G/nZJrYLjOfIQDwMfvCh98qU8vEeBJ9BAvq00D5EQFOGV9F2aFjusZk9J8t/JD/cjNpaXzvmVk2LRjMTr1aP7I3bMUZby6Cc9gnTgxnLofXMxVg7/2VP0y7SIBz7pciUGiPHrrtVo9Ikdq/4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=j5yT0IOW; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mrmVyp10dZ57MUk1tpEpK4lmy7JML0BdGNL9gQqKIUs=; b=j5yT0IOW0rwuLng9U0QpDJnSxr
	B9O98PE8FzdCTF1wNmRpOeq2nr89DH70mf2amsI56BmSluwnjvNEuoCkTeYhSqYq95KrIgSTNtalD
	mu0joKnPZW/71n6ti6VYs6ywz2l+h/w4OxeLHrbMbT47rAVXZFs6w3GbicEsxYURXXoJCSyUE6spN
	BBJWiURjhHDNsOzzvHUUMTRkUovD35AtpAGiD77qYquAfoc7vdDQyd45cwsszsrv56E7+3k/SMb6+
	rROWr/YYoTioL9ia3enqSBfk4PX3WVSTN4N3s++avo0CgCndPrWJx/KWvyubbVcCg/UXcP53/w/FL
	SF8nXp7A==;
Received: from minute.unseen.parts ([139.162.151.61]:60580 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tf01F-0000GH-34;
	Mon, 03 Feb 2025 18:13:57 +0100
Date: Mon, 3 Feb 2025 18:13:55 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] alpha/uapi: do not expose kernel-only stack frame
 structures
Message-ID: <Z6D5UyV9Z0demt40@minute>
References: <20250131104129.11052-1-ink@unseen.parts>
 <20250131104129.11052-2-ink@unseen.parts>
 <alpine.DEB.2.21.2502020051280.41663@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2502020051280.41663@angie.orcam.me.uk>

On Sun, Feb 02, 2025 at 05:39:52PM +0000, Maciej W. Rozycki wrote:
>  What do you think about providing arch/alpha/include/asm/bpf_perf_event.h 
> instead with either a dummy definition of `bpf_user_pt_regs_t', or perhaps 
> one typedef'd to `struct sigcontext' (as it seems to provide all that's 
> needed), and then reverting to v1 of arch/alpha/include/uapi/asm/ptrace.h 
> (and then just copying the contents of arch/alpha/include/asm/ftrace.h 
> over rather than leaving all the useless CPP stuff in) so that we don't 
> have useless `struct pt_regs' exported at all?

Probably that's the right thing to do. However, it implies adding

#elif defined(__alpha__)
#include "../../arch/alpha/include/uapi/asm/bpf_perf_event.h"

in tools/include/uapi/asm/bpf_perf_event.h. I'm afraid that will
result in too many loosely related changes for this patch series.

I'm starting to think that the best way for the time being is to keep
uapi/asm/ptrace.h and apply the fix there (i.e. revert to v0 patch
posted on linux-alpha). And mention the pt_regs vs uapi issue in the
commit message, of course, to deal with it later. Your opinion?

Ivan.

