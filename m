Return-Path: <stable+bounces-126794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5BAA71F1C
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 20:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633061897DDC
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A67253B67;
	Wed, 26 Mar 2025 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b="4GIKHMx5"
X-Original-To: stable@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572BC23C8CD;
	Wed, 26 Mar 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017230; cv=none; b=RxS6NRiKK82xA2xyaJWxqa5jWJR5Emzua614Eq0UKsp2SP7zeSecN/dsZ0BEHWOBDXesgCYVnU70+B5dVkfHZjWJQuFLD2YCcD+C/aqLok3t+ijHgED1nYslsr05wCesAowWyQqgCjnXC22j1Sy+uCKX99UI2fd4MN2zFI3QAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017230; c=relaxed/simple;
	bh=yAId1LVyBbc4r4brsJg50UoxxOnjUNXUtVQSvaU9dvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iieuOdap/GVls974zdmOrkUhDjvtUUrsKDRSL72q29L+iwnq3EKHkbGUhBGHu+ck4XGW1ZlqpJfOJaAoXVLJNkr8Jau9oqD+PNwFKBukjIryBibtckutA5ikBU2UbskhRz9E6Tb4ET2OZCx4K9Om7yeQnhZADLLm17b4juAtDiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io; spf=pass smtp.mailfrom=patcody.io; dkim=pass (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b=4GIKHMx5; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=patcody.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=patcody.io;
	s=protonmail; t=1743017219; x=1743276419;
	bh=csafadTp80E+2AhxL0L/Gfe0jTEubxOlvpB5ESKE150=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=4GIKHMx5iKEXtXNz/tLPeulnlEiX31I9L+UgJuubcTDfAbX3Bs/29qDAe8HbjBm7B
	 iyaAK5gEUM3YAYnS78+xh/L7dmWFdQNveh9tG5/Roueal9oVar96AF+Nl2QrBPDtp2
	 P6hEEExNaOWZMJWt+bIbJG3YFUHxoRvTb+wM2vCwT/7u81XZ2yK8ZRmZkFbBMmzbyV
	 gIC6sdOcQ1w+AhOlfhapxctifo42euIn1pmnViLOk4FrZai4YCGVvt35JbDlhkQwx1
	 +hHNgo4V6hbjMIScr693Qi1I0a8pMJfxvOgzQXBMGsZZ2XJEDilWbkB3Ex7SetLV12
	 rDiocQE40Un/Q==
X-Pm-Submission-Id: 4ZNGxn6v6kz4CV
Date: Wed, 26 Mar 2025 12:26:52 -0700
From: Pat Cody <pat@patcody.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	riel@surriel.com, patcody@meta.com, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <Z+RU/ONNC0D3neQz@devvm1948.rva0.facebook.com>
References: <20250320205310.779888-1-pat@patcody.io>
 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
 <Z+LH3k2RyXOg9fn4@devvm1948.rva0.facebook.com>
 <20250325185907.GC31413@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325185907.GC31413@noisy.programming.kicks-ass.net>

On Tue, Mar 25, 2025 at 07:59:07PM +0100, Peter Zijlstra wrote:
> > To clarify- are you asking about if we've tried reverting 4423af84b297?
> > We have not tried that yet.
> > 
> > Or if we've included "sched/fair: Adhere to place_entity() constraints",
> > which we have already done- https://lore.kernel.org/all/20250207-tunneling-tested-koel-c59d33@leitao/
> 
> This; it seems it got lost. I'll try and get it queued up.

Given that we've already included the patch in what we're running, and
we're seeing this null pointer exception, any suggestions for how to
proceed?

