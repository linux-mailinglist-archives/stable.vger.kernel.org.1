Return-Path: <stable+bounces-66012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEE894B987
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 11:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8C2282B6A
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 09:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF70146A62;
	Thu,  8 Aug 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaU3DDkq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DF13DDC0;
	Thu,  8 Aug 2024 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108560; cv=none; b=bqol92y+J77oi/I+P7XwBCPuQzrHVSPZ7Ch/81G4G+FVi8J3fh/JbAKUSTDjQjzt/6nhyenuniJc8a9S978BWhSeoBsYR+qBlbvF6v4SWuQPq0ENh6vtlqbnFWw7EPlvLZ9wxl2Xf65NSYpB38uLCooM/2hYwDRUDjVza1UeeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108560; c=relaxed/simple;
	bh=KZmNwisvy1+bW0jb4C0Xe46JoI2p4c05A2Q3nZGvmds=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z4JRMxq7egzxHLIi2kG1Rn5+MxJwUOZMt0P0pXjEd+W7XAaeMZ0+QG26A8XDor7lg2pSMj/ahpBTalLTr9I2TUHF1R0/YHcFvlmrPf+VNn6sBD2B2AAhRAv5J7JdqEkh8vJUKAGM5eMWzc865hauPCn41J902IRLjgAs03jDbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaU3DDkq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723108559; x=1754644559;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KZmNwisvy1+bW0jb4C0Xe46JoI2p4c05A2Q3nZGvmds=;
  b=PaU3DDkqNobkNRtS+47wV3vxGN/Pq4QIQcSKnCnnWNRix82dQydcYriU
   7VAdCReUTlPZ77XMSi9V+gd5Sgckhw0xF6UfINlH6bAkLeRaiFu/3lMoD
   2LLjDh8wlVVT+tyhElzfJwKcu/si3xEMdpg2fKzF2zDl9kWtQpb27tFVG
   Ep5Vd9R7yfZXKypCwZejefdF/zlztrMtp1y0fFaryTRnpLYNtNvimE+3k
   6TCDepMfbNTSSrFuw2EAFNcKMtrHUQ0821vjH4cKzPdnBYBli7ftF+NK6
   KvYviUOO69UxVypZAsW/uki8njRZo5SqcvIOPpviXVIMs7iMWd2B0hPJp
   A==;
X-CSE-ConnectionGUID: Hwj/CVwzSAWYxNJMRjKEPg==
X-CSE-MsgGUID: 6P6c/1roQUOd9MxzZEWcuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32368268"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="32368268"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:15:59 -0700
X-CSE-ConnectionGUID: pQvtXec2Tk2BMoRS26MzGg==
X-CSE-MsgGUID: tKK1SP2mRb2km2t2/AQ1xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61256847"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.125.108.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:15:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Aug 2024 12:15:51 +0300 (EEST)
To: Jiri Slaby <jirislaby@kernel.org>
cc: Doug Anderson <dianders@chromium.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 03/13] serial: don't use uninitialized value in
 uart_poll_init()
In-Reply-To: <c4c01c01-e926-49fb-8704-90a69662254d@kernel.org>
Message-ID: <816a5459-833c-07fb-cc92-288cd9a53a76@linux.intel.com>
References: <20240805102046.307511-1-jirislaby@kernel.org> <20240805102046.307511-4-jirislaby@kernel.org> <84af065c-b1a1-dc84-4c28-4596c3803fd2@linux.intel.com> <CAD=FV=WeekuQXzjk90K8jn=Evn8dMaT1RyctbT7gwEZYYgA9Aw@mail.gmail.com>
 <c4c01c01-e926-49fb-8704-90a69662254d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 8 Aug 2024, Jiri Slaby wrote:

> On 05. 08. 24, 17:46, Doug Anderson wrote:
> > > > @@ -2717,10 +2716,10 @@ static int uart_poll_init(struct tty_driver
> > > > *driver, int line, char *options)
> > > >                ret = uart_set_options(port, NULL, baud, parity, bits,
> > > > flow);
> > > >                console_list_unlock();
> > > >        }
> > > > -out:
> > > > +
> > > >        if (ret)
> > > >                uart_change_pm(state, pm_state);
> > > > -     mutex_unlock(&tport->mutex);
> > > > +
> > > >        return ret;
> > > >   }
> > > 
> > > This too needs #include.
> > 
> > Why? I see in "mutex.h" (which is already included by serial_core.c):
> > 
> > DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
> > 
> > ...so we're using the mutex guard and including the header file that
> > defines the mutex guard. Seems like it's all legit to me.
> 
> The patches got merged. But I can post a fix on top, of course. But, what is
> the consensus here -- include or not to include? I assume mutex.h includes
> cleanup.h already due to the above guard definition.

Yeah, while guard() itself is in cleanup.h, Doug has a point that 
DEFINE_GUARD() creates a guaranteed implicit include route for cleanup.h. 
Thus you can disregard my comment as it seems unnecessary to include 
cleanup.h.

-- 
 i.


