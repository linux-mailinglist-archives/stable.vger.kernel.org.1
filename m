Return-Path: <stable+bounces-124839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D069A67967
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A92885DD4
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10330199384;
	Tue, 18 Mar 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ThcD7NNC"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2520E033
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315024; cv=none; b=DRadHVU/DCfbT/yevnXJWRsjePZ9j4q+AD1eMVoxTiqzaedjzLIVCRqf7eEWQco/JXqJZETSNanfXnrh/tMTfUAiKnCmW9ft8nkuGZxt6vo9HSKptH9gngL64i5X2cBq2oXjFJjCQR+uetocJDgTKYzxKMJWd2rxxJQ8M5xZj58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315024; c=relaxed/simple;
	bh=G/kkCZCSAhcWPghG/Sg774hs1enI8rfMazxc/h7NrWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IDBr07FZaofHhCq00Y0tMnwmpHYx183IlQIcJI3NyV0M+uBMgl7WbXAw9sIM+nObYfM+eUZTJPnk4EH6j1YRLADz0ZIbV0MyYyEGJj6ivgD24nGuOv3DgLRpladn4P4Q6pYeHqkhkWsTjq+5+GbmYawgw+ZpwcOFZCWsKY8n/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ThcD7NNC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5238A442BF;
	Tue, 18 Mar 2025 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742315021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p45NB3sSky+nUbHHIqs/ofey6rSOVyyWpJL2ZVNm1Lc=;
	b=ThcD7NNCKtA7FsmcGaUbM7hY6Y3as25mezPe2v/LIp3PRbAgP+VFdhxD1XFMokygS9bXM+
	fMU7FOJ3YRf66UXJxeeJS2edC7PCxsHjiisRvTl9/DlZldkKBaG5rUU8q9lubvLIxQ8M3I
	vs1gD90DOwIBEGjbIGCC1V1pMzWrpuTQMbRLFX8NnUDp5JGjOMXzBdxAJ+3nYptGZDDE38
	zHf3RlV6Nl/LDpYylQYWGxP91mk7Xi3DXashjwMSnh2bqUR4bugO40u0uzdThol9u2yczS
	kzvmXGFqZUhydpCdP/k8IUOa5+/o49kmUQU7CaJkSQM5HdrIOPuUQwNfEM+2lQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Michael Walle <michael@walle.cc>,  linux-mtd@lists.infradead.org,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: Fix a kdoc comment
In-Reply-To: <174231458436.979692.11846172650554767394.b4-ty@bootlin.com>
	(Miquel Raynal's message of "Tue, 18 Mar 2025 17:17:09 +0100")
References: <20250305194955.2508652-1-miquel.raynal@bootlin.com>
	<174231458436.979692.11846172650554767394.b4-ty@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 17:23:37 +0100
Message-ID: <87y0x25muu.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhts
 hdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 18/03/2025 at 17:17:09 +01, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> On Wed, 05 Mar 2025 20:49:55 +0100, Miquel Raynal wrote:
>> The max_bad_eraseblocks_per_lun member of nand_device obviously
>> describes a number of *maximum* number of bad eraseblocks per LUN.
>>=20
>> Fix this obvious typo.
>>=20
>>=20
>
> Applied to nand/next after fixing the Cc stable line as advised by
> Turod, thanks!

Tudor*, sorry for the typo (:

>
> [1/1] mtd: nand: Fix a kdoc comment
>       commit: ca8cbbb2be8f906d9602a6e4324f8adf279e9cc2
>
> Kind regards,
> Miqu=C3=A8l

