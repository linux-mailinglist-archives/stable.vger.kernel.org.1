Return-Path: <stable+bounces-40728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 030F98AF3FF
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B911F22B22
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E313DDD0;
	Tue, 23 Apr 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XeiBZuRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F313D51F
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889512; cv=none; b=fVmTTy2K9rwLL67vD5JMTZ48jS7a7D4SODbZRhWzVQf9/NEaopOyl0pXVV92r4OsqI/XecAiG5MFeIw+Ah5elVZ2OsLBr914guDd+n2A6ur8Yawv+2E6SIjiXlaful4yVnG/ZRA0W+k6q/egTsdlV46c9kQ0hjTYEtxYrFdYjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889512; c=relaxed/simple;
	bh=uNmNVGPVpnSK0aaQxEdKDVECdgtUX0Nuc3lg05pzvTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGjnqJ1W5V1xJ2MM67fvJDfJKWPdupFVd1f2uP/0ebMlhVXqIzt6nyuuYnRIY6/KccvGUxRcGQXbHJ7tu4GqGQID9TaHiIWZgC/finy0iw4E2e2J5FNDxoJZDirfu9y4DEjmaRQZosHrV52tye/7slaQjJHGE9NQetaRvzlQys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XeiBZuRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A46C2BD10;
	Tue, 23 Apr 2024 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713889512;
	bh=uNmNVGPVpnSK0aaQxEdKDVECdgtUX0Nuc3lg05pzvTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XeiBZuRWV6sGv7Z8HCYvBXE8N/nCtNQHMKcFoUg9liQQsnvF2AvgxGQmIPnN4Nr9A
	 FsZ391opOTufxZk72zR/As4hD1Z6/Yx+OcB2AkKL6b79Rc6N00ZIVrmFgAMvn9ahyU
	 8pcNTMw+eAai/O8eYKupXE6fufQo+wluiS0YEPsA=
Date: Tue, 23 Apr 2024 09:25:02 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: guoyong.wang@mediatek.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] random: handle creditable entropy from
 atomic process context" failed to apply to 4.19-stable tree
Message-ID: <2024042328-juggle-woven-74ee@gregkh>
References: <2024041908-ethically-floss-e1ea@gregkh>
 <CAHmME9ryqt=HRtxWCs+WQpu7L5Q6qFXv40C1-oWtKNv=4C1-UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9ryqt=HRtxWCs+WQpu7L5Q6qFXv40C1-oWtKNv=4C1-UA@mail.gmail.com>

On Fri, Apr 19, 2024 at 05:48:30PM +0200, Jason A. Donenfeld wrote:
> 4.19 doesn't have f5bda35fba615ace70a656d4700423fa6c9bebee because of
> 66f1abda14a6789348cb9f5f676ae59e2de78ebd and so we don't need to
> backport e871abcda3b67d0820b4182ebe93435624e9c6a4 to it. So nothing to
> be done here.

Ah, tricky, my scripts can't track the "added and then reverted" stuff
very well for obvious reasons.  Thanks for letting us know for all of
these.

greg k-h

