Return-Path: <stable+bounces-114893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E47AA30881
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4680165A8C
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202521F460E;
	Tue, 11 Feb 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HCu/YfMp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BFD1F4606
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269739; cv=none; b=LRMCmfcytiBc8eceQksI5ArJ2sqXlqmr0pwKzblICKVgUXjoIkW3B8HGsWj4qYc9oibR+/dzAQdHirA4qos8PhPsRcEwZOvvAeQ7AY3EUXwB45F6MoMiGbaL5nJgTywcEzCBYHH5KkGhGoUtI/3vvrEpYGtMN5KA1i2ulMvHocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269739; c=relaxed/simple;
	bh=su9jxncekXcfI91HhoC4h8DA7KnfPatOCFUwD86v13E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiUsEQLhuAU6m6KYfOQ6urGiz4+XJgEAvdKSDbGpImWBYFvTlzuBqj6HFbC5IU79mDggzCOhnPcxg6FwsEZgiaFpnwXfZ2qec39vex8C6EV8ziWWwK40ITt6TshG/nvvcFnxIsWNpSUWHYbiVGj0VKO0jtXbfAc1T6ztgZB7meA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HCu/YfMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5E5C4CEDD;
	Tue, 11 Feb 2025 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739269739;
	bh=su9jxncekXcfI91HhoC4h8DA7KnfPatOCFUwD86v13E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCu/YfMpgx9ESoiqSG8KJgKInEk1obhw7SatoVlPzFia/9nBe6S8vHsnwqV2+EuSZ
	 ec63Cod0+2E0eUBYQ9wrE1Y8RrbR843zlmu0DFEvMVIofjwiMeIkZK1nFqo2OXEpsx
	 BcKAf7fVGojV+RQdCRPeffU+atloFpP6eljscpBI=
Date: Tue, 11 Feb 2025 11:28:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: broonie@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] spi: atmel-qspi: Memory barriers after
 memory-mapped I/O" failed to apply to 6.13-stable tree
Message-ID: <2025021128-recognize-hardhead-67f0@gregkh>
References: <2025021058-ruse-paradox-92e6@gregkh>
 <fde3442f-3ea5-4742-af70-9d243678e303@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fde3442f-3ea5-4742-af70-9d243678e303@prolan.hu>

On Mon, Feb 10, 2025 at 07:17:54PM +0100, Csókás Bence wrote:
> Hi,
> 
> On 2025. 02. 10. 13:52, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.13-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> There is a dependency, that I specified in the commit in accordance with
> [1]:
> 
> > Cc: stable@vger.kernel.org # c0a0203cf579: ("spi: atmel-quadspi: Create `atmel_qspi_ops`"...)
> > Cc: stable@vger.kernel.org # 6.x.y
> > Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> > Link: https://patch.msgid.link/20241219091258.395187-1-csokas.bence@prolan.hu
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> [1] https://docs.kernel.org/process/stable-kernel-rules.html#option-1

Sorry, I missed that.

> Please re-pick with c0a0203cf579. As a side note, I also specified 6.x.y
> because - in my experience - anything earlier will not cleanly apply
> anyways. So you can safely drop these from the 5.x.y queues.

It failed to apply to 6.1.y as well, please provide backports for that
tree if you want it there.

thanks,

greg k-h

