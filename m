Return-Path: <stable+bounces-254837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N1QBtMbGGq+dQgAu9opvQ
	(envelope-from <stable+bounces-254837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:41:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7836D5F0C26
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E381E308111C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBB73B27C7;
	Thu, 28 May 2026 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJb469dz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2636C9C2
	for <stable@vger.kernel.org>; Thu, 28 May 2026 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964561; cv=none; b=F0mt81jqeHaX3pDRq0Rerzjt1QQ1JKjgXh0xdNEwxbrf+n/FPMIw9U3cUehSqe8oLswdJVpSNHKG5q+S3rHrYcIt7KRqUhzOmSv73aGwln+x1vDgxOfSOace/pZlzRLaQ6SzBPSaFJbZQxed7uJVrXShHLjGXRpjtLQ8veqHJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964561; c=relaxed/simple;
	bh=Fg0V+oZAidj1nvbVQoP29tA6JrA291eDGVe7t9LD2ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRQHGApkqqVQpWBobIRjrLgO3Pye0yjsWAeWk5SK6/SEe94dTDPZNsmnsPF+dPURa5GQfKEk85s41Cym9xwIOMokyLGPH12q++6Yxjbx3wGd4UsPcMx+5ufeor6VXqyCAlUZmkify4I0vBYOcprwqr6ezlQ6cu5zykvWyWnV244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJb469dz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4908b92904fso7984555e9.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779964558; x=1780569358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJQU+eSTX518rgVEwjuFGD9upNQtN3nUPmcXZInkkD8=;
        b=pJb469dzLhoN+y/kbrBx5tVQ3VF6PCXcZdx1xG2dDtimAbdiFqi+YQg+EOp9KlPbkS
         D0wSXBqNe3KCaFCWQFXfrj1v5ov9izm9Ou7pDMZlpuM6dITRloO8aB/Cfuet6NeGCS62
         MjN0X0bYTQHCusPIfU9fBC87edqMT/La6FdjrOXzx5opS2HFK9eulVULgdrVm5aBUPvs
         V9VJYZVInED42HGioVmeKL7u6i53Ur0JiWmOnFXzek6tnRGdcKMq9VWt57bZDl7Ye6NA
         A39CosycW7Q/J05WTjNhm8PEwzmRyj0rM2mG/3XuTjy8moI3voUL3SQnHbyg39S9vyK8
         igOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779964558; x=1780569358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJQU+eSTX518rgVEwjuFGD9upNQtN3nUPmcXZInkkD8=;
        b=hT4f0XII0ckKzkUL1y82ip6vY0IQPjuOlXNJDthnjg1Yu6A0gYIZic79uAedVQci6Y
         urMz1vgrcXr6EQcV8ZD6P2Wm++nhmPfM8xfmPCpO//Zh6IirTWb5eWMSLwaMDhCA48Gm
         Ks02Xo6dRnVxmq5rmGQ7JH5kRKAVYmX9mzr2bGuLRJmGO3NCs7UVQsaSTBes9yAYDzLC
         5xYzA2uQEV3Qro/rASEuA3bq7sgZy3/GVX758VdrUvFF6rq0/Zh+pKa66rzKlbs+Crw/
         TYiuA2Eig7yu/VCqizxHUUrwAebZ6C8v/c1xsRAmUeAXsBLT2KwJQS2GECU1OpB4MARh
         KKoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+kelfvCVhcrJPH7fvQMa9usJHODtq7K+8UZus5mLT92HW5560EA9zCTh5QNZi/TNIu5nagac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUi4A3tOPW0O1KwtfIGNl/NnTgOllI3Ee5tONwNhvLW/zWZfe9
	WlLWRb44oMY1tpmY/NxriBO0RhBvvv32fUQhzmVZJSKBrIzEgNMjazii
X-Gm-Gg: Acq92OGHrNB8OLqrVIM9w3uQ2Gv0XHl5S8aWG+yR8p5gcmhqir0Coi36vGFRa9ml4TX
	aJv+sSyjzglZo7n9JTkQK/o3f6/2Wx2iKT8fLmku7RcxK59ux4PO6VlQO6g9wVH673kHCwyxH+s
	2NrwM+qBdYEMTCWip1sSEwprQIBXb07+F26urcHCuz3IFMt3uiVzZjW6k/ZyNt4acWLce1qp+1Q
	T2ttWM6AEn0eMXVXRdZ6E4idNkQIyJW0icw3/rB7VQlVTGNFcorIOZG9qaHBe0uJiouyaDvwktS
	8qxvem0OTPLnIOHEjiCvgomZ7dboF5xChrHHKhi6YrB9EaTlfAImUxTU9qJwYlbrXBSCeSDEkdb
	KD1cgNAlZJNLEr2me58gxFMVreRrgwcKlW/3SwCZoY5rWtxSMbSwyp91fsrQYsZ+BbqVqPWrvhf
	ll0llhI2rTgl07mKLvXwJqLuPRCdn3Xj4Kiw==
X-Received: by 2002:a05:600c:1550:b0:490:4f07:6d15 with SMTP id 5b1f17b1804b1-4904f076e3dmr375800285e9.17.1779964558385;
        Thu, 28 May 2026 03:35:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908eab0167sm13315625e9.16.2026.05.28.03.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:35:57 -0700 (PDT)
Date: Thu, 28 May 2026 13:35:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: gregkh@linuxfoundation.org, omer.e.idrissi@gmail.com, hansg@kernel.org,
	hi@josie.lol, straube.linux@gmail.com, xela@viard.dev,
	ethantidmore06@gmail.com, liangjie@lixiang.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn, stable@vger.kernel.org, zilin@seu.edu.cn
Subject: Re: [PATCH] staging: rtl8723bs: fix mismatched free of HalData in
 rtw_sdio_if1_init()
Message-ID: <ahgaii6K9EEVCDIK@stanley.mountain>
References: <ahfvCpI6YOA9Gpyh@stanley.mountain>
 <20260528101542.2395619-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528101542.2395619-1-dawei.feng@seu.edu.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254837-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,kernel.org,josie.lol,viard.dev,lixiang.com,lists.linux.dev,vger.kernel.org,seu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,stanley.mountain:mid,seu.edu.cn:email]
X-Rspamd-Queue-Id: 7836D5F0C26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 06:15:42PM +0800, Dawei Feng wrote:
> On Thu, May 28, 2026 at 15:30:18 Dan Carpenter wrote:
> > > Manual inspection
> > > confirms that the issue is still present in current mainline.
> > > 
> > > An x86_64 allyesconfig build showed no new warnings. As we do not have
> > > suitable RTL8723BS SDIO hardware to test with, no runtime testing was
> > > able to be performed.
> >
> > to HERE should be put
> >
> > > 
> > > Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> > > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > > Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> > > ---
> >   ^^^
> > Here under the --- cut off line.  We don't need this kind of meta
> > commentary about testing in the permanent git log.  Otherwise
> > the patch is correct.
> 
> Hi Dan,
> 
> Thank you for the review and for pointing this out. 
> 
> The reason the manual inspection and testing commentary was placed above
> the `---` line is that we were strictly following the example template
> provided in Documentation/process/researcher-guidelines.rst. 

Ah, hm.  Perhaps, the rules are changing.  That's fine then.  I would
normally ask for a v2 but you copied from our template so that's on us.
No need to resend.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


