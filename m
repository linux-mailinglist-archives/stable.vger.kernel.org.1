Return-Path: <stable+bounces-203119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D37ACD21B4
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 23:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB7C73062E5B
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6EE285C80;
	Fri, 19 Dec 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="IRocCq/H"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9A218821;
	Fri, 19 Dec 2025 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766183519; cv=none; b=WU75L0uwZoxEZgGcUSJaXfEdjbEXQQ5X+g91eI4YSLmYiJ/EvzsoPF5wG85wfIDOrwQ4+IT/qWLJUfOg+pS3yG6z3qzMfodhQ4ySvEMdS9fUEYTp6Fj3fnoM7MMlmX3OQAp5jKxN1gXMdnwJQ3v/+1Ertknjgg61T/M3hIUFrVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766183519; c=relaxed/simple;
	bh=qeYnj+S0ndqZd6ZRojopi41i1/4VdFF72Q0iMnnqDec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wl4gjlBI+IlPTbGldhhqZ8BJKrBICRUvEfJco78G+XUv/s7mJSlBB6FmC0k58IcGfSL6EE+rHeKMFjudd/8QCT4xR7PnwI37qsp7VTrSohJ/3/hXgNmnUT0V8XHqmpYwk5IuFFKdKar1Uu3ZLthDbSfT48Qiv7VZkd9AoBuZB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=IRocCq/H; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766183515; x=1766788315; i=deller@gmx.de;
	bh=z/IjZa9MT5WNN4OOGYi9+eQvnYEcXSFVuBCQJbfmU2E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IRocCq/HUpuo7xAu5HBpAm9wtjsCxmZX4j004TVVcLxnfwKC3b1fCGnnh3t8vkK0
	 XUU/7iUMx9FvgtBriPGTyteMxHfyLx/E0v6bhxDwg/3MJTfzWFlWqeX19A+yItQ+6
	 J4kErbjmbmF/TTmKaKrT0eB8JADei4wskNgxxcn92AQPonjKyNOEklM9GHfGIgw7H
	 bfGt9w50wv1duSAFe45ETrjW93s/TycHCiI2Jbo07cbh945bWyQjRmWv6qmiABOqQ
	 HVD7tbmZKNpkLDrxADh6EZQe0H3uRaroCLMsoN9ERsu2I6vaqRWoGG1nQCT8H5ULD
	 itkxgRkYsf1NhW/YxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.152]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6Mt-1w63lR43pz-00evyB; Fri, 19
 Dec 2025 23:31:55 +0100
Message-ID: <d31d2814-4c3e-48e9-b0cc-e8a11d55d4f9@gmx.de>
Date: Fri, 19 Dec 2025 23:31:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: kernel: replace kfree() with put_device() in
 create_tree_node()
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
 James.Bottomley@HansenPartnership.com, willy@infradead.org
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251219131926.623330-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251219131926.623330-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TeqsoBI9LrrQGVOb9UdGP9PUSNGqvaT1B0jWq7TscNoTSvbvd+L
 ItXdsRIDE6ISGEAHFmP3/lsV3w8Rxp/bfj9kg6iHFpoXwYD4aMH/MzoBKF2LITZLLJnO9dY
 KInISnM769tpeYhBW9GYSFvOGrrvA8KV6XD6sxmBZjaj2OqG2fp/pQ5kOWSkMoYfjG0ZTi5
 FkSsOFfzqrlDvBwk+tRGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IjTbmDdd3Pg=;XkpiOMLWqTlj5w2E63D1H+drcM3
 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
 pzU48aYs=

On 12/19/25 14:19, Haoxiang Li wrote:
> If device_register() fails, put_device() is the correct way to
> drop the device reference.
>=20
> Found by code review.
>=20
> Fixes: 1070c9655b90 ("[PA-RISC] Fix must_check warnings in drivers.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>   arch/parisc/kernel/drivers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied to parisc git tree.

Thanks!
Helge

