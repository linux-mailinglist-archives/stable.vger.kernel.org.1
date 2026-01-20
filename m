Return-Path: <stable+bounces-210429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC6D3BEF0
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56D3E3541AB
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 06:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EA432E74F;
	Tue, 20 Jan 2026 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmvi98Qe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76232BF26;
	Tue, 20 Jan 2026 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768889043; cv=none; b=mJ2t0hV9wRePnlaIQIJsDU5+9EVfqSSzn7cyGU1xeuvUdu7bJiPlAyG3eyFHPCBKQw6AQ8BRB8PEIbREXoYDzpc7o2lWU5OgpP01EDT848TLUg32Wn5k9LjXkQbOPavWfqHtWSC/v7f+U7W0XHNyudpF4soQ0qDg7JA+jlMLZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768889043; c=relaxed/simple;
	bh=8tMSzFv4KFJ7+xSlNNAc/PPaQqbFH99I9xBbieZA0c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LB5cQUv9vrjfdrB+YopBdtInIy5eYUB6T1rRkVfEimwjnt+iC8r9xsyt6Cj6O7g+xCjehkZibSTsHc3zPVmDP92ZkK1/jTTRmOJ0kjVJSJBw6GffYfi/+pmYGKDiLFjbPM5PiLpMkLUdIbSXaN0s5DAlSvmC2GLISEmSr26LvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmvi98Qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DADC19423;
	Tue, 20 Jan 2026 06:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768889042;
	bh=8tMSzFv4KFJ7+xSlNNAc/PPaQqbFH99I9xBbieZA0c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmvi98QeYk4rH/j8dYbKpsZ0GvF1foDDtOFHmI5tnkh7sf3NxeSITPuA/gpJvz8LE
	 96cKRzAoEMxv6P28302lMAiw8UpsAe3lQjozQ8of7kQxBH4sVfkK/q1uBw0CR+TvoG
	 iHVXgAjUQBaVPbFjtAoLyJaC5nQxcFdm0Of0Zghg=
Date: Tue, 20 Jan 2026 07:03:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, wen.yang@linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6 3/3] net: Allow to use SMP threads for backlog NAPI.
Message-ID: <2026012040-unmolded-dreaded-6e06@gregkh>
References: <cover.1768751557.git.wen.yang@linux.dev>
 <997bc0de4746100bb69e1bd2ccfb25315d8f62e4.1768751557.git.wen.yang@linux.dev>
 <20260119082534.1f705011@kernel.org>
 <20260119163026.aA1PeSmP@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119163026.aA1PeSmP@linutronix.de>

On Mon, Jan 19, 2026 at 05:30:26PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-19 08:25:34 [-0800], Jakub Kicinski wrote:
> > On Mon, 19 Jan 2026 00:15:46 +0800 wen.yang@linux.dev wrote:
> > > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > 
> > > commit dad6b97702639fba27a2bd3e986982ad6f0db3a7 upstream.
> > > 
> > > Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
> > > used by drivers which don't do NAPI them self, RPS and parts of the
> > > stack which need to avoid recursive deadlocks while processing a packet.
> > 
> > This is a rather large change to backport into LTS.
> 
> I agree. While I saw these patches flying by, I don't remember a mail
> where it was justified why it was needed. Did I miss it?

Please see patch 0/3 in this series:
	https://lore.kernel.org/all/cover.1768751557.git.wen.yang@linux.dev/

