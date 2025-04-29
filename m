Return-Path: <stable+bounces-137060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C5DAA0BA6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B161A88553
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F96D2BEC35;
	Tue, 29 Apr 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Qp+IV8BK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+alPAnJ"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6C2C2AC3
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929723; cv=none; b=m8u6sv2gH4tBnFyojNlLomE8/+L+wCgts1071vOq6HjR92m1HIVIbGW6vokaRPoCNeiE3IxYqI4oN5r6Kx57Fvk2mpKcV9W7r6f2Qb5ugwhY1y6d8TUt6gVKinl39e3C/tsZx5vpHWGV/mm6eGfyATRQCC401rptNfeznEgjZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929723; c=relaxed/simple;
	bh=LdH47Rxz71JwDKVqMFAGf5T41DQ2kErjLWix8Jb7UTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLzzgOmUhN2TUyCfB6RJn7EGp5MizLKTmTwg5VqjYs+I4MWhDT0QJ0nku2HbpyntTdy8Cqd5Kjed9QZULV8TSalAOt0Mnf9Yso/usonAX6pqBGgSspgspIDjdf/m62ScCQns3/mYMVn5H0gbHQNHR1/jrR4vkC3nh/ulTDJPils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Qp+IV8BK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A+alPAnJ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1928213808E5;
	Tue, 29 Apr 2025 08:28:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 29 Apr 2025 08:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745929719; x=1746016119; bh=zqjxDihIyv
	GLjaYNgpdrXIPLu2DOY6y7iPcfFNCETPQ=; b=Qp+IV8BKSSHnCp1G7OqI88GEPW
	Sqc5B5xoCcNR1+K4eFbsHMgy1/C6n/1wcBEHPMX9g5oEzz21PWOTPRAv1D4m91gj
	2TppBvR78896rFv1PvrI1je+7WAmMaYoWH7S5lTH7ECv86QJpTVDpXJcU0bbv2vW
	FapMuidbbl3rYbqpnXntcFGnO7m+kUFDKatvMatTOdnhh6lUZsa3gQwuxcQjzHmT
	JTnufqWjxCCpNxtm7e1wzYj16QFFjYlP2kvgQB94IR48L7KcLO7jzOJ9vyUX9rUo
	A/1oo/pubpupaE1ePHM3cgAe3sJBwjdIgzzpkheLTudM5kZ8SxVPXjp3Ol1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745929719; x=1746016119; bh=zqjxDihIyvGLjaYNgpdrXIPLu2DOY6y7iPc
	fFNCETPQ=; b=A+alPAnJn0O0sAHatRZI/+VJpZ/iWBdkJtCP2ZiDSuPw+tlFpnQ
	xvkuvhKzW5FSnMwAIhSZOnRQw7p0r+zV7WFKFvs1OBTc3T4bGT9/s0gjtXYArX+8
	kj5u/RgDi3XS4DSyHj79OFrLuKTpDIQiM9WHE0Z9Yde1bK0lirWnNOU0PaUBYgso
	MdMXwk3fIRrzS8dbCnVdJQZHSPBzTc446SgB1Pg4m48IEDizDnJFh0EdZSPDcV4v
	unTJ5dPyUsATgxlYkHAtmR3UnUYtaBKNY07PX1npfHcESa6M1qbreWzvhVtt/uQn
	NsgUVgNs0dZiGnDtbXoPyee7F4Bvu71ksxA==
X-ME-Sender: <xms:9sUQaC1kJB5BBW18uopGWDqXnQ4RNHR5i-o6dsmpaYsm5nyRzjhWBA>
    <xme:9sUQaFEx8S4kTnQHpoIFD47iWDdblR2wBAXKcMvUzMY27k7Kiqz3sK-ozVBlZpANI
    PZE72K_J1ehCw>
X-ME-Received: <xmr:9sUQaK4dDVsYhZ4w_yv71dfPXVtbU2lFvmYoznPRVOaKR_IZqLLLKoj-whlv-Ne64F5osSp1-8J2t_saXyP2uLem9Lrn__o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudef
    feelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    hhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9sUQaD1jixJtYDBklE0cmAf1VDqor8qsBxn_JSd9oBCnNpBaG-nCUA>
    <xmx:9sUQaFHTAb841U7egcE4JXGQlVq_fjWCgux1sBcXnpl3rcZtn3Dkzg>
    <xmx:9sUQaM9bNIWLo-brw1RmbsfHVr7DGjZGVfDeTHE6hntupQZ36uYdIA>
    <xmx:9sUQaKmiOFlEAUu4I8Q6DMe9Xd4AiVSKekzYrDr__58v_s_sVnESKg>
    <xmx:98UQaFSUwe_vG9SQpz_UZWuzXaN7MktH5GOGJeFNpx3htSYl8WS1r6RQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 08:28:38 -0400 (EDT)
Date: Tue, 29 Apr 2025 14:28:36 +0200
From: Greg KH <greg@kroah.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: platform_shutdown crasher reaches LTS v5.10
Message-ID: <2025042924-trembling-backward-9436@gregkh>
References: <707a42f7-09c7-48e7-9b87-4e4dd1dfbde4@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <707a42f7-09c7-48e7-9b87-4e4dd1dfbde4@oracle.com>

On Mon, Apr 28, 2025 at 02:51:44PM -0400, Chuck Lever wrote:
> Howdy -
> 
> My queue/5.10 CI test runners have hit this crash on shutdown:
> 
> [   42.547410] RIP: 0010:platform_shutdown+0x9/0x20
> [   42.547955] Code: b7 46 08 c3 cc cc cc cc 31 c0 83 bf a8 02 00 00 ff
> 75 ec c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47
> 68 <48> 8b 40 e8 48 85 c0 74 09 48 83 ef 10 e9 35 2c 80 00 c3 cc cc cc
> [   42.550016] RSP: 0018:ffffc2ff80013de0 EFLAGS: 00010246
> [   42.550630] RAX: 0000000000000000 RBX: ffff9e6805d2ec18 RCX:
> 0000000000000000
> [   42.551444] RDX: 0000000000000001 RSI: ffff9e6805d2ec18 RDI:
> ffff9e6805d2ec10
> [   42.552263] RBP: ffffffff9be79420 R08: ffff9e6805d2f408 R09:
> ffffffff9bc5c698
> [   42.553081] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff9e6805d2ec10
> [   42.553900] R13: ffff9e6805d2ec90 R14: 00000000fee1dead R15:
> 0000000000000000
> [   42.554717] FS:  00007f05a6960b80(0000) GS:ffff9e6b6fc00000(0000)
> knlGS:0000000000000000
> [   42.555633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.556291] CR2: ffffffffffffffe8 CR3: 000000010960a006 CR4:
> 0000000000370ef0
> [   42.557105] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   42.557919] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   42.558733] Call Trace:
> [   42.559044]  device_shutdown+0x15b/0x1c0
> [   42.559512]  __do_sys_reboot.cold+0x2f/0x5b
> [   42.560015]  ? vfs_writev+0x9b/0x110
> [   42.560444]  ? do_writev+0x57/0xf0
> [   42.560859]  do_syscall_64+0x33/0x40
> [   42.561289]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> 
> 
> It's likely due to this recently applied commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/5.10&id=09dc7a2708efc8eaa3efcbb1d50b2d8232b41114
> 
> Maybe commit 46e85af0cc53 ("driver core: platform: don't oops in
> platform_shutdown() on unbound devices") fixes this issue, but I didn't
> test it.

Thanks, I'll go fix this up again.

greg k-h

