Return-Path: <stable+bounces-54654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D5090F1DC
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 17:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CB41F2190F
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF85132112;
	Wed, 19 Jun 2024 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E32njVNi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3659147;
	Wed, 19 Jun 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810023; cv=none; b=GOh7mzdc2GrEUDL1H6GdiYYu4qABzHWCNkgayWRYQHrInhuoup/hjnC7yA+gIaVSfLQwDXzBNhZOmGjRuO4cYQFz8mb6PuqyJdR2XsQe5S4hovYg2PB0JYLH5sULHOHau+f/tDvDkY1RQ2NIN3Un/I8OBRbSr3trqeh6HwCdwz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810023; c=relaxed/simple;
	bh=E809a9TcoLD3hkGZftuqg6B3IfAzfIQnt74WTfBivqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyxOiEuvc8SUKvLqD+B5N2pMuDbl6d7xAZ/okCnguZalvC1/N9UiBp7lWKIRN9MU6CI2czhNHWWn4etT+daXwz7r8CElmg4OqIApUKm3G1PsFQXiW5/Q4zIYwU0/5RZrJsFTkC//sUR2Glsi8jAVDvNF4df3oZOn4afLVQLPlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E32njVNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F35C4AF08;
	Wed, 19 Jun 2024 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718810023;
	bh=E809a9TcoLD3hkGZftuqg6B3IfAzfIQnt74WTfBivqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E32njVNizIv30SkJxe0PXgaffhyX0Hc1kySbiiw2ItkqFlXBj04apg9XUbH398RQf
	 sPJMNYcGQmsz3yuYRgS1lWzo2Qd7LN9Ddr2QMwu/NihguDeEDKBMyqP9p4IX5024nA
	 MCu+O3PfwFlvEhPcjQ2plnQqcaO0ifgDrnEQXQp6pY9VrWtZOKMmmrjIcke00HmmhA
	 hCjHarOcSuqPBHbTYXhhHDQcdyJkO1gsx36f7vh398cuQVEnpo2oYRNCieQA0vGFfc
	 E6XoAZfTsFdkrxtxfoyrCfrknGESeeWiAUFBmNnRHP12EAo3SSzN07eZ5qWZZZoFGa
	 k+bNc/bp6rrug==
Date: Wed, 19 Jun 2024 08:13:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Revest
 <revest@chromium.org>, kernel-team@cloudflare.com, Kuniyuki Iwashima
 <kuniyu@amazon.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: do not leave a dangling sk pointer, when
 socket creation fails
Message-ID: <20240619081341.6b2eff86@kernel.org>
In-Reply-To: <CALrw=nESVt0g4k4AvSkF3yfqDDMDnGGsHavonxHMoEaBrigQPw@mail.gmail.com>
References: <20240617210205.67311-1-ignat@cloudflare.com>
	<c9446790-9bac-4541-919b-0af396349c59@linux.alibaba.com>
	<CALrw=nGSf49VnRVy--b5qSM7_rSRyDBUFe_t8taFs2tmRP2QTw@mail.gmail.com>
	<CALrw=nESVt0g4k4AvSkF3yfqDDMDnGGsHavonxHMoEaBrigQPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 15:34:47 +0100 Ignat Korchagin wrote:
> > Thanks. I did scripts/get_maintainer.pl <file I'm modifying>. Not sure
> > if it is different.  
> 
> My bad: it is different or I actually forgot to re-run it, because
> v2/v3 modifies a different file.

Also you should run it on the patch:

$ git format-patch HEAD~
$ ./scripts/get_maintainer.pl 0001-${subject}.patch

the file version doesn't include CCs based on the commit message, most
importantly doesn't CC people who authored / reviewed the commit under
the Fixes tag.

