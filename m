Return-Path: <stable+bounces-65213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F19943FE8
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15481C21298
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A390414EC66;
	Thu,  1 Aug 2024 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=matoro.tk header.i=@matoro.tk header.b="amSApraO"
X-Original-To: stable@vger.kernel.org
Received: from matoro.tk (matoro.tk [104.188.251.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459BE1E522;
	Thu,  1 Aug 2024 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.188.251.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474785; cv=none; b=PitkauYf0F3scEVjC08hG8aj/vhHt1Ac1IIUB3+YwlXgwqvpCg2DH4WT86DJWPgCUT2Te2KRh4DQE6qSR5wMzkmYWYFWrBWLTyUsNSf77FNFSQyacL6fnPmNk48kTUveZ55UzoaP6WitkxE5jTCuMUXmzLob/haTQq40noqEnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474785; c=relaxed/simple;
	bh=OTGVbcCMbNvLvJQ/QBZCA9l5OmR6fPq+pO/6FFWww4s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MJz0rDVjAh0sPoyX0LDDZillzhJY1dWoas4QC6QU3SJWsFEtoasuVsIpxyJzoxr9iQy9+ibGNxVjAxqApRrjxE8JriaHa5GfsMWGBCB6n91KnSMVnpVLFfmonIJHL93X1i6SkYDiMSaQj1U3iHblMSPmMeuKvYKgxW2aRbBYTI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matoro.tk; spf=pass smtp.mailfrom=matoro.tk; dkim=pass (4096-bit key) header.d=matoro.tk header.i=@matoro.tk header.b=amSApraO; arc=none smtp.client-ip=104.188.251.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matoro.tk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matoro.tk
DKIM-Signature: a=rsa-sha256; bh=Rj7elK2MD3WTzzUdUJeS0uUk8LdFv5i73Vo+oyMhhVM=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20240626; t=1722474745; v=1; x=1722906745;
 b=amSApraOrkhUaYHzcBCly5aMQC1ZSt4BStSxtMCbOouBnPohgWMfqOvr30lkv7EWZVoAb6I7
 RC9kjkvgXR05jhlUrCcvlgTVvtAjbkK1O2rqcrU/I1w6otTto9aAyWbqgTigxdhYBasV7uGla6F
 Tfl5Fns3Y+XMeyRxNUrJyl3d+MgBdZHGp/iSyt4d8g33L30m69cK+c/Dtbp/8Ceglxx9X6nclYG
 +hsZLh23N4NoPdlpNyGdzLwp4L78shFTU/yMIk7TD8YkJSLABkB88XC42nNWS+45qovv4LAfz2K
 6DLNngbsbZ6Zwqm9eRP6q/XpfWKuYfNKtkvoBF+XOyFMGy8Mv+VaujV5WnptRff0+5wrQIv+alJ
 JIhPYKWvVb8W+BWSyMHHfdgGoHKssWjBcNrkWK0B2wxrOUdVhKUOBr/GUc0Ad++s0/9PX8FmLVK
 IgZukjC1meOfZXYZQSfReXe4/XnU9ocuFd8s22wwLfsTvSm7b9MQ0vkXvSR+EyuwnWVIRWQ1Tma
 SXk+bMArapmwkKw7nwnPBL4fFj/xBv9xhMOgug0fJZGdFPa0MCEPUK9sEMIw/8zbe5Ur65ObKe0
 xJnZHQKn7Ot9UaBSEU4mlyS89aEiOe7Wou3vtGBTdGNYPct7sLybNKYs7o31pyV58A/ouGqOSVq
 dIrq82MpIf0=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 2a6d37e5; Wed, 31 Jul
 2024 21:12:25 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 31 Jul 2024 21:12:25 -0400
From: matoro <matoro_mailinglist_kernel@matoro.tk>
To: Sam James <sam@gentoo.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra
 <peterz@infradead.org>, John David Anglin <dave.anglin@bell.net>, Linux
 Parisc <linux-parisc@vger.kernel.org>, Deller <deller@gmx.de>, John David
 Anglin <dave@parisc-linux.org>, stable@vger.kernel.org
Subject: Re: Crash on boot with CONFIG_JUMP_LABEL in 6.10
In-Reply-To: <87sevpa44q.fsf@gentoo.org>
References: <096cad5aada514255cd7b0b9dbafc768@matoro.tk>
 <bebe64f6-b1e1-4134-901c-f911c4a6d2e6@bell.net>
 <11e13a9d-3942-43a5-b265-c75b10519a19@bell.net>
 <cb2c656129d3a4100af56c74e2ae3060@matoro.tk>
 <20240731110617.GZ33588@noisy.programming.kicks-ass.net>
 <877cd1bsc4.fsf@gentoo.org> <2024073133-attentive-important-d419@gregkh>
 <87sevpa44q.fsf@gentoo.org>
Message-ID: <a4d106187eeb2c3d6aca4ba50238783a@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-07-31 13:00, Sam James wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
>> On Wed, Jul 31, 2024 at 02:31:55PM +0100, Sam James wrote:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>> 
>>> > On Tue, Jul 30, 2024 at 08:36:13PM -0400, matoro wrote:
>>> >> On 2024-07-30 09:50, John David Anglin wrote:
>>> >> > On 2024-07-30 9:41 a.m., John David Anglin wrote:
>>> >> > > On 2024-07-29 7:11 p.m., matoro wrote:
>>> >> > > > Hi all, just bumped to the newest mainline starting with 6.10.2
>>> >> > > > and immediately ran into a crash on boot. Fully reproducible,
>>> >> > > > reverting back to last known good (6.9.8) resolves the issue. 
>>> >> > > > Any clue what's going on here?
>>> >> > > > I can provide full boot logs, start bisecting, etc if needed...
>>> >> > > 6.10.2 built and booted okay on my c8000 with the attached config.
>>> >> > > You could start
>>> >> > > with it and incrementally add features to try to identify the one
>>> >> > > that causes boot failure.
>>> >> > Oh, I have an experimental clocksource patch installed.  You will need
>>> >> > to regenerate config
>>> >> > with "make oldconfig" to use the current timer code.  Probably, this
>>> >> > would happen automatically.
>>> >> > >
>>> >> > > Your config would be needed to duplicate.    Full boot log would also help.
>>> >> >
>>> >> > Dave
>>> >>
>>> >> Hi Dave, bisecting quickly revealed the cause here.
>>> >
>>> > https://lkml.kernel.org/r/20240731105557.GY33588@noisy.programming.kicks-ass.net
>>> 
>>> Greg, I see tglx's jump_label fix is queued for 6.10.3 but this one
>>> isn't as it came too late. Is there any chance of chucking it in? It's
>>> pretty nasty.
>> 
>> What is the git id of this in Linus's tree?
> 
> Ah, you're right, it's not there. Sorry, I thought I'd seen it pulled.
> 
>> 
>> thanks,
>> 
>> greg k-h

Hi Peter, sorry I'm not quite following, exactly what patches need to be 
applied to fix this?  I checked out the thread you linked but it does not 
apply cleanly to 6.10.

