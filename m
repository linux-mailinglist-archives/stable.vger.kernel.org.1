Return-Path: <stable+bounces-85658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D15299E84C
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960CD1C22135
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC21D8DEA;
	Tue, 15 Oct 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qjLrh+Iv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64811C57B1;
	Tue, 15 Oct 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993852; cv=none; b=cPqua2IGb2ziw8k6QLABglGbpj3HKy0yPEYgb8BWhrR/xnHYjOBypu0Fg5n5i3aruXFJZIpkhCVoCgC2ZWUpxDJu0W++2gZNNFRqFul0QCLE7VWHl0wUmcWAo8CLvVd33CYBnWhCou7Foiu4wYHady9LCJVqllPQJHTJ9NBpT/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993852; c=relaxed/simple;
	bh=leOMth+rRQSmHfSz4OSAZt2Leys0nC9ZoeG9vZuc5UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HV2vb2pAs49y5IJiPfBS+5XqlK5H0QBIpdn79c7t9kcD3qvhOozye78fDncLzJGmIkB3yEfrqZyrOOqTUEUe/Z+86Rxp/3H3NDrsD3X0uAOQNhNdDwykfvGRTsvDWWxHkcHMF0sbaBbICc5Dnx4KdDje+Drp+t329rJgjzxKtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qjLrh+Iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14919C4CEC6;
	Tue, 15 Oct 2024 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993852;
	bh=leOMth+rRQSmHfSz4OSAZt2Leys0nC9ZoeG9vZuc5UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjLrh+Ive0T4SZUD9mlUvoc6Hety5F9K874SLxkVBg/zujZUdmWqa+4yWIujrBH9v
	 iuRCdtjldnhXtPi/bNhqGQWpqn/0RyVt27d0TfK2eL1CXcEb/U3kmR9R1HdZqTeKX0
	 nwaZnT45qiRXh8uF3zbMinzvdzLEJ9xLWUdBrhCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	KhaiWenTan <khai.wen.tan@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15 535/691] net: stmmac: Fix zero-division error when disabling tc cbs
Date: Tue, 15 Oct 2024 13:28:03 +0200
Message-ID: <20241015112501.575316858@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KhaiWenTan <khai.wen.tan@linux.intel.com>

commit 675faf5a14c14a2be0b870db30a70764df81e2df upstream.

The commit b8c43360f6e4 ("net: stmmac: No need to calculate speed divider
when offload is disabled") allows the "port_transmit_rate_kbps" to be
set to a value of 0, which is then passed to the "div_s64" function when
tc-cbs is disabled. This leads to a zero-division error.

When tc-cbs is disabled, the idleslope, sendslope, and credit values the
credit values are not required to be configured. Therefore, adding a return
statement after setting the txQ mode to DCB when tc-cbs is disabled would
prevent a zero-division error.

Fixes: b8c43360f6e4 ("net: stmmac: No need to calculate speed divider when offload is disabled")
Cc: <stable@vger.kernel.org>
Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240918061422.1589662-1-khai.wen.tan@linux.intel.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -394,6 +394,7 @@ static int tc_setup_cbs(struct stmmac_pr
 			return ret;
 
 		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
+		return 0;
 	}
 
 	/* Final adjustments for HW */



