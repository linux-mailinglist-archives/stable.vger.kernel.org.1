Return-Path: <stable+bounces-114340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5561CA2D105
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E737816D666
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC831C5F1D;
	Fri,  7 Feb 2025 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ52VDFW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2061AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968689; cv=none; b=FDgs7iLT7EKO9AtzEsIiAij5FDFC6Cn7ERYZwtnP56UskXeoaWQi5bZij2COleuVljb3+yoBwHPpXMsi9/7e2OBx93XCqpTuQfp+CEpHeqqeMBNQGfAFf3ea/XLxeu4eJR8Bxk3YByGB87iOOmoIo4BonQgJ8wJoRq9ZlbmCeRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968689; c=relaxed/simple;
	bh=ZXSJmpg9J325Q4367A9seMG+/2YPA6gjXu8LytFbgoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCeIOpd7pv31YaczA+4ONpOmg8jxgDYnEapIcUcXU1BsIspxC8EqSAmaywWtfYVfH9gKu73hAFhhJYaNXZra+rLNKP9tf/tj8bkyr1TTMo2htWOdf1o7XmM58EDgvZgioA7cjG38VdWRQWvjgF2v+46QS/o58n0Z0Rw08VPWq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ52VDFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D62EC4CED1;
	Fri,  7 Feb 2025 22:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968689;
	bh=ZXSJmpg9J325Q4367A9seMG+/2YPA6gjXu8LytFbgoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQ52VDFWD61wN8yUHlF7I/EQ/NjYGUM5FQbvXKg9VNn6iTyXs4N6uU+46Od2wCRFx
	 /iXWkrvmJcKJ755VvWxD2FpJFkdhH/M+EYICpob6XgaEwUIDN8tGI+GbJfYkDEjaN9
	 x//3iizv8U11DR8bjmdGH8ROkRoCWousjcNfSISKqyZM7OxUEeaGZRgpe5s79aay1b
	 dlXwGQ8AN4hN2d3w03hvuHMhxt4WNxk840nyWc+uLbICKyz+YHhxqyknB8ZxoO6Xin
	 +MGGtyC3FGfYHii/b2lRKvtURzxlBYZy3Ki7jAtMD/jJRJjeSMibakh6gHGitkxpyi
	 dSkl2qACJPbYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <koichiro.den@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 17:51:27 -0500
Message-Id: <20250207164431-00cda20c66058855@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250206161955.1387041-1-koichiro.den@canonical.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.10.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

