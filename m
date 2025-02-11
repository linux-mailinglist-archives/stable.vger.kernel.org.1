Return-Path: <stable+bounces-114884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51850A30816
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93C31889A5E
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9971F3FE2;
	Tue, 11 Feb 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="De+qmkA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6381F3FD5
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268579; cv=none; b=n8uXh4HjUBZtmRH2BdFnSeMpZHMqi7EEHR6m/tglCKZEPNFIzODnjTw0ljoeUs42RylA3f4DUfg/X0S+VMNFku2HIETrjMpR9/xZZ80reruocYPOGv7G/kwXtyKBEeDCe9K3XxSzHTyFX/54pUkPjwCTaWem6cafWIchdcR61uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268579; c=relaxed/simple;
	bh=vQkG6zJrtltwAS4wQWj+ljYyFITu+Hb+COCn6D/u2MM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t4vsjHhR1cfyvyq6cVYgnwNPtTj08Xhr1nIi1LklwhdH8+2gOx+/MxakzCZ7e0oqmeyzIKSYctGo/67AP3KuUKPlnQabon4P1ZeXWm5Y2fJv2wpgq2O6Yiecgx1hGkt85OqD5McUicL85huUUMH/eSoWxD/nQ0B9yAXjDt83A5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=De+qmkA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680B9C4CEDD;
	Tue, 11 Feb 2025 10:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739268578;
	bh=vQkG6zJrtltwAS4wQWj+ljYyFITu+Hb+COCn6D/u2MM=;
	h=Subject:To:Cc:From:Date:From;
	b=De+qmkA+3lGlk/3Wx5o5cNfHGUk4u+xNCTyU6MSW55rma73+ZKKYErnlZZxdYH6FC
	 sQQnK2jkYPnpglqHRfjAlXwVhV5zsQiWRyiMOLzERsfHr6FRNu9MvbtI4+z8MlYaPf
	 n7013f5Nccxi5HE9dSHmJOgP/n93xYqn/OET1wfA=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Fix copy buffer page size" failed to apply to 5.4-stable tree
To: quic_ekangupt@quicinc.com,gregkh@linuxfoundation.org,srinivas.kandagatla@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 11 Feb 2025 11:06:34 +0100
Message-ID: <2025021134-kissing-enjoyer-5d7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x e966eae72762ecfdbdb82627e2cda48845b9dd66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021134-kissing-enjoyer-5d7e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


