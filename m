Return-Path: <stable+bounces-247382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id daDNETSxBmpInAIAu9opvQ
	(envelope-from <stable+bounces-247382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:37:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C0E5499E1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 067053041A65
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB28435F5F9;
	Fri, 15 May 2026 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ivt9qBFI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JxRqW/N7"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680635F18F;
	Fri, 15 May 2026 05:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823466; cv=none; b=hnr+iRJwvjavMI98EE/vfmo8NLh325AGlkRuMAMKlX98bE8Uw6XfnCK51Bl61X5nQ/qlfkW5Qq7r2QpEO2Yt4aTNLPetVc5GG0ZiB/uFgO0pKS/ppmEYvAhcBDVubmJ6dQ3oIlBjfJXoGAaM666dBjbVTKxlqoy8cXEeeECgHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823466; c=relaxed/simple;
	bh=dB6SuESujHM7n4uFYJAAy0uWxNwyR2zSfHu6wyiMC/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4l7cCwM5rEZwJoXt5zD0FEt3rBxbi5cwf6kzZ4SJr9aERx1uN2njdK9i8p0oA3Q0aXf32LCMuoVPpnDbbhZOz/V62sOfRHJoyUJgJq/hpMTQgKqTr86pn/Jfu38UFtQOFqS831pMBhHNDWxod+Chn4k0UQRCY1NVd4mBkTuRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ivt9qBFI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JxRqW/N7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 660591D00073;
	Fri, 15 May 2026 01:37:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 15 May 2026 01:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778823463; x=1778909863; bh=ull5E2vwq2
	Y5WhJpHt+OstNvXNsWfVfTbrUwnvpT4BM=; b=ivt9qBFItfLYQORUfYjgvKOSD8
	iRzOCZJArNlPEw+HVsuW7PIfPkHi7k3T09IedUjwpRa7V5aAr2PZrdvZhZWK1tDH
	QUjIIY0Lehjxovmp2VO63G35JMny5kB65lv1S2qaN9mcM2XlGc10nRiwqbL1MAsK
	FoTp/rt7GG8RK9YTu9sW4um8+HNepqOuzl2nQjj7vK0KFZwKuxNwy16O9XdjvK04
	bK0GNZfPaJR3qlb1y3pxaW6PLVkiyNMylHU91ssUny4nPMKeIOzbWdGtyA3xt43I
	R+NUQ6Gtl/iciDdMbEXrh0HVZQXQs/Tozzufgg/jNHdBJ7aFaIb72uWnfmoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778823463; x=1778909863; bh=ull5E2vwq2Y5WhJpHt+OstNvXNsWfVfTbrU
	wnvpT4BM=; b=JxRqW/N75jGWbAoEtP2oohLXVsz15VsoE4gvUgeDh4eT1X8xmwT
	MCAoXmcT4JSO0qqfM4kt8JP2dYXbZSd7ylCH5M5RTFcvL7G13t7kX6TfX3RRkZGm
	xE+UZnyBOvXdwI2jW81Y902Va0SaOaVKDkuRCGcQz1PgO9F8MR5831nhNKmR5tiF
	QxY09qpG4bowdBtCm6cCSwLIn1nNOW8kP80bb/9jsuFRfPF0eBD2erIhzdCSgDk3
	oDqSecWXWZq7+I3sA4x24Q0WwKrEn33p07qX7MeBiPu2EmrKTlGB3bvbwrvUeGTT
	pgJWJPD5rIXsWuQWZheNDOwZD72v/VhTclw==
X-ME-Sender: <xms:JrEGatHGiPn7ewsEDm8U6qblDrqPjDPHbtoogv3KzXHCHdak1F9l7w>
    <xme:JrEGajoeWkbUCKuMnf97-m7Kwbabvt1sL_qeE_A1F0ACCgCa3uLg9ZyPfgUAJH3gR
    mwRf9mimuIGZJF6a6uGxENU3CtwIXipUljFVjJhZI6ipKLOTA>
X-ME-Received: <xmr:JrEGajz_LbAmyPVEWXJVE2TZoD3EQ2qQTBZgNhtMFJS1WFWQFxEt_NvYU8uqeRWhBkqlz212pNcSTw_WuS1pG4ZoFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdelheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehueehgf
    dtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsegruhhguhhsthifihhkvg
    hrfhhorhhsrdhsvgdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlvggvmhhhuhhi
    shdrihhnfhhopdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphgrvhesihhkihdrfhhipdhrtghpthhtohepmhhikhhhrghilhdrvhdr
    ghgrvhhrihhlohhvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JrEGalw88VSToIt3_uyEmyNIR-7Jnzalds9FF-UH-e3UyNx5z9v6SQ>
    <xmx:JrEGaqT45pmD8xCUMGadO_U9ZHtQ63nnNa86ZomxRocu3hlRJ5vP8A>
    <xmx:JrEGagP9V5X4Lzo9mvCbxJB1ikvUygRlgTstAjKh8QezLa8PSpJREw>
    <xmx:JrEGatSvSVHFFta38Jyf2Q0D46dkEwhu2PldHmLRBh8pFwNybkEKQQ>
    <xmx:J7EGaiblzBq36j0k_3bOF5hzUPzR_7BKNP3uN5cOeTRdMeSfGq6UCDj_>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 01:37:42 -0400 (EDT)
Date: Fri, 15 May 2026 07:37:47 +0200
From: Greg KH <greg@kroah.com>
To: August Wikerfors <git@augustwikerfors.se>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	stable@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	markus.suvanto@gmail.com
Subject: Re: Linux 7.1-rc3 regression (Bluetooth)
Message-ID: <2026051514-scorch-ecologist-5e7e@gregkh>
References: <f652d5d9841a9b7c100dd19ee97c86099f580724.camel@gmail.com>
 <01ffb0cc-dcf6-4e60-adf3-fbb96e0666d0@leemhuis.info>
 <51b55b97-615b-4f5e-b454-df646f4058b7@augustwikerfors.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b55b97-615b-4f5e-b454-df646f4058b7@augustwikerfors.se>
X-Rspamd-Queue-Id: 92C0E5499E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[leemhuis.info,vger.kernel.org,lists.linux.dev,gmail.com,iki.fi];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247382-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,vger:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 04:26:38AM +0200, August Wikerfors wrote:
> On 2026-05-11 08:30, Thorsten Leemhuis wrote:
> > On 5/11/26 07:17, markus.suvanto@gmail.com wrote:
> > > Hello
> > > 
> > > I upgrade 7.1-rc2 to 7.1-rc3. After that bluetooth  didn't start
> > > hci0: Failed to send wmt func ctrl (-22)
> > > My fix was to revert commit 634a4408c0615c523cf7531790f4f14a422b9206
> > 
> > Thx for your report. FWIW, there are two proposed fixed for this change
> > floating around:
> > 
> > https://lore.kernel.org/all/20260508173121.27526-1-mikhail.v.gavrilov@gmail.com/
> > https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/
> > 
> > Given that this is the third revert within a short time-frame I wonder
> > if we should fast-track a fix (once ready) to spare more users the pain
> > of bisecting & reporting.
> 
> FYI the commit that caused this regression was backported to the latest
> stable releases (6.12.88, 6.18.30 and 7.0.7). I encountered it after
> updating to 7.0.7 and can confirm that the patch from the second link
> fixes it. That patch is now in the bluetooth tree as e3ac0d9f1a20
> ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events") and a pull
> request [1] has been made to the net tree. Unfortunately this seems to
> have been a few hours too late to make it into the net pull request for
> 7.1-rc4 [2], so the fix might not get into mainline until next week.
> 
> As a side note, it is unfortunate that there does not seem to be a
> process to prevent patches that are known to cause regressions from
> being backported to stable releases. As far as I can tell, this was
> added to regzbot tracking [3] a day before the culprit was queued for
> stable [4], so such a process could have prevented this regression in
> stable releases.

You can email stable@vger to let us know to drop a patch, or when the
-rcs are released, respond to the offending patch in that list.  THat's
why we have -rc releases!

thanks,

greg k-h

