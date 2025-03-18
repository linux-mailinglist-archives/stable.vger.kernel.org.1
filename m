Return-Path: <stable+bounces-124835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C9A67901
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB955189BBC6
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69F2101B7;
	Tue, 18 Mar 2025 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IcZtxT6M"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57967211A15
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314644; cv=none; b=NSio8zqgXwamyMTsFP/Lvz9HlZ6Gbk88GERf8dFO0xPwrFJBiTorvG2qJ3J+VSUHd3JknLY3uMmMJdTfE2vH1bIdsIeUTusghWiOFp4NXOjVmXynrwOEvHOk7x5pzT8kpuGJ6ObUfvI4C4XvDIZTHuEo8rzQaBV/dK4q32A/QJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314644; c=relaxed/simple;
	bh=6swj7PUyWPMDMlPdyuRo5lz/MHiQCIIPiQcx75r3WGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRJuBqfVVLi1hk4ckEFBcYeCT/3OqGfkT7WIPFtJMBMh1+V1K+7A/tGj0tEzlLFSuLSJ9ncwF7dCvXvkXZxY9CLBptuweMjkT9ZQSmN1LPGXQJZQHn9zSZaJPrG1GXe+r024Z+yt2yqd+70AyMwyc8LijvgxKifalbVgh+SdIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IcZtxT6M; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BE2C441C1;
	Tue, 18 Mar 2025 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742314631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVk+xYOAI24ssZ2g1HmfcjpWNVsVeIoJttJ9AIMmxhk=;
	b=IcZtxT6Magpaqd3Ff644q78D5Ny303/ipNwNNsIryS6a02MG3HGAppDF0x9kp2sM9g69RH
	/b+Lflpx+y99vJiOvkgfnHHrtzwfUhsSZJqAW5eV/mvXKn70BUtxkdIK36szKVN2BuIq3b
	irBuhuBzAZCy+chmQ63moM5CLUH8K4KDR9/xjbPk8mJXZg1c7w3vslVM+JeCMm6q5FBcna
	TykLaVh+7LuaHe89JeyIsb/LIUhm9r0QfG4aU6ENdqIyDQn9wHteWhFw+UsAQQOZliCSdk
	IFG1xO7Q0lfEQbpEXRi+dQj2mEhaHBRgcvrnSmW/EP8f3/P4yzj5f01wEKA/hw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: Fix a kdoc comment
Date: Tue, 18 Mar 2025 17:17:09 +0100
Message-ID: <174231458436.979692.11846172650554767394.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305194955.2508652-1-miquel.raynal@bootlin.com>
References: <20250305194955.2508652-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeefuefgvdfffefhudfhteffgfeiieduueegffdvhedvvdeludejjeevvdfgtdevgfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhifrdhsthgvphhhrghngihprdhlohgtrghlpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlseifrghllhgvrdgttgdprhgtphhtthhopehlihhnuhigq
 dhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 05 Mar 2025 20:49:55 +0100, Miquel Raynal wrote:
> The max_bad_eraseblocks_per_lun member of nand_device obviously
> describes a number of *maximum* number of bad eraseblocks per LUN.
> 
> Fix this obvious typo.
> 
> 

Applied to nand/next after fixing the Cc stable line as advised by
Turod, thanks!

[1/1] mtd: nand: Fix a kdoc comment
      commit: ca8cbbb2be8f906d9602a6e4324f8adf279e9cc2

Kind regards,
Miquèl

