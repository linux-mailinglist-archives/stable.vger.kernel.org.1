Return-Path: <stable+bounces-43522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F29D8C1F08
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 09:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3874282479
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD515ECEC;
	Fri, 10 May 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQJW+NYJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5E20309
	for <stable@vger.kernel.org>; Fri, 10 May 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715326570; cv=none; b=fGCSG6ggCspIlpWos9J3AX8PJ57G5qpL3/0uC2C5ntWZMb1A731vQR6btMI8tKfZZinMpaxUrVwJeiMXffVQ3nuKdL1OHfLRHwcIbMQL96YrAoLdDhIg/6wMDSyFDj4eMHr2wuf6FcRCZbNtB9mMazuHtxj/JQPdzKZmYewywDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715326570; c=relaxed/simple;
	bh=x2MQTy7jJXp8aNGjPGKcwH2APTrS6jTOwD8GKqXibOI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pUV6DRk7VGtAhocCJDUG02VJmlwfLvKs+2Qgib+hJEKtQbHgAr7RsDE/TkE5zGYjZxWqUf3q2lzKgUY0ZtbIDsnyLKtycdYsYhAH2GNGMLa83ZeElf7usco29vq05MsI2x1tXSSmTiA7RKqY4eFWJesHt0r+T/xa/8lxQgNrvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQJW+NYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F234CC113CC
	for <stable@vger.kernel.org>; Fri, 10 May 2024 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715326569;
	bh=x2MQTy7jJXp8aNGjPGKcwH2APTrS6jTOwD8GKqXibOI=;
	h=Date:From:To:Subject:From;
	b=vQJW+NYJSStLW5MmVimoIKVVYZJX3zDmdf71okBD74H5Smg8TdxOfo0X4xdRm5s0h
	 6a9IG8UHmVJdiu7KSJt5erJPh8mgzTAp3TbmJKOeOLjJjP3Q/6NLQKJukz7KpYsnDr
	 mgg7uvDkpMa7cK0nbM30U0LImlizxxu9f4udLp8MVY1lrIoNILYy1O2DLgM4HGT+zq
	 Q/VSMWomXSkjgmovwrqAJN2/OKTzSN4wOODOPko58C2/sN0okxZYUYCCEZ9AtBKCA0
	 y/bLUXW9+xZ6Q0IYzbjr/U1D8m/3fJvG+3sQfqHtGeVgqtOpNgcC3unifBQgWxXF6q
	 QCmW4c1OOdcYQ==
Date: Fri, 10 May 2024 08:36:05 +0100
From: Lee Jones <lee@kernel.org>
To: stable@vger.kernel.org
Subject: 2 fixes for inclusion into linux-4.19.y
Message-ID: <20240510073605.GA6146@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Dear Stable,

Please could you apply the following fixes to the v4.19 Stable tree:

  97af84a6bba2 af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
  47d8ac011fe1 af_unix: Fix garbage collector racing against connect()

The former was only applied as far back as linux-5.4.y because the
commit in the Fixes tag wasn't ever applied to linux-4.19.y, however it
is a dependency for the latter, which fixes a real bug also found in
linux-4.19.y.

The assumption is that the latter was not applied to linux-4.19.y due to
an conflict caused the missing dependency.  When both are applied in
order, they do so cleanly.

Thank you.

Kind regards,
Lee

-- 
Lee Jones [李琼斯]

