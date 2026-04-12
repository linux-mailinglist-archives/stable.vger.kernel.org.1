Return-Path: <stable+bounces-235840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9GJjHZLd22mkHwkAu9opvQ
	(envelope-from <stable+bounces-235840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:59:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1163E54B6
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68D5430039B4
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFE936309E;
	Sun, 12 Apr 2026 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vX5UrLSP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27DE36308B;
	Sun, 12 Apr 2026 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016781; cv=none; b=jMEziKeEsFRgrAOHWDVntBlEdiuYAL1/KngQJ1ctBkFzTIFDchl5VntW+RXm64RCgAMnv0sRMYsCzW0T9lVuQN9twHMPVLiXBug3c5+IoshnKjhQ5Bt8sZ7bPyIvvQ91rMQJwORZ5NlB2tB14yCrqhvlrncND8td09NaJ893tj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016781; c=relaxed/simple;
	bh=exVNphoftEq/DGXatpQR/6gB/O9CtE8L96Kx+D2XufI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jZkloBHuLwHcw/aek6lhEt9FiEoxXMelRCh9RPTwRKYhkwo3X+jstKzAxVokg1furzbt1Sk4vb0WPYanX5mip/rJ18v5Xl5UN3mE0FZyFF3d9/SMuvGVAUEMLhu7H7rWiEfh/X5PwnP9u9MafGBOxJoyJO2yycD9K/H+huCNqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vX5UrLSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AA4C19424;
	Sun, 12 Apr 2026 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776016780;
	bh=exVNphoftEq/DGXatpQR/6gB/O9CtE8L96Kx+D2XufI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vX5UrLSPnARMXIX/mQM4uvVK8eB3MjSMjjqX7C0qIf7l5+GlOdecSGatxLiVysej4
	 UiFvVcaKGLgtzPXekd868HrxInxdfvChWUWJ1uQg7G5aBmNOCYUAFTKXj5RpDsQiCC
	 HXWEYedmXBXK+9QGKMUNHwqteybGaznIrdeox5kI=
Date: Sun, 12 Apr 2026 10:59:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Lance Yang <lance.yang@linux.dev>, lgs201920130244@gmail.com,
 david@kernel.org, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: thp: Fix refcount leak in thpsize_create() error
 path
Message-Id: <20260412105934.50892a9988df0403c209c886@linux-foundation.org>
In-Reply-To: <75F536FE-6710-4AE7-B6DB-2997D846237E@nvidia.com>
References: <20260411062152.2092967-1-lgs201920130244@gmail.com>
	<20260411142858.85496-1-lance.yang@linux.dev>
	<848180C7-F98C-44B2-AB1F-579BF9EEA28E@nvidia.com>
	<3e688ea1-05ba-4e75-9d92-2751ff6f3b7b@linux.dev>
	<75F536FE-6710-4AE7-B6DB-2997D846237E@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235840-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,oracle.com,linux.alibaba.com,redhat.com,arm.com,kvack.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EC1163E54B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 09:33:29 -0400 Zi Yan <ziy@nvidia.com> wrote:

> > wording, especially:
> >
> > "resulting in a refcount leak and potentially leading to a use-after-free"
> >
> > The old code does skip the required kobject cleanup path, but is
> > a UAF actually possible there?
> 
> That is my question too. The original code might not cause any real issue.
> 
> Guangshuo, let us know if we get it wrong. Thanks.

Thanks, all.  I queued this for testing and added a note that a
changlog update is expected.


