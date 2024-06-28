Return-Path: <stable+bounces-56029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A095691B4D4
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 03:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC3283528
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 01:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B7F14F98;
	Fri, 28 Jun 2024 01:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SxkeeZmx"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2FA14277
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719539916; cv=none; b=D/3cysqsMCQXsGvBhXSCODAQjqB3EXKtVV1CfmuUnVsG8WjH/8HrqjktMlJY5Hua+diW9GntAYLnhZn+byvxGW3oG7bUy/kohU/58E1KG/h8gHB5oEwHNhwYmP6kzRQqZEkEAdzWPAAxiOyeHQb/OjeoAbtHgvOwweurJ9q9vlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719539916; c=relaxed/simple;
	bh=ZtS+fijY7LlBLvOt0g+pfGFcJoGwK2vpiQjUWnYlR8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/qzI2vJEX6igQaNbyAX/66ElhfY3gskRDNE2vzCywQlXCjIZqUiMOY6cTcjSQjXnpwp6D1IT16GtV7CnwvEBet2lw6u+yE4oGymgQgT7oU7ypR9W9Y1Xamu+Pw7VXXBN1PsUKiA/rCRKPFjU3+ITpk9JBgBMDSri0ctCfvFZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SxkeeZmx; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: nphamcs@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719539911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yI414tHp37ioB1qJD0yy1swBgpTB4yJDcOq1WXvmedk=;
	b=SxkeeZmxrFUH+DEkykvhfi9w/1ZINwTLYwgtmTSTHUVypmnY/u9IzwIRzAqLIWP5n9dBRb
	XuVVczRVJI9vOkzNfmrRqoVnouC0pPNs44yxWSyyaycav2quDAGqEWeImNQjLjw2veuTbu
	7LGnPEK+O5i+L6RjBP7Ep7sytHqALq0=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: david@redhat.com
X-Envelope-To: ryan.roberts@arm.com
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: kasong@tencent.com
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: linux-fsdevel@vger.kernel.org
Date: Thu, 27 Jun 2024 18:58:25 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	willy@infradead.org, david@redhat.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	viro@zeniv.linux.org.uk, kasong@tencent.com, yosryahmed@google.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cachestat: do not flush stats in recency check
Message-ID: <go7i7qbnbkc55jrgs43ql6sjnfsvnvnra3mflzbj5cdy2o3jgj@rh6lqsymffzd>
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
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 27, 2024 at 01:17:37PM GMT, Nhat Pham wrote:
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

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

