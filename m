Return-Path: <stable+bounces-99976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62679E76CD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6749A2826CC
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1F01F63F0;
	Fri,  6 Dec 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR/MaW7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B115206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505117; cv=none; b=ENrCoZZltcBFkeXB75W5NzirQeK24zM0dKZBlxAYin0225WNtYOJ5NfyPQuMMZAgg3yagkJeDo6oU5cesMeceXJRC+veC6JzY3SbaVHqm+JKt3U8fQoTYF7tHWinhJRUEfS4ZznH5LFF46YhO+24rYtR5x+eoo9TKb/uaCvytY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505117; c=relaxed/simple;
	bh=ObDLJ68vFXm48EjueCQwOR6tFZnQSd6zGbAAehsvZc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5OMNG10a82lWhSDjD0FsygecDhjiNIP6pTYJZcdO2if4/q1Qk6/6RupFVEeWCcs647wF/qM+lTfAaHMIHBRWURWE+aMh9cJua69udP8Jqf3QD8O3kRSbfshvhQWYKnl7jkp3fKAdY6QM4U6oFPV0tx/297wM5XgtuYGxoY9HGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR/MaW7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC6DC4CED1;
	Fri,  6 Dec 2024 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505116;
	bh=ObDLJ68vFXm48EjueCQwOR6tFZnQSd6zGbAAehsvZc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JR/MaW7ohnnET9y/j8XxrmSWv1QytPzjUi8QtmG3f1BHxhrePwgr+6ZV7k4Y78qoF
	 eqAoWPh8yUpW0bXzpiFuiQp8kELTu+TZ3CqfjOja/Rs8yTVK/EK18lTTTqztxutjex
	 vrw6xrXKM63KImf+3A0PAEHMQIcL3/R9rkrL6sdqlVPCx/GM/F+hBgyNGNpmhmEFWN
	 58KjywjZ8xPqqLpnAy+waZHMtaLDKQdRR84VC5uZDK9lAMcwjaXSJKChbVA3bvyUeU
	 6pfZ5og2pPdt4TaB4I479eLGcfqzrbZSgmtsl1gcVthfvL3WNUeg2aZRLBc9gbqSaJ
	 mKnyK5zpkoGzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@meta.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] nvme-pci: qdepth 1 quirk
Date: Fri,  6 Dec 2024 12:11:54 -0500
Message-ID: <20241206101834-17305f9d3258d9d8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20240911174631.3484553-1-kbusch@meta.com>
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

Found matching upstream commit: 83bdfcbdbe5d901c5fa432decf12e1725a840a56

WARNING: Author mismatch between patch and found commit:
Backport author: Keith Busch <kbusch@meta.com>
Commit author: Keith Busch <kbusch@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
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

