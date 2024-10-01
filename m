Return-Path: <stable+bounces-78319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE4A98B4E6
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C14282FC0
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 06:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D4197512;
	Tue,  1 Oct 2024 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BMxgAj9/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xb0ejPtP"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729863D;
	Tue,  1 Oct 2024 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765469; cv=none; b=X+fWcYOKsNpGGlECAy4hhGljbyIjjlhZi8jrIkbCv00GuG+dZ3ZzC+8Q6g95DExNZ7AlspGZMy8P9EMD1k+v0sJisptwwGetOLduvCTfCZFwC4wvPEpWUW5zfYzEOvEDzIgFHsQclroDSV0Imel5AJR6W5mAxvXx2s6OPeCIiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765469; c=relaxed/simple;
	bh=E+0X28JRGcE8U5QB+inWSNqwqpnRiWrIeRY7OAEj5VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9Fqkf1JUKLbt0ZEEx7UdPjV/PQwAANLD0CyOtcsVIGG6wCnwhKSEFln/bL2NImYY+45vu6BPclsrx6rZeGvDsqVByYod7O0V6R3WOQEQe7xc4Rk9PJXRtMdEsaCCF25thd+gY+0DnXoNB5HoSAUH8SPFbZdc2oBR0Kkgq2bAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=BMxgAj9/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xb0ejPtP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 304B21381EE9;
	Tue,  1 Oct 2024 02:51:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 01 Oct 2024 02:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727765465; x=1727851865; bh=E+0X28JRGc
	E8U5QB+inWSNqwqpnRiWrIeRY7OAEj5VY=; b=BMxgAj9/ZVnik9GC8JiVKdNByG
	1gixrPcIsbJ4RJ6mw0Am30a90KZQJQB8X0xT38bXihLeJJcw1hQRYGhpC9vVkABK
	ultR/rf/2OvAgtSqMdMtzmAlo4oNOUEvn8xW/77y+v6PeaRIPoLEo7ZcR0T1LSr7
	v/5GNriU/+WkMqQrXe1WXR0y3uWQIwge1KLczq9EqV8ih3R07YAh9k8KrwBPpfu6
	Rx7s0ni7j99VcUbkqjDR7SugtwIGt1G0FsSlgL8lbTsmeAg93A6GW1HLTxUhdjSb
	OjAE+Ail9okcI8SqZ4zPBpGLeFTXh48ti1IWdhOw3CWidiRMFk0WjC9oQS7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727765465; x=1727851865; bh=E+0X28JRGcE8U5QB+inWSNqwqpnR
	iWrIeRY7OAEj5VY=; b=Xb0ejPtP6IuUiECwCZDhle+7k2KGNU0Xraec9nwthcIU
	Hty3AN0LtnT780s85oTmQaBmVjeMlcKh6j0Kll3bIdYIQgDpgXzLYH8Q7LUr5HKy
	GoqFkcAIa8OmE9vUmPFDT5z7lKMLtSg6vC2G+tMeG9rdB2QtF8tQTICM7bM4QMeT
	NYKinuBo9fBqJXPf030Lt1xhaiTJsdXJKYbvjmZPpNBqMHw+7skYZASrVSMbiQmZ
	2cf2NH9zzEOjPMQFPrZ5gDJXXXnxmm5aGlm+smv9iRtcRWw4zaVDuYc/q3tLS90U
	vCkg6gqnoiWae6/JFDSGgcQr30M14GOGvmGNjmN7xQ==
X-ME-Sender: <xms:2Jv7ZrK3aM5nD8CtnWxQmE9QgFis9RiCKB6tNDRPjdIZ4Bs3ZkqIZg>
    <xme:2Jv7ZvI-rvPtHaPE7xiVy7RpQnplJLKJOUcVOgSXwQcDYZUVVRZyu9l6FyX8RJphU
    jMt3Cn2QfcMGg>
X-ME-Received: <xmr:2Jv7ZjuRNijZHdDLOnKnghl441cxNbUN7H9Ou6ptVNZ1Scq9oME_B0l49avs0EZ7An729FT0r1qL5sJjf3DEjGVxs_YWj5NFj0BG2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueef
    hffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrghsohhnseiigidvtgegrdgtohhmpdhrtghpth
    htohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgr
    shhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgdqtghomhhmih
    htshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:2Jv7ZkZE_nZYogjxcizGp4XrdaaWOcr4MghsQ27ozELjVGJw7bV_xA>
    <xmx:2Jv7Zia6Zfwvztmk449wmAvD7jPmNBX1o3G00MgYdVf-Zn0nvAPRng>
    <xmx:2Jv7ZoACfex0LBskdsHf2heSv7WYb3GoCm2RhuZ-gBUsz6SVkWWa-Q>
    <xmx:2Jv7ZgaiFsLkEeVMwPYdlLaJ4QlyXMCkZ-UZfyPFXR-FG34FMoUHrw>
    <xmx:2Zv7ZvQh5wqVjMsP5yakXXUxXviJI7lmsRmT11cN4dYj1vaNJpxpBxta>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 02:51:04 -0400 (EDT)
Date: Tue, 1 Oct 2024 08:51:02 +0200
From: Greg KH <greg@kroah.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: Patch "selftests: vDSO: simplify getrandom thread local storage
 and structs" has been added to the 6.11-stable tree
Message-ID: <2024100144-aloe-acronym-f34c@gregkh>
References: <20240930231438.2560642-1-sashal@kernel.org>
 <CAHmME9pBufdO91FK8A_ywNhOcpxSjvZJA3_pBCbhPf+1qHZaMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pBufdO91FK8A_ywNhOcpxSjvZJA3_pBCbhPf+1qHZaMw@mail.gmail.com>

On Tue, Oct 01, 2024 at 05:56:12AM +0200, Jason A. Donenfeld wrote:
> This is not stable material and I didn't mark it as such. Do not backport.

It was taken as a dependancy of another patch, but I'll go drop them and
see how it goes...

thanks,

greg k-h

