Return-Path: <stable+bounces-165135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC8B153DB
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C457A18C29DA
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1032951D9;
	Tue, 29 Jul 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8X9eVA1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A692951BA
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818329; cv=none; b=kXKfRbQvm9HVQFORjxqbSxHB1viiJsRIf5BCVd6nGPtqoKm2O7Ag4LBp9ZLU+GeW2U3e/BTj7jQgZM5n5i6EPGfd4aoRGhXI2Zrv1qNw2c3RKUjSiRwHat2IGjzMUnbrrIw7K3fg5/wJXGs30qxxApmQ2m7Nytz3umCUXNTdde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818329; c=relaxed/simple;
	bh=/MC4I7bC0feWkeevsFgBS2avZFWE/Urjun1oV+HIZts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1+th5Og+Hai7n1BKVWkhlE8OWcJwip5LYKMXQGz4BwoUYc5lVLhoFxSzFa+b561o3pdp4YOTHKOXgkRh2zEsnMbgXjy2k63LQhI2bIU8h6kLYKpdNbrPIB4P+JvD6J+1VTlsAxTm6SwxTg/NDsD1ZeGqA/KvBxPHQHcqqrwbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8X9eVA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB07C4CEF6;
	Tue, 29 Jul 2025 19:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818329;
	bh=/MC4I7bC0feWkeevsFgBS2avZFWE/Urjun1oV+HIZts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D8X9eVA1Jkflom1QunwFdf1PfOWJ4b1EOMd7hXH68mDggKtoOikNtCCvgA7p8i0yQ
	 hQqQk5pPDilKhmpnKkidxWrZLaxRWUV1eORF+Fa+qIR3ih0eaCydZjzXc8V2+Na65y
	 zoYrB3NIW8lApZPJ1yhTkzvi3kLIwQbK451nXEqaYtkN15IRaVNovENrGsgpezFwCG
	 WN1NhDYtwDB3cdLB5uyMySVn6ewIFGCwprM+3kqjw0JWJ8peWg9oDXKVFPGPBIFxtk
	 mZ7lgheh0oOZox5+/CdduG5dQ3HrbmdIZunrrgyk4/Y1BqdjEckm7cqltozycUr54Z
	 9q7o4gaebQHhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tomitamoeko@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 2/4] Revert "drm/xe/tests/mocs: Update xe_force_wake_get() return handling"
Date: Tue, 29 Jul 2025 15:45:26 -0400
Message-Id: <1753809157-46894d56@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729110525.49838-3-tomitamoeko@gmail.com>
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
ℹ️ This is part 2/4 of a series
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

