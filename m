Return-Path: <stable+bounces-165647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0266BB17051
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 13:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3851C4E3433
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 11:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B72C032C;
	Thu, 31 Jul 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvHeWBDo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10DE2BDC38;
	Thu, 31 Jul 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961060; cv=none; b=ibmIjj5VaWxgILMt4eekmuxyjKtYF+l43zNfv4PnJsU2k8kStodm1yaMXTbfxySP8FH6OQuXzTNZC4YXC9oLiUIMFCD2qGeKODB4Z2HYOHFWzKvKw26UW1pU6RB0iTtghtu+T2XlGmT3INGMXYDcC8pu8TFhAZjCWshAwVuZn6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961060; c=relaxed/simple;
	bh=dbse7zUs919qfxC/gFPVDKIB9fP3VoYxCZO9GzzqFoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVU6GB8vvvruGR0na9KqlrJagSNbR7nTIlz8gndbqDRK0dWNXPA041N2kJvoET5Q7HLReZAv1BIKkdEr6RNhHkCnDadM5m+yeUXGD1Yb7o3f0AGvdPnAt4euW7XjzcyN+F47ajOFa9XrS2aULIlrNfpgM5348BIb5sEbuZJ9R5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvHeWBDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B322FC4CEF5;
	Thu, 31 Jul 2025 11:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753961060;
	bh=dbse7zUs919qfxC/gFPVDKIB9fP3VoYxCZO9GzzqFoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvHeWBDoddwtyzb01+DgXIuKnxqgSN9gXZdBU/n8bDrqfh+6/vceGn/9YN6mHVnCn
	 e3r83Eodd7HZiiPqCP3IMfSpaOkk5z7WxiBXbDT9X1GxLKcyfZM//boAac38l7dqCS
	 mG/bXb/JZeEQ7M3dGvM+nyo6mb1cpMWfwm9kTw7wJxVmYzLFfx6S/OA65FI9lcUeSN
	 +8XTGp+83P6f2yvqq4PASk2v371V2IOp/W2acu1m/IALQsUgWx3xbe6zw57zi7SZLV
	 XJ6qeO6u9ZjgEIs6MzmTr4dZwFbWY0PnncbxHlWDTrBM8PFTSw8Un97m61EjU4RmNq
	 JzHWcDZZFfAWQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.15.y 2/6] mptcp: fix error mibs accounting
Date: Thu, 31 Jul 2025 13:23:56 +0200
Message-ID: <20250731112353.2638719-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731112353.2638719-8-matttbe@kernel.org>
References: <20250731112353.2638719-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=matttbe@kernel.org; h=from:subject; bh=Uj3YDf0ZbioOAPY2ydhpobuwIyqvfLAKIyQD7qXqh6A=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK6gwLm/zVeO3lV4a+lQrN1nhTJn3gqKiNhLPF2/iaR2 PoZHmE/O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZiUcTwT8Gs/VD2SdWwg+uc pSLWax9jvvbz/qxinazu5rV2dnd5NjMyrFQR4prw0PlBDCtPHPsyzUBm70xTBU2mp6u+VHodW2H EDQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 0c1f78a49af721490a5ad70b73e8b4d382465dae upstream.

The current accounting for MP_FAIL and FASTCLOSE is not very
accurate: both can be increased even when the related option is
not really sent. Move the accounting into the correct place.

Fixes: eb7f33654dc1 ("mptcp: add the mibs for MP_FAIL")
Fixes: 1e75629cb964 ("mptcp: add the mibs for MP_FASTCLOSE")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts, because commit f284c0c77321 ("mptcp: implement fastclose
  xmit path") is not in this version. That's OK, the new helper added
  by this commit doesn't need to be modified. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 1 +
 net/mptcp/subflow.c | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d1443c5732c8..501c818bf7dc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -793,6 +793,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 	opts->fail_seq = subflow->map_seq;
 
 	pr_debug("MP_FAIL fail_seq=%llu\n", opts->fail_seq);
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 
 	return true;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2bf7f65b0afe..6a7c48397e3d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -963,10 +963,8 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 				 subflow->map_data_csum);
 	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
-		if (subflow->mp_join || subflow->valid_csum_seen) {
+		if (subflow->mp_join || subflow->valid_csum_seen)
 			subflow->send_mp_fail = 1;
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
-		}
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.50.0


