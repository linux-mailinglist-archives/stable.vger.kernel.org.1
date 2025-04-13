Return-Path: <stable+bounces-132344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F91A872B0
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7121892FA3
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617061D7E37;
	Sun, 13 Apr 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBPjUZWa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8314A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562808; cv=none; b=giBGoGSIx2CfwF2opSwtS5nVuhfKjdR2+VNFLCB1TjyKPSXN3sMB27/Rh/ZMMKlEXwPDhvlYNGuvWgtsh1fz1yrV6ks/5DX6hxzIJ5w2fjJFS70kRUV5zZnDKFlJSEYo6GXEKcdEJllOz6FB1jkLsEk20pUQbZ4cf9tffphi6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562808; c=relaxed/simple;
	bh=MsXyMuoM9cbnJMxVXg80JRLFAP6SwbCPGIUzHYXo5DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJsh5sdPmvJ7aGhP5qllaux8JcxxN8MDdeIwwAGJd/k4o1lcAc2viC/x9TP/KcBgYONqF5NSpg9ZkFeKEqZabZQ3cpOCUjCwrZtuSuypAEKc+CaZh3QyCDu5+7h+NoOc6yxwBaXexYX1LnkjBAsygSKwHAaUDukjPwkJkgMczfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBPjUZWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F996C4CEDD;
	Sun, 13 Apr 2025 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562807;
	bh=MsXyMuoM9cbnJMxVXg80JRLFAP6SwbCPGIUzHYXo5DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBPjUZWaCZGxsWg+rUei2N+Af/eQdNaFaG5LjmxpxIyvkDIEUuqcouXxroUm2no6v
	 9NCMixU6ugoFbd1UoDcaN13zoZkNl27Z7qECBCZm/lv3N0jWVQMwLUH/BbCO2uzjOg
	 aITA6EB/CXTBUN2I8CABw9HEn0HAByvIr7ADjwDBgzVNjVeUDpvXs7Q/QNcKGgGSM8
	 6Y6m0evq76BxxUMVeRH5tJ6xsj1xTxYWoPxqB+UAL01rExduIsNL7gZcV8NgY4oXc4
	 eVeUfga7vQTHOfZo5d7n0J3baGqKhZDc2jZ44mw/hIsqK5nm7rvWLAW/KcJbqiJQm4
	 IWUJJhF2FFv5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sauerwein <dssauerw@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
Date: Sun, 13 Apr 2025 12:46:45 -0400
Message-Id: <20250412095109-13b29e5a284c2d53@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411154758.57959-1-dssauerw@amazon.de>
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

The upstream commit SHA1 provided is correct: 7601df8031fd67310af891897ef6cc0df4209305

WARNING: Author mismatch between patch and upstream commit:
Backport author: David Sauerwein<dssauerw@amazon.de>
Commit author: Oleg Nesterov<oleg@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3820b0fac773)
6.1.y | Present (different SHA1: cf4b8c39b9a0)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7601df8031fd6 < -:  ------------- fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
-:  ------------- > 1:  9205eb3b53ba2 fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

