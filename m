Return-Path: <stable+bounces-17432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F9284296B
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 17:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9017293C87
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DD1128368;
	Tue, 30 Jan 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pRJ4p2zZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548F1272C9
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632531; cv=none; b=qbjqPPboxTFWsQ4VOH5CTosn+FWnfWQTFSDGh6G5ys3pwCkFZljYAphhzoz6310KZEUgufBRI30sVzN0SZTV54G3UAX4Cm6u2zx1FV4HmAMZbemi9n5IF3F3egZOWD5OXkjgetYShnieXqgIY4nhxfrCSOK1QoNPZ/5fgXpQolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632531; c=relaxed/simple;
	bh=tVf+49okM2QfeL4HQDZ800cuVpe2pXTZNuGrFvkGIrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdT/fqopNUu8ASWq50YlGPqmKsHooJz0nYaY74xoPenw/soukBN0Fuyhbb8zNKq7rE6vZEduBKFKbe1IgDXjVa/4Y2jinN2VFmz770PwWDU0Vf+RT1g36/IBUH6BBRExYRqEjn9jqLSVTWDeEMiLwVdQK0MeGqGCmF8hADW9eNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pRJ4p2zZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E3DC43390;
	Tue, 30 Jan 2024 16:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706632531;
	bh=tVf+49okM2QfeL4HQDZ800cuVpe2pXTZNuGrFvkGIrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRJ4p2zZ29T8dVfIMfq/MAozNOWG/xEC8PsWs65FU3uaw7PRZgCzwfcS1utOuwJYw
	 kl4wIrC2aGwWhMitCSjiUiSX5kFsYAjeqKXDGJzmlDbArlWQzirBH0ppEY91GArTXq
	 eBuF5J4yeGwpVUhFdA9GybrTK5OUUx6SOxD040mw=
Date: Mon, 29 Jan 2024 19:06:42 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: chenhuacai@loongson.cn, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] LoongArch/smp: Call
 rcutree_report_cpu_starting() at" failed to apply to 6.1-stable tree
Message-ID: <2024012932-share-rendering-96e1@gregkh>
References: <2024012911-outright-violin-e677@gregkh>
 <CAAhV-H44QUho8cq4cG6rpovboBH_28vfiw-akMWoLMLR6Qgu1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H44QUho8cq4cG6rpovboBH_28vfiw-akMWoLMLR6Qgu1w@mail.gmail.com>

On Tue, Jan 30, 2024 at 10:25:18AM +0800, Huacai Chen wrote:
> Hi, Greg,
> 
> On Tue, Jan 30, 2024 at 12:53 AM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 5056c596c3d1848021a4eaa76ee42f4c05c50346
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012911-outright-violin-e677@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> >
> > Possible dependencies:
> >
> > 5056c596c3d1 ("LoongArch/smp: Call rcutree_report_cpu_starting() at tlb_init()")
> Similar to the commit which it fixes, please change
> rcutree_report_cpu_starting() to rcu_cpu_starting() in the code.

I need a backported patch for that please :)

