Return-Path: <stable+bounces-179426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9148B56086
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 13:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DA91C2128A
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE62EC08A;
	Sat, 13 Sep 2025 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KMKUgEqP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3C26281;
	Sat, 13 Sep 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757763860; cv=none; b=ge8yU/yykbmuHaHDorgV3FpkvLE/3WQp+7xef/C+4Bmha05Rw3MfPSOUAGCou/ZPWRlDL6+VcawDbIggNUOCkK/vHlLp7KoUlHMdOZAIlahr0dk2IGGbMRRccp/OyC3r6GKXsCXHAhwksD/X08Rcj9RvhRni2kY4OH5jeni7miM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757763860; c=relaxed/simple;
	bh=OX/8ExrAvr+0QCe8fRUnJcR44aTmTRK7r3dF/K1NSlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQlcjufkru0Xw+AmFOUwnuZteQowf+KBorag83kRDvlqkDQq5zy1V/vOdd4/o5Hnp9zi3zy6GJM1i+VmGb/0umyrCRWeLmeDjr7s8s5sqYBgBhm6SE5McLwkjFT7JYTIhDWKv5R5IdNYFAfRCifY48mJsA76VQBW9qowvorUbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KMKUgEqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AACC4CEEB;
	Sat, 13 Sep 2025 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757763860;
	bh=OX/8ExrAvr+0QCe8fRUnJcR44aTmTRK7r3dF/K1NSlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMKUgEqPbO3SG1OaT89uMny0EjiYJf+W+KXq/Fod8jlmtK5x40xR6SJPomJ+uzdm0
	 voRW6XKdMq0qys3i8aSvK4HLyhUcq83j8/YRYtO3Lx1yXHYr1VPmft3i01is3aGOGb
	 M7mVgyhiyJpsnsatS7SULgS8HjYlUrPyNg9Vv2jk=
Date: Sat, 13 Sep 2025 13:44:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: luc.vanoostenryck@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
	natechancellor@gmail.com, ndesaulniers@google.com,
	keescook@chromium.org, sashal@kernel.org, akpm@linux-foundation.org,
	ojeda@kernel.org, elver@google.com, kbusch@kernel.org,
	sj@kernel.org, bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
	clang-built-linux@googlegroups.com, stable@vger.kernel.org,
	jonnyc@amazon.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 4/4 5.10.y] tracing: Define the is_signed_type() macro
 once
Message-ID: <2025091303-collector-outtakes-51d0@gregkh>
References: <20250912185518.39980-1-farbere@amazon.com>
 <20250912185518.39980-5-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912185518.39980-5-farbere@amazon.com>

On Fri, Sep 12, 2025 at 06:55:16PM +0000, Eliav Farber wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> commit a49a64b5bf195381c09202c524f0f84b5f3e816f upstream.

This is not a valid upstream commit id :(


