Return-Path: <stable+bounces-172710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2110B32E9A
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 11:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3AB176D2B
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40AF2586DA;
	Sun, 24 Aug 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=excello.cz header.i=@excello.cz header.b="mGYedVXi"
X-Original-To: stable@vger.kernel.org
Received: from out2.virusfree.cz (out2.virusfree.cz [89.187.156.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D423B616
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.187.156.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026475; cv=none; b=plzmF6y3rsf/IO3B1x2pNiNbF9uOuVO9fgUm7GD99rLK8qozIcMDZFIStdxQk5KQZ1G4BA+xboLtc8o0zk4OaRz7XowvoXOpYSpwHLSeS03+UoiYcrscMTMKSzahigIfnOdGQrgE3DYgHwuTd23+TQMbWEcsRKuWxTaySyFKiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026475; c=relaxed/simple;
	bh=Mq+/hYWq0cVG+amD6qkQ0L109sYYur24JCBfR8TL8t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIdrsVzvT+j/EEEakEro/B60LRXpVzmWgsKInh6tZy1HMWFtcnXtXSTFS2VpkVRbzqcKjhe0A/UINqCwi9m4gMO3mFo6eUDUqhw1jT8y71qzQrcFkIY6uGodX7U7H9d01Fmcc4Dbsohdixi07KXsY7hzVjsfhaECedcOFHd2h/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=excello.cz; spf=pass smtp.mailfrom=excello.cz; dkim=pass (2048-bit key) header.d=excello.cz header.i=@excello.cz header.b=mGYedVXi; arc=none smtp.client-ip=89.187.156.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=excello.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=excello.cz
Received: (qmail 4992 invoked from network); 24 Aug 2025 11:01:08 +0200
Received: from vm1.excello.cz by vm1.excello.cz
 (VF-Scanner: Clear:RC:0(2001:67c:1591::6):SC:0(-0.410381/5.0):CC:0:;
 processed in 2.2 s); 24 Aug 2025 09:01:08 +0000
X-VF-Scanner-Mail-From: pv@excello.cz
X-VF-Scanner-Rcpt-To: stable@vger.kernel.org
X-VF-Scanner-ID: 20250824090106.517756.4897.vm1.excello.cz.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=excello.cz; h=
	date:message-id:from:to:subject:reply-to; q=dns/txt; s=default2;
	 t=1756026066; bh=FTo/8VYVYhnYGdhHVBkoNGOEq4VXoYQoUU679M2OnzU=; b=
	mGYedVXi+XCui4+mK0n0E5G5639pUC0m60iLZIxhRtJkbZeLWpg/5xwCFfPTaWU9
	S8XpN5LuC36c3OLD7bdzXhCJjvLdyNZjwuJTyMxGeSUD5vHSTXIDZ0wDm3x+vVhO
	XKra17Fxqtkj8Op9yuURrvpk1yQyZfi3V5qkSQ3k5YSKrvF4vVFbTQ18yx5whmQc
	lDj/6PR0D22fV8Lldo/v9ysevIcqj0zzt79Jt/7491CH1xCBr0GFhK02bHOtaIeo
	SOOcMms3aC5EPVptcpts3z++1VBkP5Qz6Gb2ZpCZF2yIn+toyR6/iZ8dVRp7eFeK
	cwuvTgUMUjDwED/3B8YXzQ==
Received: from posta.excello.cz (2001:67c:1591::6)
  by out2.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384); 24 Aug 2025 11:01:06 +0200
Received: from arkam (nat-86g.starnet.cz [109.164.54.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by posta.excello.cz (Postfix) with ESMTPSA id 4FA8F9D7482;
	Sun, 24 Aug 2025 11:00:57 +0200 (CEST)
Date: Sun, 24 Aug 2025 11:00:55 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <pv@excello.cz>
To: wangzijie <wangzijie1@honor.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
	adobriyan@gmail.com, rick.p.edgecombe@intel.com, ast@kernel.org,
	k.shutemov@gmail.com, jirislaby@kernel.org,
	linux-fsdevel@vger.kernel.org, polynomial-c@gmx.de,
	gregkh@linuxfoundation.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v3] proc: fix missing pde_set_flags() for net proc files
Message-ID: <20258249055-aKrUxz36A3Yw6qDd-pv@excello.cz>
References: <20250821105806.1453833-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821105806.1453833-1-wangzijie1@honor.com>

On Thu, Aug 21, 2025 at 06:58:06PM +0800, wangzijie wrote:
> To avoid potential UAF issues during module removal races, we use pde_set_flags()
> to save proc_ops flags in PDE itself before proc_register(), and then use
> pde_has_proc_*() helpers instead of directly dereferencing pde->proc_ops->*.
> 
> However, the pde_set_flags() call was missing when creating net related proc files.
> This omission caused incorrect behavior which FMODE_LSEEK was being cleared
> inappropriately in proc_reg_open() for net proc files. Lars reported it in this link[1].
> 
> Fix this by ensuring pde_set_flags() is called when register proc entry, and add
> NULL check for proc_ops in pde_set_flags().
> 
> [1]: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/
> 
> Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
> Cc: stable@vger.kernel.org
> Reported-by: Lars Wendler <polynomial-c@gmx.de>
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Tested-by: Petr Vaněk <pv@excello.cz>

We have noticed lseek issue with /proc/self/net/sockstat file recently
and this patch fixes it for us.

Thanks,
Petr

