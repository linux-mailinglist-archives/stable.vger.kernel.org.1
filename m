Return-Path: <stable+bounces-17791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ECF847FEE
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F2C1C21823
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 03:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDD8DDB5;
	Sat,  3 Feb 2024 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qJlygBuC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pMJXADMm"
X-Original-To: stable@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB6DDCE
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706931434; cv=none; b=XTHmKdaVwJqIUe2Lao49DIOv8oPxKRUwbj7XoZRDAnRb/LJDNYguVbWYXlecS7d0D6CNWQ6ZBdEoJKMMSH9DH/vjXpdwRPwv+gsn6VcZuJzuxBGwzZFMFTjE7KNV8nW/sB5dOJlO9SjYJ70WSSSl8gmVd2I5Sez5qsT6zhPMv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706931434; c=relaxed/simple;
	bh=0q4dMlkIRmcgL+XKBlgknzD6/TV0+nrzFSU5SY8dQtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAldlCCOX+kXRsRqoLtMd6IhvKFZ+scGeAYFrkZkSdnEA116ahodfSBQcWlHv3K0bgm9v7Z6t3/Zuxoq1T9G9lxlDnX/CQDBYw8Z02/0eDfoYUUH1vVmgPIbInWwqxFDbBsdP2WBdwvk9iUFYwHt3wM2l2pzH/4Z5tn+mTtcf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=qJlygBuC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pMJXADMm; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 2252F3200A95;
	Fri,  2 Feb 2024 22:37:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 22:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706931429; x=1707017829; bh=sBzKrUcqDU
	fLm6stMtAPtaTqLigkm1Aa2pYx9OE9jsY=; b=qJlygBuCYc8srv++CuXuA6P2z+
	1ETIvppJIhdcDTbnMAuO2Ozz6JzGKERx56WPCNiCpeB+EVE797WSMj8b7RVbJvg5
	fNK8brb5f/8kc57QzGFhPXfmKF0GCqPFn6QBZYJ6nTpBWaMZmfRiNbIEid/7BkIt
	tKl/Z/v5PFO/7ydavU0iFJvM/hCIMUx2ZudrR266nyWNcLBFU6NCksfyuZqZhcf1
	RoGAX3OIxp5ooy0/+EuYPa6LtJqdrSq/KehbvGRymlTU+SPmzrIv2YXYQeFMg5z0
	eVH1a6Rq5PYRgIL115Wz6mEInPBSvEgwDl65I+UHSBKt2LCSpMOtABbmtUUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706931429; x=1707017829; bh=sBzKrUcqDUfLm6stMtAPtaTqLigk
	m1Aa2pYx9OE9jsY=; b=pMJXADMmHElCS1QyChKpfX3m+ikr4/Jfr4pwNjLbluLy
	rknzMiTnhXVGf8OfWPLljaTXf2oJeHfEbylkdf+QL4sD4aa4MJGXtmnoXXn+EhCE
	Hnhf9mfSI0UulrdMtVSmTYDlqeqaPzzzzgAJbPO1nIaNYcHw/ll6cCEmhJwcNEDO
	c1xo6x3Zjk4loQ3DhFkjCOoznhqCcoM//YFEDe6nNU4DJY9ml05uc7LBaIuA75EL
	DSAPSrolXML58/roVi9TqoXFN0kwyM8HQNPqZNEd30mSdlOwxYuKqKraZcr+zyjc
	8GB5fdQ2xeF4N6gAtBqp8X1eMes3rGT8/zIBvNrw1Q==
X-ME-Sender: <xms:5LS9ZUR4l4PIl0oPaVMsy3Jg9Yenqh_giTdRDxjeJ2ahLR6WAVgTEA>
    <xme:5LS9ZRxpMTwPlO6nm-V69BbQH3A8NmNEYYsejjRx3thRSeIX87LniqnZQvobd-qhd
    QNcTnG-TLIKYg>
X-ME-Received: <xmr:5LS9ZR1BqSrySgwb7VfmXDtd1EMMgRtDpZ7NfAJeNJ4cSAD5LeBG5hc5Co-m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehfeeltedtiefhhfelledtffffteehvdffgeelgfekie
    ehiedtheehudevheehheenucffohhmrghinhepuhhrlhguvghfvghnshgvrdgtohhmpdhk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:5LS9ZYAzMKwBtiUTzp4MmFtz-9oNBOnshH1ZcxK-MEkuPszr0A5VKw>
    <xmx:5LS9ZdixDlUHY6qWo7QVD-jhKj2wzYKMjWBixOyHa7x1VN__ZWxBJQ>
    <xmx:5LS9ZUplEC9MkXkxGAIP7WfHBYZ4YJvLCIGU-kLtAuzXstmOKzjOJA>
    <xmx:5bS9ZUM0uYu1IgcDy7-bkgLm6ViRvTuZ4fm_6n8PZlwE49psx8-iew>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 22:37:08 -0500 (EST)
Date: Fri, 2 Feb 2024 19:37:06 -0800
From: Greg KH <greg@kroah.com>
To: samasth.norway.ananda@oracle.com
Cc: stable@vger.kernel.org, harshit.m.mogalapalli@oracle.com,
	yonghong.song@linux.dev, ast@kernel.org
Subject: Re: [External] : Re: [PATCH 6.6.y] selftests/bpf: Remove flaky
 test_btf_id test
Message-ID: <2024020259-cube-whacking-8c37@gregkh>
References: <20240202034545.3143734-1-samasth.norway.ananda@oracle.com>
 <2024020204-enchilada-come-ded2@gregkh>
 <a602e2cc-292e-40bc-8ab4-8c1b339ccd78@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a602e2cc-292e-40bc-8ab4-8c1b339ccd78@oracle.com>

On Fri, Feb 02, 2024 at 05:33:36PM -0800, samasth.norway.ananda@oracle.com wrote:
> 
> 
> On 2/2/24 5:31 PM, Greg KH wrote:
> > On Thu, Feb 01, 2024 at 07:45:45PM -0800, Samasth Norway Ananda wrote:
> > > From: Yonghong Song <yonghong.song@linux.dev>
> > > 
> > > [ Upstream commit 56925f389e152dcb8d093435d43b78a310539c23 ]
> > > 
> > > With previous patch, one of subtests in test_btf_id becomes
> > > flaky and may fail. The following is a failing example:
> > > 
> > >    Error: #26 btf
> > >    Error: #26/174 btf/BTF ID
> > >      Error: #26/174 btf/BTF ID
> > >      btf_raw_create:PASS:check 0 nsec
> > >      btf_raw_create:PASS:check 0 nsec
> > >      test_btf_id:PASS:check 0 nsec
> > >      ...
> > >      test_btf_id:PASS:check 0 nsec
> > >      test_btf_id:FAIL:check BTF lingersdo_test_get_info:FAIL:check failed: -1
> > > 
> > > The test tries to prove a btf_id not available after the map is closed.
> > > But btf_id is freed only after workqueue and a rcu grace period, compared
> > > to previous case just after a rcu grade period.
> > > Depending on system workload, workqueue could take quite some time
> > > to execute function bpf_map_free_deferred() which may cause the test failure.
> > > Instead of adding arbitrary delays, let us remove the logic to
> > > check btf_id availability after map is closed.
> > > 
> > > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > > Link: https://urldefense.com/v3/__https://lore.kernel.org/r/20231214203820.1469402-1-yonghong.song@linux.dev__;!!ACWV5N9M2RV99hQ!I-3G5NyOo-Xom0b0NmUHYWm_hs6Ai1qD4A9smNew_5_8jyyEXbISpxoAPa4wSD_eXQr-IOAd4_TM2NBscejS$
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > [Samasth: backport for 6.6.y]
> > > Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> > > ---
> > > Above patch is a fix for 59e5791f59dd ("bpf: Fix a race condition between
> > > btf_put() and map_free()"). While the commit causing the error is
> > > present in 6.6.y the fix is not present.
> > > ---
> > >   tools/testing/selftests/bpf/prog_tests/btf.c | 5 -----
> > >   1 file changed, 5 deletions(-)
> > 
> > What about 6.7 as well?  Shouldn't this change be there too?
> 
> Yes, it should be there on 6.7 as well. Sorry, I should have mentioned that.

thanks, now queued up.

greg k-h

