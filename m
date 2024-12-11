Return-Path: <stable+bounces-100648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A580D9ED1D9
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939D6188371C
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDAD1A707A;
	Wed, 11 Dec 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX4cq/iB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD838DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934737; cv=none; b=hh+yA6UBXXPI5nKiURXXipBmZzO4LjdsQJ17GpSw0OURuFnsXqXzSNxWiTVSvpMI2Aa5Obrop5nzoFV5VmzSUH8CA2ckfDX7HGaH50BvmwIKhqUYttmSnq0f25mjUQMohur7CTHE3gCzNihmddxpkkTNEQW0DMqfdxDMTkryKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934737; c=relaxed/simple;
	bh=Mgab1HyTM2OikpbZ0K7fKbMibx8c1ZOSv+4FVetDdzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THaAbSSc1mPQXZ6izOiY5tkNCkz3ykGPFGK0E+LBJFzt8vyv4zQ6B1lcKxTQdQDEvN9fWC1/sCoCGzPgPKIQSXA++Ji7Eg/U1jb9ycEa69pVOXBGt3y1iUP2x7ooR1RymuaGjwcsMJ6hhlSLuzExyFN61aV6FQ0xw8WS2VitKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX4cq/iB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A784C4CED2;
	Wed, 11 Dec 2024 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934737;
	bh=Mgab1HyTM2OikpbZ0K7fKbMibx8c1ZOSv+4FVetDdzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZX4cq/iBG2vXb3XWgiAjJNtDJN34tPB+gvVvZZKN/J018hvhr5YfsEo1OVAtFkAXE
	 ub+hDyFIb2jwmhrX+XEzaL/RprXI3gznxNA0IamaFIDggix4li9wVtbPIbqWzvaE0C
	 Stz+8tDLFy7X9aCogiOL3+Ykpthoii8imM6bhqw0Rs8RihsXQsjdQtw7VfhyP383l5
	 6UnmHD+kBnOKPvCeYxtcwh6V03kFY1BbBDhVZaAWgiGNWQEhQovyiT4eNAtKGy8Jqc
	 VgEx5wktl9fOf1YRcjUuFF6b0VHjzHAwymTkZUpM5GElvX9PF2/4AXUNBgEB8svORj
	 QlnUBVAFJbLAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Wang <hui.wang@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [stable-kernel][5.15.y][PATCH 5/5] serial: sc16is7xx: change EFR lock to operate on each channels
Date: Wed, 11 Dec 2024 11:32:15 -0500
Message-ID: <20241211111006-49cbaee7f0b8794b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211042545.202482-6-hui.wang@canonical.com>
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

The upstream commit SHA1 provided is correct: 4409df5866b7ff7686ba27e449ca97a92ee063c9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hui Wang <hui.wang@canonical.com>
Commit author: Hugo Villeneuve <hvilleneuve@dimonoff.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 9879e1bec3c0)
6.1.y | Present (different SHA1: 4b068e55bf5e)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

