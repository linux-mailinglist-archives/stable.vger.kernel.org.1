Return-Path: <stable+bounces-26114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFD1870D2B
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0D61C24D0D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1898D7C6C9;
	Mon,  4 Mar 2024 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vSt86MaQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE097BAE6;
	Mon,  4 Mar 2024 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587878; cv=none; b=RY4taULe5ncy8v/+rrbLONNX5xBYx5OgczYSrtmB0zI5kQpvdO+bCdimGGOyR0Q29VtrzRU8CN/7Pyp31YO4APoCi6yjM3bXLVPIkEjMrzgin1IL96J7m/TxrcUGIIp3LKna5Yusgdbh5vFNUPCbFvWS0RyDyLRgO24+v57fb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587878; c=relaxed/simple;
	bh=TKfyOT8po29Og/gscZtvuKHHyeABgcQr2D4WX2HKfuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1lehC2gyObY29E6CV6ASsb0a5KEfCoffsU+ZgbQ9jxMGOBxakPabd/YScRuedIkeRdXByV9355X7lSpNWHtjwvOFTxod9wVwPwkdkChOZbVI2I5bAnfnLMmTn3+hRCSRatMc+u25OjK32P3hiUEyBYpDFB26+Hy6NcTsSEGgg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vSt86MaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD27C433C7;
	Mon,  4 Mar 2024 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587878;
	bh=TKfyOT8po29Og/gscZtvuKHHyeABgcQr2D4WX2HKfuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vSt86MaQI4TFKyPeR7xYudL5FojL4+2roVaVX+ieG01AB63VKbRdfvjdtDZkNCkpg
	 2S8Y7pvZXkir/RliX4c2AlNjom4RR2/n8Cn4+76bN6GNr1UyAcfHt0mFO5JqlcsJHn
	 xH1qw/X8bki9sPXZTPR4ZIBbk/SjRNEFa2FIwiOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.7 125/162] selftests: mptcp: join: add ss mptcp support check
Date: Mon,  4 Mar 2024 21:23:10 +0000
Message-ID: <20240304211555.745865407@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 9480f388a2ef54fba911d9325372abd69a328601 upstream.

Commands 'ss -M' are used in script mptcp_join.sh to display only MPTCP
sockets. So it must be checked if ss tool supports MPTCP in this script.

Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240223-upstream-net-20240223-misc-fixes-v1-7-162e87e48497@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -159,6 +159,11 @@ check_tools()
 		exit $ksft_skip
 	fi
 
+	if ! ss -h | grep -q MPTCP; then
+		echo "SKIP: ss tool does not support MPTCP"
+		exit $ksft_skip
+	fi
+
 	# Use the legacy version if available to support old kernel versions
 	if iptables-legacy -V &> /dev/null; then
 		iptables="iptables-legacy"



