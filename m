Return-Path: <stable+bounces-5432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF2380CC2E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1D71C20AB7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4364A47A6C;
	Mon, 11 Dec 2023 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s88WWIed";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y1ZfO36D"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131744ED0;
	Mon, 11 Dec 2023 05:57:53 -0800 (PST)
Date: Mon, 11 Dec 2023 14:57:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702303071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OtPxZyAIr0q83FqrgnW8CYSUeZdYcDZKkr11TEUXgqA=;
	b=s88WWIed5p6L5JcEQ/6gDQ2ADsNQdVFa5zQ9DxTsSn8kHBjUfI8PG7QdHjl6o7h15GIiCP
	qlExyefE+anTl/jrQ6zkQiFTnGGZ0nIiZD4+gY0o6cV2YG5KIS0COsWq+nz9ZRq9UDuFIB
	brmGahG8dkRaJUjhtph6ut/Ysq66wGfjXvQIMLxX2HTjxSkziasXSjhIjY+le2eF2tfU0m
	9dN1LPFf2oNGIuU7Ju09/Sbup9npASkOAfM7KmkZNX98gyMbrGNZGqbQaJe4thK9UuEKmO
	KivqoQ8TpOLwc4w8ygDFG7f9B7Ty2lVS4egXittG/CD+tXnN01itv5K0mRUJrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702303071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OtPxZyAIr0q83FqrgnW8CYSUeZdYcDZKkr11TEUXgqA=;
	b=Y1ZfO36DL0bvoLPgjRbH8hoQDThICl2d/0+e4QHrF8t71kuYefcKZhfxiEc+lYm+dpiDPK
	b53MOh73dLtA4LAA==
From: Nam Cao <namcao@linutronix.de>
To: stable@vger.kernel.org
Cc: jiajie.ho@starfivetech.com, palmer@rivosinc.com,
 conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Backport riscv kconfig for v6.6
Message-ID: <20231211145750.7bc2d378@namcao>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Please backport 78a03b9f8e6b ("riscv: Kconfig: Add select ARM_AMBA to
SOC_STARFIVE") to v6.6

Without this, it is not possible to configure the kernel with SPI drivers
for the Visionfive 2 board.

This one depends a1a5f2c88725 ("dmaengine: pl330: rename _start to prevent
build error"), which is already in stable.

It should be backported to v6.1 too, but it does not apply cleanly. So I
will send a patch for that.

Best regards,
Nam

