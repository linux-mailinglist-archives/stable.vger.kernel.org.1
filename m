Return-Path: <stable+bounces-119991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90569A4A87E
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9061175A2E
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AFB1519BE;
	Sat,  1 Mar 2025 04:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe4mD7ZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389652C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802868; cv=none; b=d4C6zHxleTYO0cBkO/UvJGNkSD13b4BpZgAIYJNuj6azjOygf5gEPL6xzNMBFopjRwcm6pYnmz4ioQMLjeLT6QUDp3id0/4nR5A6Adbj+S1varvrpVEPzwkhiliJ8IQUsHQv22z6hyzlLdd2tasrQpf42Gt84zLreJbxF/SsWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802868; c=relaxed/simple;
	bh=1Nsi8Xuno69V1lpJuzZ9/cpO02grSbDCADPPctQ8Seg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqW3Za4g9xXzsP+NhGLT2IpxtPWrDfZKWef4bO4bie/pFZmAus4yuNxI77TN2U7LNEFe58FQiE6E5yb7bWDStENgDqMRB+iG5+4CrdhB7+PZPXZ2dL3EPjMbKvk4Fi239ygRlOhusWkYU1vymKWNj7+vd+VRIVknSsCLeXSXQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe4mD7ZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7149FC4CEF3;
	Sat,  1 Mar 2025 04:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802867;
	bh=1Nsi8Xuno69V1lpJuzZ9/cpO02grSbDCADPPctQ8Seg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qe4mD7ZJ/o3CqzTg1nIN0LLxxaOMz1wHswO2i32gjEOQoDWEnP81SHjo+hPpnbl11
	 t/X8hZVbbHj+ub2A2mRReZUpwc2/rGxBx0qkdsph6OnolK7CmQ0a9P2VghAKS/phdQ
	 jqerKj6M/08syCHqYuU/zJJDaCt+ldrUuCXkGHX3bBOwOX8HP04Jje4DMzp3eecdyQ
	 QKwaoiJ81CLT7kgX0Xugtw6LOu5FlGxw2oRiQdJlyaW3EPP5GpDHiv1hXKX42zPBeq
	 bvRG16BtA33XpTVqMfHpHxUx6zVyo5YeUChqxIvdZyVSJNYy5pEDxHOM+IJrShsPE7
	 jLaNxh1bYXKgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] media: uvcvideo: Remove dangling pointers
Date: Fri, 28 Feb 2025 23:20:44 -0500
Message-Id: <20250228185437-e7697605e8039f73@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228083505.2713073-1-ribalda@chromium.org>
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

Summary of potential issues:
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 221cd51efe4565501a3dbf04cc011b537dcce7fb

Status in newer kernel trees:
6.13.y | Present (different SHA1: 9edc7d25f7e4)
6.12.y | Present (different SHA1: 438bda062b2c)
6.6.y | Present (different SHA1: 4dbaa738c583)
6.1.y | Present (different SHA1: ccc601afaf47)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-5.4.y. Reject:

diff a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c	(rejected hunks)
@@ -1577,7 +1612,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (!rollback && handle &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			ctrl->handle = handle;
+			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
 	return 0;

