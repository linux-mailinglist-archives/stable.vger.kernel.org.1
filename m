Return-Path: <stable+bounces-49078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C908FEBC3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B651F294AD
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143EA197A94;
	Thu,  6 Jun 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aF147a52"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C91ABCC4;
	Thu,  6 Jun 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683291; cv=none; b=uZk6AoedqMHOXG7+0sKOhsZkkDdBm0Njqma6EyPgQ5cOyPaN8qJhTYTVfkvX5oEybx8GDxmkMR4fZ3bMXv9YPJA6kxdii9WJtw5wLIK1PThAiomGWT4MbNCa3lNVskVHVa83ykL+JoyiClZjoTIQ4lg5bP+SYlGjvEcj2jaw9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683291; c=relaxed/simple;
	bh=YCKaeT/mAcDJcKsyoopr6FOy7ixT3JyqRUcxK5UkwLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cy41j6rF97Ew40/f8FWL2+ytrqMYeW2F2dSad+XEtRB8Cqa97IEQqqBSiMNGjQHP4AYubTWPHPs9nu83BI687E5mMWwqUzvucuEglsgTYzW9GYHhKgfP057qZVn7aOPcZvl5FLdYQMUg2dqeJ3o8mLyahuxSUYGCKo0f23Im0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aF147a52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57605C2BD10;
	Thu,  6 Jun 2024 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683291;
	bh=YCKaeT/mAcDJcKsyoopr6FOy7ixT3JyqRUcxK5UkwLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aF147a52nxvBlxvKCSGw+LWLGvLYyMqH5LUmzZWBVus6Fa29YHGKczNB9fl9phcmr
	 q+EIzWkwAs8webMUz1e6WuQ/IpOrOoUua1O29WPBuwtcNda2CCvO/yk+v/4emYn8ye
	 4byWEpRdu3x+Cr89LHgbToBJ4ENPBNR6NlOyBAIw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 232/744] HID: amd_sfh: Handle "no sensors" in PM operations
Date: Thu,  6 Jun 2024 15:58:24 +0200
Message-ID: <20240606131739.830805147@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit 077e3e3bc84a51891e732507bbbd9acf6e0e4c8b ]

Resume or suspend each sensor device based on the num_hid_devices.
Therefore, add a check to handle the special case where no sensors are
present.

Fixes: 93ce5e0231d7 ("HID: amd_sfh: Implement SFH1.1 functionality")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index e9c6413af24a0..862ca8d072326 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -210,6 +210,11 @@ static void amd_sfh_resume(struct amd_mp2_dev *mp2)
 	struct amd_mp2_sensor_info info;
 	int i, status;
 
+	if (!cl_data->is_any_sensor_enabled) {
+		amd_sfh_clear_intr(mp2);
+		return;
+	}
+
 	for (i = 0; i < cl_data->num_hid_devices; i++) {
 		if (cl_data->sensor_sts[i] == SENSOR_DISABLED) {
 			info.sensor_idx = cl_data->sensor_idx[i];
@@ -235,6 +240,11 @@ static void amd_sfh_suspend(struct amd_mp2_dev *mp2)
 	struct amdtp_cl_data *cl_data = mp2->cl_data;
 	int i, status;
 
+	if (!cl_data->is_any_sensor_enabled) {
+		amd_sfh_clear_intr(mp2);
+		return;
+	}
+
 	for (i = 0; i < cl_data->num_hid_devices; i++) {
 		if (cl_data->sensor_idx[i] != HPD_IDX &&
 		    cl_data->sensor_sts[i] == SENSOR_ENABLED) {
-- 
2.43.0




