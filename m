Return-Path: <stable+bounces-134897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B168A95ADA
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B566D1755E7
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D12916132F;
	Tue, 22 Apr 2025 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0dP3SOG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC213AD1C
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288151; cv=none; b=Cq9u35gwZYgq14IP8L9x6K/j0i4hUAIweBeSeux/DCZPGz3XMsOaL8+yiiFW33N3QunouyoNcbK1SP9YrDare0+a5ezew53AYZsW+scxnPAUcHxxb/61AV29rpkSzWV48ddLch1RFlszVQzknisJeVWbqDxqMxTGdv3HOfF0t7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288151; c=relaxed/simple;
	bh=Dv8PlSfk9kFQ0EHcwJqWpKskIW1K7JMRlTngsy2NwQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWySmqoST8TgKID6KrNBvzdn2CwOcIrBnwheSRuqgEAcFKePkmJpaoa1bemB27rLl6rMiv1g2QGMfONeyNItXOlHtmHilcvorf0babIbNCO7IRhus/0xu4fhw3hnobrLooxQqcA4QGki6LZdN6BzPceAX5/g2pd8/VjRIUjEv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0dP3SOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6454C4CEE4;
	Tue, 22 Apr 2025 02:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288151;
	bh=Dv8PlSfk9kFQ0EHcwJqWpKskIW1K7JMRlTngsy2NwQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0dP3SOGhZHyNIXcI2KTCqDymxUGmRk+uXaDzrJ/eGt0F/+eeqGhuI8jWvq7RFX9x
	 cjmbTkIKzrGOLxQMsTcLTGFDLjPJpjx30DWrS+z46X6qztuGaIjBwPFt1VfeW4PLWs
	 /irnp7tYmB5/Z/edACALVxpY/bkkVPwWJ/15JBShRYCW+zLSCwDTT9R185AnON0Vv1
	 fZ+plQo8mxkvAJdk3TofEttsBEOlPq2uRoswga9cInvvHgHLFnDYxf3v0MdGJi/NVY
	 YrAWAVcvCQZ8OJuepw22lrEsev6pzWaWpzk8/pscGLxeIR85UMIIqQi0+b9d0NFJIq
	 LrUw4tVehlV+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12] lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
Date: Mon, 21 Apr 2025 22:15:49 -0400
Message-Id: <20250421194522-33bb432a057eca5d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250421153918.3248505-2-nathan@kernel.org>
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

The upstream commit SHA1 provided is correct: ed2b548f1017586c44f50654ef9febb42d491f31

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nathan Chancellor<nathan@kernel.org>
Commit author: Kees Cook<kees@kernel.org>

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ed2b548f10175 < -:  ------------- ubsan/overflow: Rework integer overflow sanitizer option to turn on everything
-:  ------------- > 1:  e3de54ebc19aa lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

