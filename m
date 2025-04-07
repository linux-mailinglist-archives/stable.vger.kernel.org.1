Return-Path: <stable+bounces-128451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B4BA7D552
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C84AA7A67AA
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 07:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F81226CF7;
	Mon,  7 Apr 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="as0h40Zu"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE07E110;
	Mon,  7 Apr 2025 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010142; cv=none; b=GJ+wotDwf5c4Dyansh+rXg3ixhFZEJDpFkvugeUZBCGsuS4nW4xOmaGtjIvhrKWu6Ok9lzedLWHIyvbLyVZiYwZrNk2baNNDjEhuFC27f5YgXphRuX8UccItoDhZ173ekS4vZbsTdf0Fnvd5fiEIR54dATs+TgAN7fIWVYkMmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010142; c=relaxed/simple;
	bh=aQ7iYPrq4QvlgGy479lCdbFD4GliSrawEUKwsY+qUq8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B5/dCFNFuhO4EH41OReyyzKPKYaEBsfXANzNPpw5f0dYEE2MtNw/9zucoetH6bvFHnip2O/SYsbdmtxgLQpcmH0fDDAxunyITw7QBfAnBi7E5AfYmqCslvHJIROWsmuZrswDm4rZNRrAZWi9otLpqIb16QLZ7RlNCiScX7YXJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=as0h40Zu; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 280D64435A;
	Mon,  7 Apr 2025 07:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744010131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RR6Vb2iTyv3dXZvUGGbsU58gUoBeCe3GxMcX61ZGlo=;
	b=as0h40Zu+O3W8REOl2cQ0C7/zoDWfF5yaKo8jfk4K2gmIVMUQvBUXKBHzZLOHi7L0hsIqZ
	GeBzVu5fh3Fqu3hZ9pRtcsrXvOIggI0c5xGoNpa51NzTjrGxK3eYWwpvsYxx7eN9+s3Pqo
	7gcVKpLAdCRm8+3blB7sIvITGANh9LuStOMmG1TVXHftesV2bww/xedY42t6VbiUCK6O1N
	vFfGhRsJJGw03jll/84S3sB+5sNYteNCX3MVfT3qzl0o8Ooq1fcMeAlEks6aVIqF6N22rg
	EF2uqvQHMJg6y8KorEgMl+sM/0jETZ733TAitwOQSHkPMRyIEh9tsgrsQaOqeQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250402031643.3025-1-vulab@iscas.ac.cn>
References: <20250402031643.3025-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: inftlcore: Add error check for inftl_read_oob()
Message-Id: <174401013001.998658.2380032607138097943.b4-ty@bootlin.com>
Date: Mon, 07 Apr 2025 09:15:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeelvddrudekgedruddtkedrfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrfedphhgvlhhopegludelvddrudeikedruddruddtiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepvhhulhgrsgesihhstggrshdrrggtrdgtnhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghru
 gesnhhougdrrght
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 02 Apr 2025 11:16:43 +0800, Wentao Liang wrote:
> In INFTL_findwriteunit(), the return value of inftl_read_oob()
> need to be checked. A proper implementation can be
> found in INFTL_deleteblock(). The status will be set as
> SECTOR_IGNORE to break from the while-loop correctly
> if the inftl_read_oob() fails.
> 
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: inftlcore: Add error check for inftl_read_oob()
      commit: d027951dc85cb2e15924c980dc22a6754d100c7c

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


