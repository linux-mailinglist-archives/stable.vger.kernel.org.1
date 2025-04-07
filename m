Return-Path: <stable+bounces-128450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE8A7D560
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6F63BBB3F
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 07:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D4E226193;
	Mon,  7 Apr 2025 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BGFezA8n"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4021D3D1;
	Mon,  7 Apr 2025 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010141; cv=none; b=KAC60OExMyPbzC8gJrHs5WcPfSlIYUojKBAi54CT+oNIAvcI+zEX6lhcC0JS+cg8ykJprawPaNfxyDUVmyJdsQACOl7G0Pt8cBc92dAjys/qp6VwSiHBscxdcAJFeeMBmvHRGx8GYPCrCtsdPIFbwdB2cyf9rLzSda8EMXc6CIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010141; c=relaxed/simple;
	bh=f6FP6yoJSx0/Rb4wSm5gI2FsFZ0Wdrxkdi/BLO5s/f8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UV42HezCSXIBJHTEsHlLvOs47YNAE7bACU1x8TBUZIHtlbCVDcu2X+99xBdutTjy27mbTkjR9g3BUszs9Xca4xCcKjkXBU6vYATVUNdQZzic7sn4PKy86DqdwW3CgkVCQ5otW8Ih4eUzZubi7wHtHwKNfpwyfkp9WGpFpcgncYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BGFezA8n; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E592544333;
	Mon,  7 Apr 2025 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744010132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mq0cKrEu/AdyuV9FD6tDt/Sm8vJBsOcghCm2NXRd/A=;
	b=BGFezA8nPRx3KzbnQi283cljlKc89nvrvF7aAJBisnkUE3/V+XL3jErPyZ9oIIlOhJSZ22
	JZ1kMDo7bWcSrBkeQ521ZuZOpGXTrOoLS17CWZ39A1shsSwVx850I2QM0DbI2Q7tX3A4L3
	p86dAZuB55w5wAaXC5dRg5NBlOeQvRXUsDXNbHTyCMvYHShkrdg6bEckMbhyjztYeCTyNu
	0kwerge2E/E6HesJ0JIuReEaU1EG3NbrNWrDoRnUwnU9zI6Gov77xVzBKev9MqfL0jhET2
	JZypXkMYKoe77OzWdof5HDDPVKf/8PF8eZ18L7SJUO/NhepFURaE145MUj5+gQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: maximlevitsky@gmail.com, richard@nod.at, vigneshr@ti.com, 
 Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 stable@vger.kernel.org
In-Reply-To: <20250402075624.3261-1-vulab@iscas.ac.cn>
References: <20250402075624.3261-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: rawnand: Add status chack in r852_ready()
Message-Id: <174401013184.998658.14198639159193393153.b4-ty@bootlin.com>
Date: Mon, 07 Apr 2025 09:15:31 +0200
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeelvddrudekgedruddtkedrfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrfedphhgvlhhopegludelvddrudeikedruddruddtiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepvhhulhgrsgesihhstggrshdrrggtrdgtnhdprhgtphhtthhopehmrgigihhmlhgvvhhithhskhihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvl
 hesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrth
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 02 Apr 2025 15:56:23 +0800, Wentao Liang wrote:
> In r852_ready(), the dev get from r852_get_dev() need to be checked.
> An unstable device should not be ready. A proper implementation can
> be found in r852_read_byte(). Add a status check and return 0 when it is
> unstable.
> 
> 

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: Add status chack in r852_ready()
      commit: b79fe1829975556854665258cf4d2476784a89db

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


