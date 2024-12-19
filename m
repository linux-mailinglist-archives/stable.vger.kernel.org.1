Return-Path: <stable+bounces-105377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9909F8830
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 23:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B03169EAF
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 22:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38ED1AA1C9;
	Thu, 19 Dec 2024 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQSvg6Vi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309F78F4A
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734649141; cv=none; b=BciGedVhXb8CmlRzp8hi29ClycjkKjWBsLqoOIiv6yEuJc1lGJyiwvspeiOvdYN8d1PMwe547xZfPwUXzJXzlw3r+rS6sNRXd99JcIP+pqzvkSbAd+lxPjyAFUzQh/W7+nnHbntCdKQlNN0XOiPneQMKqVJWf4Mmcivn++wS6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734649141; c=relaxed/simple;
	bh=V76NWFeDa0aieupn8ujruMEIgtibUG5eTCx7o3P2MYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNiBxwUESfOSMOLlK43LcdTzNGAtbqKGec/vxzbVtxGlmUQPV5zTvVG5VTM52Spn/y2kw5RMDTgJ70o0byUD69vKIDRwXIe7M9+z2MrCBgeFlo8Qy7jfCcUWBb5WuQ5sOHm7XTg712Fj3HVvo97g6Bt+volCJREfWPHYhkXBspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQSvg6Vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03677C4CECE;
	Thu, 19 Dec 2024 22:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734649141;
	bh=V76NWFeDa0aieupn8ujruMEIgtibUG5eTCx7o3P2MYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQSvg6ViAyD+JAIxawfkxvmYM7nhik8av2fGwYiS9GRA2h/405G3DeLIGChXmb9Dy
	 g8+py2QHK3TJ+Povg9naeAa5me1mw4NNFZFGu/ch/0H0zyXc+GVcpVQBFB1Hb0WY9h
	 3+g6uNj0oY7vRnbL1fzYL3bs2tG3AeBnYo9n2MtV73Tf6P1WzoB4N8poCAZwK9QYVZ
	 gIoPwwIVx4iHFTrDbJROWBKCvzC64Mp0TG8YRMYBhqoJbCWPpVQooiXlwSxVqAWAd1
	 1dVoXUHlWbZH7aZAI6N8Ri/sCNIaN7IQYMc40BsRJKzx8Vr34mB7+ZwHMzv7hf5Xrc
	 gRy2lm4xa17nw==
Date: Thu, 19 Dec 2024 14:58:59 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: ccc194101@163.com
Cc: peterz@infradead.org, stable@vger.kernel.org,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] objtool: add bch2_trans_unlocked_error to bcachefs
 noreturns.
Message-ID: <20241219225859.fw6qugbyoagrx63a@jpoimboe>
References: <20241218212707.zjli7be5qtamdfkx@jpoimboe>
 <20241219055157.2754232-1-ccc194101@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241219055157.2754232-1-ccc194101@163.com>

On Thu, Dec 19, 2024 at 01:51:57PM +0800, ccc194101@163.com wrote:
> hello,
> 
> You can use this new version to add fixes and modify the signed email address.

When updating a patch, please update the title with a new version
number, e.g. "PATCH v2".

-- 
Josh

