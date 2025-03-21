Return-Path: <stable+bounces-125786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB668A6C1E4
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFC43A996B
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C522E3FD;
	Fri, 21 Mar 2025 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b="rWmuvsVa"
X-Original-To: stable@vger.kernel.org
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CE1D5AC0
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579559; cv=none; b=iM0+dYGWiqerobwDC9YB6E9bwpzTPAY6sMTCSzVtIciEt+VE3AFaJDdTCB+aqI9jqsI3WIE6fp4nfZqvh4RP3prpUe58h6DV8wECf+8TwgO7lxHi01nxTPBNEDB7M7UH+8lbmtW7o4oqMBs+COQHMN1kg8kKLORoCEKi0v1iDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579559; c=relaxed/simple;
	bh=3KbwbiIdZD9SwPO5/Ys1Ipv2htc083kqYRR4qOWVVyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf38OnKBdVVyfTVgqNVxpQhmUvpoqd1UAY6SnAQOsCdAxsu4o3YGDHHWYilE/+vkm7fBKLdq8otgjqj+otOOMSC38+xGFAVPZqiSysIcNnMCn2AIqpbpikpH2On9pIbz5i/3zX2m33YDyr6mQDk9js5riKWeT3ykfmqQPv+Qweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io; spf=pass smtp.mailfrom=patcody.io; dkim=pass (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b=rWmuvsVa; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=patcody.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=patcody.io;
	s=protonmail; t=1742579553; x=1742838753;
	bh=ZFYA/cCQuoMCq2M/VnoisL8CaGvvio8pJRHM3dKEtuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=rWmuvsVaxRl8KnWGiWrSB96AwDf9LpIrCYLbb/o7HkRJ2JzPDWPf+kwQt50rNNMXR
	 19zu4gTUqJKU21r63k5C6oxaiKB+kISPaud5/4J0nuH41X/OIi2166areV3zxgYojW
	 qHp0AbMOoqazmxPb1EJCx9s9h4xVxXms7DtNLcGeWURFnS+8gnrw2Z94uPYTmp//6R
	 wHORoctjh4diZDuxsEZXTbsPW/TKhpp0NE3ZIqoYap1zoMdzzUJjk61fkkSOP+tdCF
	 L7jxVcbjaosjPorH4xClsvuVBf+VHfYHOdiWA6ETNKWYzuk/7tKbBnAKgzRTp4A3l7
	 388A3bUKXwHQw==
X-Pm-Submission-Id: 4ZK95B2lg8zNx
Date: Fri, 21 Mar 2025 10:52:29 -0700
From: Pat Cody <pat@patcody.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org, riel@surriel.com,
	patcody@meta.com, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <Z92nQ8fQRGoEh4+k@devvm1948.rva0.facebook.com>
References: <20250320205310.779888-1-pat@patcody.io>
 <72cb8df7-42e7-4266-b014-7d43796b14d8@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72cb8df7-42e7-4266-b014-7d43796b14d8@arm.com>

On Thu, Mar 20, 2025 at 10:42:44PM +0000, Christian Loehle wrote:
> Did this happen on mainline? Any chance it's reproducible?

We have the following back-ported on top of 6.13:

sched/fair: Adhere to place_entity() constraints (not upstreamed, see https://lore.kernel.org/all/20250207111141.GD7145@noisy.programming.kicks-ass.net/)
a430d99e3490 sched/fair: Fix value reported by hot tasks pulled in /proc/schedstat
2a77e4be12cb sched/fair: Untangle NEXT_BUDDY and pick_next_task()

We don't have a repro, but the crash in pick_task_fair happens more
often than MCE crashes with our limited deployment of 6.13. 

