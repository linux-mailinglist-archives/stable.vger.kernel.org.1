Return-Path: <stable+bounces-139342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A8AA631B
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F0C9A69CF
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3351EDA2B;
	Thu,  1 May 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHkygMSb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6671C1F22
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125446; cv=none; b=BrCovgAq2gs5cjyu4htDUcaa8C7+Q15Tx4/HVldIfrIOJHMg6MZ9zP71Xyw3QsJ6PU+LAtaot1Cg+Kn4sf4ZajtzcPeKUvo0MIJC6tlCZBcv8fKmFb7J2TNcy6DzSUqOpEHQ5B2YKnrQAaddKnKc9FQJl5GfG9iYJt6MSGa9BSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125446; c=relaxed/simple;
	bh=uvePt0uFGHVLoGf6WYLqCsp01yu+o9DqXCscSBXgWWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSpIm/qHBWXjMU0K7s4d17qzlovHkjEOTUSVdc6j3lbeL8bXWrQLGBgXl3hs3nMYKUJgiRI8DxGMh7qlcAwt1JPXHwO/jFbugmtswGy9y/kU9C1oEehnqKTwa9ydAn889aKXQCDY4ZCOrJJNIDuH3X1wdsE4B0norWkHAKkXGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHkygMSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE847C4CEE3;
	Thu,  1 May 2025 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125445;
	bh=uvePt0uFGHVLoGf6WYLqCsp01yu+o9DqXCscSBXgWWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHkygMSbjzYd12Ojrh9gO3Gvw/GbsjbB8iw9mWw29TLHt3nXOJuhMMcZDpwSs9FuD
	 +I2twC5XrvRGBSEJJpVeNpNxe4wPN1KtTeSHdVYuTm8X1uAAPBNx09FldNh3Y07vR/
	 FIor5aABeNzh9Ldy+2olBsYQ6REWunfEBO/GyhqdSXprrggQX6XcpwgUUuMzSiB3an
	 15402o4iHWw8Yv9zUtrHKm3n17nFxdgWI3FSbe9xFeJtwUr0ZxbIKbWVMP6CzIHcHd
	 gZTXxh1FQujBYPEQo4ncVaA7FsQpTWAzzfRGAEBBvANG8CxfZ1HcSvlJDC1yjpHyT8
	 czSPInvlnFIzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6/7] accel/ivpu: Fix locking order in ivpu_job_submit
Date: Thu,  1 May 2025 14:50:40 -0400
Message-Id: <20250501115927-1f5655c461306399@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430124819.3761263-7-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: ab680dc6c78aa035e944ecc8c48a1caab9f39924

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  ab680dc6c78aa < -:  ------------- accel/ivpu: Fix locking order in ivpu_job_submit
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

