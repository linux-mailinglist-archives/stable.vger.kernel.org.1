Return-Path: <stable+bounces-100864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2819EE248
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8951883B40
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7C20E6E6;
	Thu, 12 Dec 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeRWTpho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553920E6E0;
	Thu, 12 Dec 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994601; cv=none; b=Q5p3PT3+w1MeuXGCJ7alvjZpMK9WVJXRDvQmlp0a9Mhns9LZf7jH8UG1loxD7eApN08+mEnEyTqljJJ3oW4niIKl/VgYSCsQsYejty63tEohOv7QtEAPn96dWfSipMyyXfWRoZJOQO5N8cqUoXB2skFS+wu+G2/uAh2x0M894jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994601; c=relaxed/simple;
	bh=/E4WYN+dz8HukO64p6EHSJEr+umL0S2p2i5LAWEFxEM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s6QfIlXTlZSZdEXXf+16PxuGsjmGKZcU9VUXvku3le+NmQM0SXaWPXt138d29P3pspYYOIgUEVvvRzulhHFHLS5UDnq3PIaFOJ6yHXnwHJKUufz/9yxDIfkIhW8vgXtqgdahXXKAV2sxRWNdfT3c2A0euul2zfjKJwkX5vDTHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeRWTpho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E99C4CECE;
	Thu, 12 Dec 2024 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733994601;
	bh=/E4WYN+dz8HukO64p6EHSJEr+umL0S2p2i5LAWEFxEM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jeRWTpho8+nA5g1l7hJToIwzH1Vwfxdw/CFmaOqELDI9VKQFasrFXZYg9mjRcFXtH
	 WSn/4MWokndzADOPpn5+XM6Vt2R1spX9u8gNkNLWsCZiM3Gvbf+7RZur5pQAHFpqR3
	 N8wpfIUrnDmIJQV9JceoTx70HoWE30pDo+aDYgflisaggjrtcfMcXAQ+WrrQj+gDg/
	 imHPaONQFMlZhopVYjI86IqvlWWyGh6Mlf8YrU5AkDjBiXJ033yLM4aFns0iGTxLjJ
	 F+uRiE29lmpk2OUkPKCsBjFda7alv8jObLdJEGUBzqBS7vCWNfBx/1bktZixZBWRIc
	 19TwyvokSyjuA==
Date: Thu, 12 Dec 2024 10:09:58 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
cc: ulm@gentoo.org, helugang@uniontech.com, regressions@lists.linux.dev, 
    stable@vger.kernel.org, regressions@leemhuis.info, bentiss@kernel.org, 
    jeffbai@aosc.io, zhanjun@uniontech.com, guanwentao@uniontech.com
Subject: Re: "[REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works"
In-Reply-To: <E10C8C21570ADB69+4747ffa5-22b2-4752-961b-983ebfd3f6a9@uniontech.com>
Message-ID: <1oo8855o-820q-q870-0254-2307r83r8939@xreary.bet>
References: <uikt4wwpw@gentoo.org> <7DAFE6DAA470985D+20241210030448.83908-1-wangyuli@uniontech.com> <687qoq24-o1p4-519q-1r8p-s59680noorq3@xreary.bet> <E10C8C21570ADB69+4747ffa5-22b2-4752-961b-983ebfd3f6a9@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Dec 2024, WangYuli wrote:

> > Thanks for looking into this. I have now queued the revert in
> > hid.git#for-6.13/upstream-fixes
> >
> Hmm,
> The original commit included a crucial fix for a typo where 01E8 was
> incorrectly used instead of 01E9. We need to make sure we keep that
> correction.

Sadly that information was somehow missing from the changelog.

I will reintroduce that as a separate fix, thanks for noticing.

-- 
Jiri Kosina
SUSE Labs


