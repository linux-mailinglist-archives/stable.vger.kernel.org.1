Return-Path: <stable+bounces-84635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CED299D125
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B903B1F23385
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CFE1AB534;
	Mon, 14 Oct 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JGffRMBX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2811A76A5;
	Mon, 14 Oct 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918691; cv=none; b=tFnhZE12tf7wyRylxsgdfOBYtZ2lTQTEGsbsTzf2r8LoFjKbmLeWSI1KaI3bkou38It3ahAsiVAg4NeHDRdNnRN9N0f1JfL+lIbj7n15vsaRu+wy4L15mgoXdHjvp1//p4yQE/b96WErUuLOuV/XbxOJzXGIoSYOdWZrv3mCZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918691; c=relaxed/simple;
	bh=Sakn5G+NLH7sEqTC7mP8iq7MB4aWUVy2yCqMaBFBflI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cep9V9kheTtPAgJEGojwHO5t7Vq6HMDzPDcjkfwGrh0SN+8H98Yk/04RL0IhTA78Y/4m1VJe+BL6cfNyTGmDu2g1eghKLM0mayu5mL+CsOWIxHmsK33DD441+nGbryOwpgtJydTCZtKuvzVNZpEnf1VCeeq/j5cSRzE1WR1EOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JGffRMBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8040CC4CEC3;
	Mon, 14 Oct 2024 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918690;
	bh=Sakn5G+NLH7sEqTC7mP8iq7MB4aWUVy2yCqMaBFBflI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGffRMBXtElxVsO52uWltxgG7EsRyjjXKs1w/NrIV+pTZ8rsFKAxMN4v9lARw8b42
	 NhRVWFlbWFDxWQJvwrGq+m2HawxAXt9irZ5+DRrYnsjM3qOyfLxGRRmdoLkAp/OEpp
	 JAWUUPgCxe7HyyzVlXfXA14rPvU5RAhvliDlq0Pc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.1 363/798] bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0
Date: Mon, 14 Oct 2024 16:15:17 +0200
Message-ID: <20241014141232.210904199@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



