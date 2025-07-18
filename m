Return-Path: <stable+bounces-163313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEADEB09936
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F2E17367B
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1970F13C9C4;
	Fri, 18 Jul 2025 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2YJ2c9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF402AF14
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802477; cv=none; b=nP1nTbUsoJk9yX9gfseEH1Z1L0tdt196iZibYnejh3LrH6rcITEiekaZ/LQW9ZeRfQvmB1HLz3LwusfHM2wzjIaI/DPVksQkktJkmAeQtMja8h/6//u7jm1mv8t4yNQ0dsrVVFI9g+qq1axmwCaJqwa+7fGxsbtldMLtxWDO2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802477; c=relaxed/simple;
	bh=N4tS0VJIcn7+sPABwd8CmdAXwGvPxWE2IKgTl3SOqBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bISFvacXuL4ocWldW9EE5r1xpUMKMqVO6sB1Plpm5we0Y7I2KhPDsAW1o+Kz/3nLQY3DLCJOmPvwqAyE3Gc5vpWyjw7O3QdKiVuSFI4EYOZcmN65MRj1DmT51kuH2vV+szEz6D80HP/ZHOHrqAhrmlqFTWqy9jocqYoGFyXBpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2YJ2c9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C35C4CEE3;
	Fri, 18 Jul 2025 01:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802476;
	bh=N4tS0VJIcn7+sPABwd8CmdAXwGvPxWE2IKgTl3SOqBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2YJ2c9dKi5m/tO8zi8qsMbsG2F/kNDp3oEf/bnCwqdRpJh7JBsuyGFfVowPxPmGM
	 KP+Ll5Vq6jhVhmKeyirh5dRgU+Uq3KiD/uU70omOCjesbvyWmYDQyzMWwuJ5XFQPef
	 gAP29KOdK6MwZo+Gl5VX5TRU6j+DqnBka2gZAFc1YbRlZsxH8ilNPbymnYjNaABR/Z
	 XtMjoU64CRGO/8Eci8Fhx7PdonP7K5K+ttrQcUy6x6y2uR+FRH5Dd5OIW3cbVaIpRd
	 fM5rRb+ZesuFW10YqaA1QDEyNY/uQWcTzRRQrd3puP0I6q3gJWNO/mv+IldLelWBUH
	 trTUIhd4tJriA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 3/6] net_sched: sch_sfq: don't allow 1 packet limit
Date: Thu, 17 Jul 2025 21:34:34 -0400
Message-Id: <1752797234-e3b45d71@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717124556.589696-4-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: 10685681bafce6febb39770f3387621bf5d67d0b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Commit author: Octavian Purdila <tavip@google.com>

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

