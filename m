Return-Path: <stable+bounces-16053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878F083E8E0
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 02:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452FD28B784
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B724680;
	Sat, 27 Jan 2024 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b9vyHydl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A722F93
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318027; cv=none; b=Flb6ORlS7HkeHfmN98cryxMurM301Ej/DE4H+bD3TPgPbHhhV92bN6bXYEdAufroCotw8MGS14WdI4munTaiPpdUILp4AVUcI/KwET2o2ByjNSwsKdZhcpsT2nCoaXuKbJcd9OzEzXRBuilS48iYp2rQnZmbTImpFzoqmdMyqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318027; c=relaxed/simple;
	bh=CW9SJyTT917YFY7a9NEhSOwRzob2SwoA8d8nF1/kz6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxLM9GH8/kcE3PjWdvfObdOew4WEhHULU0g88dcGmGCqlW4YEHyu7oZJ6witIkrOZmKJoe20QRNwY15CIoAkzhizwru2I5V0ctjavrU3OcTOhBKaZUMh+wozffill6Ozm65rKJ5Tqm8PITRuHFkfZ+SdTEi4o4yS2Tkl13wwrBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b9vyHydl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE331C433F1;
	Sat, 27 Jan 2024 01:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706318026;
	bh=CW9SJyTT917YFY7a9NEhSOwRzob2SwoA8d8nF1/kz6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9vyHydlxUSUwR1ots93EHKj4coc53sI2+9GjJzQC1laZFqpMg74wBRBmToGKXbt4
	 JzF1XrZqDy2h2O6w5pF2ewBtYZ5Z59vHwQA4qN92yQUeYzAAObcq8qUILc26rOWn8a
	 hyH5VFIMQUnSpXl7aJo7DEsHux9264o9dFziSE5U=
Date: Fri, 26 Jan 2024 17:13:44 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: stable@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, yonghong.song@linux.dev,
	mykolal@fb.com, mat.gienieczko@tum.de
Subject: Re: [PATCH 6.6.y 00/17] bpf: backport of iterator and callback
 handling fixes
Message-ID: <2024012618-grandpa-stylus-b2b7@gregkh>
References: <20240125001554.25287-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125001554.25287-1-eddyz87@gmail.com>

On Thu, Jan 25, 2024 at 02:15:37AM +0200, Eduard Zingerman wrote:
> This is a backport of two upstream patch-sets:
> 1. "exact states comparison for iterator convergence checks"
>    https://lore.kernel.org/all/20231024000917.12153-1-eddyz87@gmail.com/
> 2. "verify callbacks as if they are called unknown number of times"
>    https://lore.kernel.org/all/20231121020701.26440-1-eddyz87@gmail.com/
>   
> Both patch-sets fix BPF verifier logic related to handling loops:
> for bpf iterators, and for helper functions that accept callback
> functions.
> 
> The backport of (2) was requested as a response to bug report by
> Mateusz Gienieczko <mat.gienieczko@tum.de>.
> The (1) is a dependency of (2).
> 
> The patch-set was tested by running BPF verifier selftests on my local
> qemu-based setup.
> 
> Most of the commits could be cherry-picked but three required merging:
> 
> | Action | Upstream commit                                                                                 |
> |--------+-------------------------------------------------------------------------------------------------|
> | pick   | 3c4e420cb653 ("bpf: move explored_state() closer to the beginning of verifier.c ")              |
> | pick   | 4c97259abc9b ("bpf: extract same_callsites() as utility function ")                             |
> | merge  | 2793a8b015f7 ("bpf: exact states comparison for iterator convergence checks ")                  |
> | pick   | 389ede06c297 ("selftests/bpf: tests with delayed read/precision makrs in loop body ")           |
> | pick   | 2a0992829ea3 ("bpf: correct loop detection for iterators convergence ")                         |
> | pick   | 64870feebecb ("selftests/bpf: test if state loops are detected in a tricky case ")              |
> | pick   | b4d8239534fd ("bpf: print full verifier states on infinite loop detection ")                    |
> | drop   | dedd6c894110 ("Merge branch 'exact-states-comparison-for-iterator-convergence-checks' ")        |
> |--------+-------------------------------------------------------------------------------------------------|
> | pick   | 977bc146d4eb ("selftests/bpf: track tcp payload offset as scalar in xdp_synproxy ")             |
> | pick   | 87eb0152bcc1 ("selftests/bpf: track string payload offset as scalar in strobemeta ")            |
> | pick   | 683b96f9606a ("bpf: extract __check_reg_arg() utility function ")                               |
> | pick   | 58124a98cb8e ("bpf: extract setup_func_entry() utility function ")                              |
> | merge  | ab5cfac139ab ("bpf: verify callbacks as if they are called unknown number of times ")           |
> | pick   | 958465e217db ("selftests/bpf: tests for iterating callbacks ")                                  |
> | pick   | cafe2c21508a ("bpf: widening for callback iterators ")                                          |
> | pick   | 9f3330aa644d ("selftests/bpf: test widening for iterating callbacks ")                          |
> | merge  | bb124da69c47 ("bpf: keep track of max number of bpf_loop callback iterations ")                 |
> | pick   | 57e2a52deeb1 ("selftests/bpf: check if max number of bpf_loop iterations is tracked ")          |
> | drop   | acb12c859ac7 ("Merge branch 'verify-callbacks-as-if-they-are-called-unknown-number-of-times' ") |
> 
> Note:
> I don't know how deal with merge commits, so I just dropped those.
> These commits are empty but contain cover letters for both series,
> so it might be useful to pick those (how?).

Nah, merge commits are not needed to be backported, that doesn't work :)

All now queued up, thanks!

greg k-h

