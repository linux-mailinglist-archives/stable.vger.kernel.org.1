Return-Path: <stable+bounces-95406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493A9D8912
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A08E287062
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9937A1B3930;
	Mon, 25 Nov 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUoP75u7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE31AF0D5
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548057; cv=none; b=arSAZj0sHtHYrzqdwbnmWxtK+JTllPzIXGV1eKmfleQzARlbQRxxQrAzICHWO4fefTt6vTCGYqCY3IvfE4pIFbqLx/CLdIMZUrzaADyiV+JTqMpSjFsxBdmsSoLnB4DGotXmrZBrjnFAlLdqFSU+3RbGrwlbqW4xFyuDdziRMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548057; c=relaxed/simple;
	bh=gsLUqlBPk8I2eMwd9RP+/jW5ax32bn9liAUihT+SATQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxig2Qgqsi6oMg3bojSUx93jAZwYr0ph+Snabzzwu+WLttTp88O1oQozmVzwmR80rDQOmW2laBYTyYxB0Lpelc+B5lOjjGzsn90Jjb2xYEqzPK6bShHelS87dZwFWtCODovFHUzzLndyfxfIWGql/Af4Tv6mhEp0iRIhy4VPZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUoP75u7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50E8C4CECF;
	Mon, 25 Nov 2024 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548057;
	bh=gsLUqlBPk8I2eMwd9RP+/jW5ax32bn9liAUihT+SATQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUoP75u75bjNQMtvaY4Xg09pWeMlN5hIIhHcK1zBEvoXbEt33sXUvZN7YYJHK8VFj
	 MLcFUWqhHrH7/BhT5hfiB2QHjP/ESWu+B1oagem8ufZZyd+gO8P7PC6hTUehWynk61
	 kOkvm0h9mtM7NnWmJg8uXdaZ+qcwTKZxvFpkYd5h5ua8stlShZphrDfkOHx1TP9C6Q
	 /+sxF+jz7LvvMxbu4T3xRnQtAPWPgUKWyMgdmdv0cw4h8s2KvLHgYUd+yQwGciozcA
	 1x9eMpkA5OdGQYAmo0qIpdQYYhl16dK64islJCEa9cj6J1xZE1m+2LUFFpCPe2NIdc
	 t3WHwQaX5ibZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 3/3] net: fec: make PPS channel configurable
Date: Mon, 25 Nov 2024 10:20:55 -0500
Message-ID: <20241125092936-8008bf13218ad74b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125091639.2729916-4-csokas.bence@prolan.hu>
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

Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 09:25:02.822819093 -0500
+++ /tmp/tmp.NUygUEJTBz	2024-11-25 09:25:02.816734590 -0500
@@ -10,12 +10,15 @@
 Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
 Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
 Signed-off-by: Paolo Abeni <pabeni@redhat.com>
+
+(cherry picked from commit 566c2d83887f0570056833102adc5b88e681b0c7)
+Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
 ---
  drivers/net/ethernet/freescale/fec_ptp.c | 6 ++++--
  1 file changed, 4 insertions(+), 2 deletions(-)
 
 diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
-index 37e1c895f1b86..7f6b574320716 100644
+index 37e1c895f1b8..7f6b57432071 100644
 --- a/drivers/net/ethernet/freescale/fec_ptp.c
 +++ b/drivers/net/ethernet/freescale/fec_ptp.c
 @@ -523,8 +523,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
@@ -44,3 +47,7 @@
  	fep->ptp_caps.max_adj = 250000000;
  	fep->ptp_caps.n_alarm = 0;
  	fep->ptp_caps.n_ext_ts = 0;
+-- 
+2.34.1
+
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

