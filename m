Return-Path: <stable+bounces-125622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45B8A6A05A
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 08:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CAE8A054A
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E591EE7A1;
	Thu, 20 Mar 2025 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+Due8vG"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66F0156861;
	Thu, 20 Mar 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455408; cv=none; b=LzxYtJkokroDNUZrI9WVcnOxT5eGUTDqfmtS9dxSH2OYQckX4ZcA5AOsJZs6YYsKGQJxesQ+Jdj2cSA1BCmfaAZ5iRH3st7VerD/2HTvj7zqWDv05NZbagU5Zcn8KD7oO6UyZ53qsyD/mnLyCsfgbRb4gPS0dfcmB6swXPrXBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455408; c=relaxed/simple;
	bh=wwU9bUJF051+5HwNYIbpitpUKGuwRi4BHbVk/WKcqsM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FDMHGmnnBUAutvtndrzm6IPxGi+WYkCmWL2M6jP76NY1PNdxpAlgZ6PSzh/EbzXHIRvw/SE9Bs7mYosFSG9inKZzPIHrPhxOZQ5f4JkfBSqxBx7azZ//dCeuVWxxFUrNNtuG9oRTCthQzUc1eEeSbnTNvrCUP/DUveIS68zNZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+Due8vG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8DA90114029E;
	Thu, 20 Mar 2025 03:23:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 03:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742455404; x=1742541804; bh=2H+Qf00iEaCSI1CWQVfPhmwGwdj2sIpGX/G
	fQZrkw+4=; b=Q+Due8vGNek6M49EV/l1+7UuRrHPUgMNFyIUna7lt+0mhosNVwV
	KE4B/G8R4yDg/J+2wY20CnYLAQdMlEtI8liHpdrR4MXtTOOuL+jIhzCcKntXh+Bk
	y0uYimgjuuAgXpl6LrrPjWgZYEMG66hYWzqYZVYMySAJD1f/LOdSHk3EvuJ70kaM
	0XoRqfRDC9kCtljIM14BB9IH0etLn4rAfDOSEnTX3jTt6hjkmK80vDLMcU97h2SF
	Wu1Ia/VdvheXjudyyffmrj7zolmoJ5ot0pGrZckBDUcjxYwGa77YADrvnpcivL+6
	kWKbgkP0R4pnUjzQ6hA177lrBWV5FK2WjUg==
X-ME-Sender: <xms:bMLbZ9yuj2smCVrV1L3bYDqsCkKB5RPHtjeL__uVU3HpqvdyhiJcKQ>
    <xme:bMLbZ9Q3DSaJSr3tpx8IXh_mMgUAww2Sf-T9fY2Pul-cuc09fYnrkSiUwp8QeKSNW
    7bfV1htYFbzOnSDg3s>
X-ME-Received: <xmr:bMLbZ3WVmVpWmi3mMpXbcSsSyPa_EJOtw8LJje1ZbWpGmfCSwGJob4JSNUXad_J_Cht50zE-ZrpVKQq8e_-zM3YnS0rml3DWTmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheike
    hkrdhorhhgqeenucggtffrrghtthgvrhhnpeelueehleehkefgueevtdevteejkefhffek
    feffffdtgfejveekgeefvdeuheeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehstghhfi
    grsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepghgvvghrtheslhhinhhu
    gidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrd
    hlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bMLbZ_gsaxJe9zwO1EaRkWLds2Om_nvBjYrGovgQ60aYUM_AH1IKCg>
    <xmx:bMLbZ_C57OJIQq48uO3KH-JGhUM7dJlXrKufXWUh0jEJarcOVtf8_w>
    <xmx:bMLbZ4Jn_1eYD3jCfdVsF2klSMWzpfz50ZrmPlLDJP2eVdVaVF-_iw>
    <xmx:bMLbZ-BvM4l4FTrrL6cx0uqKvF2oHeBIdX55J21G4GRjtuhzJ2-2TA>
    <xmx:bMLbZ68ab0I5hEtUHiv4b5OpT1tDb-_TSSf1lnfkadALd9ZbWO4LnqDD>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 03:23:21 -0400 (EDT)
Date: Thu, 20 Mar 2025 18:23:19 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Andreas Schwab <schwab@linux-m68k.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
    stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] m68k: Fix lost column on framebuffer debug
 console
In-Reply-To: <mvm1putgx3f.fsf@linux-m68k.org>
Message-ID: <df3dcadf-fc50-8d93-5623-4861e1772874@linux-m68k.org>
References: <cover.1742376675.git.fthain@linux-m68k.org> <0fa5e203bb2f811e36e9711dfd461a8f760a1ed6.1742376675.git.fthain@linux-m68k.org> <mvm1putgx3f.fsf@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Wed, 19 Mar 2025, Andreas Schwab wrote:

> 
> s/subil/subql/
> 

> 
> s/addil/addql/
> 

Will do. Thanks.

