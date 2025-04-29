Return-Path: <stable+bounces-137092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF65AA0C95
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0EA7B17CA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EDF2C2ACB;
	Tue, 29 Apr 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwy0kEC+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B342D191F
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931684; cv=none; b=Gd4xOPKa/74yqefOtEJgIIMeDsNXc+l6GctuzQFEVsgXwXdnpKwBj1rELNNa/fvalqe41975KemD+y2j/nrqOrpHxy9J2Sy1jHiPtknq2uLCc/LG2+mbBl5sX6urGVL+zxNMhTDg0br/n8EgSakjbTiduXaLcnbeyeZRr2qA/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931684; c=relaxed/simple;
	bh=2mlO4v/kbLnrPZG5zH8KdCtOs07AXSf+4Bs8VCn4QOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwyYgXikzSOJZ9vT8D1G+VAyhGDxtTolrxB9gkrFN8l95OJ+A2IEqUjHesNyp3Psrh4tArgkYg/6S6g79CN/HMVV3oLWpJuvyGkF7Y/1zNp3+Wwj2WFc1WypzZBa2CzLhvEJtgue01NAbn4l7uf8oH26BVI/nesb24+QqKy55mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwy0kEC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28309C4CEE3;
	Tue, 29 Apr 2025 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931684;
	bh=2mlO4v/kbLnrPZG5zH8KdCtOs07AXSf+4Bs8VCn4QOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwy0kEC+R6crqPhFrfjXu5i51GJlcJcE8L0zfer++/Ruf/X/Gwjma2dsuN6SGtvrW
	 +dNQSuqyf4Vlqtw7i1ybepMxJG2/vWJAM8VFubzhp5bH7ALs8fLLJPyC8OT0+oFSqG
	 1YiIXJxlU7J1vaQOIqK8XpGxmw/LH2ocDaHWRL4Vl/9D3+2dVN95ZennmFnkGp4g9e
	 LgRmd10diuwOKfJJgzsjwfclh7/+mTqHxFQIrAOQp/okyuWkddhhT7FOjdjJAG+/r9
	 0ZIY+bDTzPeUMxG8W4Ikay7Z21K101NA0G1KnHy6FNQdctZkKmPTDMKIeF4a9wY2KC
	 wVPA8isQ8LdBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 3/3] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Tue, 29 Apr 2025 09:01:20 -0400
Message-Id: <20250428225051-eb45433926e11814@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428085744.19762-3-kabel@kernel.org>
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

The upstream commit SHA1 provided is correct: a2ef58e2c4aea4de166fc9832eb2b621e88c98d5

Status in newer kernel trees:
6.14.y | Present (different SHA1: a0898cf9a38d)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a2ef58e2c4aea < -:  ------------- net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
-:  ------------- > 1:  8fabf354f66fc net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

