Return-Path: <stable+bounces-188582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF9BF879A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 22:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DAE3AEC13
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D98528E;
	Tue, 21 Oct 2025 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MwnCTwCv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800F350A29;
	Tue, 21 Oct 2025 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076866; cv=none; b=HdncX9OgHXJnNjO4UzR744UETLckiqvZsfkwt5NlvZDOxXmctnYQzjqCS7kFxoKczqbtGUVDKHhyHwVFDmynrZSOGRVyCqpdlJ8lsSgmh3uY1hJoV/hDlIsWWE4OcrTOSQuVROUASBjfNJKCpE2TJnZTA+OOR5NVm5DrPVP83AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076866; c=relaxed/simple;
	bh=guq/mHu9EBk7GCHJNnJaLouXlytIqKBLSOfBAOOUQ4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkoN19kpfVSflN/oOZWVkSzjc/mVpEWD2Jo/GYwggHWCyubIOhtQxDLorhVSbd/wgdJM3EOz2lLnKMRW0NMN5ggX/7lpprqJ8K8hk5Awutk+u0x/eusZYgcACSYj1w4wU8mIHxkcz2MncXOs8NNUDfHv6ID1W9woVF4t85hZaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MwnCTwCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D353C4CEF1;
	Tue, 21 Oct 2025 20:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761076865;
	bh=guq/mHu9EBk7GCHJNnJaLouXlytIqKBLSOfBAOOUQ4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwnCTwCvemJV20iPap8AGbb//6Cedb1ODZlX2M9GDnwTZHMsPYc1YE0QlT7C2G5/H
	 VO2wLkbKPSJ1+1CvS6Vux2rGH6vCss0TztTPhzRRs6L10Pj/AD0HTTfScRThbexFRW
	 POucnNY8++93Cvcl2HYo0SF7Bg8NIbzu14Lzzw/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 063/136] tls: dont rely on tx_work during send()
Date: Tue, 21 Oct 2025 21:50:51 +0200
Message-ID: <20251021195037.491615755@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
References: <20251021195035.953989698@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 7f846c65ca11e63d2409868ff039081f80e42ae4 ]

With async crypto, we rely on tx_work to actually transmit records
once encryption completes. But while send() is running, both the
tx_lock and socket lock are held, so tx_work_handler cannot process
the queue of encrypted records, and simply reschedules itself. During
a large send(), this could last a long time, and use a lot of memory.

Transmit any pending encrypted records before restarting the main
loop of tls_sw_sendmsg_locked.

Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/8396631478f70454b44afb98352237d33f48d34d.1760432043.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index bebf0dd3b95fa..1ff0d01bdadf0 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1152,6 +1152,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
+
+			/* Transmit if any encryptions have completed */
+			if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+				cancel_delayed_work(&ctx->tx_work.work);
+				tls_tx_records(sk, msg->msg_flags);
+			}
+
 			continue;
 rollback_iter:
 			copied -= try_to_copy;
@@ -1207,6 +1214,12 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					goto send_end;
 				}
 			}
+
+			/* Transmit if any encryptions have completed */
+			if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+				cancel_delayed_work(&ctx->tx_work.work);
+				tls_tx_records(sk, msg->msg_flags);
+			}
 		}
 
 		continue;
-- 
2.51.0




