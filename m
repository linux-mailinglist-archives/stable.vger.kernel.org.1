Return-Path: <stable+bounces-134700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07046A94344
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B97E7B0341
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48161D5CE8;
	Sat, 19 Apr 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKx9xlv8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57731A254C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063435; cv=none; b=oM5IKU8fGocCV5zClmAYa1OPEdrvLc1MKKYGZxcKAh10UL7YvH3zumLn5c99Hvl/QeuXy36dQvnzGjYWXHJ+J4uOTr+yatfXXhPv2Y7LhNRv1LOVIwHQ5vLDou7HSvY1I4yXwMKI1Ko0RfmIGKtCwHxu+eNXIM6KsfqXrwvOMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063435; c=relaxed/simple;
	bh=CWazMI+e9S0oSejc2+2CGR3aajVdtayY+rt4ZkCwZhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooVL5r+W7uhHMgzTRUWzf8H89YbKor4+Fwr0G14VrzeIdeyuHAWPRnYKZ/7VxFeM3KY9BRnmhy/RWh2tn8Egmfg/QG9aPiPn6Lvn9EqNjFiyqB6isr3ZsV/Hc64FxQpe0dESHbMtAjFEwav0JnIiAZ3QPTrGQCd4TOcxnLE2wNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKx9xlv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189F2C4CEE7;
	Sat, 19 Apr 2025 11:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063435;
	bh=CWazMI+e9S0oSejc2+2CGR3aajVdtayY+rt4ZkCwZhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKx9xlv8NUGOCGAV4/I6AuxHOLLmgC3RvMNnclwnYMFWhOB99StpNrQ3AwidPDzUZ
	 KTWoOJudqKgZhMIYrWTQrLjsMV9BGhLbOEM98dSAXRyhfsAuIId7IgxSHkmMkGd9rZ
	 gKKESEHFb0jy2X/TaaJn8gRQf5qIBP5qVPZJxygJKSxNR4yhxsinZuDUu8ya5yVE8q
	 c4iWUQgyxz44AO6YZH6Uh64kBwmE6rh2OpDXUi3kdUMwB2ADwxRpP2VtnGLhEemGwD
	 VwhSQ+vp1wM2vVOLfdcej+0/8XlAudhvPB4zI7zskxT2OU5VTiOVOgRTj2av0Y2WCE
	 0r7aLtcCKh9Eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
Date: Sat, 19 Apr 2025 07:50:33 -0400
Message-Id: <20250418204251-2409e4559867a712@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418122508.2031718-1-hayashi.kunihiko@socionext.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 919d14603dab6a9cf03ebbeb2cfa556df48737c8

Status in newer kernel trees:
6.14.y | Present (different SHA1: ca4415c3a46f)
6.13.y | Present (different SHA1: c52bd0b9e72b)
6.12.y | Present (different SHA1: 4616cf3fc00c)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  919d14603dab6 < -:  ------------- misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
-:  ------------- > 1:  1496351a9cdcb misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

