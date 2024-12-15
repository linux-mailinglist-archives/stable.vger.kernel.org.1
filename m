Return-Path: <stable+bounces-104287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8529F2524
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 18:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D64A18860BA
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8C1922D4;
	Sun, 15 Dec 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e55z/4Qw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2F1119A
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734285093; cv=none; b=uEQm7jrr1PTBrRpcSkwD5xEGqMJOzhGZo0xyq2IjCtf6uf+tn12I8vQREs6hSjg7hpNtTwuOhW/MiHfl2RZTxBPkeKJmAJZzkZq9QgOLXb0HPih9szHykRwLj+aC70sqXtAtS5bULSpUG5UPoDlL0+BJkXZF3T0Ur8u1lCX9Qns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734285093; c=relaxed/simple;
	bh=TxmLWAHFtyOa75aJj2ly9rAxoT4Dskp6Ze0JwF4BMf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgJ9kfQEVq8ien47KPPc5Aa+f8bvQglESdHXobLkPe6WTDuDvhtYGiGldWr47anv2CthKx8EUPrQRE6VD63kvB1nGeTSDJ06AU2UM1/d26eWcVQ7iji+20sO1dqAPOnLMAI384d9UC02h6ZEFQpKMpF9/kkY58rHtOYgLwKcE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e55z/4Qw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766A6C4CECE;
	Sun, 15 Dec 2024 17:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734285092;
	bh=TxmLWAHFtyOa75aJj2ly9rAxoT4Dskp6Ze0JwF4BMf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e55z/4QwFFNvlGDFlNQrM84QqYy+Hzq7i33wu7c0pBhvPW7oSg673dcCVx7sIxLzU
	 u8RCarDcXN82EddL4cFrZ4zYGumJ0gXP8m57N3qCqU2+WzFavGzhisJUhYdSUIQdJ0
	 k9CAVhUZqSG0KdiizYwj3yeILSAYQT53+92S/EofbBYcnBs1aZBM43A5+KAe5BQJzp
	 YoFOtwHxDj0SRavIGAd9GgL/Um/nMCU35krqu/9nceV76DkOdsLNDn+9vXXPYCqCUZ
	 itMG62Mo6Cqx1dRMC22T/o1n8cX5F4rpVoHRE09jHCMInyYw4SBq8rAkgYBaZl7MqG
	 wN+5tadS1G4cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] exfat: fix potential deadlock on __exfat_get_dentry_set
Date: Sun, 15 Dec 2024 12:51:31 -0500
Message-Id: <20241215092945-d5eebef117fc6a59@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241214221839.3274375-2-harshit.m.mogalapalli@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 89fc548767a2155231128cb98726d6d2ea1256c9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Commit author: Sungjong Seo <sj1557.seo@samsung.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a7ac198f8dba)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...

interdiff error output:
/home/sasha/stable/mailbot.sh: line 525: interdiff: command not found
interdiff failed, falling back to standard diff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

