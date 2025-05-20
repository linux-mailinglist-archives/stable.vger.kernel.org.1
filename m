Return-Path: <stable+bounces-145032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07DABD1B7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB091BA13EC
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE24261372;
	Tue, 20 May 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/JNXUkc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97323BD0E
	for <stable@vger.kernel.org>; Tue, 20 May 2025 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729163; cv=none; b=rMwup0xio/Jn5oAwn0qnWw4lNxPAGE/OdjsGl01d2r3lretNSz9tvzoicD6ulKDmq247ycjyCMPCEuEU6RJJX7QI0wUoTe5J/5HllDUs0J2lIccoBFOwco3KGOYZgzt+4qRgCNad0vYkOfV+mIyiGaIEFs3kY9dp+bTQqGa503c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729163; c=relaxed/simple;
	bh=Kn6VTSgS9XbEGjDQlHiplHPqojlPHpJ8wd9KcROQMbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsQCun6ZhDdBc2z9pdzdIrwPigloCzzMfJMqiPOVlVSGdRQN+OfhGZ0SVH6o+JEf9miQx6VqS8l6V4c7Tf9HJNuLHiE16UoeudrUAOJrFjnn8Xr5xxDA2eHxo1RxPvSa8VnzqdH7M1+BeOMht7mytkDIg7KwMf36MGmPTnk4tx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/JNXUkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E13C4CEE9;
	Tue, 20 May 2025 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729162;
	bh=Kn6VTSgS9XbEGjDQlHiplHPqojlPHpJ8wd9KcROQMbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/JNXUkc99JLQug9/uApAsjeODN2eMeXMOyxjwcX3+HAm9ui2bUUrR+CzyCqLYSw1
	 i1WYhPhMWx+bgdkvgXqnLhMCuO32b0nQ4w2vXpgLTa7lf65KRSPDsh17jh85q+a2Sr
	 ag0zjX5+/u0jsy1Imn65elU6zqgoBIsIyUEE7u4WewYsKXBd4ef9Fidn60xEz9VoTI
	 A0VhmsbTMHkKs6zWa4Togp8tedvEyB8C3ufIw+PZaOZgxACsC2ALMCtiqRdW36J7La
	 382VADenejmDXD4Yml89jBQnxUxdea69X9mEUh4UblZ9YT3882WAIvkjG1xmurIRHX
	 5Qyw3Jj3dqtsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] powerpc/pseries: Fix scv instruction crash with kexec
Date: Tue, 20 May 2025 04:19:20 -0400
Message-Id: <20250519173002-8d21bff9aa9fa528@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519012816.3659046-2-Feng.Liu3@windriver.com>
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

The upstream commit SHA1 provided is correct: 21a741eb75f80397e5f7d3739e24d7d75e619011

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Nicholas Piggin<npiggin@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d10e3c39001e)
6.1.y | Present (different SHA1: c550679d6047)

Note: The patch differs from the upstream commit:
---
1:  21a741eb75f80 < -:  ------------- powerpc/pseries: Fix scv instruction crash with kexec
-:  ------------- > 1:  c013f06b90b03 powerpc/pseries: Fix scv instruction crash with kexec
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

