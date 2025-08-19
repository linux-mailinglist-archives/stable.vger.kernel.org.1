Return-Path: <stable+bounces-171836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1330B2CB9E
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 20:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710115E3FBB
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE1530F53B;
	Tue, 19 Aug 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdp41m9x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BBD30EF86;
	Tue, 19 Aug 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626629; cv=none; b=gJBr4TKUIgZdpjYFnNkoLtrVWBwoYngzOncdHVDCNCbcsjhZxLzr63VKkUt5W4CDS5wFT1bbQEBAx7mdtT318alcFvZvdqpXPInhkvwBvxOODE5l9COziPLvvjCOGZhiRgTespxnrBHELXQTiTBSs61J1WegrI04aC7k2DzFqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626629; c=relaxed/simple;
	bh=F62FyC88y55IwNEaGhr59itkIJTjmWaqtjD2Xo8S9lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/gV9j3yVo+nXr6Nhc0F8x4gY96bAYhrobrICWcBUTHVDRRhqgTE10v8oCR1If8Ao/mdn060CTGRPDGVG+Qti+rnSRHsPdL48qxm+6K+D/VAqiLnN1FMHs42qdMGJUhWQ4pT2bANs5Qqz/8QXPlmHjI1a+EmTbcdZ6kiyOFL2UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdp41m9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E74BC113D0;
	Tue, 19 Aug 2025 18:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755626629;
	bh=F62FyC88y55IwNEaGhr59itkIJTjmWaqtjD2Xo8S9lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rdp41m9xY68OPmiEA18fXO3+3gQXycbZPO3QBmePtHJd7L58Ni8M61MHwsNsqYJAE
	 lib0wPl5tF8kqZg1KPIf3fxorIBfxQife5TwhP7iYapUteD2gvZ2sDRRPNSIzg9LBW
	 J8Y59flPHO/IpqQI5+0KBtoMwumtp4UsviYXEAHNSx8Czscwa9hkw9sWxkbVzwerTx
	 gybQY4WiaxS7E1izEveajYzoh0vbGvkkXzTUYij0NUKxC6K3do2rdlv7AWUbvEU579
	 mFWof+W1KmeXYPIhPndXexMSynRAFnOZyOy/08g6iOnQCuMMHe2WRDS1f4OETqw+uA
	 AR9hlhJ2Ffyfw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Tue, 19 Aug 2025 11:03:47 -0700
Message-Id: <20250819180347.45187-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819172718.44530-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Tue, 19 Aug 2025 10:27:18 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> 
> > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> > include/linux/jiffies.h
> > 
> > /*
> >  * Have the 32 bit jiffies value wrap 5 minutes after boot
> >  * so jiffies wrap bugs show up earlier.
> >  */
> >  #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> > 
> > And they cast unsigned value to signed to cover wraparound
> 
> "they" sounds bit vague.  I think "jiffies comparison helper functions" would
> be better.
> 
> > 
> >  #define time_after_eq(a,b) \
> >   (typecheck(unsigned long, a) && \
> >   typecheck(unsigned long, b) && \
> >   ((long)((a) - (b)) >= 0))
> > 
> > In 64bit system, these might not be a problem because wrapround occurs
> > 300 million years after the boot, assuming HZ value is 1000.
> > 
> > With same assuming, In 32bit system, wraparound occurs 5 minutues after
> > the initial boot and every 49 days after the first wraparound. And about
> > 25 days after first wraparound, it continues quota charging window up to
> > next 25 days.
> 
> It would be nice if you can further explain what real user impacts that could
> make.  To my understanding the impact is that, when the unexpected extension of
> the charging window is happened, the scheme will work until the quota is full,
> but then stops working until the unexpectedly extended window is over.
> 
> The after-boot issue is really bad since there is no way to work around other
> than reboot the machine.
> 
> > 
> > Example 1: initial boot
> > jiffies=0xFFFB6C20, charged_from+interval=0x000003E8
> > time_after_eq(jiffies, charged_from+interval)=(long)0xFFFB6838; In
> > signed values, it is considered negative so it is false.
> 
> The above part is using hex numbers and look like psuedo-code.  This is
> unnecessarily difficult to read.  To me, this feels like your personal note
> rather than a nice commit message that written for others.  I think you could
> write this in a much better way.
> 
> > 
> > Example 2: after about 25 days first wraparound
> > jiffies=0x800004E8, charged_from+interval=0x000003E8
> > time_after_eq(jiffies, charged_from+interval)=(long)0x80000100; In
> > signed values, it is considered negative so it is false
> 
> Ditto.
> 
> > 
> > So, change quota->charged_from to jiffies at damos_adjust_quota() when
> > it is consider first charge window.
> > 
> > In theory; but almost impossible; quota->total_charged_sz and
> > qutoa->charged_from should be both zero even if it is not in first
> 
> s/should/could/ ?
> 
> Also, explaining when that "could" happen will be nice.
> 
> > charge window. But It will only delay one reset_interval, So it is not
> > big problem.
> > 
> > Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> 
> I think the commit message could be much be improved, but the code change seems
> right.
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> > ---
> > Changes from v1 [1]
> > - not change current default value of quota->charged_from
> > - set quota->charged_from when it is consider first charge below
> > - add more description of jiffies and wraparound example to commit
> >   messages
> > 
> > SeongJae, please re-check Fixes commit is valid. Thank you.
> 
> I think it is valid.  Thank you for addressing my comments!
> 
> 
> Thanks,
> SJ
> 
> [...]

