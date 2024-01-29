Return-Path: <stable+bounces-16727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5572840E2C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6820CB2707E
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE9915EA8C;
	Mon, 29 Jan 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xga2ToMf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8CC159595;
	Mon, 29 Jan 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548235; cv=none; b=DSjj6ZHGdqxUJDKE0+BwRJeRLiQth8zlly1JDqKwrAN+HI0l8bqZ7C7e8PBIVV8F8lvBTt5c1YYD5jGmBo7nl08/xATnov6rrsChhRKDzPUbeTGkC+dyjNkseJNrUFfEOl8aPDXhqvT6oLeSOX3sbXVt1lPebU7+8pv8AvaFPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548235; c=relaxed/simple;
	bh=ttB0oN3HXPhd1h3gMU+s9OyNsUaxZeazjngNfIb2ocM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oA9Wlo1A69gXJ2MUG0YiVSBenmczYB5xOWO+Qn0/Ng0PcLAC4QH9RIhNjdvYT8FOcK3bs82+UGYZYGdZpMTxXE8T2apJ0mYjG+KrbYKmMNsz60fUIyEuthUY4+LkDP1cD7wS+JMXQCg28q2BXut6vzJ23AXikT8DawlnVa+WAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xga2ToMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DA6C43394;
	Mon, 29 Jan 2024 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548235;
	bh=ttB0oN3HXPhd1h3gMU+s9OyNsUaxZeazjngNfIb2ocM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xga2ToMfIXQzC+pCjRy5+BEKZ7Yle9Kvv8nnUc/Ue0eS0Gl/I8TSAmleUTvSg7V3E
	 E76ZxNnjYnlQLmsZ1D3ayFn8nxqR6K1o9lyxnum4RVtQhT6XV6FwS+XxFPeirl+zCS
	 pbAKfc79t0KgwDIgECEs6UMWafZfFoTDpgR7yl2A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Zhang <yifan1.zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.7 263/346] drm/amdgpu: update regGL2C_CTRL4 value in golden setting
Date: Mon, 29 Jan 2024 09:04:54 -0800
Message-ID: <20240129170024.124589957@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yifan Zhang <yifan1.zhang@amd.com>

commit 2b9a073b7304f4a9e130d04794c91a0c4f9a5c12 upstream.

This patch to update regGL2C_CTRL4 in golden setting.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.7.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -114,7 +114,7 @@ static const struct soc15_reg_golden gol
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL, 0xffffffff, 0xf37fff3f),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xfffffffb, 0x00f40188),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff, 0x8000b007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff, 0x80009007),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf1ffffff, 0x00880007),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_CONFIG_CNTL_1, 0xffffffff, 0x00010000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x01030000),



