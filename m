Return-Path: <stable+bounces-114341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FA6A2D106
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BC816D686
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541361C68A6;
	Fri,  7 Feb 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzTPTCFE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149231BD03F
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968691; cv=none; b=oX4kespWPE/hLouxhdYMzrB3SdnUL3lirzekBEmbmz22cdEBeoTjHOnD20lwDnTshkfhLh0td/3tCoB0D2vzQNFL7g2UR/tkcvJdG7mvgVCY5EVSctEsOIHDBs50zfRR0k5VhmEvIdCnJVWRMKAN+dr7/+UgSnLSC7qSL73tnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968691; c=relaxed/simple;
	bh=72BIYVKlC7nV+hTsRogdAEY9wS3a8LzazBLaki657yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSRgJjez8k9nR9/eDqz7t6shI4S9ORpNG/Ex/K+X2hVkd9a7xqXU3ZaWhHH2fm7LoUZX3KS9MREWwSVFjswDnyvm0msAV71PENlPSzgvoK6eTVQPWn/QxVcRAxAxKDjUWZJqDfGzgsDor99LyXZQHvkYqGhBxrdqYbIMqBsF5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzTPTCFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FE5C4CED1;
	Fri,  7 Feb 2025 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968690;
	bh=72BIYVKlC7nV+hTsRogdAEY9wS3a8LzazBLaki657yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzTPTCFEroL9vqYhBwmzy9v9rO+EarQ/g+uVk+3GdmLKl/XEr+HOage+Tzd1F5+UO
	 IYSPBO+GlqJch5lsn4ZP+YqfjfLZUxdk3fR++iGLuSf0wmqXRN6oeybeWddsRcQ/sl
	 5JLyA8PaOW57uIK75wTRjfleKOlAmskUQWyXgwJ9+lWiMWXkRQggHoezVU51L3lYL4
	 TseUmKTCZyyZMuzBe3ioSBjzXaLSnXkYcbOWAY1NpWxKyzTF5355dpaGRosJ8tBRi+
	 /+7JmbBxW6+TFrk1VZYKxLYmAJ82+K3Eb8cJh3IpRLdr9vc+jFYR+6cKH67TcSjTOC
	 YFmBqV5B6nfQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jetlan9@163.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net: dsa: fix netdev_priv() dereference before check on non-DSA netdevice events
Date: Fri,  7 Feb 2025 17:51:29 -0500
Message-Id: <20250207164958-d088c1c4f2dd4fcf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250207070643.2327-1-jetlan9@163.com>
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

Found matching upstream commit: 844f104790bd69c2e4dbb9ee3eba46fde1fcea7b

WARNING: Author mismatch between patch and found commit:
Backport author: jetlan9@163.com
Commit author: Vladimir Oltean<vladimir.oltean@nxp.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 69a1e2d938db)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  844f104790bd6 < -:  ------------- net: dsa: fix netdev_priv() dereferen=
ce before check on non-DSA netdevice events
-:  ------------- > 1:  1c02698e9064e net: dsa: fix netdev_priv() dereferen=
ce before check on non-DSA netdevice events
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

