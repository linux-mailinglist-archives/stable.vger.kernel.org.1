Return-Path: <stable+bounces-6982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B326816B4C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 11:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8121C226AA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3FE15AED;
	Mon, 18 Dec 2023 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2o1J3U/J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B9156CC;
	Mon, 18 Dec 2023 10:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5CCC433C8;
	Mon, 18 Dec 2023 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702895983;
	bh=gsBFtvcLQEB2OPxEzYU/lJVtb0niJX/qEG4k+iaW8j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2o1J3U/JYyyJ8shRx7yP2P7QwM05LT3pBibGCUKDaacFJoWilnkMX44IJvSX6HZlc
	 fpBzv+GKWEgjorubg9rThSmIkD88jXI+t5cqITOTzLNuNSl3KFGi4rjqg6mHoLSWXI
	 XqdYR9e4fQRuAVB8JnR/572Z++7Y+p+zJXbL3wR4=
Date: Mon, 18 Dec 2023 11:39:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Fangrui Song <maskray@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: Apply b8ec60e1186cdcfce41e7db4c827cb107e459002 to linux-6.6.y
Message-ID: <2023121835-ditch-tanned-4a46@gregkh>
References: <20231213000338.GA866722@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213000338.GA866722@dev-arch.thelio-3990X>

On Tue, Dec 12, 2023 at 05:03:38PM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please consider applying commit b8ec60e1186c ("x86/speculation, objtool:
> Use absolute relocations for annotations") to linux-6.6.y, which is the
> only supported stable version that has the prerequisite commit
> 1c0c1faf5692 ("objtool: Use relative pointers for annotations"). This
> fixes a bunch of warnings along the lines of the one in the commit
> message that are seen when linking ARCH=i386 kernels with ld.lld 18+. It
> picks cleanly for me.

Now queued up, thanks.

greg k-h

