Return-Path: <stable+bounces-46127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FBA8CEEEC
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E18281A4B
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 12:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2042073;
	Sat, 25 May 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="RopJ7zKA"
X-Original-To: stable@vger.kernel.org
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019BB4204B
	for <stable@vger.kernel.org>; Sat, 25 May 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716640930; cv=none; b=SQ6sjkSNcdeS01HlM0372hVihlTTXRfmCpJHHhwXqYPvh61S1IO+KXoIHbnQN/6hfWdxJ6GGK0CdYsbecBhLF5q+bI3i6I2Wnsg05JBmBX1/IV8T9gMslpAV/lRAQ+reHuGIgu3LNgjmsr1Dl3mDuHodabeQyc5xbUCmovgQpyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716640930; c=relaxed/simple;
	bh=0qS8wSauLUnTYjfVDo3Dk8MFVN9Elalr3WPvHgl/6Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uwNZq7low5d3aCE32rxhJSc0fr5o1zB4My0cJLl14c50QxSo6RIXNmcwwJSZX57ZSfcmTnDQNpXhtpomY1IcVJZhuf6XYvIcVEJWHaq6jiXpN32CqUlHQkKiPgfn14KxaglpyYMw5bgjUzpiVpLJucoUhH/SUaw0/oLIP4InFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=RopJ7zKA; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
Date: Sat, 25 May 2024 14:36:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1716640602; bh=rKSddhw4rUv+siIbg+JSaX75PtgMAQWEmSEofbJp13E=;
	h=Date:From:To:Cc:Subject;
	b=RopJ7zKAH4DJ6N3yncbEYdxbFj/fmPDpB4uKWICjoYr0SctfHCX0BWBqcc0xQVLtk
	 9CQT2Kn1EOR3tjlr70DkjAmoWCya4p0kbbkmRow3ihy+K1u2jcbnALF18ET3a+Fek1
	 eAK+J6/P/dH/luaAde6ZaiG4jpSLR/iznQD2l46Q=
From: Florian Klink <flokli@flokli.de>
To: stable@vger.kernel.org
Cc: thorsten@leemhuis.info, gregkh@linuxfoundation.org
Subject: cherry-pick request for "arm64/fpsimd: Avoid erroneous elide of user
 state reload"
Message-ID: <xvhrz2hqorwt42c4bdx7qzbofjpkv5x4ryzfmoptde5aztygha@pi7mq5dxdq75>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline


Hey,

I got encouraged to send another email here from
https://github.com/tpwrules/nixos-apple-silicon/issues/200.

"arm64/fpsimd: Avoid erroneous elide of user state reload" / 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=e92bee9f861b466c676f0200be3e46af7bc4ac6b
fixes a data corruption issue with dm-crypt on aarch64, reproducible on
the mainline Linux kernel (not just asahi specific!).

This list has been included as Cc on this commit, but it'd be very nice
to make sure this already lands in 6.9.2, due to its data corruption
nature.

Thanks,
Florian

