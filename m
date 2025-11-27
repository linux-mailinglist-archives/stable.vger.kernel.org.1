Return-Path: <stable+bounces-197134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2BBC8ED3F
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A16A3432FE
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C63F277007;
	Thu, 27 Nov 2025 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wz/EPYOr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CBC26F2A7;
	Thu, 27 Nov 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254888; cv=none; b=nP6Sc+2H0Dl9ldS3nietthem0Ifwe0Ee03Stp5XjlzrLLgwswl8nPBkNY+ePJGEjyerlgLBHQCnVgcTrTDIaNwlUS4WXuNJBxMmWD4MLA6rJanbVRGeaWvJRGnDT2M2hhtdKCMd0rzNJ+uq3C6rfwHnCJW2iTJ4rdkXDafIplS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254888; c=relaxed/simple;
	bh=zFVL9melLv12Lxk8/3U/th3qKXXHZR2G8g0fEtT6bR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKA9GXFmN6u5/ScJRIzUPfF+QMeCt36Y92Z9bXnYU/ON0xyT9YhzMUqkI41zQgjV+mlBykH3LGcRCi3q6uYbUieG+p25QDrZz/dwqClpimmPrA1JHLRExwCyhX3I3BnwlFAxivUDMOsl8yHxdJ4zersRZXHFAlCbX0lSEqs2JgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wz/EPYOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0676CC4CEF8;
	Thu, 27 Nov 2025 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764254888;
	bh=zFVL9melLv12Lxk8/3U/th3qKXXHZR2G8g0fEtT6bR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wz/EPYOrcNPgyXql78yvZg/td/j6SyBap1LVMYIAiYkpcQyij91I/TwkV8wr/dcuP
	 LtiqFJd9HD43mKHh533eQ9jpndYRQ3d8zPgQev3XjV3jvZOaSWcqYv9Repr/qCNu1D
	 7/4rwKHiQH7q0zniH+/CS/SaHM41bIkfV5ERaxZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Lyude Paul <lyude@redhat.com>
Subject: [PATCH 6.6 20/86] nouveau/firmware: Add missing kfree() of nvkm_falcon_fw::boot
Date: Thu, 27 Nov 2025 15:45:36 +0100
Message-ID: <20251127144028.558124149@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144027.800761504@linuxfoundation.org>
References: <20251127144027.800761504@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nam Cao <namcao@linutronix.de>

commit 949f1fd2225baefbea2995afa807dba5cbdb6bd3 upstream.

nvkm_falcon_fw::boot is allocated, but no one frees it. This causes a
kmemleak warning.

Make sure this data is deallocated.

Fixes: 2541626cfb79 ("drm/nouveau/acr: use common falcon HS FW code for ACR FWs")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20251117084231.2910561-1-namcao@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
@@ -159,6 +159,8 @@ nvkm_falcon_fw_dtor(struct nvkm_falcon_f
 	nvkm_memory_unref(&fw->inst);
 	nvkm_falcon_fw_dtor_sigs(fw);
 	nvkm_firmware_dtor(&fw->fw);
+	kfree(fw->boot);
+	fw->boot = NULL;
 }
 
 static const struct nvkm_firmware_func



