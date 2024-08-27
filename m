Return-Path: <stable+bounces-70665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0AE960F6A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407951F21964
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39471C9EB0;
	Tue, 27 Aug 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xUJUTrmC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F21C8FBF;
	Tue, 27 Aug 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770663; cv=none; b=SRuJAKR5twOyEDvDq5q2+2xctiyv2Ifc48MpzmclBPosYgt+x9dzajkzQBmGozl7OlpgQHLgYIjjh85Z5QaduLVqMPbZi1nsCDrPubeSzcJcdsqzR6ZmQ1WJ1y8pmyJYrhzlNXmWWJzFHZTagI2baIk1Yr2sljcSl7CemSKZ97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770663; c=relaxed/simple;
	bh=X9w08mkufSdXAZ9Rr37QYgQB9lhphCm/Qg6JjDh34RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guWN0o4Pe6aEQfUgfzMgJdv777MhCWQlzrnKgAjw44Gq3sfl++a/bQQqMBSjWYtES999jwZ5ijPg0qCwRWYLtmfPqjJXv7Ap1f61uo2/D0Ap7/hPsUJqJejPJVM3a/xgMQEsq3tJT8HLQ3Pv6wmWEMtv0r3rXN9nBhjN5fw0rRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xUJUTrmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2044FC61040;
	Tue, 27 Aug 2024 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770663;
	bh=X9w08mkufSdXAZ9Rr37QYgQB9lhphCm/Qg6JjDh34RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xUJUTrmCIJDTg10b7zpjFUYjf72Y8KkF8AjzGESLj4jl0oeF3Ud+c13+wAEKCt4LK
	 j63+hmd5vLNhihL+vsGwOMVGRFUESLex+I6Y3oBIybvu8BJss66AJMpFP1pDEOgDy6
	 0Vn/2KxxpGkY9rBKbpIX/+tPvssiYggz9krfwLQ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Candice Li <candice.li@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 297/341] drm/amdgpu: Validate TA binary size
Date: Tue, 27 Aug 2024 16:38:48 +0200
Message-ID: <20240827143854.695399635@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Candice Li <candice.li@amd.com>

commit c99769bceab4ecb6a067b9af11f9db281eea3e2a upstream.

Add TA binary size validation to avoid OOB write.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c0a04e3570d72aaf090962156ad085e37c62e442)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -166,6 +166,9 @@ static ssize_t ta_if_load_debugfs_write(
 	if (ret)
 		return -EFAULT;
 
+	if (ta_bin_len > PSP_1_MEG)
+		return -EINVAL;
+
 	copy_pos += sizeof(uint32_t);
 
 	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);



