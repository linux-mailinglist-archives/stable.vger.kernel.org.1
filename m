Return-Path: <stable+bounces-20820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C1585BED1
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B411F215E0
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611272C1B4;
	Tue, 20 Feb 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n69LUBz3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BC1C2E
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439552; cv=none; b=AcsSdtzQcpOSxzPAtZJbbB3KaAPZoeRb2Z+RZIiHpelJD+DOgzWgQkDOLWCSjmxTN+CTxRDOfZq5f7rlWd6UtiMvKTJZkpF+eHzcaYdoqibbM4EggBKU38q0PlAVlA35ARbD29QtYpxhGXLNIYOZm0XnO4+kcEURP+UvaWRJZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439552; c=relaxed/simple;
	bh=5p3O8/Aha7ANumD1ttHL7zqmZAuoWGJOsL11EFr4UYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPlRKzP9OfFdW3/I8C072IVYJ8PSKbJqfnCUHgeYM/SwFRWQ4PxMqg3LZvevMfiMa/T4TPHHSCfW6KPYlcxQrYGOyV8XksmmGqg1Lz312FH78xpJIUk+jI1UW1JmfmgQyXfBb5LqvsNcwDsB8yIoY9TgYlEOCO1xU4Gj7MF8pAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n69LUBz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39837C433F1;
	Tue, 20 Feb 2024 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708439550;
	bh=5p3O8/Aha7ANumD1ttHL7zqmZAuoWGJOsL11EFr4UYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n69LUBz3zmVlXn+PHHXOmHVdT9u1XC+UGORQPkcSuKAc+rhmF2MRwEuYpEPsI76ts
	 ZqTmHs8nD6iN+CPaxfyfga3EEldDPi7b0rhWZbHH+7z2LmCJOmztXpfZQbZvRFRhEg
	 rAwsL0WfFmX6rBG915sw6zT76eZm54jQluiRqzZk=
Date: Tue, 20 Feb 2024 15:32:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: stable@vger.kernel.org, dave@stgolabs.net, tglx@linutronix.de,
	bigeasy@linutronix.de, petr.ivanov@siemens.com,
	jan.kiszka@siemens.com
Subject: Re: [PATCH v2][5.10, 5.15, 6.1][1/1] hrtimer: Ignore slack time for
 RT tasks in schedule_hrtimeout_range()
Message-ID: <2024022057-slit-herself-a4d8@gregkh>
References: <20240220123403.85403-1-felix.moessbauer@siemens.com>
 <20240220123403.85403-2-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220123403.85403-2-felix.moessbauer@siemens.com>

On Tue, Feb 20, 2024 at 01:34:03PM +0100, Felix Moessbauer wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> commit 0c52310f260014d95c1310364379772cb74cf82d upstream.
> 
> While in theory the timer can be triggered before expires + delta, for the
> cases of RT tasks they really have no business giving any lenience for
> extra slack time, so override any passed value by the user and always use
> zero for schedule_hrtimeout_range() calls. Furthermore, this is similar to
> what the nanosleep(2) family already does with current->timer_slack_ns.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20230123173206.6764-3-dave@stgolabs.net

You can't forward on a patch without signing off on it as well :(

And this is already in the 6.1.53 release, why apply it again?

confused,

greg k-h

