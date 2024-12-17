Return-Path: <stable+bounces-104408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE5C9F3F4C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 01:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE6D188B069
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 00:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ECE60DCF;
	Tue, 17 Dec 2024 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi9wleDw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667315AF6
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396141; cv=none; b=c4tWm2GaBhQu7G5wwsKnidrtnViZhWYL+UGYZaem5P3nOiUjvRPScQdmfKziFEIHosVPy/woyWXd1ybkYknCXwjKpr4w4SVAmpgvxx3qd6qlxacJtJ8J2WoH4x4GUUrU1cX6sQVT64JyCeydL7yB5JmRBu9ffgKBc8k24OTkVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396141; c=relaxed/simple;
	bh=eYJFII38oZBQUhf5tziYQZnFgMyIj0JHn6lnWr5TVaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+c2rpij2YQ3zbXc23POr3Gs2dU9i/Gf16L8NC7ftDehOAPo/+dQEy1dzH2jx9jnEvJbUCodc8HACBFWPoUjzXdjK+lNkTkQ4BbJzq+6J8A1zJ2tPan4/3Yu+i8Iw7tps97z+X9+z4xG8F7dFNe6mJcZpQB8WGLrvef1FK6ukeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi9wleDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C47C4CED0;
	Tue, 17 Dec 2024 00:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734396141;
	bh=eYJFII38oZBQUhf5tziYQZnFgMyIj0JHn6lnWr5TVaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fi9wleDwbpCO58V6CTuGaejb1Pu7iMZ6AePf8pM/DnGqO/MO8KTPBu0takCP4D2ox
	 ip7cplWDutawe8p9C9bIGK6q8OSppw8zR6pH2T74NWr8PxVTL09VogLX+hJJFUcUyz
	 O3zoA1Cc8n19+phdsjpid734MPWbQ4KoC4HdIBIjxEUB3OQ2T5CTn7OQ+fiSGz8oae
	 HvNoBrUqm7jV/Wah9+bIu4gjQjYsl6Lh+NoaTNK4MRViDSbxjh5u8UNQ2Ev8d/WpGo
	 9SQ3wfHSRJk/NjcZxyx1BzmdEKhbX+e1hEIsZR/udHD0i/c/n01h8PRvdbg7d7x51n
	 NfDnSzfHb2vkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hugo@hugovil.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/4] serial: sc16is7xx: add missing support for rs485 devicetree properties
Date: Mon, 16 Dec 2024 19:42:19 -0500
Message-Id: <20241216192550-2a2ffb95b5a28b13@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241216191818.1553557-2-hugo@hugovil.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: b4a778303ea0fcabcaff974721477a5743e1f8ec

WARNING: Author mismatch between patch and found commit:
Backport author: Hugo Villeneuve <hugo@hugovil.com>
Commit author: Hugo Villeneuve <hvilleneuve@dimonoff.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...

interdiff error output:
/home/sasha/stable/mailbot.sh: line 525: interdiff: command not found
interdiff failed, falling back to standard diff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

