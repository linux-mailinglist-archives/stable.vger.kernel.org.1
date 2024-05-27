Return-Path: <stable+bounces-47191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5288D0CFC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7C71F20FE2
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EDE15FD01;
	Mon, 27 May 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BK0EtN4J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0635F168C4;
	Mon, 27 May 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837904; cv=none; b=fPn8/COjVgAR1qfC39WQ0gAHrtA8udgfbgbg8006XvVFmV+052qEX8LBR9yXyEMme4s6lQQeR6zIeXOllG1F4eeCkFMtONZlM8MJOh+TJxboi3fkt85YIsFXVINdn6s5hOmjzGSt2i68NNZXj1mC1tmDJ8cOEVpUB7hy00b3c+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837904; c=relaxed/simple;
	bh=LJgVjqujfkb//1MhwqZywfN+wJmzDWpkZsmZ44C1gGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQK+EKkY4sfd+UL/yClOwHLKpNSN3iaoKrCV/qiWCiSPSwmVJ89rseldu/7WXDN8e08Kfm2EBTIxKu18zEdvKtZiHRDZgDUyYs2SuA3UKKEUzxqE4tePaJCZj6bbV3HTCKga+Zp9LRYxo0zfQkuo6RbNp6lYz0SIcjtE2uGI8bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BK0EtN4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E05BC2BBFC;
	Mon, 27 May 2024 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837903;
	bh=LJgVjqujfkb//1MhwqZywfN+wJmzDWpkZsmZ44C1gGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BK0EtN4JKB8JakdfzV8s8M0+AJcvC7oypTdF9/W8fH18l2Bzc8M2kzNOr/+wJel+B
	 leUBfYbRKZk9kAlrYHptXUgpzP55J+yZL3C50SmUwFXcTOK2bLS+mYkt/mnnuBeRR+
	 q0r8IdpfWEEPv8B2pcEaE5/EU9X/pP7PjMTTTIhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	Christian Lamparter <chunkeey@gmail.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 190/493] wifi: carl9170: re-fix fortified-memset warning
Date: Mon, 27 May 2024 20:53:12 +0200
Message-ID: <20240527185636.568483835@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 066afafc10c9476ee36c47c9062527a17e763901 ]

The carl9170_tx_release() function sometimes triggers a fortified-memset
warning in my randconfig builds:

In file included from include/linux/string.h:254,
                 from drivers/net/wireless/ath/carl9170/tx.c:40:
In function 'fortify_memset_chk',
    inlined from 'carl9170_tx_release' at drivers/net/wireless/ath/carl9170/tx.c:283:2,
    inlined from 'kref_put' at include/linux/kref.h:65:3,
    inlined from 'carl9170_tx_put_skb' at drivers/net/wireless/ath/carl9170/tx.c:342:9:
include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  493 |                         __write_overflow_field(p_size_field, size);

Kees previously tried to avoid this by using memset_after(), but it seems
this does not fully address the problem. I noticed that the memset_after()
here is done on a different part of the union (status) than the original
cast was from (rate_driver_data), which may confuse the compiler.

Unfortunately, the memset_after() trick does not work on driver_rates[]
because that is part of an anonymous struct, and I could not get
struct_group() to do this either. Using two separate memset() calls
on the two members does address the warning though.

Fixes: fb5f6a0e8063b ("mac80211: Use memset_after() to clear tx status")
Link: https://lore.kernel.org/lkml/20230623152443.2296825-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240328135509.3755090-2-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/carl9170/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 6bb9aa2bfe654..88ef6e023f826 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -280,7 +280,8 @@ static void carl9170_tx_release(struct kref *ref)
 	 * carl9170_tx_fill_rateinfo() has filled the rate information
 	 * before we get to this point.
 	 */
-	memset_after(&txinfo->status, 0, rates);
+	memset(&txinfo->pad, 0, sizeof(txinfo->pad));
+	memset(&txinfo->rate_driver_data, 0, sizeof(txinfo->rate_driver_data));
 
 	if (atomic_read(&ar->tx_total_queued))
 		ar->tx_schedule = true;
-- 
2.43.0




