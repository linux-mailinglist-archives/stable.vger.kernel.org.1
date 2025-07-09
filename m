Return-Path: <stable+bounces-161415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0638AFE592
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1285B3B2A23
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10128B7E9;
	Wed,  9 Jul 2025 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eSSLmmYt"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6283C28BA96
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056347; cv=none; b=fEVGWhiKKsfOp5nMS+te6aoaV24WKkf7XRSb+bgYNV3J8YmCQN2xvqvnWWZ6pF7/UIlBMn8Plf/GFTy+m317Q6TpRK4udsaj9N6bwTVlmNESrKYgsXZ9seCytfOkB5jeU49FNW7Ej84seLVDeNDtEqm9PAar3PchgKyOoZ9+fjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056347; c=relaxed/simple;
	bh=WFfrpLOufmafkRH/p5lsE+zghoesfuTtMOANL1BlGyw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From; b=kHOmgCdoGxriw5i19RLzVz+8id1UqZEoFjtVMiWTjqfWmHtxODACLt0pcCb66JgxPCEsssm2hsg98cpr7gkKcj4l67zHqyVvpmxcZ3Fz+ENg7MSMK3cJKv6gzPG7lmCdc52SRjb45SfX8qTyYRlkaSNIaDLLjws8X5TF5u3OHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eSSLmmYt; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 126D11FD35;
	Wed,  9 Jul 2025 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752056342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WFfrpLOufmafkRH/p5lsE+zghoesfuTtMOANL1BlGyw=;
	b=eSSLmmYtBeylkd2ZmGCi1QzAVouo6HUCYmOKl0/b8r1V/GlGJFNi8c7r1KKttUeKKxvDRV
	Z/lL9DiuZS4grwHbc7cPq1aBRzp8wMAnP9VMcnHejopP/XsA66lVNvOepVz8IbTM2/5hU+
	HWrYk7z1h98Sm+Z6sULWCWVd+Vl4icvyF8mjIltnUk+DCHd1FHMfXWgdO6ZlDN18ZKdRs7
	CY0qY1euHCdoxHO1A5SS7Mtq+vFrUSDIMocn4iMiRaj1dX9PUHdfQp1mebRhgUyYzACyyi
	sHhQoDs7qXYWIDUrrueVnowmxf1kdRDEuqaVvqUwhK5Bm9PPDwlHxkul3XKpOA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 12:19:01 +0200
Message-Id: <DB7G4ZS920XB.1I7M44B53YY6Y@bootlin.com>
To: <stable@vger.kernel.org>
Subject: Backport perf makefile fix to linux-6.6.y
Cc: <luca.ceresoli@bootlin.com>, <olivier.benjamin@bootlin.com>,
 <thomas.petazzoni@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpegggfgtfffkvffuvefhofesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejkeduteduudektdfgvefgfeetfeeuhfeutdekvdffgeejveegtdefhfeuheeitdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemhegvsgeimeduvddtudemrghfugeimeeffhgssgemrggutdekmeekfhelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmeehvggsieemuddvtddumegrfhguieemfehfsggsmegrugdtkeemkehfleeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepohhlihhvihgvrhdrsggvnhhjrghmihhnsegsohhothhlihhnrdgto
 hhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Hello stable team,

could you please backport commit 440cf77625e3 ("perf: build: Setup
PKG_CONFIG_LIBDIR for cross compilation") to linux-6.6.y ?

Its absence prevents some people from building the perf tool in cross-compi=
le
environment with this kernel. The patch applies cleanly on linux-6.6.y

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

