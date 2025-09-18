Return-Path: <stable+bounces-167349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0710FB22FA6
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB5F562821
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F0C2FDC2B;
	Tue, 12 Aug 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JAVQ0L8r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DED2F7477;
	Tue, 12 Aug 2025 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020515; cv=none; b=P6wh9cCE5xYIf/vQks64r8nTVga0s/aRDHGqBhFq898Nig+QM1eaV5dWXrTH6j/ON5mTAq2oEBwbeaSxQ2kJmxcmc1tCPndLLdID/Wr4iH0ndNN6deiUF+acZxQjPcUItJwZaeSXcM3TGM+HXdBwKbNWMhops6fB8FgynpCxT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020515; c=relaxed/simple;
	bh=rqQkHaaDNLC5/PyOUCqww4M5eTOfOTHpUAX+pk2xpYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYZyEeY3WJ+L4EOy2LStmn7nETLQG7fYAi28jU2xgtV8ELhEoEwv+XnDtm6p8j0mdS9KftlrUbQnZUQM5/klRokA3MRnZ1zLBJ07m8un1FCRfN65JJrifvcuJz+7uYhpHnqLDl2YWkqDSuNLqhOu3/udu/vmV6CbAPs+CcyOXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JAVQ0L8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246F9C4CEF1;
	Tue, 12 Aug 2025 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020515;
	bh=rqQkHaaDNLC5/PyOUCqww4M5eTOfOTHpUAX+pk2xpYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAVQ0L8rAsXCLtUWxcwk+rV0Jd/tfPDsmHy+x5LEc0zjR80WKj9QtG474GdTz37Qj
	 +gakRhxuQLJ4HyYhwVPyed2x+SEefQU189VYuyOYtP6GsbxHmC1L7dU+5ylEPGyhWu
	 LheCk8ogbIt+0CNJKjhtmubg7Kr2MUFAdpl97KkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/253] wifi: iwlwifi: Fix memory leak in iwl_mvm_init()
Date: Tue, 12 Aug 2025 19:28:12 +0200
Message-ID: <20250812172953.153791011@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiu Jianfeng <xiujianfeng@huawei.com>

[ Upstream commit ed2e916c890944633d6826dce267579334f63ea5 ]

When iwl_opmode_register() fails, it does not unregster rate control,
which will cause a memory leak issue, this patch fixes it.

Fixes: 9f66a397c877 ("iwlwifi: mvm: rs: add ops for the new rate scaling in the FW")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Link: https://patch.msgid.link/20221109035213.570-1-xiujianfeng@huawei.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 0a11ee347bf3..64cc1e1bbb47 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -64,8 +64,10 @@ static int __init iwl_mvm_init(void)
 	}
 
 	ret = iwl_opmode_register("iwlmvm", &iwl_mvm_ops);
-	if (ret)
+	if (ret) {
 		pr_err("Unable to register MVM op_mode: %d\n", ret);
+		iwl_mvm_rate_control_unregister();
+	}
 
 	return ret;
 }
-- 
2.39.5




