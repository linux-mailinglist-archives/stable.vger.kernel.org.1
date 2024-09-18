Return-Path: <stable+bounces-76630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED2697B7C1
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 08:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659BF1F23BC0
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 06:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB115351C;
	Wed, 18 Sep 2024 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="q5hEphUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTf/wAJc"
X-Original-To: stable@vger.kernel.org
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0572572;
	Wed, 18 Sep 2024 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640181; cv=none; b=GeAhLRobqermmpvXp92NF8O20D/vjdQov9uDVnC2KjOqr7W2M0onIjt25Nt89eUxA2R4DmKXhSv/Ocpes4rdiEBLK3AxMn8a1HMigcIiN1zIuyPR5FZYjsc71O42biy7YgSvzIhO521hfigNE7X141oZONWLI1LhC3kW+nTMtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640181; c=relaxed/simple;
	bh=L6VLgXb0nsy/ei1kX/M4emXhQua5TsZo4/SKjQR/Bas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5y2eiiKw6ncmo+gz4Y8S7z8qcY/SlqVRFG3NYbNQFfJjm6JSfNhHQUIL6S95Jf9DKymU+QAgMK/ZOrAzbGqQN3Q10ngRcyVJ8aTimGOSG/edI1BzCbgYgWny9DyEmzCTVm6ZCtn/OukvQMSG5uLQR4zc9gFRMmyDgDBuSBcBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=q5hEphUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTf/wAJc; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 40CB5200277;
	Wed, 18 Sep 2024 02:16:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Sep 2024 02:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726640178; x=1726647378; bh=bjg6tOXFvS
	jUAfjb5nP5F+Ifn6Ejc8/6s26MZEMvtPo=; b=q5hEphUiT/cwuy/44f0hxc7d07
	PDcUd4Cd4iYYvIZklj7+Ido+9KVpn5MV2MLsrnZIcRVTm0cTGturfzOVQt5OTR7w
	SVD2dnFMRg//11xUH9CBqt+dtjjsEa+ypidiOPKrt+vUiYIvhMwcrnduCTp0CdZe
	B7LaY46vWk3fosRbVZ8Xxe4KO5Kpqcbq7auqjljBhM2k066spYn39/dbdPEcpQpn
	uDytuszbkqJCwp3c1lS1ahgWALN7QXj2lqEIE+bAG1j+vyko1pBP8RHPbYdd3eW0
	S4UiflaB4XlCUPtkse369pjoMnrYYJ3uwLKRANgxEPNKwHR07o3Ot/g8B55w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726640178; x=1726647378; bh=bjg6tOXFvSjUAfjb5nP5F+Ifn6Ej
	c8/6s26MZEMvtPo=; b=ZTf/wAJc2CP21TiGxPGVxoNH6KSukIQhr2Y85g3aj0OL
	cwKpZLHci9lJTsHLkEsla3n/I2nRmNHfgwmk8edpvoUTpIxn5yzUdw2v8zjNMdPr
	BuowCCrQpEVATeWjX0gLoPhRS6h3bIJer2wlAmEoiMhB76YfS+2N++iJFDOCL56L
	777O3CfWAh2ERpbb6GM/Pdd5FcpOpeKnc72MNI8Ju3CgFltgpZmsCkudfe5XXAU0
	QPhEp4VXR4F440WWVujjIRp2kp42fT8ZEdubBzJxtC1AqEIJHSyecoJyFkLc3oSt
	tONgsScz1R+6gvbZVvOyiMC73oYYTHQYj4Wf9xhMfQ==
X-ME-Sender: <xms:MXDqZpSzq_EJNVmPkedElnZbhJE89IKhYsTkkw917iO9ISgDk-sHCA>
    <xme:MXDqZiyK2FWA-jxqw4pAT7BBcCophTFlMuA_4S41rUNi4lQzeSjUzpCZvngFZxxfs
    9djTW-tmt2jKQ>
X-ME-Received: <xmr:MXDqZu20RpkUBODuocKWmYhVCJfmIFN5A3uZHJoO9mGo1ayuLjxlY4m0_sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeef
    leevtddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    pdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgi
    hinhhghihurdifuhesshhtrghrfhhivhgvthgvtghhrdgtohhmpdhrtghpthhtoheprhgv
    seifiehriidrnhgvthdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgrsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgvrhhnvghlsegvshhmihhlrdgukhdprhgtphhtthhopegtohhnohhrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MXDqZhBjB1-V7qb2v--YpTSrt5w_nTg5yvr5K7THb_nQTh7zbBfJOw>
    <xmx:MXDqZihSKYgp-dFEktPCxyYLEWrzsuYZcCBGTEiYL8h83uQJx2hyVg>
    <xmx:MXDqZlqHLgc2KwLRw2uM-QQUQGrbIH1LeXasdmOjzL-angR3wQUU-Q>
    <xmx:MXDqZtgOACKGFcyph6iLE2TGxByOFt8V24F2OJDurMRrF3jV7qw7aA>
    <xmx:MnDqZiQAatTlwKBdRbqbRX8v4AJ1CaR-SDoCM7oBJGl8j72y2nRmEsaT>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 02:16:16 -0400 (EDT)
Date: Wed, 18 Sep 2024 08:16:14 +0200
From: Greg KH <greg@kroah.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ron Economos <re@w6rz.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>
Subject: Re: Patch "riscv: dts: starfive: jh7110-common: Fix lower rate of
 CPUfreq by setting PLL0 rate to 1.5GHz" has been added to the 6.10-stable
 tree
Message-ID: <2024091841-swooned-parmesan-8666@gregkh>
References: <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091451-partake-dyslexia-e238@gregkh>
 <NTZPR01MB0956BF9AAE1FCAAF71C810A69F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091445-underwent-rearview-24be@gregkh>
 <NTZPR01MB0956C2EF430930E4DB2C35BE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <59b65d17-7dce-ef5d-41ba-2c04656fb2e8@w6rz.net>
 <2024091501-dreamland-driveway-e0c3@gregkh>
 <148a908f-e2e2-6001-510e-73aef81d07b5@w6rz.net>
 <2024091557-contents-mobster-f2c3@gregkh>
 <NTZPR01MB0956C27D2BE2076D5B45DFFC9F622@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NTZPR01MB0956C27D2BE2076D5B45DFFC9F622@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>

On Wed, Sep 18, 2024 at 02:54:57AM +0000, Xingyu Wu wrote:
> On 9/15/24 23:10 AM, Greg KH wrote:
> > 
> > On Sun, Sep 15, 2024 at 08:01:33AM -0700, Ron Economos wrote:
> > > On 9/15/24 6:22 AM, Greg KH wrote:
> > > > On Sat, Sep 14, 2024 at 03:32:33AM -0700, Ron Economos wrote:
> > > > > On 9/14/24 3:04 AM, Xingyu Wu wrote:
> > > > > > On 14/09/2024 17:37, Greg KH wrote:
> > > > > > > On Sat, Sep 14, 2024 at 09:24:44AM +0000, Xingyu Wu wrote:
> > > > > > > > On 14/09/2024 16:51, Greg KH wrote:
> > > > > > > > > On Sat, Sep 14, 2024 at 08:01:44AM +0000, Xingyu Wu wrote:
> > > > > > > > > > On 13/09/2024 22:12, Sasha Levin wrote:
> > > > > > > > > > > This is a note to let you know that I've just added
> > > > > > > > > > > the patch titled
> > > > > > > > > > >
> > > > > > > > > > >       riscv: dts: starfive: jh7110-common: Fix lower
> > > > > > > > > > > rate of CPUfreq by setting PLL0 rate to 1.5GHz
> > > > > > > > > > >
> > > > > > > > > > > to the 6.10-stable tree which can be found at:
> > > > > > > > > > >
> > > > > > > > > > > http://www.kernel.org/git/?p=linux/kernel/git/stable/s
> > > > > > > > > > > table-
> > > > > > > > > > > queue.git;a=summary
> > > > > > > > > > >
> > > > > > > > > > > The filename of the patch is:
> > > > > > > > > > >
> > > > > > > > > > > riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.p
> > > > > > > > > > > atch and it can be found in the queue-6.10
> > > > > > > > > > > subdirectory.
> > > > > > > > > > >
> > > > > > > > > > > If you, or anyone else, feels it should not be added
> > > > > > > > > > > to the stable tree, please let <stable@vger.kernel.org> know
> > about it.
> > > > > > > > > > >
> > > > > > > > > > Hi Sasha,
> > > > > > > > > >
> > > > > > > > > > This patch only has the part of DTS without the clock driver
> > patch[1].
> > > > > > > > > > [1]:
> > > > > > > > > > https://lore.kernel.org/all/20240826080430.179788-2-xing
> > > > > > > > > > yu.wu@star
> > > > > > > > > > five
> > > > > > > > > > tech.com/
> > > > > > > > > >
> > > > > > > > > > I don't know your plan about this driver patch, or maybe I missed it.
> > > > > > > > > > But the DTS changes really needs the driver patch to
> > > > > > > > > > work and you should add
> > > > > > > > > the driver patch.
> > > > > > > > >
> > > > > > > > > Then why does the commit say:
> > > > > > > > >
> > > > > > > > > > >       Fixes: e2c510d6d630 ("riscv: dts: starfive: Add
> > > > > > > > > > > cpu scaling for
> > > > > > > > > > > JH7110 SoC")
> > > > > > > > > Is that line incorrect?
> > > > > > > > >
> > > > > > > > No, this patch can also fix the problem.
> > > > > > > > In that patchset, the patch 2 depended on patch 1,  so I
> > > > > > > > added the Fixes tag in
> > > > > > > both patches.
> > > > > > >
> > > > > > > What is the commit id of the other change you are referring to here?
> > > > > > >
> > > > > > This commit id is the bug I'm trying to fix. The Fixes tag need to add it.
> > > > > >
> > > > > > Thanks,
> > > > > > Xingyu Wu
> > > > > >
> > > > > I think Greg is looking for this:
> > > > >
> > > > > commit 538d5477b25289ac5d46ca37b9e5b4d685cbe019
> > > > >
> > > > > clk: starfive: jh7110-sys: Add notifier for PLL0 clock
> > > > That commit is already in the following releases:
> > > > 	6.6.51 6.10.10
> > > > so what are we supposed to be doing here?
> > > >
> > > > confused,
> > > >
> > > > greg k-h
> > > >
> > > Sorry, I didn't check to see if it was already in releases. So the
> > > 6.10 queue is fine as is.
> > >
> > > However, these two patches go together, so the 6.6 queue should also
> > > have
> > > 61f2e8a3a94175dbbaad6a54f381b2a505324610 "riscv: dts: starfive:
> > > jh7110-common: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz"
> > > added to it.
> > 
> > Given that the file arch/riscv/boot/dts/starfive/jh7110-common.dtsi is not in the
> > 6.6.y kernel tree, are you sure about this?  If so, where should it be applied to
> > instead?
> > 
> 
> Hi Greg,
> 
> How about this patch[1] which I sent earlier about DTS?
> [1]: https://lore.kernel.org/all/20240507065319.274976-3-xingyu.wu@starfivetech.com/
> 
> This patch is based on older kernel without the file (jh7110-common.dtsi) and has been tested to work.

If you think it fits the rules of:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
then great, resubmit it!

thanks,

greg k-h

