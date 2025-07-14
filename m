Return-Path: <stable+bounces-161868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C4B04556
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CAE166F53
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811711A5BA3;
	Mon, 14 Jul 2025 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mail.net header.i=@dev-mail.net header.b="qbtcQfpW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOmasbrm"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7591DE3C8
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510160; cv=none; b=knRzltpajqmctOJIMKfsXVaFpBGY9WvV9FidGLvaO82lJqkpSkIR+gts6uXfFhe2ICTcVqPua4H+GyblkjSYCB3cu9khzJPpMLUxZ/VBPoCdZ5EzXJpFsB0AH5SKh6+NxMysO4Q+16/xvCPXlRCoMOm3SCWZOKlyNadjA8HsujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510160; c=relaxed/simple;
	bh=bav8Kj0Kj5ICDe2azROBf526jpLSAr4kH1AUWPoYazY=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=YmmChyByj7yb6V94g7Qe2zd1BtPv8h+IXUqJIMvvEJZWY3nU4y9YlKBYkEfuEpyMiyrMvsGhbEM/KKouFEGI5ANmbUkAwN8FZHgAG9wLhldP20l/SrAlUOejVDJ8yW5gM/rVZQmw1xeFkQQHKxiqHnOPGM4FTSPvl04j3lS0kw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev-mail.net; spf=pass smtp.mailfrom=dev-mail.net; dkim=pass (2048-bit key) header.d=dev-mail.net header.i=@dev-mail.net header.b=qbtcQfpW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UOmasbrm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev-mail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev-mail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 921CF140005E;
	Mon, 14 Jul 2025 12:22:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 14 Jul 2025 12:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev-mail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1752510157; x=1752596557; bh=o0JWuKS61J+6y1YtXkwC7qWXMI5gm+tQ68M
	Z+Bzs3jY=; b=qbtcQfpWL/qdNuSNn1tblpNBpi9TZBtoy423djnEpd56DZPx19x
	iGsC/Zw+28Z/P0FOK0LDeLK2QhM/B4r9waOKpqjfYNxF80jJqnrWue2cHeL1uzOh
	PdvOlxsGR730hjrQIzWIXoH3jcLaNf+uvM9h03fdEQa8vLOd9awjdDox2Ajnyvc6
	MDGdWIybBtmHc/pI9DRmFCbGHOueYJwnYakP7sDA0JyBMpi+l57d/no5zUiY0g2D
	PW4QXT+c1TgNpqOq9U6R7ntJe73uxPjqGjeF8qwGKIjRGQ/hY5Ooc1zBRLsNK7Hk
	O5T+SlIjindW1X1slJsaB3H2xEvvGvrxgQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752510157; x=
	1752596557; bh=o0JWuKS61J+6y1YtXkwC7qWXMI5gm+tQ68MZ+Bzs3jY=; b=U
	Omasbrm2d5qUGEBU9hwqewBeCH2k3VaHCDIf/cqm4tpRI4AsEYjtQpwtf0BMwcU5
	0qMm+ePq1xyEsQML9dLBzLFEwQIXcezGH03/3SUQRMK0/HE5xcGtOMBj+F8ajgdc
	v4pQkNJlcq8zdcqWkwqu9OTV7VebE8huTzXFAirRy7EA55zmpywWIYuFvhxYAErf
	jzH2Stwkq42m3oOUOlXp9aDVFH/K0hzzHBOCzCmwxiv64q0SShpbylOk/X1aDcnX
	yREpqSQbLnbGJi/4RCGwbJzCC2AHLLvxoFLkp4h2vPhxiCqUJFfNMMGVg8bTx9Ed
	OxRcXHuiWuyjKMGwnvutg==
X-ME-Sender: <xms:zS51aHN0BaSO_N1oChFcMJFFv9sF3DxDIy3zoEImNYwbqXWFE-D6cg>
    <xme:zS51aK5kvLphFsbRu-lKvGPlzvpEbAQWxaWdsOz7TcYscIWDd0n3iZLYP48irUGof
    HnAZFSOhCXbu3XL>
X-ME-Received: <xmr:zS51aIMdqxYM5oz-g4xg6KefIKW47_Wp2WY-fJV78gaYVDd4i0lfKKSMd_Wvag7XLRcABY3fqIYACTWrFkgSiiqsFJmkCazH43VL5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfufhrfhfhvefvjggtgfesthejre
    dttddvjeenucfhrhhomhepphhgnhguuceophhgnhguseguvghvqdhmrghilhdrnhgvtheq
    necuggftrfgrthhtvghrnhepjedtuddvffffhfevueejudeludfggfejjeekheffudejte
    ejfefguedugfejjeefnecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpghhnugesuggvvhdqmh
    grihhlrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:zS51aIn1tw3tTbsxbjHLLviZYDesk_-4huW4flkbUVHSW7SzX93G8g>
    <xmx:zS51aPSYCvitJcULZbbCp4IZsCFe_oD5kWmbx-cCwf0WaeE66-Kdiw>
    <xmx:zS51aEBgXO8JW7PUPI1S9sePRO1fzQZain-FX1c0Nc2tN4WJeKz9hw>
    <xmx:zS51aOT-mAzP_6LWYSMuOIZqoKJ7IopCr-YyNl0XRzscNWNq2nV7WA>
    <xmx:zS51aIxmxf5B8uVk8jHdS5yScfyvvMDvmp5xOAZIr5OIKelAi9E0Hg1T>
Feedback-ID: if6e94526:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 12:22:36 -0400 (EDT)
Message-ID: <cdae477c-6281-4ee0-b635-9c3bab483cbe@dev-mail.net>
Date: Mon, 14 Jul 2025 12:22:36 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION]: fwd: regression in 6.15.5: KVM guest launch FAILSs with
 missing CPU feature error (sbpb, ibpb-brtype)
Content-Language: en-US, es-ES
Reply-To: pgnd@dev-mail.net
References: <a34aef44-75e1-49d7-8210-5269542c1857@dev-mail.net>
From: pgnd <pgnd@dev-mail.net>
Cc: regressions@lists.linux.dev
To: stable@vger.kernel.org
In-Reply-To: <a34aef44-75e1-49d7-8210-5269542c1857@dev-mail.net>
X-Forwarded-Message-Id: <a34aef44-75e1-49d7-8210-5269542c1857@dev-mail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(already submitted @ Fedora; advised to post here to upstream as well)

-------- Forwarded Message --------
Subject: regression in 6.15.5: KVM guest launch FAILSs with missing CPU feature error (sbpb, ibpb-brtype)
Date: Sun, 13 Jul 2025 17:37:57 -0400
From: pgnd <pgnd@dev-mail.net>
Reply-To: pgnd@dev-mail.net
To: kernel@lists.fedoraproject.org

i'm seeing a regression on Fedora 42 kernel 6.15.4 -> 6.15.5 on AMD Ryzen 5 5600G host (x86_64)

kvm guests that launch ok under kernels 6.15.[3,4] fail with the following error when attempting to autostart under 6.15.5:

	internal error: Failed to autostart VM: operation failed: guest CPU doesn't match specification: missing features: sbpb,ibpb-brtype

no changes made to libvirt, qemu, or VM defs between kernel versions.
re-booting to old kernel versions restores expected behavior.

maybe related (?) to recent changes in AMD CPU feature exposure / mitigation handling in kernel 6.15.5?

i've opened a bug:

	https://bugzilla.redhat.com/show_bug.cgi?id=2379784



