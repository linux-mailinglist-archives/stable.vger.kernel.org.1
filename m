Return-Path: <stable+bounces-77878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4218A987FCE
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 09:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813D3B25715
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0978E17836E;
	Fri, 27 Sep 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="vfGbwadx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j30Al9Zr"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1718787B
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423789; cv=none; b=rAnoM7bIUI4590NtNLzsPsedNS/3DtI6Snztm/g46RNukLgn78nUjKhBPU3nlT99tuRlfCa57VNDom1AYl5gVCqgPJMJJgz3A5eOcIutX/PbGrSu9P6fhkvVSXck7dyi7fAylJoM9A2vLE8FzvBfRjVPi4vryjG1Q2nm5+gZuhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423789; c=relaxed/simple;
	bh=atxgWhlufWJqB+3x/JTi4Ij5JPZN1vZ5tOZ3v8Z3u6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUCgYzIsaGdEYW8xAQKbFPZE6IInuzrCNS0AR+lonFD2J0pA/rZ1L+BHZuHB2lj5wLNrXz5k8ORg23zB3f5EiO8YEFMBvpFH8rhg2R6QzU6VrJFolqQ8stBybRrkMXPMu2oA0znhp8UL7alXME3NmB74Id+xM9aHttMqhTqLR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=vfGbwadx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j30Al9Zr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F19011400BB;
	Fri, 27 Sep 2024 03:56:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 27 Sep 2024 03:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727423787; x=1727510187; bh=J+aU+SP6FS
	WrN8/ayrddri28YUJF01/SouAK9Cfqn+g=; b=vfGbwadxN5yYKWMd7itCK8LVty
	KWjZxQoZAFpAfcXO4xZH1yp71gQBmKvYIaXE9TQ5pIc7eTerREZCM2ISO4TOM3LI
	6HmOKIrRBzfNQ6Ta3t/fT0zXv8JZ/ROrmSE4GeWSHrJu9T3zA+ovUruSCCPE9nJz
	Rw5HKXyYFCqkj2Z7ii7x+jRswo99/udyNnPs+P2PHUEs6nPsZKquclb9Sf+0/jqE
	Fk6GvUKrGm708zIE5MsxBpcJ4mVQG4804aBLjNPUzUwJ1zuILKMNDrIStYKenj5g
	t5cZO6FS4pMi0tK7MCltNcY7rCh+bfHf8AenW0/dkKY4BOjvR0FRunfcxXZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727423787; x=1727510187; bh=J+aU+SP6FSWrN8/ayrddri28YUJF
	01/SouAK9Cfqn+g=; b=j30Al9Zre/RPGtqVKXFVkt2XqVPJnKy/F3kkHR6VI42Q
	5cgUrhRHgZ1NwU6RLBM30oFlNOXravwtstnyIqwsGCFFThh0GMR9y/oglsE20A3H
	8OClvTTt6LW5Fydkd2aU3GL15ThAgHDyu1Mr6PFm9rYQKu0oSZrC6APfdr7tqchm
	UD3f0PvtXRIC31YF+0PWyxGpcKUKL0LCC/EFqH4zh+CRfL6kNT7MuId1RDPGRxCx
	Gbn+1iO67LztLanyA40yQT5DWt9+4PQCM0wVSos3Oo5+HZtYlJP8LjlMYWU199gN
	dBKUsb4Vf/a6cu4nBvn1qC1sk/QXa0NH4x2kYHA+Fw==
X-ME-Sender: <xms:KmX2ZlJlVnnsbblQiPsID_7vWRNfbrksCfU_lb8Iy3gUiOJxDcogxA>
    <xme:KmX2ZhLsXhQ312KxrJBO6gnfK7w3YfjcEexJPpsZ__98eJ4D1TErqe3rd0BrORfKc
    fj6IREvHCTAmg>
X-ME-Received: <xmr:KmX2ZtsHeyj3dig2MWypHQg5MDzRbTHyYNKgRktZPjp81Oi3Mj6PIwy_OlFF2-kFZ_ScWjcfnwmWGns-DtGjT0EXykzTMKFcqpP-Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtkedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeef
    leevtddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpuh
    hlvghhuhhisehhuhgrfigvihgtlhhouhgurdgtohhmpdhrtghpthhtoheplhhkphesihhn
    thgvlhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhnuhig
    rdguvghv
X-ME-Proxy: <xmx:KmX2ZmaGODI6NFZQ9vPhb4pJVXcxvEqmRuwtfoBa0EVLYX8_fObdfg>
    <xmx:KmX2ZsahHMHT_r7WaNOZIoQ3_8w2GIWhn8GJnixC0bPeq_LZI94xRw>
    <xmx:KmX2ZqBh90kuuIP8C4ZEF5JXSkls01QUNONVhQP6YsVK2Nipd5WHkw>
    <xmx:KmX2ZqbiJ_J949A3LoORGhQSyicSSk4GVndaccBR_hOAUq_ipOC-tw>
    <xmx:K2X2ZiOdNySecq_0phkNQFd0Yvk5CuMu4SIyMpB1JQClwNT3ifaI5QMw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 03:56:25 -0400 (EDT)
Date: Fri, 27 Sep 2024 09:56:15 +0200
From: Greg KH <greg@kroah.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10] bpf: Fix mismatch memory accounting for devmap maps
Message-ID: <2024092751-thrift-squander-0036@gregkh>
References: <Zu1QdPBf_QnYCxbS@3bb1e60d1c37>
 <2bd9fdba-d916-4453-a0d9-a1a5b827a454@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bd9fdba-d916-4453-a0d9-a1a5b827a454@huaweicloud.com>

On Mon, Sep 23, 2024 at 02:38:07PM +0800, Pu Lehui wrote:
> 
> 
> On 2024/9/20 18:37, kernel test robot wrote:
> > Hi,
> > 
> > Thanks for your patch.
> > 
> > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> > 
> > The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3
> > 
> > Rule: The upstream commit ID must be specified with a separate line above the commit text.
> > Subject: [PATCH 5.10] bpf: Fix mismatch memory accounting for devmap maps
> > Link: https://lore.kernel.org/stable/20240920103950.3931497-1-pulehui%40huaweicloud.com
> > 
> > Please ignore this mail if the patch is not relevant for upstream.
> > 
> 
> This fix only involves 5.10, other versions are no problem.

why?  If this is true, then you need to get the relevant bpf maintainers
to review and ack it.

thanks,

greg k-h

