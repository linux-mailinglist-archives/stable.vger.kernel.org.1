Return-Path: <stable+bounces-170792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1358B2A69F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811506861A3
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3A4A93D;
	Mon, 18 Aug 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oI7ueYf5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A791FF7D7;
	Mon, 18 Aug 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523809; cv=none; b=AcFP9eoMNLShfWkWCipfl5hLOSdKxjtQmAFbrFlV3Y6U5uON1XGB4iKInEIYkN0SmGjfQ+i38hraQwbpnV1kbqyYX+9cZaZwXNYTfvtmJqwmGG9kFMdNnmejpZ2Kp2qiepi/h4IFAtLJpJDH9cGuxSZIWp2WiN6w7WjPVBTssVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523809; c=relaxed/simple;
	bh=Yxy/FV7nj3KCItEHTiLjZVusSltO0OSjMqvSIO7slCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnkZSZ4MEz2PkAhi7sACQLeLKU+YFSsEkeqTYkbtLDF/Vg87Kq9FU18cC8Jn4mFRbsqxbY3gnBn1ZLBiSjEYrtNroD+5u6OLiOv6R+QYRpvoAH76B4uolYCsiKlO3+fBGoiInKZYyfzhYJxp/k9fzhz9u5IAp99ufed3QY6E25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oI7ueYf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4671DC4CEEB;
	Mon, 18 Aug 2025 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755523809;
	bh=Yxy/FV7nj3KCItEHTiLjZVusSltO0OSjMqvSIO7slCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oI7ueYf5Ltd7Z9+pOwQHXB/OCpo44HpyOHycEjAICWdPTWWY81fQW+84CWv8WUyHJ
	 NfAcTmde7jIAQ5lRfmDFtL1E9oUAvGcsouye0D5y+3gM1/JYJR1wSbH2+jlBzJ1+3p
	 4Zfou8FQWQT0Q48k4d9iqmSWBqiYqEe5aU97CHGM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rand Deeb <rand.sec96@gmail.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 279/515] wifi: iwlwifi: dvm: fix potential overflow in rs_fill_link_cmd()
Date: Mon, 18 Aug 2025 14:44:25 +0200
Message-ID: <20250818124509.167038947@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rand Deeb <rand.sec96@gmail.com>

[ Upstream commit e3ad987e9dc7d1e12e3f2f1e623f0e174cd0ca78 ]

The 'index' variable in the rs_fill_link_cmd() function can reach
LINK_QUAL_MAX_RETRY_NUM during the execution of the inner loop. This
variable is used as an index for the lq_cmd->rs_table array, which has a
size of LINK_QUAL_MAX_RETRY_NUM, without proper validation.

Modify the condition of the inner loop to ensure that the 'index' variable
does not exceed LINK_QUAL_MAX_RETRY_NUM - 1, thereby preventing any
potential overflow issues.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Link: https://patch.msgid.link/20240313101755.269209-1-rand.sec96@gmail.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 8879e668ef0d..ed964103281e 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2899,7 +2899,7 @@ static void rs_fill_link_cmd(struct iwl_priv *priv,
 		/* Repeat initial/next rate.
 		 * For legacy IWL_NUMBER_TRY == 1, this loop will not execute.
 		 * For HT IWL_HT_NUMBER_TRY == 3, this executes twice. */
-		while (repeat_rate > 0 && (index < LINK_QUAL_MAX_RETRY_NUM)) {
+		while (repeat_rate > 0 && index < (LINK_QUAL_MAX_RETRY_NUM - 1)) {
 			if (is_legacy(tbl_type.lq_type)) {
 				if (ant_toggle_cnt < NUM_TRY_BEFORE_ANT_TOGGLE)
 					ant_toggle_cnt++;
-- 
2.39.5




