Return-Path: <stable+bounces-134032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F59A928F4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF811B62165
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F525B675;
	Thu, 17 Apr 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TUFxB14u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361CE264A78;
	Thu, 17 Apr 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914888; cv=none; b=EjevggeGlHzOeUh6Qre30LlrwUpajVkZ5MDh00ZVA6k2IEjqBpFohakNoTnNBXMYi6CKeDchs5/GzpVp7VP39zrsOntONSHxqjIixj6sVMaKrf/P73qynInLsKzBjNlq05BWWAdLlDkB9UT9jeogpMTANc6j73go6l3zbWiPVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914888; c=relaxed/simple;
	bh=yQWS5hhy4l8S9NDUwQEcluM5FHecDEkQU0kbp4/ScVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCQNis46Q7VdSVuDET+KIEU1mSyVtwM20K6BE75LW+ocTwsCd1LYDixYHK1qAPPTEbNv/e7d+KRmkBiQVr+ClUuWAv3ADJADT8ah63gvPy1UbcG8qUkFL7gQH514MjCIRaGx7j/eevTn3z6nH8tQlnCfdxybBzyWkbFVG7oUqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TUFxB14u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDEAC4CEE4;
	Thu, 17 Apr 2025 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914888;
	bh=yQWS5hhy4l8S9NDUwQEcluM5FHecDEkQU0kbp4/ScVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TUFxB14uDV/QCO/ZhbjIIE8z42FviMxrAi1JPqBkUo4nyEAeTD5DyfpdGt9dwe4fA
	 CRg99Af4HERasuUPRS0jvyMDS37EAv9dvQGyT/10qzQo977AP9cYpLceG31P8m2kRl
	 Xr6ydOdMabB2M0+GGh1fVjncCTXXdOVsSilEj954=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.13 363/414] gve: handle overflow when reporting TX consumed descriptors
Date: Thu, 17 Apr 2025 19:52:01 +0200
Message-ID: <20250417175126.059035340@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joshua Washington <joshwash@google.com>

commit 15970e1b23f5c25db88c613fddf9131de086f28e upstream.

When the tx tail is less than the head (in cases of wraparound), the TX
consumed descriptor statistic in DQ will be reported as
UINT32_MAX - head + tail, which is incorrect. Mask the difference of
head and tail according to the ring size when reporting the statistic.

Cc: stable@vger.kernel.org
Fixes: 2c9198356d56 ("gve: Add consumed counts to ethtool stats")
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250402001037.2717315-1-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -392,7 +392,9 @@ gve_get_ethtool_stats(struct net_device
 				 */
 				data[i++] = 0;
 				data[i++] = 0;
-				data[i++] = tx->dqo_tx.tail - tx->dqo_tx.head;
+				data[i++] =
+					(tx->dqo_tx.tail - tx->dqo_tx.head) &
+					tx->mask;
 			}
 			do {
 				start =



