Return-Path: <stable+bounces-169094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC1B23811
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25245A065B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8E27703A;
	Tue, 12 Aug 2025 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FrTo1vCL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86C21A43B;
	Tue, 12 Aug 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026357; cv=none; b=KjvAHPHNr9kZVey1JYwV8UrqhThuF8UyUB7jzVjzyxJwm3XEVwubA2UAnHdtlKCkp2svBx/zfvgJHzvyuhBejAi0Oz8L1PO35VSNlc3z86f3QxpXRNtCZaFdkmOq5Qi1fN8aOAHPptl93PVPfALaaShhSDfEKMU4LKKrLI5CWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026357; c=relaxed/simple;
	bh=sDKVnBAWw+VEjJlwU6qbIAbSYDnFekPiS8cxhoWJ6YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWeVnE6Z4REafqGXBPsYGo0KS/No/qESvlaDaYONmk9fbcaLPkoDEtzFc+KpJ5XqiG5hPJ4Kb9+XknVBx2AyFg3h/0nSJTGH531mjI+sK9+tmtH9nUCbeZU9AdbyY4gJE+6jQoDfQbWH1R7E9mKWcSmN56nfGchYkNicYKqPoBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FrTo1vCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2913DC4CEF0;
	Tue, 12 Aug 2025 19:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026357;
	bh=sDKVnBAWw+VEjJlwU6qbIAbSYDnFekPiS8cxhoWJ6YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrTo1vCLFoMik4HabMRim9gnz9Vd/XvBYWbeCrtH84BNrDzOeIduF9SrSNSqBCIUw
	 4uP2DBa7WDzGc2bUUeicPo82D72B3coZJhtcrWrwDIU6QSzwXYnV+PaIccsgunrKqv
	 SKrdF6GgIbmqsWD+w8t+aiUdHaHzDS+tlygi+2gY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 313/480] crypto: qat - fix seq_file position update in adf_ring_next()
Date: Tue, 12 Aug 2025 19:48:41 +0200
Message-ID: <20250812174410.343501257@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 6908c5f4f066a0412c3d9a6f543a09fa7d87824b ]

The `adf_ring_next()` function in the QAT debug transport interface
fails to correctly update the position index when reaching the end of
the ring elements. This triggers the following kernel warning when
reading ring files, such as
/sys/kernel/debug/qat_c6xx_<D:B:D:F>/transport/bank_00/ring_00:

   [27725.022965] seq_file: buggy .next function adf_ring_next [intel_qat] did not update position index

Ensure that the `*pos` index is incremented before returning NULL when
after the last element in the ring is found, satisfying the seq_file API
requirements and preventing the warning.

Fixes: a672a9dc872e ("crypto: qat - Intel(R) QAT transport code")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_transport_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c b/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
index e2dd568b87b5..621b5d3dfcef 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
@@ -31,8 +31,10 @@ static void *adf_ring_next(struct seq_file *sfile, void *v, loff_t *pos)
 	struct adf_etr_ring_data *ring = sfile->private;
 
 	if (*pos >= (ADF_SIZE_TO_RING_SIZE_IN_BYTES(ring->ring_size) /
-		     ADF_MSG_SIZE_TO_BYTES(ring->msg_size)))
+		     ADF_MSG_SIZE_TO_BYTES(ring->msg_size))) {
+		(*pos)++;
 		return NULL;
+	}
 
 	return ring->base_addr +
 		(ADF_MSG_SIZE_TO_BYTES(ring->msg_size) * (*pos)++);
-- 
2.39.5




