Return-Path: <stable+bounces-165063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF05B14E86
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EA31751C0
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922901991C9;
	Tue, 29 Jul 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqkkjz6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5F2110E;
	Tue, 29 Jul 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796405; cv=none; b=Ntnvdo0j2VF2J80RrVpC6oL9G0zcrhbeQkvZMF5V+HE9epeUL9x6LqzbyeX6J+OKLeQbBH/PUopJ2Q40xuz/HXaVfKjfIBw1AHHODlZye771qD5D1Sa92mudg9Iq3yPlPvQR8VxeVDSHyhTdfnQg/LRKnWmpAjMEv9qb2CLj8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796405; c=relaxed/simple;
	bh=f/LGPw/5dHlTrw7lOR6Cg83JH1ggAoCnyHGQ66Ie3yA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cLb5/jcS1pcxZN0PMqXTFYNp3ZnEcizoSRrJBNCguTuWxbQQkBJgeI1CZ6WIhVByRWYNENvfoA3lNv6gaWQD4NJGSHYtnGeP/1bbd1ViUszgy3ETCW4Hlgv7uD3OXhcMeepKsRBFHz6+2A8PoD0WAHIjmLB2aT5PTPKg/lFjFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqkkjz6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE713C4CEEF;
	Tue, 29 Jul 2025 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753796404;
	bh=f/LGPw/5dHlTrw7lOR6Cg83JH1ggAoCnyHGQ66Ie3yA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dqkkjz6Yz0TPt/dDJ3zE1lSYh5f71snL7ISfGBJgmkApPm0o8t+VLbMo1n7So/vTg
	 d5MlDEjzD0Vfh5kxZrVa4JM2EwxmzcUHYnaQH25tiSkJ+z5jrZz11eaLV2dSKGlPmf
	 slYo15lf7/m4aFVH1Cc+Q0s95rVSmQhLPOVoKh4SJPcAsQEGmUs63jLA0rhz61NPNa
	 wPpWpBxdw1YNCS0Jm6FJfBXLhp3pFPJUNvuYeSHXLMwSXIJB6oiGwYk0EXMMS3udaM
	 VoFr4stxRBEJxccV6UNbt5N2vYaJodc0pdp5i+xtMTbavumi0kSfYXqwrcGHocnGrK
	 KsCxZjxg3Vnpw==
Date: Tue, 29 Jul 2025 22:40:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Alan J. Wylie" <alan@wylie.me.uk>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: "stack state/frame" and "jump dest instruction" errors (was Re:
 Linux 6.16)
Message-Id: <20250729224000.2f23f59acc79a78f47c1624f@kernel.org>
In-Reply-To: <hla34nepia6wyi2fndx5ynud4dagxd7j75xnkevtxt365ihkjj@4p746zsu6s6z>
References: <CAHk-=wh0kuQE+tWMEPJqCR48F4Tip2EeYQU-mi+2Fx_Oa1Ehbw@mail.gmail.com>
	<871pq06728.fsf@wylie.me.uk>
	<hla34nepia6wyi2fndx5ynud4dagxd7j75xnkevtxt365ihkjj@4p746zsu6s6z>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 08:42:44 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Mon, Jul 28, 2025 at 09:41:35AM +0100, Alan J. Wylie wrote:
> > #regzbot introduced: 6.15.8..6.16

> I don't have time to look at this for at least the next few days, but I
> suspect this one:
> 
>      1a3:	8f ea 78 10 c3 0a 06 00 00 	bextr  $0x60a,%ebx,%eax

Thanks for finding!
Indeed, this is encoded by XOP which is not currently supported
by x86 decodeer. 

> 
> in which case the kernel's x86 decoder (which objtool also uses) needs
> to be updated.

OK, let me see how XOP works.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

