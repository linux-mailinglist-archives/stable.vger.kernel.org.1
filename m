Return-Path: <stable+bounces-165648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B01EB17053
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 13:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B7189910F
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A882C08AD;
	Thu, 31 Jul 2025 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8WtptoK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72D2C0323;
	Thu, 31 Jul 2025 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961062; cv=none; b=IxXPhjn0h8LxINdsYNPh7dEe5gDFO+MYCHKifdgj0p3W0DP9K7SHD7dKmIeMdQOiYuUxXV7ZpetFcqbGiBZJbSanIj2I5+sJHAAm5Fs3NJ3PuiQAxg3kD0qtRI9PCi1AH+7tA/IkfzmuX6gOcOFNAGIovvsXYOoRWUAIZkWIUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961062; c=relaxed/simple;
	bh=MPSbPtQjAV2eygYGhFiBQ4sM5BAfTiZnZlyvvgaJ2Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afrXG7D/cHl28i2f9KQ8tcSJqWY1x19JQI8jNXNJRY7C67V7JyMuIUbrxG+4oJtEWQkpwY3ARzRRr5dwRgjX+6cv2b0dH7On4rYK+cL+ZmYyB8jN2JsXINHvRIZu+3pUTnvYGr0pkSjHobI3Ogygt/ouW4pBNr5u9aRbI+8GH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8WtptoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB28DC4CEF7;
	Thu, 31 Jul 2025 11:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753961062;
	bh=MPSbPtQjAV2eygYGhFiBQ4sM5BAfTiZnZlyvvgaJ2Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8WtptoKAGCbtIYrcJ/HtZUJ8e1FCnBmIHcFWyWdpG5DLL0O+IHq+r0gjB6pvlhwn
	 5+m1OnSLhkJDwtTVsaa7WWlOCYIpDXt4nwm3ckDRbxv+5/k3VsL4Kyjz18J/Kaf9kB
	 GfQhCBPRu9bwsWv/I/wH+BpwB9/p7nyRHA8bbAupIZe27V8XYzBO8PyhT6fGIyIixq
	 jYZ3jasZibSkavUGiLC/88pp7coVJ/sGyIk9cVGx2y1ndb8Ne72uigj5+zIbPeGMme
	 hR+bK2n+SOuGsQRndvULo34ISJsGk3ZjWA5jmi1dHuqDY+lgfxyGed+/lTVDru7VdN
	 G+5X3oALKeAeQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.15.y 3/6] mptcp: introduce MAPPING_BAD_CSUM
Date: Thu, 31 Jul 2025 13:23:57 +0200
Message-ID: <20250731112353.2638719-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731112353.2638719-8-matttbe@kernel.org>
References: <20250731112353.2638719-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=matttbe@kernel.org; h=from:subject; bh=mLRnr7LXgyI96bAmZqsGlfibrcb7p5Fc95Zh9jlPYpo=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK6g4LC5ttkvIu6s/foju+9/nNtza+2VPN5zVofYBoc/ +9VgYxaRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwET2szL8D/nturG/LOTqku9z npnoF3pxLlitt+zsyTWq7tHXT5uf+8XwV3r+NyUPnwcHZz7M/Z0X/fOIfEp8kuDuw2xMDWLqfkv iWQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 31bf11de146c3f8892093ff39f8f9b3069d6a852 upstream.

This allow moving a couple of conditional out of the fast path,
making the code more easy to follow and will simplify the next
patch.

Fixes: ae66fb2ba6c3 ("mptcp: Do TCP fallback on early DSS checksum failure")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in subflow.c, because commit 0348c690ed37 ("mptcp: add the
  fallback check") is not in this version. This commit is linked to a
  new feature, changing the context around. The new condition can still
  be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6a7c48397e3d..6bc36132d490 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -848,7 +848,8 @@ enum mapping_status {
 	MAPPING_INVALID,
 	MAPPING_EMPTY,
 	MAPPING_DATA_FIN,
-	MAPPING_DUMMY
+	MAPPING_DUMMY,
+	MAPPING_BAD_CSUM
 };
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
@@ -963,9 +964,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 				 subflow->map_data_csum);
 	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
-		if (subflow->mp_join || subflow->valid_csum_seen)
-			subflow->send_mp_fail = 1;
-		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
+		return MAPPING_BAD_CSUM;
 	}
 
 	subflow->valid_csum_seen = 1;
@@ -1188,10 +1187,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
-		if (unlikely(status == MAPPING_INVALID))
-			goto fallback;
-
-		if (unlikely(status == MAPPING_DUMMY))
+		if (unlikely(status == MAPPING_INVALID || status == MAPPING_DUMMY ||
+			     status == MAPPING_BAD_CSUM))
 			goto fallback;
 
 		if (status != MAPPING_OK)
@@ -1232,7 +1229,10 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 fallback:
 	/* RFC 8684 section 3.7. */
-	if (subflow->send_mp_fail) {
+	if (status == MAPPING_BAD_CSUM &&
+	    (subflow->mp_join || subflow->valid_csum_seen)) {
+		subflow->send_mp_fail = 1;
+
 		if (mptcp_has_another_subflow(ssk) ||
 		    !READ_ONCE(msk->allow_infinite_fallback)) {
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
-- 
2.50.0


