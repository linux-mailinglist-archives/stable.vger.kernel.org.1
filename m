Return-Path: <stable+bounces-164811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5937B12852
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 03:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8315D3BDB72
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A87199FD0;
	Sat, 26 Jul 2025 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXQDv/B5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379402E36E6
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491689; cv=none; b=qjcIMXRaGLUhFPG6HRuIR7Oml+FT5XBYsMdQMkavixlS3StfauANRWYW8keknrX0ghfee8DRDulOq4Xp0R5oYYuZWtUQ0O8WRuC6W175zRgmaaJLHjj4leIHyUARanVL0WdazLTSQvH9pKDJAZmxRd2XyG2M9PLu25M46oaDlKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491689; c=relaxed/simple;
	bh=o3c0mftP2Ly3Blw2TtsKE2jv8cKFu0OeyAQzi5aUCZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PefWOPEf3FbuX53UYyZje6+hg65oWQFS02WbzJ8iCtd6R7aV1tFqgwNXSTFGE1oDzcgATO6KMFT+Hd3jbuHKsW+CuUj5j5tvXPH+vVhj/Gx1GH91vcCLbLPBAhCeDZt5eIcbCJatTXbpHR8WOm9axel7AUWs/vYQ6C+QmlABqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXQDv/B5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E52C4CEE7;
	Sat, 26 Jul 2025 01:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753491689;
	bh=o3c0mftP2Ly3Blw2TtsKE2jv8cKFu0OeyAQzi5aUCZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXQDv/B5HxmTaKB5tKOHp9NT5KM7L1vX0b87H6j7Crjoe85OESgbXG+JBCUiBKpuu
	 Usnr+cj4fMNr95+gmdgxcUHLe/SewivvhfSTFHtbgavOkK1Kj2OyAtUD1owfmNcf5+
	 Ys9RKqDcHc9eqGrj78XlD1BcJf9wfvx/pEcpjlEhbu684U3zOyZD2jj13dfArho9ys
	 YNnfdCwOCwwCiKKeKpJSAvOst5U0knZrAoPGMv/FmAdTG0qFe/C7NbW51BDnQhbGIr
	 S9vydnVspeLj5Xh4au7OVXoyf1nyJqhksfZBmiyegP+4kwqse6aLGEeYTQzznZfQRa
	 TdZ3ri3STkNJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Fri, 25 Jul 2025 21:01:26 -0400
Message-Id: <1753465523-11ca8c31@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724182218.292203-9-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 1b98304c09a0192598d0767f1eb8c83d7e793091

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1b98304c09a0 < -:  ------------ comedi: comedi_test: Fix possible deletion of uninitialized timers
-:  ------------ > 1:  99ae1f59c7ad comedi: comedi_test: Fix possible deletion of uninitialized timers

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.4.y        | Success     | Success    |

