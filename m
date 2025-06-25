Return-Path: <stable+bounces-158578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8004EAE85C1
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310DB6A5673
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06452265626;
	Wed, 25 Jun 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQGknDpi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905425EFB5
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860446; cv=none; b=YX1zgdxgAXY7KAqdgX9Apn+Th6PPQR2hV7okrjVgtTtTcEUr4FYZYXT/osxOIXglf+pp85BaKrny4c9eitDMiHbeWw9m7a4BqdeLykpBFEIMxIVZvjdovjnsUVu8f0jEcQ/wpsovkdM6gEP435k/1u+Weqqm8Y46qrJM8se+T9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860446; c=relaxed/simple;
	bh=XzwD9Z5KwH0dngUBSpTF7guYNMLZEp/p2uiHl9hJXL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKuORq3wPX+HF+u46SDv5AoYsKqfJHitB6F++xW94h2GM2Uims6F066cl5X98D55pki6WvMJ+uG57Llj89rtvLjC1xsLoOomqAkX5mc+KUGch/j3WgkfAK9pTidyeqwHUia7KV8EKrm3i72u0aQ2BVCZZPHGEgafsF9y39NLRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQGknDpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75520C4CEEA;
	Wed, 25 Jun 2025 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860446;
	bh=XzwD9Z5KwH0dngUBSpTF7guYNMLZEp/p2uiHl9hJXL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQGknDpiGsBB6xrk1jHKSzHGCLTqQNCGKql7s/aQZAHE5vJP3L+Horhp10/lG/lCO
	 uE85bYGSqihfC5nAIW9UgNf7UJi8SdPGOXPsXdYSItIjUqp7hQtfpU23qy4FDuT91J
	 E5OXzBiAmobtiK4jgzWi306s1oTS1SgNjJ244aJCJk8Fl3fBpd6T+PKkZ8bPrkNW8V
	 bTgVujmxb6nqQ2iDu7KLoQQJNIMD/IMT1/97f7L25kBJflYV0e/Qwra0QlKea/vFv0
	 yFIrB+sH7nMpnt+i7Wo4hp2PvaxRAg7UTuazTmD5dTSz0RGS28E33y554YDjNKst9Y
	 p5SPWu10QAhaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 4.4] scsi: core: Remove the /proc/scsi/${proc_name} directory earlier
Date: Wed, 25 Jun 2025 10:07:25 -0400
Message-Id: <20250625020258-2359e71f2a4956a7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: fc663711b94468f4e1427ebe289c9f05669699c9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nobuhiro Iwamatsu<nobuhiro1.iwamatsu@toshiba.co.jp>
Commit author: Bart Van Assche<bvanassche@acm.org>

Found fixes commits:
be03df3d4bfe scsi: core: Fix a procfs host directory removal regression

Note: The patch differs from the upstream commit:
---
1:  fc663711b9446 < -:  ------------- scsi: core: Remove the /proc/scsi/${proc_name} directory earlier
-:  ------------- > 1:  a2b47f77e740a Linux 6.15.3
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

