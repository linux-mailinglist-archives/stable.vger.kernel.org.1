Return-Path: <stable+bounces-165134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1A8B153DA
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE9E18C1F64
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151E428540F;
	Tue, 29 Jul 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejrtkJ6n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA825275878
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818328; cv=none; b=FatVfzunQcO0xhdEf7XBnDuXVhb0ZM5nKhck4XWTYVqXfEdJN3i9OfR9patZNXIg/JDdgG8KaMPP4oChwt+eyh57+V5yqYa+5E2efW7Zboy9cvCE1afybWEnguYZGAJqACpZFVOkVBCYRlv5SQ+pp8MAVewD0JhqWJM2L5Ds2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818328; c=relaxed/simple;
	bh=RdYzvu7lDa51VuP9nlCLjrvBFSzka9k9xN7etOemJG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aj/Ln2vu1UibqtKFjxbGFwwBRaUNl5Y7z9wAc6xsis/u1Z/qDlT3+WBjhr5tW/gYurhQSKU0LxWrUM1LbngE3ja3n5D8OfnQLWo0GrvGWI03ly/QK6ceSOiyx1iRIrLvdezkmWf7yBmbEmpaYxaJHoKy5ZVLZoRGE8PsbbMLak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejrtkJ6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6260EC4CEF8;
	Tue, 29 Jul 2025 19:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818326;
	bh=RdYzvu7lDa51VuP9nlCLjrvBFSzka9k9xN7etOemJG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejrtkJ6nPQNolTzqRhDptwTz34jgFWtlW7FfSbjAyInql/SVmyYTAHWDdxwF+4zOT
	 8IxTfFN9MgZXvKGVk5FxWKM+F1ZQhSXWRl85No8AT1M2mfY1/qyVVZQTw4zCpN6T/1
	 U00z3YzYGcUoA9cJS/jSD13NPBrhrax95rE64JsX6oUdmMofWo+UxDCPuDTMZCzcXN
	 BR0UVXsoFv4CMI32t18Y4aakbz5deFhm45LPYIzm3cklT3Y5xlKmAZDrXXBiNrFtWp
	 34pFQoTINLkC6siPBZSqsS1rKCDpq1Jt0tcrZFaNYX5PwKbdznl+aw6BgMWT5+R6JX
	 BN0I2akJ+RHnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tomitamoeko@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 3/4] Revert "drm/xe/devcoredump: Update handling of xe_force_wake_get return"
Date: Tue, 29 Jul 2025 15:45:23 -0400
Message-Id: <1753809157-4dc93d8b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729110525.49838-4-tomitamoeko@gmail.com>
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
ℹ️ This is part 3/4 of a series
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

