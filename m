Return-Path: <stable+bounces-191980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B873C27A6A
	for <lists+stable@lfdr.de>; Sat, 01 Nov 2025 10:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AF8401689
	for <lists+stable@lfdr.de>; Sat,  1 Nov 2025 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D8F230D14;
	Sat,  1 Nov 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GONH59AQ"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450FE1386C9
	for <stable@vger.kernel.org>; Sat,  1 Nov 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761987694; cv=none; b=MwDsSj2hzInvi8G+Nb9E2fc/bSau37pbKX/Md+zmM4236C90tcbnQvyId7kICV2tZJP8hUu4Dr93lu+tDOSLIIU+D3CjrovUhQsWwy76Cf1+7TciVbGeRMCiDBNcOD3dNNndAclBP7V7ogQiQggyo88MEV/QDYM9bimQwjNxUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761987694; c=relaxed/simple;
	bh=OkmXDH+8s6o7nmZLFLfbxEPfQIoBqLBaQVRkKTvwLKQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=PYnNoaxDRjtXPH/w/N7/CJzNll9GzK+6RywSDbK+IeK98sggn9Wf4NfbcQQTl7R50OMTZDBNs0QgFvraOuddlJ2vGFouap0PhjVerd1cCrH05v/T/IZ70gkR9gCmEkEIx33DOnGQ9NWRyzlscov8ckubpUoC2mcqZ/zFJd7IJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GONH59AQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DC51DC0E96D
	for <stable@vger.kernel.org>; Sat,  1 Nov 2025 09:01:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41FE36070B;
	Sat,  1 Nov 2025 09:01:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA66611818085;
	Sat,  1 Nov 2025 10:01:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761987689; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/UrAtR9rvQYKTngRXxxUvdWSHmw552fuZKvvT/tBqRQ=;
	b=GONH59AQL9jg/3O0Ac/lBXUZSQvQkmUSwXYoEfljuoGCyNeDxW0NjhAwevfsfmP+3bUAUD
	Zm7cOWjtHnu1isTTJyHHRC7DlRdGU4YJIsMjywl5JjIYFUFMJjcCI4B+gGFZu288INfJE3
	epFERrayODOEEhFnBS/XLBD/Hbgkj9mLZeQQPxydZkL2pJhp8HCoJnbCKDqOs3dmxnQtNU
	PxYbg4naK4j7BvskbnVvb9VvRNkYEwJxseeuIl5mMX26pEGE3gu6TOVYwzCQy9ETImJMM9
	1wh6OTYkpCyrAZo/K2rpYdfhzBfts0MwVaZKbPP/TdPG4VJsEgRJs7TOht+VGA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Nov 2025 10:01:27 +0100
Message-Id: <DDX8I8XRC06M.2BIY9ACNMI9ZT@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH AUTOSEL 6.17-5.4] net: macb: avoid dealing with
 endianness in macb_set_hwaddr()
Cc: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Sean Anderson"
 <sean.anderson@linux.dev>, "Simon Horman" <horms@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, <nicolas.ferre@microchip.com>,
 <claudiu.beznea@tuxon.dev>
To: "Sasha Levin" <sashal@kernel.org>, <patches@lists.linux.dev>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251025160905.3857885-1-sashal@kernel.org>
 <20251025160905.3857885-63-sashal@kernel.org>
In-Reply-To: <20251025160905.3857885-63-sashal@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Sasha & other stable maintainers,

On Sat Oct 25, 2025 at 5:54 PM CEST, Sasha Levin wrote:
> From: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> [ Upstream commit 70a5ce8bc94545ba0fb47b2498bfb12de2132f4d ]
>
> bp->dev->dev_addr is of type `unsigned char *`. Casting it to a u32
> pointer and dereferencing implies dealing manually with endianness,
> which is error-prone.
>
> Replace by calls to get_unaligned_le32|le16() helpers.
>
> This was found using sparse:
>    =E2=9F=A9 make C=3D2 drivers/net/ethernet/cadence/macb_main.o
>    warning: incorrect type in assignment (different base types)
>       expected unsigned int [usertype] bottom
>       got restricted __le32 [usertype]
>    warning: incorrect type in assignment (different base types)
>       expected unsigned short [usertype] top
>       got restricted __le16 [usertype]
>    ...
>
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://patch.msgid.link/20250923-macb-fixes-v6-5-772d655cdeb6@boot=
lin.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I know about the Fixes trailer and therefore include it whenever I know
my patch is stable-worthy. Are there any trailers to mention that a
given patch isn't stable material? If not, would you consider adding it?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


