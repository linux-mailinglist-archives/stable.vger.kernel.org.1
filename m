Return-Path: <stable+bounces-136636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F89A9BB30
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563ED3AF2DB
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 23:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B914427BF9E;
	Thu, 24 Apr 2025 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko/D0eAZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4FA93D
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536980; cv=none; b=bgnN/3MoHjSfyEp0q5E5TbevSZOYL/6z2R1padG1i2Ml2q/ywzr2NpDW1B/pNCtOKDtqO0NcvCOnWiqU/9Um/k2mpqaBkPf4sVcrLo7DtZAlFWr9P13mTi89b+kS1OvdSJW2F4JpRaXDaByE1ArTDeD3QE3Xk3uwydcYQ/Z2RQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536980; c=relaxed/simple;
	bh=LRfoGXP+uItb/PAEW2lhJZ8QHQk4pKJzAyEeF1Fp2Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQ2F+hGlVgK1GrsLac+4l5j4w+ewAJPsJO6lJJ4AvwbMyst254ImG8YuvJDVS7kZu8NRgEY3WskoPO1723KVr6Hzoye77R2Pi68NYB+/YopDIlfC6nLJ6FO3I0iQdwIaI9sIe4n7xhsh903irsUoV0IOsIVJWykXrUZc7j+LORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko/D0eAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D482DC4CEE3;
	Thu, 24 Apr 2025 23:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745536980;
	bh=LRfoGXP+uItb/PAEW2lhJZ8QHQk4pKJzAyEeF1Fp2Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ko/D0eAZLJsseiDIrX5ZfSoFWtv8F9K1PFmAvfb/Hie0ppN0y8tAma+hxndq+otVB
	 b7zoZGor3gcW90JdJGHf6FYTcbymi5fd5fL+14pwitstNg4qw2gzHpMNt2K/DamYvj
	 q/yz7zBnmhElyfdCzy6xi0/9xnUutExkYr4ii+Oib0V9mA5jCp7EQJxyTbmZxQ97lH
	 IQe+RAS/XgrmGnM/MwDJz72g46OBhYsFyXLe6bbNbOa1127yguCWyf+rDrmICaXkZM
	 qMKt+U/y+AVAqQHQApVKVV7ibaY5EOIxPupTAWD006vJDvinwzY1yxfGZuSBN4sefr
	 ObJ/aWY7tVYmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bigeasy@linutronix.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable v5.10] xdp: Reset bpf_redirect_info before running a xdp's BPF prog.
Date: Thu, 24 Apr 2025 19:22:56 -0400
Message-Id: <20250424164927-61c2c88e05301f8f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250424130405.xenRxobI@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

