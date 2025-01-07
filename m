Return-Path: <stable+bounces-107874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC02A04682
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 17:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E243A18A3
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C93E1E47C8;
	Tue,  7 Jan 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEMTeyK+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587EC17B50A;
	Tue,  7 Jan 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267771; cv=none; b=O/Ddye2F3nd2G15Qghqgla+sQAI/GgJdWu0K7W928cZOKQGVzfycFBOIfdHWkaWwHQvV+0LFDy+vu13IPFxudXM1dSXIs4hUHOM+xaA+p0PKE0pX2AFvu8UIiV1dyt+JMkcCyqLOyKt+L1ylaIGaLXSvL01CrLY/q00POk47pOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267771; c=relaxed/simple;
	bh=vzUy837LTyBXWf89XS3TbwkCCyKms+5Y1Lql1pXQSKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0DzPBMt6037FZSPdlMz4q3Uo1etyoCnKSHP+fEzH2m8fTKe6ah5+78WDS8M0S4uTpfd6illODp6HhtuOwIhDMFSSm0qQBsM+OrDoiw/22q9wYxAL//Pdwy9IIVQPHaiEA6B/Yh5Qe7BLLFq4ASLqVmDdvHYZqRMml8DEjtAUKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEMTeyK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A43C4CED6;
	Tue,  7 Jan 2025 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736267770;
	bh=vzUy837LTyBXWf89XS3TbwkCCyKms+5Y1Lql1pXQSKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pEMTeyK+4/4l4RjvrmYXzKeX2NGzmnOhakTbV6zBZK4zIn1RJqtQHYYoLuJ4lFhHO
	 FO5REhS48U4ekxqsjsHMH7MUVm8PSFLjg5JRolhaQczXwf8MV7YGBEk+YYe4FzoNJV
	 N9o7e+a9YFCSPtMoCKQJpBBqph5zQNCwN07R2Xw6T7jIBU85GhEg6BxY+U4ePdRBzV
	 PJv1ev1Gv2OJOOFCRsdGb6fb+mCS81A+lEMX6GYqDVHKzsZ8hT7HGDujzxH3eOS2vw
	 zwG4TlVunT9Tl26UEBTSLX80JNpa0W5PyzfLuw0HhlHvts5LAWIU6tmRKPiG2FZdt5
	 cW7MtWcc5NCoA==
Date: Tue, 7 Jan 2025 08:36:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, stable@vger.kernel.org, jdamato@fastly.com,
 almasrymina@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com
Subject: Re: [PATCH net] netdev: prevent accessing NAPI instances from
 another namespace
Message-ID: <20250107083609.55ddf0d6@kernel.org>
In-Reply-To: <677d27cc5d9b_25382b294fd@willemb.c.googlers.com.notmuch>
References: <20250106180137.1861472-1-kuba@kernel.org>
	<677d27cc5d9b_25382b294fd@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Jan 2025 08:10:36 -0500 Willem de Bruijn wrote:
> > +/* must be called under rcu_read_lock(), as we dont take a reference */  
> 
> Instead of function comments, invariant checks in code?
> 
> Like in dev_get_by_napi_id:
> 
>         WARN_ON_ONCE(!rcu_read_lock_held());

Can I do it as a follow up? Adding the warning to napi_by_id()
reveals that napi_hash_add() currently walks the list without
holding the RCU lock :)

