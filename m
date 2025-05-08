Return-Path: <stable+bounces-142902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27FBAB0034
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5048E4E7508
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF69280CD1;
	Thu,  8 May 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MugMLBWf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80322422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721188; cv=none; b=AdFJd9qPYcBAjQM8kVq/hLWVIciYKRyj5oB/t5ziuwsWAi9AID3gIMuElgPfSG2r+ZbNJUh2AuUYpcmnrSwvUfdNr3Ji5yb/VjYXK/kNoat3mJkjojzAKytmLQXOYjkZBbe/Ap5B7bFOXUW4qiDo/wU0GsyZP65FmAFxw1TqXuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721188; c=relaxed/simple;
	bh=3LILQQBa6rXzhKpx9mqT8PWgHmM14hxyolzRW2IzclI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIA0mIUQSZnacfoKexV8a8vj6j9J3w2s/aRDzHWbmeN0Ny08esn4Xu4Ps2B7G8tRzlqrHr/xrJWQIFMcKAXyDM5/Jfe8UGIv083HlvSfiUO8QFzxISmWYr3vUgdblwHsiJeIVM7UWn35LReRr5mzmxG1sk4LTvawZHJahVCWgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MugMLBWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF54C4CEEE;
	Thu,  8 May 2025 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721187;
	bh=3LILQQBa6rXzhKpx9mqT8PWgHmM14hxyolzRW2IzclI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MugMLBWfLS1rTUi4sYZVm7V2yyveIZTXTahVDK550RwIGqKQ/7xB6zv968IPXlqoD
	 /5yH0KAsAdTEhBCk3eA7bSeRJ7eRYmnRoCpYjdjqdEWXc374xKfC82AoUYbQYxvvUL
	 yj9FLk7f2VkRik9mYspsndGy85IqzZUc+vdJkdwKXuFcsMiQIaFWdrK+lpGQthJH/K
	 2Lkk9259yA1SQahARUnoMivsq/hTzcTKg9MOD0yR6Nl5qskd327BPhJ9ANqqPAHIjj
	 gF5d2uoBFkS/y9JJDXIe5UlDrFkNvBOVVH0kzaIrMRfSuhy7O6UGW6ihRXhimNwcAH
	 Qhddn1F3S+rIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 1/7] accel/ivpu: Make DB_ID and JOB_ID allocations incremental
Date: Thu,  8 May 2025 12:19:43 -0400
Message-Id: <20250507115642-348e239c584214d6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250505103334.79027-2-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: c3b0ec0fe0c7ebc4eb42ba60f7340ecdb7aae1a2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Tomasz Rusinowicz<tomasz.rusinowicz@intel.com>

Note: The patch differs from the upstream commit:
---
1:  c3b0ec0fe0c7e < -:  ------------- accel/ivpu: Make DB_ID and JOB_ID allocations incremental
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

