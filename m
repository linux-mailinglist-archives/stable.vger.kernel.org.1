Return-Path: <stable+bounces-144684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED41ABAA3C
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBE61B63EFE
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC24155393;
	Sat, 17 May 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd88qx9q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC7B35979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487327; cv=none; b=pJBqJG5nxCiyn2Ta0KBCGs8HVQj3UuGjWkMceDoWKvoaSMX+T8Bbr9MrD/D0QW8iGfc3SxnBwtTyk/Sjs47qHpw9KjMYjAWlh46RhSNfyHm7LTo+4szkUtwVo3MCDb1xF6X27+33z1ECrnpmNMiUx2R4FLcREI4DR94dKVX29Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487327; c=relaxed/simple;
	bh=peaPTP/9wJESfxY4XKYchOkrReTAby3uicQjPpX7MhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWgXPoiWh8NaXlnjiTjVJHLppg+AR2R+CBctnricU9Et+A5U8kDHWdDYDu7CQJ4exLPbhRpT6Uk/Y08eEhBX6cApGwXIhdhdWqYGamSoM8IKoRPq+ndipM5lsId8XIDYsW5j3WVxbV/m3TmhnyYwNhJav1SiOMr2r4JvJizvF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd88qx9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CFAC4CEE3;
	Sat, 17 May 2025 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487326;
	bh=peaPTP/9wJESfxY4XKYchOkrReTAby3uicQjPpX7MhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jd88qx9qw/SIhZ86jZc7XtDCiSneVNcQgrYIl+LKqugGxI6Rb9sVCIX78kaeJOty9
	 CIt1ZpP3pcoJnjGc2ROJZsmf78/fPNIOsyce7qfqhR2v9AHmWGMvlIvpQrcQyc/yol
	 GUbBhv2T9DtD1WuFaZf7fBmJJkmS6WhrW9s7DQUA/JZLUMcTnaH+I+qQn/FS4ediJP
	 LcuhFAI+p9GtHvYScOyzPbP4NmIAwv57QiqO3UPCrTkeAVRHc4bRP9XvyJ8uM4u0Un
	 NHiCIdgujcOLbGGlKo7dlZ1cMOChj8dGDjQF8bdkNGQiCd/4o/t44cHN2zv5TEabNB
	 YxCP+ohA0FIXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 09/16] x86/alternatives: Remove faulty optimization
Date: Sat, 17 May 2025 09:08:44 -0400
Message-Id: <20250516215242-0e2631018bcb6921@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-9-16fcdaaea544@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 4ba89dd6ddeca2a733bdaed7c9a5cbe4e19d9124

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Josh Poimboeuf<jpoimboe@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: de5d7298bcd0)

Note: The patch differs from the upstream commit:
---
1:  4ba89dd6ddeca < -:  ------------- x86/alternatives: Remove faulty optimization
-:  ------------- > 1:  3b8db0e4f2631 Linux 5.15.182
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

