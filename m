Return-Path: <stable+bounces-124815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2C8A6775A
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BDB17A638
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C5620E702;
	Tue, 18 Mar 2025 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYIuzzAP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FA186294
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310760; cv=none; b=RQ4BYzA3pYCX+Q35XGD3NWcOO4gF+Qxg9X7H+XXMLziDFCkGNac386VscJ/d/7sJuIL/vMPIhMv5gC8meZhwFfyf7uSqtH3CQO8dyTRIkPsZ6mWGBoj/JjF/DCjpMbZvzdhV/f1rThoA7z2veXaVXrZaAqzLStBRGzUjdN4MbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310760; c=relaxed/simple;
	bh=vnja9mGuzfYKv8VfaCKck6bR+tqIgqJztfDyJZ1LxHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpZOEuuUwjWq1CfFc2XYMjYG5IbpX19MLNyZ1CL6E1RiiwJyKzlzOya+ZzezCWvQ4Rv5owjAbyDA8CUddd2pZLFFwQ7taOpNveznEd0S0p5cOj3jTro1idui45fCDIY4vG81UnB3BuFBOmpWxs2gCq6lHDoof4+khpOGxOO4lEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYIuzzAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936CBC4CEDD;
	Tue, 18 Mar 2025 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310760;
	bh=vnja9mGuzfYKv8VfaCKck6bR+tqIgqJztfDyJZ1LxHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYIuzzAPfknL6DY38ODD/eFDqj5q/z6wba58IWeP+sQnA6MTeClN1NBROwiEW6K7Q
	 xmRYMtIMb5vnmuYHEhk31rO3hnS9qg82DhAPNxbd4s6NzFJNTYqs1CFdKFNMFdYEOA
	 5VjDc4bdp1Xh7BIq0kj/pR7Eo8nVn2KNn/UV0K1ZcrIUNecRYKk2urF9ZrHAriukzC
	 iSoy2KLY7/Orvjzoq93NKIP7AVvCB8Xms58MrvRQsc+D12t2f5t8LDhDiAkLpuJdTU
	 geI4MEg89yJll5w89oqLAEchovm+gC1uCxBe5GDXRyP3tp4Tg2zR9j8ijbseeuMUWC
	 +Vk3GzYOVe3ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	henrique.carvalho@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] smb: client: Fix match_session bug preventing session reuse
Date: Tue, 18 Mar 2025 11:12:38 -0400
Message-Id: <20250317210251-f82934e17360e688@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317221409.2644272-1-henrique.carvalho@suse.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 605b249ea96770ac4fac4b8510a99e0f8442be5e

Status in newer kernel trees:
6.13.y | Present (different SHA1: 4a133bda03ec)

Note: The patch differs from the upstream commit:
---
1:  605b249ea9677 ! 1:  7f254bc22751a smb: client: Fix match_session bug preventing session reuse
    @@ Commit message
         Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
         Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    (cherry picked from commit 605b249ea96770ac4fac4b8510a99e0f8442be5e)
     
      ## fs/smb/client/connect.c ##
     @@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
    @@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
     +		return 0;
     +
     +	switch (ctx_sec) {
    -+	case IAKerb:
      	case Kerberos:
      		if (!uid_eq(ctx->cred_uid, ses->cred_uid))
      			return 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

