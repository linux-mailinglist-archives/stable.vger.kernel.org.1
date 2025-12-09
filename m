Return-Path: <stable+bounces-200489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D4FCB137C
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 22:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E15E301B9F4
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 21:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF602D0C95;
	Tue,  9 Dec 2025 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wGu4rESh"
X-Original-To: stable@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928F2FE56E;
	Tue,  9 Dec 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765316432; cv=none; b=dtTKcmoIBmpGixt9TUFzK/dVJzai7Y/SER1mXoYZ/4nk/B/QVpy4gkagmWomz/CxsI1epL9q7AK3HldTIgThbjRkhzGIeJeScViEf/con8D/8M1hDJ+xN4LCRFfRyvcKDtOBjn5UpH7wKs9ojyg6o35103YiFHr8ppdpaYJ8h9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765316432; c=relaxed/simple;
	bh=ZiNZAX1mJEDhJD1LDuVFL8ZId5FkXyM1kh4xDQFsWLo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kEgf560Qt3PLS0vm7W4j/TLONMoc4Offh4CB0qeafR+Y2Ni6+8KVeif4VGTfUn7204ewFcOviYyWSWnjdfBxa9kXImOxlKaEKVNQ7/uFdgHKu2vmpjpjiVJOQFHL43qSu7n8pSOHgiRGpNXV1v1nWE2SafvGP/OfkD0tnl7S6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wGu4rESh; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id F34101D00187;
	Tue,  9 Dec 2025 16:40:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 09 Dec 2025 16:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765316427; x=1765402827; bh=RfOZgApXXy9+kALkGYzB/Ets38/jq6fxW2o
	QQcU2kgQ=; b=wGu4rESh55E7fU67ONJ/DyKco06l2RsXOtxoT27k2vK9jsSgvBd
	J7ovrmRvtk5QA81DmByzXHCoTkWBX6RcV2yosc0eiAaIAb7cD73dhvSEbWndTFmC
	1BSehsDLcUNny13OPPRhZTt/R27jqBO1be1HhRglIg20ped1y173er7EWCzVRg5J
	j8UghLNYUqZTP/2lMFuG7yhW39P+/GksqB2NhpndTmkJUCtSkrvnSbGo8Hfm38jI
	BWf0pT07hmutPahecewobLhZhKFORxJ0w21KdQNegDjyHb/MbG3Fm1V5HO8bc2wC
	jqlcVpScndhlNKOdrXPF3Q1pCAdtP1Gx9Kw==
X-ME-Sender: <xms:S5c4afUsOm7r13big8FM7Z2vXmxWC2H8BRmn3UDyb3g_y9Ij8yd0lA>
    <xme:S5c4afsTBEacfrM4V02Om4j_LsKA5TDGoYLCBcgzPj1OPTSzt4n9SMySfjndq2uBe
    Ro7OFPEP83ywTWIpFGIh_P24ptzT1X0C4zY3ri2zpp09QJaFBHnwqbT>
X-ME-Received: <xmr:S5c4aa4RrVjk502NblkXptOFrjW5ZHDeEZdNBW5lWlMf3tW8XFw-_CuZL0PUBVZFajjPVrC-CQz95DDS-UoVW9o5l4S_nljcZjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmrgguugihsehlihhnuhigrdhisghmrdgtoh
    hmpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohep
    tghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhope
    hnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggvuggrrhhmrgigfigv
    lhhlsehmrggtrdgtohhmpdhrtghpthhtohepuhhsvghrmhehjeeshigrhhhoohdrtghomh
    dprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghpthhtohepsggv
    nhhhsehkvghrnhgvlhdrtghrrghshhhinhhgrdhorhhgpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:S5c4aaRZZcImTyCks3l7bDnCzaYcY_w_icAASQFp91JlvDjGaYuQag>
    <xmx:S5c4aVuk0Cuc2rIi2SGLzIPhkxWU7p6BU4tabwJmLHpkFQp_PZsFUw>
    <xmx:S5c4aU9c0e7qRP-0vS72S8OJcvuZnK3DFkgVkmiraJ8RKuOJ-thSvQ>
    <xmx:S5c4aWxS0ftzEajY1FNHg5D41zDEYB9S59jkBwP614yCzt8jOwoQtg>
    <xmx:S5c4aWN0AFvhjWRlkLfdvvM6JwFt4GjIno7VJEG9VywON9RvgacLWwT2>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 16:40:25 -0500 (EST)
Date: Wed, 10 Dec 2025 08:41:21 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>
cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Nicholas Piggin <npiggin@gmail.com>, Cedar Maxwell <cedarmaxwell@mac.com>, 
    Stan Johnson <userm57@yahoo.com>, 
    "Dr. David Alan Gilbert" <linux@treblig.org>, 
    Benjamin Herrenschmidt <benh@kernel.crashing.org>, stable@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: Add reloc_offset() to font bitmap pointer
 used for bootx_printf()
In-Reply-To: <697723f8-ab0b-4cc4-9e83-ea710f62951a@csgroup.eu>
Message-ID: <3ff1f917-fad4-c914-1ffc-58a5d8185368@linux-m68k.org>
References: <22b3b247425a052b079ab84da926706b3702c2c7.1762731022.git.fthain@linux-m68k.org> <697723f8-ab0b-4cc4-9e83-ea710f62951a@csgroup.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


I noticed that this bug fix did not get included in the 'powerpc-6.19-1' 
pull last week. Was there a reason for that?

On Wed, 12 Nov 2025, Christophe Leroy wrote:

> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 

