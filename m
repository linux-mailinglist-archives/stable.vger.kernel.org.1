Return-Path: <stable+bounces-137074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A89AA0C14
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DD5843AD4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B22C2585;
	Tue, 29 Apr 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxtnoJFH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514871519BF
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931011; cv=none; b=fAI96Kh9JtWtVIVf54z69cJHcOfMG8IPnJqP8ICGh7ANGG71fTLgFmzCIFsLnSz+un5b3P7IpU2RuqnfwCNEiKzDmblN8/rRU31+3d7lch7wcNLMo9lgQtQqTVMqYAXwnk/USfZQUflc2q4QvNAdVrNzqQdKP3IJA8DnqqrKnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931011; c=relaxed/simple;
	bh=KLjCjzIKUZyGLQK1251yK4pjxvkS21E6IWs7dO6kZvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yo6laVGcPDP/0nHOuHlprtMX8ZGi4X2mzJZ9MYT12oac4UjPFd5hBhxM83cPXOAeD7L6Jb3SHY6LGrxENOLiPrxnsQjz4tc4IBavK3ZURjMvy1+CV7RPL+Gk2v3fw7Zi1pkHIKwVEimt7QlACCpUwbak4ki6ShpFKTOkmxLih2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxtnoJFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA298C4CEE3;
	Tue, 29 Apr 2025 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931011;
	bh=KLjCjzIKUZyGLQK1251yK4pjxvkS21E6IWs7dO6kZvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxtnoJFHj1teYIfs6olyQ4VIOYJYOLK9426F+8dp6viz9URWU7hz82Tj5N5gkadhq
	 IFkGyd3A5DwpjBOk5irLu4TwYJ9ZOc0fhUrPx6LFLlk39F9UgQk2D9J5+Hzm9pVrMs
	 t79jtMZC+9cHsYt8dMcIHNcB9zI5UQe1X6eWE0GNrPIhnDEwIN4BGNmKfkMppSIILc
	 QOJMXa4u/NW4BXsJ0mWjIRxFNeEGpSmWvshqnLRSJUdtw8s93oUPwAUptW5AtpBZrN
	 ceZJ16vWGmoUluc8fp2oNeVDk1a1WG2cV2VgK2nDdnl/byRiupRkMAZXKTfrymIgm9
	 gqmrwY+hpaV1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/4] xfs: Do not allow norecovery mount with quotacheck
Date: Tue, 29 Apr 2025 08:50:07 -0400
Message-Id: <20250429001955-6a5666980c6e8446@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <174586545419.480536.17699094964584987030.stgit@frogsfrogsfrogs>
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

The upstream commit SHA1 provided is correct: 9f0902091c332b2665951cfb970f60ae7cbdc0f3

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Darrick J. Wong"<djwong@kernel.org>
Commit author: Carlos Maiolino<cem@kernel.org>

Note: The patch differs from the upstream commit:
---
1:  9f0902091c332 < -:  ------------- xfs: Do not allow norecovery mount with quotacheck
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

