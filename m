Return-Path: <stable+bounces-139353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76825AA6326
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07A24681CC
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974C0222571;
	Thu,  1 May 2025 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT8QJUzT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CDF222568
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125495; cv=none; b=C5dFqpDMUhBVNjlWnJXqENQSLblQZWKjqJE4vnOdeZz28nSj7+ASV8p9Ag/R6p4g8j1xL87nYxX+mC8x+0KHk2QPNmIbVHDTpdfBrTYNem+BgjEHWaisyzeuslXCTmKPwoWLShzRvySsTSwLpJnD5c8VOu/qxy6Gv0FfrnyGPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125495; c=relaxed/simple;
	bh=sYGBBYXGqDVoDG/zESZmX/2s/ZbaqvDGNwseBrQcYHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qot4XhI9cSASkfGKDVgHiRWTb1bHyzcSnd1QMl2PpvfEqvCMh++rnbUtatQmrkmthm6abb34E4c+4/OFKwvkWiOrewOie1XtaKCWFU2fpe5arHPSKphAvP4UUKBY1hz9wY6VZc/kPkROsjoDuDvF4swlXC9YO84dB3JN9nJCTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT8QJUzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9479CC4CEE3;
	Thu,  1 May 2025 18:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125495;
	bh=sYGBBYXGqDVoDG/zESZmX/2s/ZbaqvDGNwseBrQcYHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AT8QJUzT8Wxg6FWF2fTMfnVs9oFfgZr3r3zogp5TsDpxBSYm/CXCQQkUS/Ns/ZSzq
	 uZcdmvuF7mo3bOvk/snIVyTxZlZZ1aM5foFnhEDuhHHUo12/wTmBwFMOPNYJZQCB5P
	 E0q6Z59KUSwUE3ljIu7ixFsM085C0AUY4NfpEFpbTlyAgp3AsQANWV30Dbv4TJbs+a
	 vz5MsVv3jBbPJxdEby/uREMxDYjofdXkCawKVla4zpyVhe3W6dOb1adn2tYLsAANte
	 x1RZASiXBdlGdxvNcy10SbvOSiHddS+apLFVO7YN0sw9kbFLDEpYbGJaUadb0Qqdr7
	 E/WJZ8WVaCDqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] comedi: jr3_pci: Fix synchronous deletion of timer
Date: Thu,  1 May 2025 14:51:30 -0400
Message-Id: <20250501070655-60f20924d96dbe51@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250429120142.403147-1-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 44d9b3f584c59a606b521e7274e658d5b866c699

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  44d9b3f584c59 < -:  ------------- comedi: jr3_pci: Fix synchronous deletion of timer
-:  ------------- > 1:  af4d8d3875b9c comedi: jr3_pci: Fix synchronous deletion of timer
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

