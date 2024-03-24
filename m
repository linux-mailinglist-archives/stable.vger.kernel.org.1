Return-Path: <stable+bounces-30534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27B88922D
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB2B1C2DD70
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C4D1B5DC1;
	Mon, 25 Mar 2024 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJRMwtCE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305012733EC;
	Sun, 24 Mar 2024 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323322; cv=none; b=m4h0MEotB0pu8/UVOSpcGNjlgvIyRgcFRiAucLD+cVmcjgTWPn58g5U9A7c5tLEdU94awW3lfSJssponZp+ohDuYPUdh8rh0APhhC/CwmeVkHt3+putiXoRrpwp6xOpT6pJ+I06DzRNyfe5NuqFW2657eG4PHaBPQzg1NSk5YFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323322; c=relaxed/simple;
	bh=GnWtl6l52l+gUbfZkM8BRybvjTAPzKv3zjCkOuB8YF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERs2z588yUaqfhMJQG/vy5LTw9mc6DJoKyyCFfEu+QE+L0FTz/J6ChnFI80gJKz52j49mSozNYrgVvy7qLJslevqtL9pz5cB2DXBFpYIqMSrGapQDVBixJViJgXFdeKnybUxA6EaeoBowOyYa9gzFMCf/eMWSHqbYfk0bkeQXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJRMwtCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678D0C433A6;
	Sun, 24 Mar 2024 23:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323321;
	bh=GnWtl6l52l+gUbfZkM8BRybvjTAPzKv3zjCkOuB8YF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJRMwtCEkb9j11WnPVx1r2IxZaUMM0vFrm/TscpzxPjndHUHvcJomQSbZbDo91DYo
	 gPqmLgt+1wGzaKynMcadqrRFRHWIXJDNkXOr7ZkgtmYGqvK4ssryzYf5LSVjO9gmQY
	 vX9MRDBc6y2rsodtxRxm9tH+NUe/wwlAeh86uunOQ5fWK2gHo1okE3QYIgvK1+I3gf
	 h+WOCpc4VMufjRLYrlQrt3ux/ODFSpxE6CahZuYV32yU0zoc7Gj3x30ynDfkdKeSBg
	 oyb4SV/fnA1/6t+9iOYS1YxaNCpJmT7AYqScmJaXCYicXHFxkmKetlZsW62Iw7dQr3
	 7AgQ+UnF2OYkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 021/317] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Sun, 24 Mar 2024 19:30:01 -0400
Message-ID: <20240324233458.1352854-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit ee0017c3ed8a8abfa4d40e42f908fb38c31e7515 ]

If the driver detects that the controller is not ready before sending the
first IOC facts command, it will wait for a maximum of 10 seconds for it to
become ready. However, even if the controller becomes ready within 10
seconds, the driver will still issue a diagnostic reset.

Modify the driver to avoid sending a diag reset if the controller becomes
ready within the 10-second wait time.

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20240221071724.14986-1-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index e524e1fc53fa3..8325875bfc4ed 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7238,7 +7238,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 		return -EFAULT;
 	}
 
- issue_diag_reset:
+	return 0;
+
+issue_diag_reset:
 	rc = _base_diag_reset(ioc);
 	return rc;
 }
-- 
2.43.0


