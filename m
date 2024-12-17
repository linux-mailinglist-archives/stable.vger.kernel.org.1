Return-Path: <stable+bounces-104526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C69F5044
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248771892911
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD931F76BE;
	Tue, 17 Dec 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WhCERluD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5B1F75B7
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450827; cv=none; b=ZcoM2KOgens8CEJTcbUqkA/ZQ5PViuBr7tOvAqvyZWnS17ckOEyJ11EK3bM0U2U6WrRoAE1/6bwKoTbiwKVitoajgekbqgY7WBaEHXjyyiAgiC29fFPDuNuuLS3GZJYkwzh7FItPYofm4ATfNNhF9dXZ5cRQDf9quNybSH77OfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450827; c=relaxed/simple;
	bh=OLEYZVA/59zceT283knETokcfgpz/XKbSB3XkXxL3Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlTXF+DYpPkFnIRPRao1mazBcMS/wjlZDoX1g3nT99Tf8VQ06NWCUt7biec1mGY8lnDzNQCdcBAkiPe9FelWuBM0SwUiiwHCs66E3CdWAW/j2NSrLp/CVWqlJzqTsRuJhXjT3EgmEZD19z9wd6bcYep422XoeE+BJFVkKGn5aLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WhCERluD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73027C4CED3;
	Tue, 17 Dec 2024 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734450826;
	bh=OLEYZVA/59zceT283knETokcfgpz/XKbSB3XkXxL3Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhCERluDnojZPXXIK3SvBESftQHcxkQWc8OmVa1kmX8xZYV4Q/bHQR50F2WPAEDTk
	 NSoT7PawlTFY2le9LCpZwjIJRZOpkssxeTAoe985c2fhmqiFy0rYtpLazjj3/3W4Cl
	 IVJv0fytkZeHNhIStqyk5nPz5L212g5D8N+UNK84=
Date: Tue, 17 Dec 2024 16:53:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Cc: stable@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: Request to port to 6.6.y : c809b0d0e52d ("x86/microcode/AMD:
 Flush patch buffer mapping after application")
Message-ID: <2024121745-roundworm-thursday-107d@gregkh>
References: <Z2GZp14ZFOadAskq@antipodes>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2GZp14ZFOadAskq@antipodes>

On Tue, Dec 17, 2024 at 04:32:55PM +0100, Thomas De Schampheleire wrote:
> Hello,
> 
> Below commit was ported to 6.12, but I would like to request porting to the 6.6
> longterm branch we are currently using:
> 
>     commit c809b0d0e52d01c30066367b2952c4c4186b1047
>     Author: Borislav Petkov (AMD) <bp@alien8.de>
>     Date:   2024-11-19 12:21:33 +0100
> 
>         x86/microcode/AMD: Flush patch buffer mapping after application
>         [...]
> 
> 
> The patch itself is small, but the consequence of not patching is large on
> affected systems (tens of seconds to minutes, of boot delay). See original
> discussion [1] for details.
> 
> The patch in master relies on a variable 'bsp_cpuid_1_eax' introduced in commit
> 94838d230a6c ("x86/microcode/AMD: Use the family,model,stepping encoded in the
> patch ID"), but porting that entire commit seems excessive, especially because
> there are several 'Fixes' commits for that one (e.g. 5343558a868e, d1744a4c975b,
> 1d81d85d1a19).
> 
> I think the simplest prerequisite change is (for Borislav Petkov to confirm):

Please send a set of working, and tested, commits that you wish for us
to commit, we can't cherry-pick stuff out of an email like this for
obvious reasons :)

And whenever possible, yes, we do want to take the fixes that are in
Linus's tree, otherwise maintaining the branch over time gets harder and
harder.  So just backport them all please.

thanks,

greg k-h

