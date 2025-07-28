Return-Path: <stable+bounces-164899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DFCB138B6
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2771711C2
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFD255F27;
	Mon, 28 Jul 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gvl8upK1"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502B1FBE9B;
	Mon, 28 Jul 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697833; cv=none; b=p5ZtbmVx3P7qc07X4gSpzrEajsrBrfdrITFj7ofokbuRgnKkTWJmaliI2zzPMbrWES4AHJsWW8kIMtNRe368+oUSHG3/Ly9SXNIJ5tAj83VPgb+8CBpon+JLSBIq4Unc0Fj0A1qHpVfuSmpaGykbGOZwEYkS//mvHUPGCFthbPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697833; c=relaxed/simple;
	bh=++iwmbXGL40I9Dre1hXT3L65MKPkgLEo7jWhER6znfI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DKJA8YYFhH7MWmGc+SFzQ2YhJdzGM8iEAno+InuvlxWWJ0HEUgJLHZCZNhJVN340GmirjJE5i228T09Ke95US66pLWru9c+oMP5TlYo4m9sXsQbUHhZLTI+6h5CNtxpsG4ivbnx1DQtdp/59yh2BxS/9QVX43pUnul/P1LR7wA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gvl8upK1; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B535143295;
	Mon, 28 Jul 2025 10:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tB/giJamLwrlrWdb+yV4MiXhuFOprryUVJQyo9azviI=;
	b=Gvl8upK1SXANWVdQ+RKqeWjUJwzaYa1IC7pSWxIHaT+PJiZxljCfZp8obsC2xIoS0hTWZp
	t64TYwVMiSipYJV+i5zLQUb/RANjGYc3Tdk8ZVHztV501TnBPfu5Mo6HvzoCqODZYqcZ3Z
	qSC11MduGjowoht84bSVJd6k3DyIcQDWLNQeq0Xe5MTXKoP04DY3T68TzoWEYMHJvuUYs/
	aDb492zuOm7qam46TkpgGTPMvGKlOdxLzFHob8xtjmVKkiO2T5BKKfW2ospCLGPO3uen4X
	ETVav/UWaPfAkKqeEDgXF6XIrGxA2ELKrMAMAMYoyxhRCgUWLYqlhz9WWWhlFQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Viresh Kumar <vireshk@kernel.org>, 
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
 Vipin Kumar <vipin.kumar@st.com>, 
 David Woodhouse <David.Woodhouse@intel.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707073941.22407-2-fourier.thomas@gmail.com>
References: <20250707073941.22407-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH v3] mtd: rawnand: fsmc: Add missing check after DMA map
Message-Id: <175369782769.102528.246537562442649222.b4-ty@bootlin.com>
Date: Mon, 28 Jul 2025 12:17:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehvihhpihhnrdhkuhhmrghrsehsthdrtghomhdprhgtphhtthhopeffrghvihgurdghohhoughhohhushgvsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhitghhr
 ghrugesnhhougdrrghtpdhrtghpthhtohepvhhirhgvshhhkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrthgvmhdrsghithihuhhtshhkihihsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepfhhouhhrihgvrhdrthhhohhmrghssehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 07 Jul 2025 09:39:37 +0200, Thomas Fourier wrote:
> The DMA map functions can fail and should be tested for errors.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: rawnand: fsmc: Add missing check after DMA map
      commit: 7c9e7bdd663b238f32c9354938ff65d023f13daf

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


