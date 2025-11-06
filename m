Return-Path: <stable+bounces-192622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA1C3BD72
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 15:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DBC425468
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70A833F8BE;
	Thu,  6 Nov 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIjMn+d1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638541FBC91;
	Thu,  6 Nov 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439954; cv=none; b=g9G26Wnq8GuQySifE9OuClCaLrHm/hPF2UjRa0mBqitoOc98TX5hf0Bu4m2LLMr5CyxYRxLj8oilT/pMD4KJQoYd90s8EcPTF/E95VQFaqD+A8sqJsh5kxBYBQJr3QOqwNJxpxzKQTdgV6t7pMwDNqSGBUcWOqyfs13Rvsev2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439954; c=relaxed/simple;
	bh=rgTscvYVReRAfIwKuMy7/wgaz5aLagamJ2vCnI9TwFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4qekVrioxkFkyJJHW1SQumR+mguIzou1mC/sH8FKeL3ij3QJo1eIsAGXjrkxbD3Y1uohr2YG1Mlf2tRDerM0Yjg6kmLOH/kBXcDiz9hGuvTA/LvtnDrhPVQ/VFKoD5AaU3uER8ltJgJLAJGX0SQtOOKmeFlYWhLs9V42w5NT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIjMn+d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD19C16AAE;
	Thu,  6 Nov 2025 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762439954;
	bh=rgTscvYVReRAfIwKuMy7/wgaz5aLagamJ2vCnI9TwFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIjMn+d1qLk6GHp0EIMcAKwqCh0aeWoE6XzAT8c6SAM7dZ33Kf1MCvyoVrAg06dOc
	 nYP9BK/qhEPIZHD+ShtERwCTfBtgklPZKuqmod/tp/Sjc4FESxXhhzZTbFulu7ComH
	 TC6eYjrNx1kvk347OeMbuEP38uUTyLJTS/YMJsh2ubCna8tJP3s5juUL3/7MsKgyQK
	 M2YDycp/VrW3xIs8nV3sobucewBI/hxvaUPnLfzfeiOxSDkcGdf80gbphNavFspvvi
	 D6ZmliPfA1g9bukUsP6rgW9NKNURjKzZ7uYYH2KKXM1peSkKRO76GdFuhx9kEv2Hz5
	 MfLDTmvkIP27A==
Date: Thu, 6 Nov 2025 14:39:09 +0000
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: make24@iscas.ac.cn, mdf@kernel.org, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johan Hovold <johan@kernel.org>, Mark Brown <broonie@kernel.org>,
	Suzuki Poulouse <suzuki.poulose@arm.com>,
	Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] drivers: Fix reference leak in
 altr_sysmgr_regmap_lookup_by_phandle()
Message-ID: <20251106143909.GR8064@google.com>
References: <20251025142352.25475-1-make24@iscas.ac.cn>
 <62ab3119-94d8-4d74-abb3-e141c4b85934@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62ab3119-94d8-4d74-abb3-e141c4b85934@web.de>

On Sat, 25 Oct 2025, Markus Elfring wrote:

> …
> > Found by code review.
> 
> See also the commit facd37d3882baad4a38afdd5f33908f6fc145d13
> ("mfd: altera-sysmgr: Fix device leak on sysmgr regmap lookup") from 2025-10-21.

This patch has the correct formatting and doesn't do extra, unnecessary
actions like store the regmap into a local variable for some unexplained
reason.  For those reasons, I'm planning on taking this one instead.

-- 
Lee Jones [李琼斯]

