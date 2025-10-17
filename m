Return-Path: <stable+bounces-187487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BF7BEA488
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0361C1AE2E53
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1F82F12A0;
	Fri, 17 Oct 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OF1CWtIf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD9330B0F;
	Fri, 17 Oct 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716213; cv=none; b=Ppt+5RD/IjpanySgScyAuRPqij4fWAW6zQsXfLHDiU+JLWicYStmOKb/GmLgfUNEpy5LWgoulMLEXO51mEOiKTVaV5r3ywZWgcXgV0CCW42EurZ1WvUsP6iBYSAkxcCIK8G1pk5DH6rE+Ytwpt0+or7gh4g0370PrAIAAoWtxPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716213; c=relaxed/simple;
	bh=GhrSGDCL9SJP+EfT7xugyPPQSvYQQVjQmvRW2QHwVX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7VBgfO1yr6rIUx9T/mQo6dYJx2fbUNZXeN/JVBm0WW2g9mTY8PKJzzo0x5ChMlaqWO/vrJSqeZCI+SCUDEkYRwJ0FDdW09l8eJWjdsThGeO9Hctinf6o6AO1dolvy9mXvewXQl39PWtdn2k/33feKj/hmazI3hqhGMsnB6myh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OF1CWtIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F74C113D0;
	Fri, 17 Oct 2025 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716212;
	bh=GhrSGDCL9SJP+EfT7xugyPPQSvYQQVjQmvRW2QHwVX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OF1CWtIfcwlkhYDpltr8+C73+jcmF5SYR4ZL3N4ohT4N2KhsFi9XZv53zC/+hCIKq
	 24UNfrPvx/WDfedzmgisHMGl0mygJhkOM0S03tHOT5tlPcjmoEQQ+BncDOEU9EUzLp
	 uJWdq8qcTDNNQ13YB7JY6nAiR9WvS3xfnVQLBpMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 080/276] scsi: qla2xxx: Fix incorrect sign of error code in START_SP_W_RETRIES()
Date: Fri, 17 Oct 2025 16:52:53 +0200
Message-ID: <20251017145145.407961339@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qianfeng Rong <rongqianfeng@vivo.com>

[ Upstream commit 1f037e3acda79639a78f096355f2c308a3d45492 ]

Change the error code EAGAIN to -EAGAIN in START_SP_W_RETRIES() to align
with qla2x00_start_sp() returning negative error codes or QLA_SUCCESS,
preventing logical errors.  Additionally, the '_rval' variable should
store negative error codes to conform to Linux kernel error code
conventions.

Fixes: 9803fb5d2759 ("scsi: qla2xxx: Fix task management cmd failure")
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Message-ID: <20250905075446.381139-3-rongqianfeng@vivo.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 2053c560b580c..5f3593680c953 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2061,11 +2061,11 @@ static void qla_marker_sp_done(srb_t *sp, int res)
 	int cnt = 5; \
 	do { \
 		if (_chip_gen != sp->vha->hw->chip_reset || _login_gen != sp->fcport->login_gen) {\
-			_rval = EINVAL; \
+			_rval = -EINVAL; \
 			break; \
 		} \
 		_rval = qla2x00_start_sp(_sp); \
-		if (_rval == EAGAIN) \
+		if (_rval == -EAGAIN) \
 			msleep(1); \
 		else \
 			break; \
-- 
2.51.0




