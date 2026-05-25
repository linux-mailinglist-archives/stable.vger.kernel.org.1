Return-Path: <stable+bounces-254112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIu4EaEOFGpeJQcAu9opvQ
	(envelope-from <stable+bounces-254112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:56:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC545C8315
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47B863001D78
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E13E4C95;
	Mon, 25 May 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njjuR/c4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20901212566;
	Mon, 25 May 2026 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699356; cv=none; b=GpOVikN1p4hZGBFkDN+Yi+cbY7cueoAjlOM5KyOp4zYjX/6agiJfSaOB2TquPagtTpGD10BhTCAfbvmy07U+F/8DgIEIbWl56uK7srVmOdNBBiJnN9/BTGPoOFmKpY6AyDChYNvzf65S4Rbt8gm5ct461qbPZhsAXR6heNn7eRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699356; c=relaxed/simple;
	bh=QDVlHkaJzd1yhCNccg0oJiSTSQUYqwHGcctnwRzp9hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JU1XUsu17uLdWLe5DGeUwLwZw+iGF8JxUVYE8n8/9wEDiMwHWlz5RQB7rdKACdeQ1uhnqNa2GlTWBYi5hDTlIRegT1j2gFOZHQIwh5tLKGTxUYkEnvQsU++bYD5L9ELdusuWG/uO0eQzeVL1DkzNx6A5r36Mdq9yOuM5YPnGnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njjuR/c4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779699354; x=1811235354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QDVlHkaJzd1yhCNccg0oJiSTSQUYqwHGcctnwRzp9hY=;
  b=njjuR/c45goQgObIEkONMk1GF73NqfGHRIkUYGs+y3vXgnnVbQqXR1H0
   mggtZh9c0X7QMAt6uzy0Ku7ZayvPAChcDvEk8u1+MDb7gam03xz32VzIY
   gAUiqI8J25i6X/Z0BQ6c1RijLZTdp0DiPqpI5xBuE6aGc+EJZS7mf5WSI
   pBzBSqEz/UYBhfxfGFyXsg7UtRxjZTwarP/pp5usB+xwK5ZBPZKu5q8ZI
   iKC1nx89w3HSSeWBmuoJRaHqHv/BZXBP7H+oepXXsfgKXvTYxlP4VbPBl
   1hES/44SAoeT5QaND/FWtG79U5usAM5Y9BJg6VWShrCS5xwjdbKMGVosq
   w==;
X-CSE-ConnectionGUID: IEAedow2QDSpvom1YcsjXg==
X-CSE-MsgGUID: Ho1rYmAATJq6Vj1+AKmCVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="91627068"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="91627068"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:55:51 -0700
X-CSE-ConnectionGUID: Bknsz68oR+KLd8gP4UuJog==
X-CSE-MsgGUID: ZUe6382PRmebDTDU7tSw+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="237129261"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.200]) ([10.245.245.200])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:55:47 -0700
Message-ID: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
Date: Mon, 25 May 2026 10:55:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable and
 timer callback
To: w15303746062 <w15303746062@163.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
 melissa.srw@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
References: <20260515131826.388154-1-w15303746062@163.com>
 <2026051557-thermal-petite-7da0@gregkh>
 <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
 <2026051633-skyward-parrot-cdd3@gregkh>
 <397754a7.224c.19e38e42006.Coremail.w15303746062@163.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <397754a7.224c.19e38e42006.Coremail.w15303746062@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-254112-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,ffwll.ch,kernel.org,suse.de,lists.freedesktop.org,vger.kernel.org,stu.xidian.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DEC545C8315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Mingyu

Den 2026-05-18 kl. 04:22, skrev w15303746062:
> 
> 
> At 2026-05-16 17:51:59, "Greg KH" <gregkh@linuxfoundation.org> wrote:
>> There is no "minimal-risk policy for stable trees".  And if there was,
>> the least ammount of risk would be to take the reviewed and tested
>> patches that are already in Linus's tree, and NOT take anything that is
>> not already there, as 90% of the time that we do that, it comes back to
>> bite us hard.
>>
>> So please, just backport all the needed changes here.  Otherwise how are
>> we going to deal with the merge conflicts for the next 4 years in this
>> file?
>>
>> Or, get the maintainers of this file to agree and review this one-off
>> change that it is acceptable.  As they are going to be the ones getting
>> the bug reports and not having their patches applied over the years, not
>> anyone else :)
> 
> Hi Greg,
> 
> Got it. After looking deeper into the dependency chain, backporting the mainline commit (02e2681ffe1a) would indeed require pulling in the entire new DRM generic vblank timer infrastructure to 6.18.y. 
> 
> That scope is just too large and complex for this specific issue. Since a one-off patch is not the right approach either, I will just drop this patch and abandon the backport effort for 6.18.y.
> 
> Thanks for your time and the quick review.
> 
> Thanks,
> Mingyu
> 

As far as I can tell, if it's just a bug affecting vkms, all you need to do
is only a few commits:

74afeb812850 ("drm/vblank: Add vblank timer")
d54dbb5963bd ("drm/vblank: Add CRTC helpers for simple use cases")
02e2681ffe1a ("drm/vkms: Convert to DRM's vblank timer")
79ae8510b5b8 ("drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks()")
3946d3ba9934 ("drm/vblank: Fix kernel docs for vblank timer")

There's no need to convert all other drivers if it's only vkms that you're fixing.

But since you found this bug in one driver, it might be wise to check if others
have the same bug and ask for backports for those too.

Kind regards,
~Maarten Lankhorst

