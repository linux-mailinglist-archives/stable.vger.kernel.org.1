Return-Path: <stable+bounces-118919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CF5A41F66
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8A5171A4E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5F1A3174;
	Mon, 24 Feb 2025 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxI1MKQ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3461DDE9
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400710; cv=none; b=FSgYLSRuSOtqDYKiUHZWDlT7V+LneaQHmIVuJs17xuTX+GYhyWtVRQ/AagsZocoxmxPtOhd314xYHIvim4oMjf0hlD/8Ojjt+T0OxilX+kjrn+YVRhCMJQHgOSdYM6WKdOcca/O9jv88TTb/zaKu6d9Eppt/ng14uK2KaA/I/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400710; c=relaxed/simple;
	bh=R4HSH/yghKsyG7Tt+JAugZzOi6Z1NLaM4duKEdkvhIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d946JbvjAYECOAQC59NgFDROgC42jkP+9UwkgC9eDGw+brKvnIZMUvpdQSGHZfqjLRAnipK2piuqoSxk87Yrmki3NkKl28OXqrrJ39FMZC3F4DEpikdC9bE2oUp0pzglxt3NMQwwOUjYMIff7MQ06hMFUK1Al4UtFd5OvRoEIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxI1MKQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF733C4CED6;
	Mon, 24 Feb 2025 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400710;
	bh=R4HSH/yghKsyG7Tt+JAugZzOi6Z1NLaM4duKEdkvhIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxI1MKQ92Pc3XXMlzW0CFcieP/Gk4wkeioiLnMwHQPCJhy9py5yG2yLkCR7Izar5+
	 jtmYeSK1rgHaQJ5YU16P0zq0nMe1D52cA0owarjdSbGxrvPxqewrBG3bCO7fVbtLta
	 Rab+lcpLuVWeGtYLGe0myqyg5/uhrfT6E8bQGDhjgPB1eODz/o2lWqoiL1uA7WygQv
	 TyAIJSjYcXqXiFdVL5xtpnDNlkxYxOYDbUMakNwfn5WSmPFIofLSqoVXd2uAmmVPhE
	 C1jdsf9CBj07lY3F/54k3/j4BRNGt7fG30PmXc+wEGXdE5r2Li3tFKagcX0oVnQwMS
	 r4jPcxsIhakYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cnsztl@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
Date: Mon, 24 Feb 2025 07:38:28 -0500
Message-Id: <20250224072153-1ee8207a226c232a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250224105721.840964-1-cnsztl@gmail.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: a6a7cba17c544fb95d5a29ab9d9ed4503029cb29

Note: The patch differs from the upstream commit:
---
1:  a6a7cba17c544 < -:  ------------- arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
-:  ------------- > 1:  136df8c642891 arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

