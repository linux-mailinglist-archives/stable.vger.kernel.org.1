Return-Path: <stable+bounces-111975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7640A24F64
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FD3162B7C
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09E31FBEAB;
	Sun,  2 Feb 2025 18:13:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-2.orcon.net.nz (smtp-2.orcon.net.nz [60.234.4.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A02AE93;
	Sun,  2 Feb 2025 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.234.4.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738520020; cv=none; b=IdupvV0oyP+C1fL8HsZs+OKnTCKdW6dMZpsioSwXCG78VB+eCSpmkV4WQO0uybAuaGs6hCdq0VXx6kVMj43FrqrnI0kYQTcrUZB+kUYyLTrRsXjgU6kk28904v/dyOupRiXEEMIk0L6RsbegWjyCuJ64OHirjmfq7/nI6l4TTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738520020; c=relaxed/simple;
	bh=Yisqya3wJWHCBfglmHqcGTAUvcFmJZY0noqJVsvwjos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc8epXTH7u3HHzPzG/lQU2XcxKUOzMFc3ptPNkpEn92DNeIsIPThGcy+KPvoNc2SfIlVuYe8MXHm1SLrO73CduKiqhuapK4Qh3ErUKflY/BJ53khlbXVm23BJDpsQje11hOBDrPOP5BKODk/7E0L0FFMaQglUL8EGeDvskyvC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz; spf=pass smtp.mailfrom=orcon.net.nz; arc=none smtp.client-ip=60.234.4.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orcon.net.nz
Received: from [121.99.247.178] (port=56569 helo=creeky)
	by smtp-2.orcon.net.nz with esmtpa (Exim 4.90_1)
	(envelope-from <mcree@orcon.net.nz>)
	id 1teeT5-0007QH-4F; Mon, 03 Feb 2025 07:13:15 +1300
Date: Mon, 3 Feb 2025 07:13:09 +1300
From: Michael Cree <mcree@orcon.net.nz>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Ivan Kokshaysky <ink@unseen.parts>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] alpha: stack fixes
Message-ID: <Z5-1tWz5edpF64qH@creeky>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
	Magnus Lindholm <linmag7@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Ivan Kokshaysky <ink@unseen.parts>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20250131104129.11052-1-ink@unseen.parts>
 <6cb712c1c338d3ce5313e05a054ea9de21025ff0.camel@physik.fu-berlin.de>
 <Z56qWp9GGuewJr1K@creeky>
 <CA+=Fv5Sd8hwJN5uxoNEB0MttZ-EvkBRJsK9LDp9H-srJaa_y1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5Sd8hwJN5uxoNEB0MttZ-EvkBRJsK9LDp9H-srJaa_y1g@mail.gmail.com>
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --

On Sun, Feb 02, 2025 at 10:43:59AM +0100, Magnus Lindholm wrote:
> I've applied the patches to git 6.13.0-09954-g590a41bebc8c and the
> system has been running for more than 24 hours without any problems,
> I've generated some system load with building kernels and unpacking
> large tar.xz files. The patch series seems to have fixed the
> rcu-related issues with network interface renaming as well as the
> kernel module unload. I'm now also running tests with memory
> compaction enabled (CONFIG_COMPACTION). This used to cause seemingly
> random segmentation faults when enabled on alpha. So far, memory
> compaction seems to work with the patched kernel. With a little luck
> the issues seen with memory compaction on alpha were related to stack
> alignment problems as well.

After 24 hours of really good going with the patches and
CONFIG_COMPACTION turned off, I rebooted with CONFIG_COMPACTION on
and within a couple of hours saw the random segmentation faults
reappear.  I have now rebooted with the kernel with
CONFIG_COMPACTION off and its been plain sailing for the last 12
hours.

So I suspect CONFIG_COMPACTION problem is something else.

Cheers,
Michael.

