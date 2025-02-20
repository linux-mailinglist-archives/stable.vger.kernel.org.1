Return-Path: <stable+bounces-118510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39978A3E58C
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 21:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6223B512F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D53214A8B;
	Thu, 20 Feb 2025 20:05:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1C1E5B6C;
	Thu, 20 Feb 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081937; cv=none; b=c5/7452p3XVsHBHeaN0uo+PQL2sSqVxRbk7LsaV56zP6h+0vfNRWTXUr5LkRxJ1AhEKNFJZOEx4WW3LARcAVKlFKs88pnhp1LvWjLK55GuAFr6X6061TsBgl+mUkBmrnLIVqgOWT26rf/Ma/+7x5muV5hc5Pz9K27X1aot2zBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081937; c=relaxed/simple;
	bh=F/fXjgv4BeGF5FPVqy9+hUF14lIoncGGnoL86e/4Yuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGIXs/dFR7aewswnsNsohrT71vSpNcIRk8flsodPB4jgz7HZjTsF0R+4wot+ii9GTBLbChheXnKDhiTb0tIyKRdqJvsR2enNJOCghMcdDyw1/oRQugoTqZmlInU4HjoToe+SjkwrdA9GVZ+/Ux2vpj15pAIjITbo8RzzcjtQY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29759C4CED1;
	Thu, 20 Feb 2025 20:05:36 +0000 (UTC)
Date: Thu, 20 Feb 2025 15:06:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ftrace: Fix accounting of adding subops to a
 manager ops
Message-ID: <20250220150602.25163ea9@gandalf.local.home>
In-Reply-To: <20250220155858.8a99ab5dae52b875fdbab1d6@kernel.org>
References: <20250219220436.498041541@goodmis.org>
	<20250219220510.888959028@goodmis.org>
	<20250220155858.8a99ab5dae52b875fdbab1d6@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 15:58:58 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 19 Feb 2025 17:04:37 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > @@ -3292,16 +3299,18 @@ static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_has
> >  /* Return a new hash that has a union of all @ops->filter_hash entries */
> >  static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
> >  {
> > -	struct ftrace_hash *new_hash;
> > +	struct ftrace_hash *new_hash = NULL;  
> 
> Isn't this "= EMPTY_HASH"?
> 

No it has to be NULL. As the change log stated:

   Fix this by initializing the new hash to NULL and if the hash is NULL do
   not treat it as an empty hash but instead allocate by copying the content
   of the first sub ops. Then on subsequent iterations, the new hash will not
   be NULL, but the content of the previous subops. If that first subops
   attached to all functions, then new hash may assume that the manager ops
   also needs to attach to all functions.


Hmm, but we should return EMPTY_HASH if new_hash is still NULL after the
update. Otherwise the caller may confuse this as a failed allocation.

I'll send a v3.

Thanks,

-- Steve

