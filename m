Return-Path: <stable+bounces-132863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60903A9067E
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6AE8A4D01
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7701AC892;
	Wed, 16 Apr 2025 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnChpWtb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE52C9D
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813483; cv=none; b=NeXJ6S25BRs6hseQCRAVWjL5bUL242tukSsWdSzflEQydJaZkDB1rwQ1EIGCvWdwPYDIHsVYszY8Ne7r/JeW5sphd/d7yTJcOZXF70HGb9+wxJ0woDGHiCkSNKfsPM1xBHmyP1zI/hWX3aAP6OI7oVKDTw85gvSa2ovQvyTw7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813483; c=relaxed/simple;
	bh=HDml8SvaNJDJi11P4KMGv3x/y/dSWOupFTWfPNuiHfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0iMmvMfuoD2MXhBrW+uD1P/ISuaVCuiJIdB8CrjZHqDzOxLUKCmTV9AeZeWxFDgP4cQs2YHy3POM8PfUi1pAZqjDo6DOgn/+TTjZIcYeaJCWsruRErcrBZYCBoSIP93VtCC3yllZjbfiFtiMW6qYEd+jGtBLWD9yPoxMHpkTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnChpWtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479D2C4CEE2;
	Wed, 16 Apr 2025 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813482;
	bh=HDml8SvaNJDJi11P4KMGv3x/y/dSWOupFTWfPNuiHfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnChpWtb4hXjcdD9ZM5J0gW2FkfJ+S8E1v74MIfEtxcjoMs1t/YYTLmKBJck47pUk
	 SURg5QsIuSCHCkZJxpHN4D5m+HL47XcK6C/KYUIaV8sQa6lDvtDifrAmuBMQJHji7i
	 zzolYwKZtjxM7O/0OJh+k0ar7xzxyB3d4ZLSDo+OumqJRyos/BrWyqJOb2venmpV06
	 CcLLYRwshGmTYVYMbQCN6jqpUVZzwIpxSa1LQsDCJd/6qKxWbWv5sB95rNbIcXWstG
	 n92by34Iy2oGJBoEKDUgL/Y6Q0fI1Mzfhs0DjYyGwg1Si+H8pX75cl7AaiMjYsqstv
	 MLB+/LKHffqyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()
Date: Wed, 16 Apr 2025 10:24:40 -0400
Message-Id: <20250416093330-864042838b9a9f93@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416010252.388173-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 4e8771a3666c8f216eefd6bd2fd50121c6c437db

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: ChenXiaoSong<chenxiaosong@kylinos.cn>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 07f384c5be1f)

Note: The patch differs from the upstream commit:
---
1:  4e8771a3666c8 < -:  ------------- smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()
-:  ------------- > 1:  508cc483bf4d7 smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

