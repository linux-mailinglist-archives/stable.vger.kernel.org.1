Return-Path: <stable+bounces-171851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92912B2CF7E
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 00:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382971C42B2F
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 22:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6B3202980;
	Tue, 19 Aug 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fX0VJvHp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B335353368
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643753; cv=none; b=Qcbd09rgUmrBmbt8qm9eKKvHeyRhEI1TDN4comIrw9fIjjTey679NyF32eH29ffCPDagGOOJ5xJ4MIdBpet5khSJ1FYxsyOPS2VpLhSXq2wXOPM85XnlGh39CkLRt6Lc3dOwqg/I3JeCqz9ZaMEi75Dvj2irrOYumao+d1lZRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643753; c=relaxed/simple;
	bh=xoFiK4rxFUIRRw1ywG9Sjg1y2W8RvmUgV7KXFN1o+3s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EiTKWHgXIdR6dfygtKqH2z2AFnFzFYdiHVWwXEI9vNqvVRzBAylEbK+RxW5BTOGNNifkGmAY3j2VQQK1/PV6vYDp0ooUrNq3+a/FbmotFrPrN1Zbda3oidYtxI8IElX8C33oXcGWo7uap3rY4dhDqhlEiEXURk0FL+t16kgm1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fX0VJvHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E865C4CEF1;
	Tue, 19 Aug 2025 22:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755643753;
	bh=xoFiK4rxFUIRRw1ywG9Sjg1y2W8RvmUgV7KXFN1o+3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fX0VJvHpX3zu2ROg1lqiKzEizuel6NvNX6/Wtmm0ZKaCqMVDJp1D7BCvZAQTN+rn7
	 aXayhYqu8BNYqwF+FQePFye/I3lOe5f1HVyTbqWPGRozBFYJ/oZ1Z5dsX9wyyEcmCp
	 yd9JcwJu0EHuwRMDyLMGsWvp3HNsAmNAMVDdiZCU=
Date: Tue, 19 Aug 2025 15:49:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Gu Bowen <gubowen5@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, stable@vger.kernel.org, linux-mm@kvack.org,
 Waiman Long <llong@redhat.com>, Breno Leitao <leitao@debian.org>, John
 Ogness <john.ogness@linutronix.de>, Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v4] mm: Fix possible deadlock in kmemleak
Message-Id: <20250819154912.f6599afb4d7f1c2d5a39890e@linux-foundation.org>
In-Reply-To: <aKSYq17EUrXRGFPO@arm.com>
References: <20250818090945.1003644-1-gubowen5@huawei.com>
	<aKSYq17EUrXRGFPO@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 16:30:51 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> > 
> > Signed-off-by: Gu Bowen <gubowen5@huawei.com>
> > ---
> 
> I suggest you add the 5.10 mention here if you want, text after "---" is
> normally stripped (well, not sure with Andrew's scripts).

Yes, I strip it.  Although there's often useful stuff down there so
I'll paste that into the changelog.

> Otherwise the patch looks fine.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks, I'll queue it for testing and add a note that a v5 is expected.

