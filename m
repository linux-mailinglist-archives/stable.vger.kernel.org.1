Return-Path: <stable+bounces-193294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530B9C4A1C6
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37923AD9DF
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13F025A64C;
	Tue, 11 Nov 2025 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XZJwKOjK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E327253944;
	Tue, 11 Nov 2025 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822829; cv=none; b=OXGdxI7Ge8IBMjtkViBNDDnu//v8NA1aYsbKtLunzOGIDU1U9w7GrmybokIw5WixXUau0atK0+Zj2FnncG3Z3857R09v9zzlO8KgY3LIGbOC/q6SZP7KMbzFi4Fou5jjntdk9ee+w3xQ6NR8xICjzx/36wtP4KTJbC5SNZMiZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822829; c=relaxed/simple;
	bh=7ykWlo9EdXlGC6Wuf0I8qzPM85t0+/woQz+TlspRFmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVrggxgsfpuCcm3Ij4bDG6tNKQoRq52kZSLlv9jOsQysA5SVTMiqVuxvGR+yPqnkifvCbucRuOQOg3LofOgqnwgCe84mXWxJY9fhBmOT5A77Bbs6dHmttzC65lKhjpJeyaLqKWiTPwvVNlvlumWmn6BTiEJApi/z3Xwg8HAzLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XZJwKOjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C747C113D0;
	Tue, 11 Nov 2025 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762822829;
	bh=7ykWlo9EdXlGC6Wuf0I8qzPM85t0+/woQz+TlspRFmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZJwKOjKXlWmPw9EMYxxAq9oDI+YXXWZx+kh1eWXgzHdV8+Jplj3DxA7VSL5mVHUI
	 /TTvAfbJNJn2B05jaD4gvtiVCGVt17N2lzRZhRFnzAFMpCeA42hR5l4eR2+9Tqu0QT
	 Y5fwdEXf1Si2m5Xw9mbvbCVfr9sqYt4iqLIG//wY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christopher Ruehl <chris.ruehl@gtsys.com.hk>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 116/565] power: supply: qcom_battmgr: add OOI chemistry
Date: Tue, 11 Nov 2025 09:39:32 +0900
Message-ID: <20251111004529.566368094@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christopher Ruehl <chris.ruehl@gtsys.com.hk>

[ Upstream commit fee0904441325d83e7578ca457ec65a9d3f21264 ]

The ASUS S15 xElite model report the Li-ion battery with an OOI, hence this
update the detection and return the appropriate type.

Signed-off-by: Christopher Ruehl <chris.ruehl@gtsys.com.hk>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/qcom_battmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index c2037b58fbcdf..dd89104cb1672 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -978,7 +978,8 @@ static void qcom_battmgr_sc8280xp_strcpy(char *dest, const char *src)
 
 static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry)
 {
-	if (!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN))
+	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
+	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
 	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
 		return POWER_SUPPLY_TECHNOLOGY_LIPO;
-- 
2.51.0




