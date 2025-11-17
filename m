Return-Path: <stable+bounces-194950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19703C63A39
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 11:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D69F64E32A7
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06DF30DD2A;
	Mon, 17 Nov 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="acRHh+hS"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC127F727;
	Mon, 17 Nov 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376891; cv=none; b=iLQelnwRd8QoFdMhZ4uRAxDK/zKrOZCdPBQgvYy5NQf8pp0mrK+MiVyKFyDUTLUJGqjcGIKwjLT4cU2qAcgjiYJOkAitudlP2ghAcIjjdHGOMvncOqZT8BCFdt/XJmTiyzC19Z664LMj51OOs8z9UflLj+gYXeHHN3Xu0t+9HK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376891; c=relaxed/simple;
	bh=cGY7RSBmIoirXpygWNT5BXgLCPu3G1wTc5aQXbjfuTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOTcCyXJYGAN/ow3nZ91/G9XhY9oV/NaiAb1+7+Ox2n41Gk9pWvUuN5t0tp0tZSewO13Ho2A2F+3kjnTCHqv97syt4mpXSHu3NZUD3cvEaZxqiaR/atodUsuLJmRah0VM2QS4uxbOLvOOFPm1shejUQcd4CeZoqnJyygCFQRDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=acRHh+hS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6D5E61A1A1C;
	Mon, 17 Nov 2025 10:54:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3FF85606B9;
	Mon, 17 Nov 2025 10:54:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEF9310371C4A;
	Mon, 17 Nov 2025 11:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763376883; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mMectNnRPab7BhFVYKDAdCzLnLVlb2FUpd/eKC07nLU=;
	b=acRHh+hSRhww8tgmKa/NtJk5CI7EcOPC/Oqw8ciXO9z3nMeuawl1c1sVuUTNXbZVpqAUYy
	ctGW9kyePbWaev3o2znY9xjvH1OFmVxjbLBMcVZ8udGlzyOekkObvjCmrnU61A0YuOr1wq
	lw6rK3mbKg6R3z8TYXG/eq9YpDbPXqm67DsNMRqcwb+1n/j8HOPGacvBeMyMrZn2ylxNmW
	0Scm9bQhKdIXwHgP5LlaR6tvTYaz6IY0lB0Dx96pbWwOuJpkhJJbZvnwCMq40B/jq0m31U
	eE3ucWFUL6cpc2fqZOL6ssMgCwrxuCFCQaKfID7LzabBN41kg3XDWIMBEady3A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mtd: mtdpart: ignore error -ENOENT from parsers on subpartitions
Date: Mon, 17 Nov 2025 11:54:33 +0100
Message-ID: <176337662462.1740091.7879288362167135698.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109115247.15448-1-ansuelsmth@gmail.com>
References: <20251109115247.15448-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 09 Nov 2025 12:52:44 +0100, Christian Marangi wrote:
> Commit 5c2f7727d437 ("mtd: mtdpart: check for subpartitions parsing
> result") introduced some kind of regression with parser on subpartitions
> where if a parser emits an error then the entire parsing process from the
> upper parser fails and partitions are deleted.
> 
> Not checking for error in subpartitions was originally intended as
> special parser can emit error also in the case of the partition not
> correctly init (for example a wiped partition) or special case where the
> partition should be skipped due to some ENV variables externally
> provided (from bootloader for example)
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: mtdpart: ignore error -ENOENT from parsers on subpartitions
      commit: 64ef5f454e167bb66cf70104f033c3d71e6ef9c0

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

