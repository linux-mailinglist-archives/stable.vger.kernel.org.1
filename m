Return-Path: <stable+bounces-217678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCkICh5bm2k4ygMAu9opvQ
	(envelope-from <stable+bounces-217678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 20:38:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCDF170358
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 20:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D043004C54
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 19:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24F13D891;
	Sun, 22 Feb 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AZCMsAWK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5E35C195
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771788993; cv=none; b=iUxwpdfrNyXMN8ZujoYsWv9jQvJlqUAJP50N8BstU8rbzce20nfx8JyWNBc8vnehK6PIeefgiNrsxzCDya99F8l8EDQEyB+ehByMEHEbPvvaghx7rWDxV1Gf85K2nClZDKGk55SLeTUk/xbnvkK4rzPZ9ZUq4v6csqmD5Pgz4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771788993; c=relaxed/simple;
	bh=j6Aq3bLjqLlAE41T2HRH6SRYftcu10d13je1+Jl1r4U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HQ8oG0/xPq9CcBLxUmY0Y1tDqnVYcKG5xy+u1zYXf61iDJSpJLIoT5RB2QI4WWGLDCxaJw09bCYaUc4BNn9KjWArJyTfxVYLmrlas4ztDswKvFqXQ7CRuEqaQ9EsqOWqj6VYwqY84HpcXJgLNa5S7IEBw0mpYa61g21V50cfYFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AZCMsAWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAEAC116D0;
	Sun, 22 Feb 2026 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771788992;
	bh=j6Aq3bLjqLlAE41T2HRH6SRYftcu10d13je1+Jl1r4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AZCMsAWKL+/zY8NFl0Po/6EbZiGpdgS8AA5J6C27bJSt27K4bXZpGss4wAXbRL7G0
	 txWNxp4a2TET+NfCMmAHz2Ut++fN12p+1OZEySCZc0eHUWQNTlhJ2rfBQs6buFLkdn
	 ORFfplOCuxjoO/fR6VoOASJReEhD/6m8S9SHmYBA=
Date: Sun, 22 Feb 2026 11:36:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: YoungJun Park <youngjun.park@lge.com>
Cc: Chris Mason <clm@meta.com>, stable@kernel.org, chrisl@kernel.org,
 kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/swapfile: fix list iteration when next node
 is removed during discard
Message-Id: <20260222113631.6011221e2d8d8f3973f035ae@linux-foundation.org>
In-Reply-To: <aZpe3kD/xmz87zYH@yjaykim-PowerEdge-T330>
References: <20251127100303.783198-2-youngjun.park@lge.com>
	<20260220151338.3234934-1-clm@meta.com>
	<aZpe3kD/xmz87zYH@yjaykim-PowerEdge-T330>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217678-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[meta.com,kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,kvack.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 7BCDF170358
X-Rspamd-Action: no action

On Sun, 22 Feb 2026 10:41:50 +0900 YoungJun Park <youngjun.park@lge.com> wrote:

> > Hi everyone,
> > 
> > This fix landed upstream in v6.19-rc1:
> > 
> > commit f9e82f99b3771eef396dbf97e0f3c76e20af60dd
>
> > Author: Youngjun Park <youngjun.park@lge.com>
> > Date:   Thu Nov 27 19:03:02 2025 +0900
> > Subject: mm/swapfile: fix list iteration when next node is removed during discard
> > 
> > Looks like the commit being fixed is actually:
> > 
> > commit 9fb749cd15078c7bdc46e5d45c37493f83323e33

yup.  I've updated the changelog.


