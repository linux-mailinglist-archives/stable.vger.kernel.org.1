Return-Path: <stable+bounces-118924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6AFA41FC0
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92293B3E0B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288923BCFA;
	Mon, 24 Feb 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pHEDXCbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB418B47D
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401412; cv=none; b=pYwLNr9G1m93ingorPlhmNnqFdV1vomzsJtFXP1ZiqPHJoqjY6xXt74hVcgg0TRZhbTWJPcSJsgr2etqCjn6HYrEYb62eySMHWuFbGjMBRYx6ttJLefqf/yNLFUmohJugBO24SP9W1gK2wLfQ80TWqs5F9hPL1AZ/aQA1X9pRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401412; c=relaxed/simple;
	bh=x/d7h7F2f9ES2/GHWrAvtcp2vyGtRoUd7cwQd05bpUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+2Z0ZkFuQgx3HuetqJHcwRSt94g+3y12JaW7qHhaUPl66K87Dc/G0gIt7LCXMYiNBy8yXkI9kxR1dCot1/4oXpcO0gMwc10DBu45ZpNmK36wPKf1cPDxFiUPbciD9/qVA94Qf6BcvrDjiHs6v2RssZro/4Lf6a42hapkeq172c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pHEDXCbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9790BC4CED6;
	Mon, 24 Feb 2025 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740401412;
	bh=x/d7h7F2f9ES2/GHWrAvtcp2vyGtRoUd7cwQd05bpUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHEDXCbN4zBHpBCA4vf2/iocyNfxnmPIgrjEv/wM+tVK/QfbPUazTxCJ6SZ+5sM/e
	 SEjUWgHOtpNedzm+Q7axr0Jr3svTSWSCWQIiKyxKb9UDuSs/Gj9C+4OQ51eLQeq5Ug
	 692kVltRiIJGE9pC0WAI/ESoOUZATRBn2TwJl3Sc=
Date: Mon, 24 Feb 2025 13:50:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: lukasz.czechowski@thaumatec.com, heiko@sntech.de,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] arm64: dts: rockchip: Disable DMA for
 uart5 on px30-ringneck" failed to apply to 6.6-stable tree
Message-ID: <2025022438-frail-cache-64c7@gregkh>
References: <2025022438-automated-recycled-cc12@gregkh>
 <ff3a6ebe-1723-4879-8c17-561c9ea5b9c4@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3a6ebe-1723-4879-8c17-561c9ea5b9c4@cherry.de>

On Mon, Feb 24, 2025 at 11:46:55AM +0100, Quentin Schulz wrote:
> Hi Greg, Heiko, Lukasz,
> 
> On 2/24/25 11:27 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 5ae4dca718eacd0a56173a687a3736eb7e627c77
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022438-automated-recycled-cc12@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> 
> Commit 5ae4dca718ea ("arm64: dts: rockchip: Disable DMA for uart5 on
> px30-ringneck") depends on 4eee627ea593 ("arm64: dts: rockchip: Move uart5
> pin configuration to px30 ringneck SoM"), both slated for stable, so I'm
> surprised this patch is the one conflicting and not the first one (because
> it does conflict too!).
> 
> An option for clean application is to backport 5963d97aa780 ("arm64: dts:
> rockchip: add rs485 support on uart5 of px30-ringneck-haikou") to 6.6 first,
> and then 4eee627ea593 followed by 5ae4dca718ea.
> 
> Another option is to resolve the conflict for 4eee627ea593 which is simply
> about the git context (rts-gpios can be removed if 5963d97aa780 isn't
> backported).
> 
> @Heiko, @Greg, a preference on one of those two options (or a third one
> maybe?)? I personally would prefer the additional backport so we avoid other
> conflicts in the future (I already foresee one with a patch I posted (not
> merged yet!) last week).

I don't care, it's your call, just submit a patch series of the
backported patches you want to see applied and I'll gladly take them.

thanks,

greg k-h

