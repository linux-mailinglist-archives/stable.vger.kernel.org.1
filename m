Return-Path: <stable+bounces-116443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAC7A365B8
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 19:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5205A16A672
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD862690E2;
	Fri, 14 Feb 2025 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rhosxkk1"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EFE14D28C;
	Fri, 14 Feb 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557681; cv=none; b=N74c3ZxHeO330agY5peeuVvbGhw/ZKfAPgwo+PUWPkcfkjgfJogfjt5c1qe7IM+McB4K4spSMmI7CQbH6UESql3Xb8vTWTdalRSpo2LtxoVcqknos3X+P75hCkGBA/nCEeYstxk+dTZGNvpdkV/z1XE61P0P/kv0qxP3GMdd77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557681; c=relaxed/simple;
	bh=zUy8H2TXFgYBHz9VYypM+bAWJmRV/WrtybTJ+h3s1f4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EoG7xYZn3zQc9oVZKRwD7QMUGFQQnGidrhkmNhuiIx6jO6GZRtGwa1TIiUr2Mc5xhOiND1U/ViWn1KcB165hkOGVkkdyFJJQPQFd1BQQRCqV+97tTVr9d6O/sUpt9lzW91hCdFALKod3kHWP/azmLdSTJwvSweRliHZpej4TDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rhosxkk1; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 723364442A;
	Fri, 14 Feb 2025 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739557677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUy8H2TXFgYBHz9VYypM+bAWJmRV/WrtybTJ+h3s1f4=;
	b=Rhosxkk1SMWTYOQ+STvzgixJugox5srvE3afnwNLcfA7raIwFpwbBz00K0LU+BDT2uNAEt
	fATwbXx6zTUNhKBB1vCIVkUV3QQgrrT1mZWl8VqHVyIKmCmG6IyEVAXcyPasW9NqBbC5nt
	aU5xzAsp8LUg0fSQESnrhJOWxdA2+RNtBr+8mNC2qmhl3fu/+4kCCVu3EIswba5pRpHoEC
	EhnWNC6BrFyBwBDY8Za7bGFuWiCqTHqBQJyD5FOlDXAqMruJlIRc/Mg66wKOao9YH9DkAj
	6j3Essbbc/FF7Tn8vBjN+BiM3YNChEV5WlQckgv7HQ6JUhCpKZF+s01x5dlR3w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <richard@nod.at>,  <vigneshr@ti.com>,  <quic_sridsn@quicinc.com>,
  <quic_mdalam@quicinc.com>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <p-mantena@ti.com>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spinand: winbond: Fix oob_layout for W25N01JW
In-Reply-To: <20250213060018.2664518-1-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Thu, 13 Feb 2025 11:30:18 +0530")
References: <20250213060018.2664518-1-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 14 Feb 2025 19:27:56 +0100
Message-ID: <875xlcnzyr.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegvdduleeihfettdfgieevtdffjeeggfefveetudeludekieffhfeiffduvdehffenucffohhmrghinhepfihinhgsohhnugdrtghomhenucfkphepledvrddukeegrdelkedrudeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedrleekrdduieejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepshdqkheisehtihdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhiughsnhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdri
 hhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpqdhmrghnthgvnhgrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Santhosh,

On 13/02/2025 at 11:30:18 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Fix the W25N01JW's oob_layout according to the datasheet. [1]
>
> [1] https://www.winbond.com/hq/product/code-storage-flash-memory/qspinand=
-flash/?__locale=3Den&partNo=3DW25N01JW
>
> Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND =
flash")
> Cc: Sridharan S N <quic_sridsn@quicinc.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

I am sorry this patch does not apply, are you sure you rebased on next?

Can you please fix and resend ?

Thanks,
Miqu=C3=A8l

