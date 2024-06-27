Return-Path: <stable+bounces-55996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3991B0AB
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 22:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1ADCB218F3
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 20:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C10119F49C;
	Thu, 27 Jun 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UVIIzkIV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B67406F
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520883; cv=none; b=LvPCzbScn4KjewIMqrEojB4VQhZJjdNe7wRkOQJ9c9qmjN+IA7esXimdWYbXUZjAw6Gse99ts7yTSlwIi75fuZIrjuiJJKiFrUe0lBxLon6LrmzHeWDLO25ezkLs3f2StC0YTFz++yYWllkxzzA1Wbakxpl9BDugUiUlfGuZnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520883; c=relaxed/simple;
	bh=6c4jsOigt9Ruk43a9HCcueSY0YeUSMFClS0eq+S9m88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjrah9Stp+1z7iRLLVQdlIF8ewuFFAYsKxpbft44ENA+j2lcjYMgx3Ftpa7eVw3L32ybTQesgRnXQeis9eOsPCXaYxIcK+vcRDN1447hawD5xYGzq3s8U5LF0TXhu29GBuBY35jF5cDZ/nugwzPf/FsklMqL3AvbQ2DEls9dTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UVIIzkIV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44642df9af1so6052181cf.2
        for <stable@vger.kernel.org>; Thu, 27 Jun 2024 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1719520878; x=1720125678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yo7oSl8s5fW3RzTF5jL4BNIokFeXY+7HGhql3Vku1kY=;
        b=UVIIzkIVmMkkgsoPEYsRsVrnq2LF3tRCwYZPDLOgbeT2EFVpOUyoKtbtxPNus4B/S+
         ELhTQYL9QCOKg67OC3oBDlJu8LmIUj8uqc4ORem2/NW62bwulasAlUlkCtO/Z7S2+oIE
         3YR3nOIEDgNDyhJWnWlHrDOOYn8Sn21nocnNW0M47DvtvYdF+ragBHNYgabnfXra8KyR
         vhviPyOjub8zuLxUClEqS5MdvTgFM4mSNXo+dkg3Z3pYydCFWQoiavf7lEVJpP00lwG3
         ZU3Kr2MGg2Vi5rEpN8L3YPfbIcIuqZf7zJqLDdWoro9N8Nfmo6vxN0UcUB0tsDw0koCg
         pF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520878; x=1720125678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo7oSl8s5fW3RzTF5jL4BNIokFeXY+7HGhql3Vku1kY=;
        b=sv+HZpt/UQ2zttDhA2QZ+dXN6JnQQNCW9JlLpVoDuLgIghTFbgY7eRUiovOXQc0/ih
         UMWh/sOYRiBh/TbkLV2PNsHg2QJj49wCPWThODlQg5+ajgA4C2EZW65/l2QXqNm9JeuN
         /2AkuB0adk8d3yJKUY1U58D1n03Vlxgw0oEUFtCixwVoL1JgssH1GsPoGW+L9wq6Mwjf
         GHe4lGn0JYTbZf/tG3KbN33ampSOhsttRFMjFZ+2IcMV4n3uB598VP+qot9fWBElE8+l
         1U1D5ZAgwLY6Wl/WASubJt9mK9eUtH20D5uG1P2L+ZjqxAMfoTeDjGfDKJvhxAne9Ooa
         us2g==
X-Forwarded-Encrypted: i=1; AJvYcCWcOORcvwgVhkH54sQ8EJXiStMY+v0xxQwhvLFDVBwDwSTM7osaLcCnPwilT/J8Q2KDK0MID2W+om+QKfDtjcx9a0L9rHql
X-Gm-Message-State: AOJu0Yw5xRRKY2GgGWprRwoR+2c/Y32Ev4ehRynrOmtX5s/dwpx9yrS8
	k1a/2+ngUL/yjX8ZFyT5B0G2Nh+3kpHQVcdplAfvwpQ9gC95Fqa5eiArx1Pl68k=
X-Google-Smtp-Source: AGHT+IGFIa4hRaQA4Mu+AfyzyAeM600yB3mVaPeVNWkc2nyBTtruDGKIVTjDcc3JK0L5TEEZ2mr0/g==
X-Received: by 2002:ac8:5a4b:0:b0:446:426b:70f9 with SMTP id d75a77b69052e-446426b7a4bmr31951631cf.24.1719520878558;
        Thu, 27 Jun 2024 13:41:18 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44651498827sm1607971cf.62.2024.06.27.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:41:18 -0700 (PDT)
Date: Thu, 27 Jun 2024 16:41:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
	ying.huang@intel.com, viro@zeniv.linux.org.uk, kasong@tencent.com,
	yosryahmed@google.com, shakeel.butt@linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cachestat: do not flush stats in recency check
Message-ID: <20240627204116.GD469122@cmpxchg.org>
References: <000000000000f71227061bdf97e0@google.com>
 <20240627201737.3506959-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627201737.3506959-1-nphamcs@gmail.com>

On Thu, Jun 27, 2024 at 01:17:37PM -0700, Nhat Pham wrote:
> syzbot detects that cachestat() is flushing stats, which can sleep, in
> its RCU read section (see [1]). This is done in the
> workingset_test_recent() step (which checks if the folio's eviction is
> recent).
> 
> Move the stat flushing step to before the RCU read section of cachestat,
> and skip stat flushing during the recency check.
> 
> [1]: https://lore.kernel.org/cgroups/000000000000f71227061bdf97e0@google.com/
> 
> Reported-by: syzbot+b7f13b2d0cc156edf61a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/cgroups/000000000000f71227061bdf97e0@google.com/
> Debugged-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Fixes: b00684722262 ("mm: workingset: move the stats flush into workingset_test_recent()")
> Cc: stable@vger.kernel.org # v6.8+

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

