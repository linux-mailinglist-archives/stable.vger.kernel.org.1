Return-Path: <stable+bounces-22950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D4B85DE65
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DD91C23B04
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24553D981;
	Wed, 21 Feb 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LqScBrh8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDCF76905;
	Wed, 21 Feb 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525062; cv=none; b=joanR4pJ70JguHzAr43/Fh9eyk5FCX883H1PP9sboNWX0huMd5M3pLScxMQpxndn9wYNOc/pHm1K3A913ixfgJtCveNCe+Ff/V4MHm58GmnDwnOAobHDNdkRD2YPRwZs2zDEDS8rjxQ5IL2bcg/SbS1HPN9ZUTkNEQlvVLa5fkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525062; c=relaxed/simple;
	bh=inLnIJGZl5EPlSKpz6OQ+HlLtOEhyBPwFfAC4Uh9NwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW78nkOdeWI0BFFezNGWZRSgiy8O22UImlvgHJnpoWXYJJR/uux5H8G9p6RXhgLZ1apgHngNqsveByjzy33ylSsRI2f3+0jediReOTh0t56ATOCQ92ie/+PsLoGND5M/r4nHNFUFrYhz2IKlHZtMMK6S3hjC21RIe7LDt1DLc4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LqScBrh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B8DC433C7;
	Wed, 21 Feb 2024 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525062;
	bh=inLnIJGZl5EPlSKpz6OQ+HlLtOEhyBPwFfAC4Uh9NwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqScBrh85TyRdGy/14fwR5O5ghEsZ5LshemIxQQ8zrnIZgFziGzYZimV5v9M3SL+7
	 v2Unl1jpRNVWCPeY7qniWaOa66t20MKE8btVI4HoTOtpEYORQH7eUKqi/xJkU9stEa
	 qLY6XtLUcyfhMb45uHhENwmYFcZUuFE+5fjhaRh8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Subject: [PATCH 5.4 050/267] drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking
Date: Wed, 21 Feb 2024 14:06:31 +0100
Message-ID: <20240221125941.577743552@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 914437992876838662c968cb416f832110fb1093 upstream.

The i2c_master_send/recv() functions return negative error codes or the
number of bytes that were able to be sent/received.  This code has
two problems.  1)  Instead of checking if all the bytes were sent or
received, it checks that at least one byte was sent or received.
2) If there was a partial send/receive then we should return a negative
error code but this code returns success.

Fixes: a9fe713d7d45 ("drm/bridge: Add PTN3460 bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/0cdc2dce-ca89-451a-9774-1482ab2f4762@moroto.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -56,13 +56,13 @@ static int ptn3460_read_bytes(struct ptn
 	ret = i2c_master_send(ptn_bridge->client, &addr, 1);
 	if (ret <= 0) {
 		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
-		return ret;
+		return ret ?: -EIO;
 	}
 
 	ret = i2c_master_recv(ptn_bridge->client, buf, len);
-	if (ret <= 0) {
+	if (ret != len) {
 		DRM_ERROR("Failed to recv i2c data, ret=%d\n", ret);
-		return ret;
+		return ret < 0 ? ret : -EIO;
 	}
 
 	return 0;
@@ -78,9 +78,9 @@ static int ptn3460_write_byte(struct ptn
 	buf[1] = val;
 
 	ret = i2c_master_send(ptn_bridge->client, buf, ARRAY_SIZE(buf));
-	if (ret <= 0) {
+	if (ret != ARRAY_SIZE(buf)) {
 		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
-		return ret;
+		return ret < 0 ? ret : -EIO;
 	}
 
 	return 0;



