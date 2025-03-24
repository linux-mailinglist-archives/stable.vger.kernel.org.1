Return-Path: <stable+bounces-125865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6215EA6D69E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD2C1892340
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8071DFF0;
	Mon, 24 Mar 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="naB/o4qr"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902C7DA6A
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806418; cv=none; b=D7cYJfZDPL/eyuRIoXUWUlmTCrY7kgHZMRR94P2YcT7u/nvj/fRmwRzJXbTS/a/X66TPHM1g0mR1qH85jRBPssUt+ybZqyxxEsF5LinloWAyuK48wKQz6/Nk4cZWLovZ4uuzF2jH7SV8Pe/GOIaA8X5kRUAT2aVZRXddIyovFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806418; c=relaxed/simple;
	bh=1sjxmZs++RtKttk5Kcgs7zOyukmBm9bzTbYf3Slz9tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHC1SR/q+fwf9oEfUKdBRZEA8e55hNzAiVEPCFKgw9QAWdUaANnNiDY5+q/MjwvWuCgc1IBP1JZwMn2FVvMhyaaUJpfFT9EPUVDfDGTsHKEcxqDX4tN8WayGZ+nDmp4mjaesu4cpoep9vOfeZZd+SikT40JvXbNegUK9xC31kpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=naB/o4qr; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.16])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8BFA140737D5;
	Mon, 24 Mar 2025 08:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8BFA140737D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1742806406;
	bh=WDE8DY1nUB62vbtKOsrqcK61nnPZYTljE4agZlw0ZIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=naB/o4qrhYvBKo5n3qO3ClqL4laBC7e8yF5eCZj4HBUuvgYZRGvXFlIeQG9Gu8F/B
	 4EJVKyfDik+hzoKSMoR1oFvWFPZ2h7yaev0JZxHK5R3+aR/mCSGVBksG8Gj5tAmdnF
	 V9gI0iFyFyOlWJsYtFMBoPBe3htUWX5rQo+zvP8g=
Date: Mon, 24 Mar 2025 11:53:26 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover
 intent items
Message-ID: <wv2if5xumnqjlw6dnedf5644swcdxkc6yrpf7lplrkyqxwdy4r@rt4ccsmvgby4>
References: <20250313202550.2257219-15-leah.rumancik@gmail.com>
 <6pxyzwujo52p4bp2otliyssjcvsfydd6ju32eusdlyhzhpjh4q@eze6eh7rtidg>
 <CACzhbgRpgGFvmizpS16L4bRqtAzGAhspkO1Gs2NP67RTpfn-vA@mail.gmail.com>
 <oowb64nazgqkj2ozqfodnqgihyviwkfrdassz7ou5nacpuppr3@msmmbqpp355i>
 <CACzhbgQ4k6Lk33CrdPsO12aiy1gEpvodvtLMWp6Ue7V2J4pu4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACzhbgQ4k6Lk33CrdPsO12aiy1gEpvodvtLMWp6Ue7V2J4pu4Q@mail.gmail.com>

On Sun, 23. Mar 17:29, Leah Rumancik wrote:
> Okay so a summary from my understanding, correct me if I'm wrong:
> 
> 03f7767c9f612 introduced the issue in both 6.1 and 6.6.
> 
> On mainline, this is resolved by e5f1a5146ec3. This commit is painful
> to apply to 6.1 but does apply to 6.6 along with the rest of the
> patchset it was a part of (which is the set you just sent out for
> 6.6).

Yeah, that's all correct.

> 
> With the stable branches we try to balance the risk of introducing new
> bugs via huge fixes with the benefit of the fix itself. Especially if
> the patches don't apply cleanly, it might not be worth the risk and
> effort to do the porting. Hmm, since it seems like we might not even
> end up taking 03f7767c9f6120 to stable, I'd propose we just drop
> 03f7767c9f6120 for now. If the rest of the subsequent patches in the
> original set apply cleanly, I don't think we need to drop them all. We
> can then try to fix the UAF with a more targeted approach in a later
> patch instead of via direct cherry-picks.
> 
>  What do you think?

03f7767c9f6120 is '[PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover'

Two subsequent patches depend on it logically so should also be dropped:

'[PATCH 6.1 15/29] xfs: pass the xfs_defer_pending object to iop_recover'
'[PATCH 6.1 16/29] xfs: transfer recovered intent item ownership in ->iop_recover'


On the other side, '[PATCH 6.1 13/29] xfs: don't leak recovered attri intent items'
which is at the start of the original patchset [1] looks OK to be taken.
It's rather aside from the subsequent rework patches and fixes a pinpoint
bug.

[1]: https://lore.kernel.org/linux-xfs/170191741007.1195961.10092536809136830257.stg-ugh@frogsfrogsfrogs/


So I've tried the current xfs backport series with three dropped commits:

[PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover
[PATCH 6.1 15/29] xfs: pass the xfs_defer_pending object to iop_recover
[PATCH 6.1 16/29] xfs: transfer recovered intent item ownership in ->iop_recover

(everything before and after that still applies cleanly and touches
other things)

and no regressions seen on my side.

