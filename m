Return-Path: <stable+bounces-100002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 072EB9E7C46
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 00:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB6C169B59
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ECC212FA7;
	Fri,  6 Dec 2024 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbijYPVE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3777D1EE010
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526712; cv=none; b=fw0OGzCSFTVG6JPlAx9P8xSWSKqlDJjUWn3XBO+tNyW8LT/9dmVNXsA44QbR7TJIBkLJUfbCBxgyJK930dOMiArJX16FiRXNsK5asX4Sx64d3eg+WhEkjan2PBa+PXJgARg08Kv6Kjkhc19CV9G5nz+U73q+X+RjhFEF8ET1zpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526712; c=relaxed/simple;
	bh=0pNzG5S1JGnaKBuCCAfnx3OM2+3aDMCSbqm/19sAwC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/HG7F6TI1CuNxas9q4kklgI0Q/HcIzZDoGplSaMEIXNFyIMLHonGkfCU470jny40xYE9TlDj5RE0pVadZZD0Zy8XHzTGt8qUCzaGrK0QPrkv0xrIHwFxOol8rnePGkYE6wVDY/ZG9ZzJIwrKuL3Rj+rlRidn2pp7k3nZQPN89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbijYPVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0E5C4CED1;
	Fri,  6 Dec 2024 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733526711;
	bh=0pNzG5S1JGnaKBuCCAfnx3OM2+3aDMCSbqm/19sAwC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbijYPVEXdRACFgDrW4vY3Awq7+TZd0lGjes9IVW41+A60WLtaEN/GDKwGz557pC5
	 c1huQTzr5GuvLD/+T/2nd5U747Jo9h0c4qOfS38wOowX8b+qLdxAxVNDPmf45a1HLO
	 nypIU2imIqdAkF6ajnVC2xplXfJyHvbl9BGhNLtCvsOpytk2HvsnkSjSDZz0+8GTBj
	 /Mz5W/Jr+dNc2DAkpferk92HyPAaFz1jscnjsN2q+Sk9n+TYR43EK+qbwuNFDwo/gf
	 1BFs7PO/ycMC1AiLqez3Y39WTE+TkajPQHIqP22ebBmYHqvpXZhc5JzrNMR6KH01yw
	 mS7XW1xLmxsxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1 3/3] veth: Use tstats per-CPU traffic counters
Date: Fri,  6 Dec 2024 18:11:49 -0500
Message-ID: <20241206131424-437113d3ff8659e4@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206153403.273068-3-daniel@iogearbox.net>
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

The upstream commit SHA1 provided is correct: 6f2684bf2b4460c84d0d34612a939f78b96b03fc

WARNING: Author mismatch between patch and upstream commit:
Backport author: Daniel Borkmann <daniel@iogearbox.net>
Commit author: Peilin Ye <peilin.ye@bytedance.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: b74095a4945f)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

