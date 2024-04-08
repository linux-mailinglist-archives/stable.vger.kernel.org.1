Return-Path: <stable+bounces-37629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C7589C659
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD202B2BE91
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776867F7F5;
	Mon,  8 Apr 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p+Eug0ij"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA47E580;
	Mon,  8 Apr 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584794; cv=none; b=HuEmFEORePlpBG2oXbov+vqKsa2LJEFSr8AkadSwYw5Y5ZsUr29sHxDspwjZRHY8R7zcVrqgAY4jaJ4BJW4W7kkrXgl1JkVCqkeIdYEkwkDTL/UNcRQ8Mhw74Po8YnVjyQIoCs4aRWfk82f0SIxuhfAkYVcrTzKLBHdGxWZ+vHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584794; c=relaxed/simple;
	bh=n2BWadht5M5BVHGakBXfhmBZydUYatfmazuezocYS3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JW5sjxeOrYqGht6LYxxFW4Wh6KBtfGbFhWiBqoUB0caooHTORwM8w7F4crVR0XRM+apyg696YTtHh1L8QSyEY9JhBS/tdjj4ss4iSUL8G9SPokOxoTKhsW9FrWk+ih4n2/MP52BSIAvFjHxVuD/f31E+dnhN3q3z+ARWyL5STdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p+Eug0ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0192C433C7;
	Mon,  8 Apr 2024 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584794;
	bh=n2BWadht5M5BVHGakBXfhmBZydUYatfmazuezocYS3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+Eug0ijXLYXxa8BD/BCft9/n7drf1U82WYFwr92BJarIIFHLszoot/IQI6ChFLxQ
	 BZece+ICQStjke6m1wRgMGoI6ETDR1bAsJ7woPPKey4RtBWgjnL5XnuCOAPSdHkyWg
	 0OB4KZaqQSCLnscft/OHyLEexHdD4/TjJDyNeu98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 560/690] selftests: mptcp: diag: return KSFT_FAIL not test_cnt
Date: Mon,  8 Apr 2024 14:57:06 +0200
Message-ID: <20240408125419.914087677@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 45bcc0346561daa3f59e19a753cc7f3e08e8dff1 upstream.

The test counter 'test_cnt' should not be returned in diag.sh, e.g. what
if only the 4th test fail? Will do 'exit 4' which is 'exit ${KSFT_SKIP}',
the whole test will be marked as skipped instead of 'failed'!

So we should do ret=${KSFT_FAIL} instead.

Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Cc: stable@vger.kernel.org
Fixes: 42fb6cddec3b ("selftests: mptcp: more stable diag tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/diag.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -53,7 +53,7 @@ __chk_nr()
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	else
 		echo "[  ok  ]"
 	fi
@@ -88,10 +88,10 @@ wait_msk_nr()
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	elif [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	else
 		echo "[  ok  ]"
 	fi



