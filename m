Return-Path: <stable+bounces-85487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42E99E788
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414102829B9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76351D95AB;
	Tue, 15 Oct 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z3y3TwR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66141D0492;
	Tue, 15 Oct 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993280; cv=none; b=VcrTQFjzOtG5gBR8y9lsSXV6eX7FRd9jRxa7JJRiP4NcvRGeoEbRA1t2KgBfpHAJrcYwpQ8VJyPXbla53NvPQ+Cy2nzw4bGNp0DyZQ0svBQOtvXLJONNMmn4NzK6NYLYAXxFxApRns8ovfkF3R0vPuSAITdz3nb35vNQUj9TF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993280; c=relaxed/simple;
	bh=p7PLCAotSa2q05sJPvejO/AxkwhtcUSAfzs2cUcb3fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQIu2NcCRHOWK0XjzA7gVcmS3gu0GMgVNph289hX8Gyp5sKXPNR2CGKO84XFe6hPxjtCp/wMNZXvWZnUHFFRwbcqC/y0Y+GVBkyJSW05fTFOgjv5WB1J0AUIvuB3FSR8rpHrkYd34ja6k/Vn1jyoIdlK6gNQ5iA9LRMPcwBSmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z3y3TwR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A59C4CECE;
	Tue, 15 Oct 2024 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993280;
	bh=p7PLCAotSa2q05sJPvejO/AxkwhtcUSAfzs2cUcb3fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3y3TwR2gw7mooYDGwwie4XYUdE26SA2y42lY+pqIQraws71ewJu23GXGM6Ti5GA6
	 toyOMsGkGCNKuy/7Hmi3+0B0ezy3U9P9LngolEP1kdgO61Jffs9dK4+IsGJBucMjyD
	 HRPatq614yEfDa2Cfqif21RyC7+Brz4dpFikR90U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.15 365/691] bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0
Date: Tue, 15 Oct 2024 13:25:13 +0200
Message-ID: <20241015112454.833740920@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Liu <song@kernel.org>

commit 300a90b2cb5d442879e6398920c49aebbd5c8e40 upstream.

bpf task local storage is now using task_struct->bpf_storage, so
bpf_lsm_blob_sizes.lbs_task is no longer needed. Remove it to save some
memory.

Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
Cc: stable@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>
Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Matt Bobrowski <mattbobrowski@google.com>
Link: https://lore.kernel.org/r/20240911055508.9588-1-song@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/bpf/hooks.c |    1 -
 1 file changed, 1 deletion(-)

--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -24,7 +24,6 @@ static int __init bpf_lsm_init(void)
 
 struct lsm_blob_sizes bpf_lsm_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
-	.lbs_task = sizeof(struct bpf_storage_blob),
 };
 
 DEFINE_LSM(bpf) = {



