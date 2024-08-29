Return-Path: <stable+bounces-71531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8FA964B86
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786BE1F21AA8
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7047C1B5819;
	Thu, 29 Aug 2024 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZPyjLtEZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874E192B84;
	Thu, 29 Aug 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948377; cv=none; b=g7LC94jeCGR+aeQ4T3krClL6cws6A/bcVf7w5kOj9yjqfCj1jfpkJm5qm7tHXPKo+BqEUWLfl2zivfeq4Zm9W+GUmgRYC7si4E7TXBlM4e6ZYZlUQ0+T5ST0g+yWZIh4ab03U8M0lL4HPNbSVHbMs0ufTSu/ri30eaWmUN4OEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948377; c=relaxed/simple;
	bh=4CHGMmWZ4NJGcKzax2TM4riuGzuZDTrbLguiK8tLXgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6sIPqWyycv5xV2U7QwJ2pJOPG3DvnnYV+KL5y1KVXIJ7zh+lVgEU0K4rKmU+K9EROw+StCW2PP8Orv/6ikoBn8T0RJGZvvgwha5Kn1GdW+eRpGFWP9MDpsIyoslxUYgd1CxCOQw9i2vhgT/WFIlDXbVMvTUnqtqOoZAGVakqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZPyjLtEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0D7C4CEC1;
	Thu, 29 Aug 2024 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724948376;
	bh=4CHGMmWZ4NJGcKzax2TM4riuGzuZDTrbLguiK8tLXgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPyjLtEZSlvfTZBHWsvcsjnLEHhKGtwNQizxHafK8ykarof0q5ranSkJ/9IaYy3Tf
	 E//6yNpfrLsVH/ww6CrHNJlXu2vhoV6yJX5TTdc2F7fSSBjjXDVULimQRSvnna06zi
	 m12B25UGlZLGjlUzD3PEYCYx/VBdAS89qoj8qurc=
Date: Thu, 29 Aug 2024 18:19:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: Apply dbaee836d60a8 to linux-5.10.y
Message-ID: <2024082927-subheader-rival-08cf@gregkh>
References: <20240827222159.GA2737082@thelio-3990X>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827222159.GA2737082@thelio-3990X>

On Tue, Aug 27, 2024 at 03:21:59PM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please apply commit dbaee836d60a ("KVM: arm64: Don't use cbz/adr with
> external symbols") to linux-5.10.y, as a recent LLVM optimization around
> __cold functions [1] can cause hyp_panic() to be too far away from
> __guest_enter(), resulting in the same error that occurred with LTO (for
> the same reason):
> 
>   ld.lld: error: arch/arm64/built-in.a(kvm/hyp/entry.o):(function __guest_enter: .text+0x120): relocation R_AARCH64_CONDBR19 out of range: 14339212 is not in [-1048576, 1048575]; references 'hyp_panic'
>   >>> referenced by entry.S:88 (arch/arm64/kvm/hyp/vhe/../entry.S:88)
>   >>> defined in arch/arm64/built-in.a(kvm/hyp/vhe/switch.o)
> 
>   ld.lld: error: arch/arm64/built-in.a(kvm/hyp/entry.o):(function __guest_enter: .text+0x134): relocation R_AARCH64_ADR_PREL_LO21 out of range: 14339192 is not in [-1048576, 1048575]; references 'hyp_panic'
>   >>> referenced by entry.S:97 (arch/arm64/kvm/hyp/vhe/../entry.S:97)
>   >>> defined in arch/arm64/built-in.a(kvm/hyp/vhe/switch.o)
> 
> It applies cleanly with 'patch -p1' and I have verified that it fixes
> the issue.
> 
> [1]: https://github.com/llvm/llvm-project/commit/6b11573b8c5e3d36beee099dbe7347c2a007bf53

Now queued up, thanks.
greg k-h

