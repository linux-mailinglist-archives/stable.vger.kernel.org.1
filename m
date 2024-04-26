Return-Path: <stable+bounces-41506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E17E78B3537
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 12:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483A0B24662
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F97E143877;
	Fri, 26 Apr 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zuyNgbcx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB26A142E97
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126877; cv=none; b=hgy6/kuujztqBareA9sDOvSriNdmexPm+4XgDKVDglpQ1V016jccbhPYYoovsDG4lal4nsldaVxVxvAAmqUAvfT4cDN3x+F3AyAITlibMB+U3sONbZjqW+y30RaBaN876vjcMqfPjOitsw5rIyvX/deSvFcn61Tgc+Wxxd1o1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126877; c=relaxed/simple;
	bh=ucsbODpPjTwljTOoj8jb2cfEoo3wKj0em2o1BQwLAi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkMMG0KVWKEPrHmCk8U2yFOzy6SNCSeHW2nhBsaROLU2Q/DBfZuTzRDW8PrZz9aHlYLqlM5NNLzWQcrKS2KFFj7SNo4O0yS2txGkkKZ2+a1nNC0CE//pcbORX21N50+xzwsIbMQcrhB9jNe6il1EVKF+GSwy+BEiEitbN7kC0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zuyNgbcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F7DC113CD;
	Fri, 26 Apr 2024 10:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714126877;
	bh=ucsbODpPjTwljTOoj8jb2cfEoo3wKj0em2o1BQwLAi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zuyNgbcxcS4i69r1ECTxWezjNogGWCWOcqQIvhVaKZx41O3Mik18lmn+zJlU2euzO
	 OtY24Yb1a3HWRBF+WddOQ/j0B2J5JhBeD9JL5JfqvAMNj4SwrnaTgSrzcReBvltc53
	 eUUVGg1YCNeA4K18FzdEzK/9Kzkk7etpZNUCckV8=
Date: Fri, 26 Apr 2024 12:21:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geliang Tang <geliang@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [6.6.y] "selftests/bpf: Add netkit to tc_redirect selftest"
 needs to be reverted
Message-ID: <2024042648-dweeb-serotonin-f76f@gregkh>
References: <ea05dcf2a0417aa2068a4dfa61bd562a6e8127d6.camel@kernel.org>
 <2024042610-tiring-overdue-a6b5@gregkh>
 <e890da3e6b47059a496f743623800223282d7984.camel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e890da3e6b47059a496f743623800223282d7984.camel@kernel.org>

On Fri, Apr 26, 2024 at 06:12:22PM +0800, Geliang Tang wrote:
> cc stable@vger.kernel.org

I'm confused, where is the original message here?  You just forwarded my
bot response to the list.

greg k-h

