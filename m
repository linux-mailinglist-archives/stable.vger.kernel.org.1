Return-Path: <stable+bounces-158574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B755AE85B3
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D617B317B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1D17BEBF;
	Wed, 25 Jun 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkZHq+1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB225EFB5
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860442; cv=none; b=EW2BwcIGV1XaAxbd2L7Md4KOGDrYanJu6vb2hYrmSFjpw32IenhgDmXv0BpJ6/pFd2YRZIeY8idG5haDyrVbTk9ZyipRvz7j3R/Kc2rrkO7Jx5Nx6R2Rlxb1mECDMj2h9j1LSFAC1EYYy78R9QsSxsQUmPM4tE3sJ92tBLliRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860442; c=relaxed/simple;
	bh=PZJDOP2ZAsi9SqViziXgzyPsbLggoJf4TneiNWFbLSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdMAYTNjt8PA+o/N0XTdU6f7wU6WvW+5IrJdhK5AKEfs8UD8nI6CLPcnHszn+Ai12DlZ0b9vtO5h5bwxg852iwmjwr6ipH8BDQLZThIm4jUock5JUlaWHaqY80IlqZ6N7y2fYoa9CpMT7FvIRzGul5Yo6fDlHP1EOqagQBq6zcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkZHq+1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8522FC4CEEA;
	Wed, 25 Jun 2025 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860442;
	bh=PZJDOP2ZAsi9SqViziXgzyPsbLggoJf4TneiNWFbLSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkZHq+1p8b49LD61jP0TRYtRdrEQbnL/X0EmsYP6cfPi5IATDROCbZMh73rWJVB9d
	 XbdOE4fGjXd0XcVO81KJ4/Yei0VWMp39ksAx9tZ5bWS4k4WX70kuWsPDVxyb5APrui
	 Zdf0liYDgJ9P3j/lpsEdhSN1Ftht+gJLJaSHFJQUZmWmAQR2eOR9Vda7CvwrsO4Ue1
	 3Tb+JWxrH+Px04spBRWetg1/TBz9za2sIIccyZBkApRiGx1HrIFWQm/wmi9nYSo4i7
	 XRsDLtq28Z90oBZ9P9XoTFPdG0LJOpznlhZRQRyU+4PcEoQN5SWNrfYLRjFXFHmzKk
	 GGH0yZEw38JAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] s390/entry: Fix last breaking event handling in case of stack corruption
Date: Wed, 25 Jun 2025 10:07:21 -0400
Message-Id: <20250624200321-5a1e95cc8e416a1f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623131131.783064-1-hca@linux.ibm.com>
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

Note: The patch differs from the upstream commit:
---
1:  ae952eea6f4a7 < -:  ------------- s390/entry: Fix last breaking event handling in case of stack corruption
-:  ------------- > 1:  ef0214542a9f0 s390/entry: Fix last breaking event handling in case of stack corruption
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

