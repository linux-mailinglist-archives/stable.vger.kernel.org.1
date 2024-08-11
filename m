Return-Path: <stable+bounces-66361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F2794E106
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7082E1F21406
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 12:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1E33D55D;
	Sun, 11 Aug 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="f4Io5/K6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1DNzsh/"
X-Original-To: stable@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55311CB8
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723377888; cv=none; b=JpCQzTiPL7vmlMJRPTzuRSKz2nSDKe+xS0+vogWPZbAM3zvqR4RYULxFNjLbWbF54EehvZj+/nzcZ19qGzE2Q2JjgijA/ymnvJBBPEPqeiPWrWOEyUqzstfOQidKwo0vVoHeuDnC13huNDl8GyDedLv79rcNAPwI3wAbCaCRZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723377888; c=relaxed/simple;
	bh=GiXqb5WK1SYAf+hBgG9YICrkDJ189y/D7g8s2TlDMbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okPc1AXb5GyWFpCMdwyF0y+JzS/ued+JhrZBojWYMdcMlnc7bRgu0y5+zfnCbMNHFM/zcExtNy8DzoZPStf6A0s6HKS8K75aCepNVHUve6LTe2DDbZ4ErNJIo+jTY2X6y6D/FCicbDTWJ566NXnUVzpnze6JC+c19sSuQTDy55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=f4Io5/K6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1DNzsh/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A5A211151B0A;
	Sun, 11 Aug 2024 08:04:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute8.internal (MEProxy); Sun, 11 Aug 2024 08:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723377885; x=1723464285; bh=gFAgqGD2YG
	r8385SYfJL0FkDb1527PgPaHf8rG/7Q1E=; b=f4Io5/K6wr1gnByw4IVXoMRbAA
	x5IW1XpiTmf7hXFd1VzOa2fiA21YxT2uDfALe8a2cJYlv9VW0OCd30nvo1B2+1a9
	xJ0Dt+vokiEDo47VvFrIcDxCvDAeu+8LekqW/CPIcxOzKs/ihKfbyA6rqGOva2QH
	24rhl+kDl1zeVrqE0v79gSYOnQs5X7L+5jW+LJQQX4JVS6dyWb+DbZcoJY5vO3Zx
	kdS3fiKk8+tLf/XPVdanygK34hxc8bEaCIGKGbDOIIHz2sGt535/FdvlS7liZf80
	IMolLQwbociETlMtgO7lGjhvrhaKwXHFfDUpKVScRiG3sOdAzY2Xr04VONLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723377885; x=1723464285; bh=gFAgqGD2YGr8385SYfJL0FkDb152
	7PgPaHf8rG/7Q1E=; b=E1DNzsh/MCLo8ChRIS/wMEqGizC9nNW7g5aiXoaxxNSm
	3+F8QZ3u5HlosQISA7tlJtZDYq5RZLCOhvZciVSFXYrODez1VH5fkqvdrZpErUlw
	bxR+U9ll4ZjTJYVRUb9jDD+0eYv+GfMLJ1z2ygyDfvcNFwecBHU6M8YcJyZ5tHOF
	B+7MeR12m6C7XD8Y7hmWB9eyaP3gpbm8DiExyvm4d9em1Y/dH68fMqda/Ean0zIt
	xsOpYPI7j+FkFUe4TFKuXASJqv517L8vlW0T8pRN1iA8/4Kys+9hdEMl1fCxeZty
	oWreKr3hbbUjWlVzdzM9dmPWaqrNmG7w4PEQmCNQYA==
X-ME-Sender: <xms:3ai4ZtfGIQ5Gm3P9g1RzM1NAKoCixVFuArXhLe-7N8-Y-uDwfl5hIw>
    <xme:3ai4ZrPvMGX3lpCHaS_r3W2F5UNt5I8wJt9Ec1qo1ldjOaDNGcsNHIOaM345bEHEH
    6IE-byIAJaI6Q>
X-ME-Received: <xmr:3ai4Zmg5lTfIycoXOhrpT5olsgVU4Zj8nn_TTi5mw2LbYYaOi-q4VPu8iF0dJyDoDpK09mq9ZfNxwJcHc5gwujxz0Y698I4GXQnOUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleekgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejteeuheetkeeuhfelheekffffiefffeettdeigeekvdeigffgfeeuffek
    gfeuffenucffohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhhuih
    gtpghsshgrkhhorhgvsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepfhgrshhtrhhp
    tgdruhhpshhtrhgvrghmsehqthhirdhquhgrlhgtohhmmhdrtghomhdprhgtphhtthhope
    hquhhitggpvghkrghnghhuphhtsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhu
    ihgtpggskhhumhgrrhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3ai4Zm9N4BzXScZ31LKoSpVl-EsQ-BGG6jfZSEieA2CZJZt-iseTJw>
    <xmx:3ai4Zpt2qrGNEv1e4GKk2z8jCbK4hve6H827jVCaqlVAIiWAXzTwEQ>
    <xmx:3ai4ZlFe7g1mcUmB1wfQ1TKB9kjHCxoC-hfORtrOrKVDOza3FENz5w>
    <xmx:3ai4ZgOAhLqZk5mjEvLjq414_amivsismY6ddBs2pgie2PIVjhGNwA>
    <xmx:3ai4Zqnl199Mm-LWwklCi0ml9hGxwQZTpf133qq0HF_idJBTqX7ewNHe>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Aug 2024 08:04:44 -0400 (EDT)
Date: Sun, 11 Aug 2024 14:04:42 +0200
From: Greg KH <greg@kroah.com>
To: Santosh Sakore <quic_ssakore@quicinc.com>
Cc: fastrpc.upstream@qti.qualcomm.com, quic_ekangupt@quicinc.com,
	quic_bkumar@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v1 01/41] mptcp: fully established after ADD_ADDR echo on
 MPJ
Message-ID: <2024081119-impish-vixen-475f@gregkh>
References: <20240809101849.1814-1-quic_ssakore@quicinc.com>
 <20240809101849.1814-2-quic_ssakore@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809101849.1814-2-quic_ssakore@quicinc.com>

On Fri, Aug 09, 2024 at 03:48:09PM +0530, Santosh Sakore wrote:
> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> 
> Before this patch, receiving an ADD_ADDR echo on the just connected
> MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
> resulting in an MP_RESET. That's because only ACKs with a DSS or
> ADD_ADDRs without the echo bit were allowed.
> 
> Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
> we are not supposed to send an ADD_ADDR before because it requires to be
> in full established mode first. For the MP_JOIN 3WHS, that's different:
> the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
> can be received on the recently created one. The other peer will already
> be in fully established, so it is allowed to send that.
> 
> We can then relax the conditions here to accept the ADD_ADDR echo for
> MPJ subflows.
> 
> Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-1-c8a9b036493b@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/mptcp/options.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Any reason you are resending this to us again?

Please fix your scripts...

greg k-h

