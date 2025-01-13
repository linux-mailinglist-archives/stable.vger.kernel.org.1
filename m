Return-Path: <stable+bounces-108545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC94A0C538
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D943A7A79
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9541F8932;
	Mon, 13 Jan 2025 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivWxtTd/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33E1CACF6
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809755; cv=none; b=A88i1ZrslkQXLdEV2nNQb7Uq2Rt2+0eftkeJsTnZiYbXbAkhGl7BcKGroZgbQiMZ2OYsyhMeSyaH9vWHt4fBEZbd/Pn+oGeeGjk+O48yqx7MrrbHazJ9UMX+1/uzGmmliQk/vlvcLzYQd7XiC54EUC+cWk906dmpC9eyvpM3fUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809755; c=relaxed/simple;
	bh=UmAcxcHLDp2ScwQub9Sp3pKih5cR3SXu5UVO065Q20E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IimJqn/7CAcp5p9xQQwDS67JzN8/7LSj2TzZhg9SUXen0pbPHrnra56jU/oH7GAIRta5DuQfXKeTdAOuce9Fe6R9AkKRaZvIXUzCv+SUs3zn+gkIshU8tTSJ3WaZpxQ1/ehQpfTrmBX6IkW9MXnzt+MFC5iD5+Nc31ntprl1AmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivWxtTd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98889C4CED6;
	Mon, 13 Jan 2025 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809755;
	bh=UmAcxcHLDp2ScwQub9Sp3pKih5cR3SXu5UVO065Q20E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivWxtTd/GhSiJHGE8vnJTCLeIqS0LPSR+VPfuX2EN4k8NQTH1EYQ+2hHUwE6AxhHW
	 VnseO/3hGUIK/QoTn/2uDfycU6oujaM6HlVn6TY/DL+dx6J0a3Xf4Gyut91Cu1ACWR
	 DOsyrx621/qIGaSk5yiETionQFMtJhHaHcIijO3HteyqIWOBJoXH449iBPXOFs3zhl
	 6jxkwQZdVcEAk5Lst/fgd1mZRyM1YiEnVj+OBP8Im62CljOo1rumotFbT9DKj5xho3
	 kB8vfJgorW/D9oymF0nr9uk6iT/oG909xE0UcKlq77hzWvRiVK3/8Wsbr0oli+gQ19
	 0ydBXjx2HUDYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] riscv: kprobes: Fix incorrect address calculation
Date: Mon, 13 Jan 2025 18:09:13 -0500
Message-Id: <20250113161136-6f79bdef49508915@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113075955.675949-1-namcao@linutronix.de>
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

The upstream commit SHA1 provided is correct: 13134cc949148e1dfa540a0fe5dc73569bc62155


Status in newer kernel trees:
6.12.y | Present (different SHA1: 79be3a64d83c)
6.6.y | Present (different SHA1: e9d56f517630)

Note: The patch differs from the upstream commit:
---
1:  13134cc94914 < -:  ------------ riscv: kprobes: Fix incorrect address calculation
-:  ------------ > 1:  bc6c56837c1b riscv: kprobes: Fix incorrect address calculation
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

