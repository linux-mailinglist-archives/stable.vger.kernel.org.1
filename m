Return-Path: <stable+bounces-139711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72EBAA970E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93EA189034A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EC25C83C;
	Mon,  5 May 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK619vRV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252915574E
	for <stable@vger.kernel.org>; Mon,  5 May 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458035; cv=none; b=THOu83zeUghZwv08o6Uj0f6/aprlvwlk9y1jnsfaZkiJBlPAu2qJ8Ie3VB+DiGnfwi+oIHDJT53sRDCoQ6ePfa0wGs/EFlFozITGY43SC+CEoxESeXq8l335Yuo5qlXHgKmHPM2Zzw22+Jmgue76RnVKtLTGD9R9jWN9No17cUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458035; c=relaxed/simple;
	bh=zM81JSKRdgrVmRgEse54Hhizg70aW1SP56DhjQgCsy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqLhhvCL0XK+zCZ6vqDQiiFm1iX08il+0iR2jsZMXyBNp7b2RcfrfBaE3m45kOVttOTta4xmpnwBCFofP0YsgOlVaBcZAXqvVM+/O5tkaq/wfin9MXIy1hd807Mn0X1BzG801uUdwWCXBdXokfUeAzKl0jt9GtGpZfa3n9bIQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK619vRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F66C4CEE4;
	Mon,  5 May 2025 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746458035;
	bh=zM81JSKRdgrVmRgEse54Hhizg70aW1SP56DhjQgCsy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lK619vRVs48B1JDQYSOXad29YB0s6CvyjBsHJRYdHsFRGEz4wcDaQx0aMweTk1tow
	 Z+BT1OQZ/6Do10ILam6z8YpVZ9Y0y6q2bCUx952dFGugWoGbFNRnIjOD12MwrDYAz5
	 YkTlJZyIIA0V/crMyZuiAIclvhEB0TY7dpW+AuuzvBuTRojh1a+2QfN16tF6lOUvEz
	 f2E5J9EAxAIkuNH7zEx0rUHIWYxGuH0Corf88tQeqHzVIJHHsvgGVuaToWO0vFZf+y
	 P7sqkC7JbJUv4F3JbdLt1sFW3L0B1hrhaHsY7xZyymdHfSwmTgV+Nl6kkF4GdImB1m
	 EaUFepn5tKrrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryan Matthews <ryanmatthews@fastmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 2/2] PCI: imx6: Skip controller_id generation logic for i.MX7D
Date: Mon,  5 May 2025 11:13:53 -0400
Message-Id: <20250505090300-37fae3ee201ea34f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250504191356.17732-3-ryanmatthews@fastmail.com>
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

The upstream commit SHA1 provided is correct: f068ffdd034c93f0c768acdc87d4d2d7023c1379

WARNING: Author mismatch between patch and upstream commit:
Backport author: Ryan Matthews<ryanmatthews@fastmail.com>
Commit author: Richard Zhu<hongxing.zhu@nxp.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: d0f8c566464d)

Note: The patch differs from the upstream commit:
---
1:  f068ffdd034c9 < -:  ------------- PCI: imx6: Skip controller_id generation logic for i.MX7D
-:  ------------- > 1:  6f456b8c64c73 PCI: imx6: Skip controller_id generation logic for i.MX7D
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

