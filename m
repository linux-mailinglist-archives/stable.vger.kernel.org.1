Return-Path: <stable+bounces-137069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB1BAA0C0F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A023D1B658EC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E54A8BEE;
	Tue, 29 Apr 2025 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N91lZWD5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC592C2585
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930990; cv=none; b=pyZn6sl9MalkMlt9fNYFJICTYv8/LuNCGoXx1RbZNErOuBwAYv+NUmQlGFhfZgyVIvyi4v2PNwxlFFmcrX93sbK8htCkTgdPYu/q2EcJdho2dMG4vZJsCbmdkb4NUM/9jo6wnHK5f+VXsiDDBFFxVys95Vr3pIKLgQf8cwJ9fss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930990; c=relaxed/simple;
	bh=gW4UmV8A8hr6jm27ae8fInMU3OfuUwBosYaJUQjptXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYmsgZoY9nFfag+LOh5yMwvw7+u+SOmIXLlXftbIRkAtG+XC9TJvGIzg9cwaJk1tCaC/qYMmuNwuTp11rqqhOcszZBYavEOwg+l3jI/65mt+6PLHs6lGBSP7Dzr3aeXAU8aCujATLCWTNnT6hv1uwQpFiJzMe62UPdy4HTxx8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N91lZWD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32128C4CEED;
	Tue, 29 Apr 2025 12:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745930989;
	bh=gW4UmV8A8hr6jm27ae8fInMU3OfuUwBosYaJUQjptXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N91lZWD5pSTuUf0KwmAe6pp/3KsVVQWRRyo2nnhngYELPpg/OvBdC62G8SYvYHHCm
	 R1xyrQ346znnobMEu3CZXkUSwjaSlvPS4VAFSQkKYWcSCAvxDDWHfZF8rKlcnTfIkE
	 rNdcQDoo2vF2sqV5JP2E2ddoBgMuPYxBUg22Y3B3IE77R+2iHgb7QOZ5MUNRaxSwJU
	 LX+9F4tbeWskKwXWB8Pf8Piu4P/h2h2dsR9yYpYcYbRUciXCtn3ycVzeSTC42U0Hl7
	 yFfPQRmuCtkyfQGG8gkW3fHf237BhQD/1uaGkP1Qjkc26+BdhB9bEMTOaVZXXenSMa
	 xeLv0touUr7qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/4] xfs: do not check NEEDSREPAIR if ro,norecovery mount.
Date: Tue, 29 Apr 2025 08:49:45 -0400
Message-Id: <20250429001646-bbac610a4e78b855@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <174586545399.480536.11556523767440235148.stgit@frogsfrogsfrogs>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 9e00163c31676c6b43d2334fdf5b406232f42dee

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Darrick J. Wong"<djwong@kernel.org>
Commit author: Lukas Herbolt<lukas@herbolt.com>

Note: The patch differs from the upstream commit:
---
1:  9e00163c31676 < -:  ------------- xfs: do not check NEEDSREPAIR if ro,norecovery mount.
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

