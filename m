Return-Path: <stable+bounces-75768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1616D97461B
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 00:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC04288352
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 22:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B951AC43B;
	Tue, 10 Sep 2024 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMkvoXNS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA701F951;
	Tue, 10 Sep 2024 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008247; cv=none; b=Y0jEKJ2QBXrryAHoqJOXRnxoRutUyFN9pNRxmrfVc30f95TCXAeWwFlitqrQQpk85R8CleqfuqrTk6higzQ2oD7EkxySNPTIVmIDUgMdLl/EtNDWNF6gCakGeU6kO/RS7S/yYhj/PGiHXyXybJ/JaGakkX2iQ15HUN2zhUM0x80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008247; c=relaxed/simple;
	bh=2C22c+h3eJ6IwjxO28xiElPTv1O/OAwDF5xufoz0r2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPAuoqksgGME3HoeqKkqVpwnyL7Ila6NxzOt/jyHisjk+7IPOeHq18MG5px4aiisfSyhwyyfOZ/gtJNSAHrYgXBYwhjRQeELXIJoCB1UZUpNUXGn4cDMwhUxPJb+lfzxjppCxpG+8ZR3MOhlSKibphNBFBGDtXNceEGnVoFh7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMkvoXNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5367FC4CEC3;
	Tue, 10 Sep 2024 22:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726008246;
	bh=2C22c+h3eJ6IwjxO28xiElPTv1O/OAwDF5xufoz0r2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SMkvoXNSTbr8zEcMXXgY3dAwrDQARPJJP78rND4Pp5fyuvHTMvQn55SM8J3oOdpvZ
	 TRVPytn0uI7WfKuxMj58J4L8A7Ijt/UYBbMWhpUIElAa/9sDzMyDEjaoiomExZfO2e
	 FcJxkoIKxx6NP3Oo7+8XyEE2rPPeRgdbuVzApJWgqGUR+G1pPIh6gEKoBeWqc8E3AH
	 dJ1DdxVlFcUUtiVkFnPPzZF/xS7fCg9B8nllx7ann7AaRF3T5JGdVS0eWoNFdWw065
	 UvdPvFG5G0acvcISL9WwECbjHQcBEgANtwNorKb99opDqTRJ3G6fYc86vxX1NZv4ea
	 C9HTUsIEFR68A==
Date: Tue, 10 Sep 2024 15:44:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2 net] usbnet: fix cyclical race on disconnect with work
 queue
Message-ID: <20240910154405.641a459f@kernel.org>
In-Reply-To: <20240905134811.35963-1-oneukum@suse.com>
References: <20240905134811.35963-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 15:46:50 +0200 Oliver Neukum wrote:
> +static inline bool usbnet_going_away(struct usbnet *ubn)
> +{
> +	smp_mb__before_atomic(); /* against usbnet_mark_going_away() */
> +	return test_bit(EVENT_UNPLUG, &ubn->flags);
> +}
> +
> +static inline void usbnet_mark_going_away(struct usbnet *ubn)
> +{
> +	set_bit(EVENT_UNPLUG, &ubn->flags);
> +	smp_mb__after_atomic(); /* against usbnet_going_away() */
> +}

I have sort of an inverse question to what Paolo asked :)
AFAIU we need the double-cancel because checking the flag and
scheduling are not atomic. But if we do that why the memory
barriers? They make it seem like we're doing something clever
with memory ordering, while really we're just depending on normal
properties of the tasklet/timer/work APIs.

FTR disable_work_sync() would work nicely here but it'd be
a PITA for backports.

Also - is this based on some report or syzbot? I'm a bit tempted
to put this in net-next given how unlikely the race is vs how
commonly used the driver is.
-- 
pw-bot: cr

