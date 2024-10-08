Return-Path: <stable+bounces-82864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E584994F0B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D10B2BA71
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2187E1DF724;
	Tue,  8 Oct 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="okC2QwcW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46BF1DE8BE;
	Tue,  8 Oct 2024 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393682; cv=none; b=kr7m2ACiLkgqLwc2aIRKOKcTfO2nCCHOEFZWJZFC9rugKaw1Zz1sM/Qta/RvIhCUTdN+uMVorhqWoyH/lGmv/LQHm7iWlkKqQX9SRjMpZkorIYazw9Fegkj+RE50XsNrS1/bb4aNJ90w2kkwkAyITBqhkpdZzj1xQP2YVrvSl/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393682; c=relaxed/simple;
	bh=HuSd7IoFmI1Oz0ItBCBNKYaAh6ngAGBb/ccDKVGNJWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6QTOH4zNwiFIM5R/euLkrT7th+Zth2vwfqLVRWvXBmBFBqqjfn+KvpoPOtfVe+Erz3wZCrZrDWdyakYO7eQOR64N02EBp1iZunue/eVtKJaS2jbHbAowaFCSnOFC7Mi624RRfKqgQb4zXe5FEBPOwR85bEbLD02QR+Ov4qmuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=okC2QwcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F79C4CECC;
	Tue,  8 Oct 2024 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393682;
	bh=HuSd7IoFmI1Oz0ItBCBNKYaAh6ngAGBb/ccDKVGNJWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=okC2QwcW9LscD7vQ5TtHqYJ+h41jq3GOkhN3SsK/TdviPMiw4LLGPvcIzfWcYbRhu
	 2SDA+KQauHlrWTMBA5BR1UQv6Q96im04xe1MiuVsFfTsRzIyEnfmXQv+Iyj/ToPZMo
	 O/zaMy4G38J7iYRRbhS6q2nk8agHwxzHm6mJgwak=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Alexander F. Lent" <lx@xanderlent.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 193/386] accel/ivpu: Add missing MODULE_FIRMWARE metadata
Date: Tue,  8 Oct 2024 14:07:18 +0200
Message-ID: <20241008115637.002418828@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

From: Alexander F. Lent <lx@xanderlent.com>

[ Upstream commit 58b5618ba80a5e5a8d531a70eae12070e5bd713f ]

Modules that load firmware from various paths at runtime must declare
those paths at compile time, via the MODULE_FIRMWARE macro, so that the
firmware paths are included in the module's metadata.

The accel/ivpu driver loads firmware but lacks this metadata,
preventing dracut from correctly locating firmware files. Fix it.

Fixes: 9ab43e95f922 ("accel/ivpu: Switch to generation based FW names")
Fixes: 02d5b0aacd05 ("accel/ivpu: Implement firmware parsing and booting")
Signed-off-by: Alexander F. Lent <lx@xanderlent.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240709-fix-ivpu-firmware-metadata-v3-1-55f70bba055b@xanderlent.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_fw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index a277bbae78fc4..3b35d262ddd43 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -55,6 +55,10 @@ static struct {
 	{ IVPU_HW_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
 };
 
+/* Production fw_names from the table above */
+MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
+MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
+
 static int ivpu_fw_request(struct ivpu_device *vdev)
 {
 	int ret = -ENOENT;
-- 
2.43.0




