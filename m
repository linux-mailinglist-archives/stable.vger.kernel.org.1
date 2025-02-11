Return-Path: <stable+bounces-114885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2848A30817
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B2918899D4
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9841F3D59;
	Tue, 11 Feb 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MeYtoRNC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA701F37C0
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268582; cv=none; b=Ce3FOMW2B+6+IeDeeF08ywkBQfyrGbFOT8Lf96oWc863BOqJC29gaw/fmzpcHRyMXsQuhAxQYCl34jL3jRslCjxqvTv7TFkbmSSD8RdC2z4/L0ElaqlHyz3JAIs611xuVu0tmXP6UkmNNprZ+Dq1ZkgsfRYnbGrp2aKQ8MJTJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268582; c=relaxed/simple;
	bh=BBu7B5nH7iav87sRQX2zBDVAeGpoZhX9Ft9JOkcX7nY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l3aog7njDaYs9ulkeyXNdcWQq0awLfHhu5YsiZLWeQn8IeGNvWzNZNwFEai89kZq7e7KvqB0cznGXa+BEW/n4XZJ9aylfwxqGdDj+/RdQjAAcjd9CrXIElrM+V/ZGCYpzkhZVzyXLm59hQ3l3b8kkkUDXv1tFtjjjUpD4H+pi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MeYtoRNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CFCC4CEDD;
	Tue, 11 Feb 2025 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739268582;
	bh=BBu7B5nH7iav87sRQX2zBDVAeGpoZhX9Ft9JOkcX7nY=;
	h=Subject:To:Cc:From:Date:From;
	b=MeYtoRNCqFAg8ilMChnVFkLG2Bjo8/PfeYT+8Z4Fs+D5irEVdVB+UPKVlrXQ+U5px
	 6iNBpSCK6hVGbdmeBeHL5HDIfZFxrT5wLPwS1lMGnooV3ueko+MqvSPsLrDF/+sKa7
	 xcixdUxI6TKzV5sPBE5mRPSkPd7DY/+CxAJxtzR8=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Fix copy buffer page size" failed to apply to 5.10-stable tree
To: quic_ekangupt@quicinc.com,gregkh@linuxfoundation.org,srinivas.kandagatla@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 11 Feb 2025 11:06:34 +0100
Message-ID: <2025021134-attendant-greedless-c5c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e966eae72762ecfdbdb82627e2cda48845b9dd66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021134-attendant-greedless-c5c8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e966eae72762ecfdbdb82627e2cda48845b9dd66 Mon Sep 17 00:00:00 2001
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
Date: Fri, 10 Jan 2025 13:42:39 +0000
Subject: [PATCH] misc: fastrpc: Fix copy buffer page size

For non-registered buffer, fastrpc driver copies the buffer and
pass it to the remote subsystem. There is a problem with current
implementation of page size calculation which is not considering
the offset in the calculation. This might lead to passing of
improper and out-of-bounds page size which could result in
memory issue. Calculate page start and page end using the offset
adjusted address instead of absolute address.

Fixes: 02b45b47fbe8 ("misc: fastrpc: fix remote page size calculation")
Cc: stable@kernel.org
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20250110134239.123603-4-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 56dc3b3a8940..7b7a22c91fe4 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1019,8 +1019,8 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 					(pkt_size - rlen);
 			pages[i].addr = pages[i].addr &	PAGE_MASK;
 
-			pg_start = (args & PAGE_MASK) >> PAGE_SHIFT;
-			pg_end = ((args + len - 1) & PAGE_MASK) >> PAGE_SHIFT;
+			pg_start = (rpra[i].buf.pv & PAGE_MASK) >> PAGE_SHIFT;
+			pg_end = ((rpra[i].buf.pv + len - 1) & PAGE_MASK) >> PAGE_SHIFT;
 			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
 			args = args + mlen;
 			rlen -= mlen;


