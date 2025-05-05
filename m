Return-Path: <stable+bounces-139678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFEBAA9280
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07AC18930A5
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943BE207A0B;
	Mon,  5 May 2025 11:56:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps-b7ad3695.vps.ovh.net (vps-b7ad3695.vps.ovh.net [51.38.114.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1A207A27
	for <stable@vger.kernel.org>; Mon,  5 May 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.38.114.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746446190; cv=none; b=gThv1xrP8OM2s6DuPUtvP6ahZR9y8F+iBOj8jbqMgT66v+wLMMip78uo4cUWEfwoIh39wlSIBNPtcu4SrHpnbTe5UxFJqdhtQ8cr+kQOiBBC1RwGKED3VJLGsUFqG7mEWnYyrlm5/Bc04Fc/QaL43XZrGNJKT+2NWorLBpT1Qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746446190; c=relaxed/simple;
	bh=AbomoVcY534xT1b1+QbT+VhnTEUx/DQ46lB7b/b3RWU=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=VZIUp3iCdRrkydJLIn/qbGUwj6hWEpdDKsJn4upBxRUXVi40mAk+eHNIAlbHB1X1cnYwqArJH7PJejjFQDox7SF/jK9vAjynz1Ryd2FldHB3Ud+bAN7Z57ECVqKNqfSvuraio0q7NFA09dvdoIPm+WwvSMZgTbzw5ZIVhIyhWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inutil.org; spf=pass smtp.mailfrom=inutil.org; arc=none smtp.client-ip=51.38.114.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inutil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inutil.org
Received: from hullmann.fritz.box (p5089ae0f.dip0.t-ipconnect.de [80.137.174.15])
	by vps-b7ad3695.vps.ovh.net (Postfix) with ESMTPSA id B2792164;
	Mon,  5 May 2025 11:47:16 +0000 (UTC)
Received: from jmm by hullmann.fritz.box with local (Exim 4.98)
	(envelope-from <jmm@hullmann.westfalen.local>)
	id 1uBuHz-000000000QR-46YE;
	Mon, 05 May 2025 13:47:15 +0200
Date: Mon, 5 May 2025 13:47:15 +0200
To: Yu Kuai <yukuai3@huawei.com>
Cc: Melvin Vermeeren <vermeeren@vermwa.re>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	1104460@bugs.debian.org, Coly Li <colyli@kernel.org>,
	Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	regressions@lists.linux.dev,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [regression 6.1.y] discard/TRIM through RAID10 blocking (was:
 Re: Bug#1104460: linux-image-6.1.0-34-powerpc64le: Discard broken) with
 RAID10: BUG: kernel tried to execute user page (0) - exploit attempt?
Message-ID: <aBilQxLZ4MA4Tg8e@pisco.westfalen.local>
References: <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBJH6Nsh-7Zj55nN@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBJH6Nsh-7Zj55nN@eldamar.lan>
From: =?UTF-8?Q?Moritz_M=C3=BChlenhoff?= <jmm@inutil.org>

Am Wed, Apr 30, 2025 at 05:55:20PM +0200 schrieb Salvatore Bonaccorso:
> Hi
> 
> We got a regression report in Debian after the update from 6.1.133 to
> 6.1.135. Melvin is reporting that discard/trimm trhough a RAID10 array
> stalls idefintively. The full report is inlined below and originates
> from https://bugs.debian.org/1104460 .

JFTR, we ran into the same problem with a few Wikimedia servers running
6.1.135 and RAID 10: The servers started to lock up once fstrim.service
got started. Full oops messages are available at
https://phabricator.wikimedia.org/P75746

Cheers,
        Moritz

