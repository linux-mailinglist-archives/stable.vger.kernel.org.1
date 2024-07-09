Return-Path: <stable+bounces-58751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB9C92BB6E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F0E1F27D78
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC3015F403;
	Tue,  9 Jul 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OQiAJhjg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E515EFBD;
	Tue,  9 Jul 2024 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532038; cv=none; b=pM85jX/55NboITPT6FFpm8HNPkNR4OYx6y1GTQbzt6zgW4r6Zog729S6ZrK0Dh3/0QTxSwCKOH82agtQSrhId95VyrzWcFXri2B6Mx35snFCbSRVntoVRxBQtbxAiCNUU1IvWZSntYLIiGUKAgpNNYNIfPmynxZRrsvd5ceJTxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532038; c=relaxed/simple;
	bh=YpBr01fXSLRNi+/28zE/N5hTvft6w2xxp4+1RXcmi3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoURPci6JoBFOEibUtq99o46Wwyh/yH354inQeZHaA7X6J1yKbv+tieQkU9XWZkjFl1c6aYVxNYqxXeqKRZCqCh8JZITptk/rweno4zCPuvKYRoqLqbw5cKHjIKjaNcUymEiiu7OzB2zWIuJlb1TMHhD9HvTQqiZx4Cj78AiVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OQiAJhjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CE2C4AF07;
	Tue,  9 Jul 2024 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720532037;
	bh=YpBr01fXSLRNi+/28zE/N5hTvft6w2xxp4+1RXcmi3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQiAJhjgxAiqBufHRFuE+EC9RdkbjjcI6Da55YoSJZqi97L6mw1WttHv4042GTFxh
	 yWSfrSF3402my+Flxx/jSfQtDLLzT64P1RLRCyj2MGmMGQppSNOQK/HuNVqUr8XR9r
	 rPqezDDM3WCadU3JPWAJig/KkTZjG/w8gdPBwTzM=
Date: Tue, 9 Jul 2024 15:33:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jim Mattson <jmattson@google.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 5.10 RESEND] x86/retpoline: Move a NOENDBR annotation to
 the SRSO dummy return thunk
Message-ID: <2024070930-monument-cola-a36e@gregkh>
References: <20240709132058.227930-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709132058.227930-1-jmattson@google.com>

On Tue, Jul 09, 2024 at 06:20:46AM -0700, Jim Mattson wrote:
> The linux-5.10-y backport of commit b377c66ae350 ("x86/retpoline: Add
> NOENDBR annotation to the SRSO dummy return thunk") misplaced the new
> NOENDBR annotation, repeating the annotation on __x86_return_thunk,
> rather than adding the annotation to the !CONFIG_CPU_SRSO version of
> srso_alias_untrain_ret, as intended.
> 
> Move the annotation to the right place.
> 
> Fixes: 0bdc64e9e716 ("x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk")
> Reported-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/lib/retpoline.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why is this a RESEND?

And is this only needed in this one stable branch or in any others?

thanks,

greg k-h

