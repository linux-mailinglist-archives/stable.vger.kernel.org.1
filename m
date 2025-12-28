Return-Path: <stable+bounces-203442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B8CE4B18
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 12:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87386300C6D2
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F62262FF8;
	Sun, 28 Dec 2025 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6CMOcAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC620ED;
	Sun, 28 Dec 2025 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766920733; cv=none; b=LdhPIjCuoQ0fbScSTVlUEmtQlQf492qcxl9e0Wzhn5qEdAnynxbUjbx3mPw8VG2eHI6EI0JqH2XytaRl00PX2D659Pj5MC8Kihv0w4YbVPTqJiTqNlGFgvjwvId7aKIQf+J9cxBAsneFY3t1YmTZ8atJQTj/gtKnKH+nloddbTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766920733; c=relaxed/simple;
	bh=GRVTmmcDoCG9ClW3xDmBuTQe7S6wyOdOCLlfZEbSI18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZKb0EDhFQqInev25T0VOzR81BsJqxytj/GQOdeL9XfhJM5smGjLGE9KEdiIA9DW5iZP1Otzx7Z7Hj9cRV7PYylwFQ8EriYHLAjMUegEvTrt9/AMHpMf4MupZIQu5zlD7aNINsl/Z2NoYd/8xXIQJpL+hT7YoUuGJvgk6CW2Fi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6CMOcAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD83C4CEFB;
	Sun, 28 Dec 2025 11:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766920732;
	bh=GRVTmmcDoCG9ClW3xDmBuTQe7S6wyOdOCLlfZEbSI18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p6CMOcACMr3nzMJOJph1eQZv4qUwu3VEju3ijRhTCizxX8AfVGXz3rtR5iZt89S2L
	 4n1OylE531WyTGlgU5i2Bq6G+27pde83BsUBset+PDq72azTJbrU1mlTSqXSkBKc4F
	 5Tu3S6Jsej6wArw6KACmdcZuoGGm13ykKXJQbQLG1nW5NmbHetTIfTif9/30KLdBoW
	 TbeqxAJa8BLxRWwxQAXoQlb4lOvgF3igdLclx09HCh5gb95vWamOn94MQlQahld+yv
	 sQMscTHGWeMSHzj9EC93pQICvJ1xRAtzZei1a5LiZZoUDpPOihvfCJWubC2wQIWolD
	 iwmVITPw9YwBQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: zbr@ioremap.net, minimumlaw@rambler.ru, gregkh@linuxfoundation.org, 
 Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20251218111414.564403-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20251218111414.564403-1-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH] w1: fix redundant counter decrement in
 w1_attach_slave_device()
Message-Id: <176692073090.56515.4804717383085601959.b4-ty@kernel.org>
Date: Sun, 28 Dec 2025 12:18:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 18 Dec 2025 19:14:14 +0800, Haoxiang Li wrote:
> In w1_attach_slave_device(), if __w1_attach_slave_device() fails,
> put_device() -> w1_slave_release() is called to do the cleanup job.
> In w1_slave_release(), sl->family->refcnt and sl->master->slave_count
> have already been decremented. There is no need to decrement twice
> in w1_attach_slave_device().
> 
> 
> [...]

Applied, thanks!

[1/1] w1: fix redundant counter decrement in w1_attach_slave_device()
      https://git.kernel.org/krzk/linux-w1/c/cc8f92e41eb76f450f05234fef2054afc3633100

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


