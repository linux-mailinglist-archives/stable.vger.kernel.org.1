Return-Path: <stable+bounces-2564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE0C7F86DB
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 00:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2A91C20EDB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 23:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA503DB80;
	Fri, 24 Nov 2023 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 8973 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 15:41:32 PST
Received: from 4.mo550.mail-out.ovh.net (4.mo550.mail-out.ovh.net [46.105.76.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C210F6
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 15:41:32 -0800 (PST)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.143.109])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 9276F275E5
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 21:11:57 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-wmx76 (unknown [10.110.208.112])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 225AE1FDEC;
	Fri, 24 Nov 2023 21:11:57 +0000 (UTC)
Received: from RCM-web2.webmail.mail.ovh.net ([176.31.232.109])
	by ghost-submission-6684bf9d7b-wmx76 with ESMTPSA
	id E+cDB50RYWVpxBkAOqy2KQ
	(envelope-from <rafal@milecki.pl>); Fri, 24 Nov 2023 21:11:57 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Nov 2023 22:11:56 +0100
From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org, Michael
 Walle <michael@walle.cc>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] nvmem: Do not expect fixed layouts to grab a layout
 driver
In-Reply-To: <20231124193814.360552-1-miquel.raynal@bootlin.com>
References: <20231124193814.360552-1-miquel.raynal@bootlin.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <1d895bbb7e892507195db9ab81f88f54@milecki.pl>
X-Sender: rafal@milecki.pl
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1269170673624656716
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudehhedgudegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnheptdekvedtkeegteefheeifefhueetvedvvddvudekgfeihfdufefgleduheelgfevnecuffhomhgrihhnpehophgvnhifrhhtrdhorhhgnecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipddujeeirdefuddrvdefvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedtpdhmohguvgepshhmthhpohhuth

On 2023-11-24 20:38, Miquel Raynal wrote:
> Two series lived in parallel for some time, which led to this 
> situation:
> - The nvmem-layout container is used for dynamic layouts
> - We now expect fixed layouts to also use the nvmem-layout container 
> but
> this does not require any additional driver, the support is built-in 
> the
> nvmem core.
> 
> Ensure we don't refuse to probe for wrong reasons.

I pushed a pretty much identical patch to OpenWrt (I just forgot
of_node_put()): commit 61f674df4f0c ("kernel: nvmem: fix "fixed-layout"
& support "mac-base""):
https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=61f674df4f0ce2b1c53b0b7f6b0c1d03d99838c0

It's in use since July and seems to do the trick just fine.

Thanks for submitting this fix.


> Fixes: 27f699e578b1 ("nvmem: core: add support for fixed cells 
> *layout*")
> Cc: stable@vger.kernel.org
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Tested-by: Rafał Miłecki <rafal@milecki.pl>

-- 
Rafał Miłecki

