Return-Path: <stable+bounces-158594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9723AE85C8
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B765C188C006
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F3826656D;
	Wed, 25 Jun 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDjY07nd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35381265CCD
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860545; cv=none; b=aSsmF6IzhCqdPNifsSCObgckRKWF3capE2Q8pYlC8aZLRL3BTD0YH6gjj7IN2D+8TPol95qrwqIGmwMWtEhS5WSN18iS3HvGNO/ZE+hWGlQNvQkvqT/s0LRC9uhLldiAVqVloUzzxQY0P1dyySGLhSwvoDPOmmIntOHsZx1PN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860545; c=relaxed/simple;
	bh=kzDfnd+zP+uem89H88lg0VSTy+knSgX7PrPx9AWEe/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgE/qmuI1MG1zEB2k5CMqGB/yr+K4cB1jbQC7O/N/2669HERkrnkLOwl2otXOy5GlhgciVMFIXDlp1W914FdYn8YwZISHlGWVLHb827btAA4GDytCyemedzIerIB7jDiMOOdN3L9kneIOR8BtddbX/LJQg4CdF2U+kC66gV9/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDjY07nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CAAC4CEEA;
	Wed, 25 Jun 2025 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860544;
	bh=kzDfnd+zP+uem89H88lg0VSTy+knSgX7PrPx9AWEe/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pDjY07ndpn4N8FR2qsDb9oxDMBA8F2bxKojS+vrZPPiWzxSHKngxe/4JLbwvcJkcw
	 4k/ZycQfsdbrfc4j9LNmETpM3Bi/snYFyRHL55p3DPBtkfmIAHJbhNAPPjbXylSh/i
	 zOmbjFohPx2goIf+KJAjKoj8/Uu2S8IVbdBDyOl3lMU0zISazTRDO02tex8EK36BD8
	 MIuTV374ty0QpbEVKIsHwm6GqlPjuXMwBrGFBroq2jcXtT52o1lpyrD+pnAJCyDsBN
	 Fsx8JASkZmJl2ii6Oh1DM+rzT2M6BaLRwNGnM99b/CjnHYpw/+QWgUGTjlgBfidL6N
	 pr9Vn15iOqhFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] s390/entry: Fix last breaking event handling in case of stack corruption
Date: Wed, 25 Jun 2025 10:09:04 -0400
Message-Id: <20250624190842-c463bac6535c20bf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623132221.891555-1-hca@linux.ibm.com>
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

The upstream commit SHA1 provided is correct: ae952eea6f4a7e2193f8721a5366049946e012e7

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 5c3b8f05756b)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ae952eea6f4a7 < -:  ------------- s390/entry: Fix last breaking event handling in case of stack corruption
-:  ------------- > 1:  16cf896acf5e0 s390/entry: Fix last breaking event handling in case of stack corruption
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

