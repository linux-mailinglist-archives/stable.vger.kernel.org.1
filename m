Return-Path: <stable+bounces-110185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF46A193B1
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2F17A4B6E
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8F52139A6;
	Wed, 22 Jan 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDxqh7ih"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393B212D6E
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555401; cv=none; b=uNy1Z+P4RwyNQqjeZt10EiR9OqqGkyJkR52DWTe1LItG7Vn2nHSpyfcOuxcB51Zjggc4MLDS3tnR8/IB/LQq3K+MUGZZD8lE0/+UunqijC6RsmofoI1GeE776us5NUrp+QRBFRLaJIfUuItmVdTUiBtxoBTMp8OJTNhkNMZ8VDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555401; c=relaxed/simple;
	bh=i8DIe7Pzcmjn7lfhm5XddMvP0FzwEkdHZYuaUuHL7Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bn5rZbXYpSvhwP3XTyMXQDOLhqyJ+CYlzj1f5BsUz+9a+lxTWAwVP4/C+9ylsvyfieP30OdZ+QFyzoJ+o2/RcDrarjIGWrOeWcF05iUZDchVB9uEmxz8IzPPQ3G6Px8ywMnIa/Mej6qP0EaMe4OlhALyYbLcziI1pUK2y4IGvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDxqh7ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074DEC4CED2;
	Wed, 22 Jan 2025 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555400;
	bh=i8DIe7Pzcmjn7lfhm5XddMvP0FzwEkdHZYuaUuHL7Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDxqh7ihUT9Iy6HhRrhOZjjF0u9Fkd/uPvI9/h2qMG6RZPs9lt8O9JV0WboznmkMl
	 QTh9WgRNID8MbIIwl2kFdReDV1zuzK75EQD3GOfpk6DFTUjr2B7nLZGXogwSca5z7j
	 cKEA3zxxrm/mFBMhcUD4PalT/iscdnvurpJoEFGfaNTirfyA3dF6Zlq84BUQfkF5IK
	 4FREqTNDTwSoLJuo/VnoBnUj2FOfh+zybUa0sV+8YLmH8oiS34SSOPsH3qUMoFGtN5
	 +2Cx5vEy3pW6e2JHwZ+1SDr6XhA4KWcGK+OUzobpap5WPrhLSkVmdghlZICzzPR9mJ
	 JdZ1hanC8buig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] KVM: x86: switch hugepage recovery thread to vhost_task
Date: Wed, 22 Jan 2025 09:16:38 -0500
Message-Id: <20250122085127-320a0ea13bb20920@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <Z4Uy1beVh78KoBqN@kbusch-mbp>
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

Found matching upstream commit: d96c77bd4eeba469bddbbb14323d2191684da82a

WARNING: Author mismatch between patch and found commit:
Backport author: Keith Busch<kbusch@kernel.org>
Commit author: Paolo Bonzini<pbonzini@redhat.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 91248a2e4101)

Note: The patch differs from the upstream commit:
---
1:  d96c77bd4eeba < -:  ------------- KVM: x86: switch hugepage recovery thread to vhost_task
-:  ------------- > 1:  d7ca669c0cbba KVM: x86: switch hugepage recovery thread to vhost_task
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

