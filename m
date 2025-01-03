Return-Path: <stable+bounces-106704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81535A00AE4
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3593A4059
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E51FA851;
	Fri,  3 Jan 2025 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUVZh+sp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676417FE
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916116; cv=none; b=hYiMPvqeCb3OPmiquoy95LCRMP88N8DZBka1Gb9gqofD/9Bo706yPBoAQV6I7JjvTr8NeG34ZQ9iPeDFe8RkKme3TjfEZWrhdR9852eL7vtA/UW1RiCm3VtXNSLNErh7C3NUKUqCSmnzpvbgLY2F2bYoJbliqHqNEUKD+S8yp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916116; c=relaxed/simple;
	bh=3Jse1I0I2Qst7m5Qy3pR838w7180SiH4RknugazRDEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OS8djkPldcKMlrwi9gtbprZFpa1evq4UAmkrXvaz1HtDw2go1cstzywHwxyTROpyJC0FvTZb6Ut+D/ndezQ2ME8cyTD2AnixE1dAg9wb1kKAYT50QBherVEAys8arEiF8o5QJZN573CS5jytwOjsRo1OzzhvhOT/clJeRmMC+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUVZh+sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63321C4CED6;
	Fri,  3 Jan 2025 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735916115;
	bh=3Jse1I0I2Qst7m5Qy3pR838w7180SiH4RknugazRDEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUVZh+spK9ckwoPxBaTFcWmqd8/9L2/ZdWCb4zo53gGozs8iogBKm/kOf5ezs690P
	 QYwE1NJpOLQp5f4NPCiRrzKm482iNU8/ikjs06lQB9mq4pONGL5brepKWqGW3+CLIs
	 gu8cY4kpNphxv0yDWBTSbEmrInU2+JVIv4w7z7P7aKJxcKxzy0AEiK7UmCOsDIUiDd
	 XLSo7uMnGJHmzBd4L6sHorlKsbiyRj+AVSlsWr/DNSbZB7vxxcfVg4z82SClusUV1U
	 fWCAYKc0YjCJwKNGXB8fE7fp8hpgVglDLFk68EDdyOOOhP7mzzHK0ivSGs2tKkvNZL
	 ziWDfHzOvVyyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alva Lan <alvalan9@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] btrfs: fix use-after-free in btrfs_encoded_read_endio()
Date: Fri,  3 Jan 2025 09:55:14 -0500
Message-Id: <20250103090829-683415280a977d8e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_E8A406095A8B9A9E0F174978EB429C011807@qq.com>
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

The upstream commit SHA1 provided is correct: 05b36b04d74a517d6675bf2f90829ff1ac7e28dc

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alva Lan<alvalan9@foxmail.com>
Commit author: Johannes Thumshirn<johannes.thumshirn@wdc.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: f8a5129e4a9f)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  05b36b04d74a < -:  ------------ btrfs: fix use-after-free in btrfs_encoded_read_endio()
-:  ------------ > 1:  6e1494094cdb btrfs: fix use-after-free in btrfs_encoded_read_endio()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

