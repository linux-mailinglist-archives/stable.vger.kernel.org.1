Return-Path: <stable+bounces-220340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAKPNhU2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6262B1C60CB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9064232BDBD1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6619398DA3;
	Sat, 28 Feb 2026 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBoMmttw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E50359A97;
	Sat, 28 Feb 2026 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300239; cv=none; b=RHN0MPl62EcIA1pjYwLr62wVUW7FKFpnbFLqAEicRt4UDLGXTQcY4LDrsgKA/rbHh+sgQPs87RwiocFk19tarpAIIFfT3WhW1wI+Bf37ybatY7/EMzUX5bW6rrUZ0Ul4EHaxzhBsHVKoCXbxtp0cORObNfWQbU2bW0VGy58ggP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300239; c=relaxed/simple;
	bh=Gz1ludxEEJFQWEbjaRhIszl1VzZqmuMRqS+le7z7d1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmT7atDxw/bE6S9KqPuBY4xjZbGgXGPFL3vQG16nqXFTtSp1tz9jCvl+31NGabYymWCAqHG7fYBJspmN7feEwuXZpuGJIRb4Q5Gsr3wVRFADLGsfBy94AzWYT9zVIDTClSQiVZTK+pk9O1lujtqbgfdkj1Ydth1k7VRG3CK6Cek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBoMmttw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3EDC19423;
	Sat, 28 Feb 2026 17:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300239;
	bh=Gz1ludxEEJFQWEbjaRhIszl1VzZqmuMRqS+le7z7d1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBoMmttwkbhRjeCra74iYYp/AK1N/IeSARZ1fn/+5ycuabq8oqncAwNMSkL7OcP8G
	 krLhckHvf2dLsdsEf03+vR0nLG0R86fvjude+toblkPC+EOzocNRH+Kd7sXsNr+/0V
	 4gIrGMBfnmZZdz3fqCpq0WrXNZH0hANMx5IJHfBiEi3AUXCsqIWc+tTeiPhNBhEL9V
	 qa9o6ZpmFYTzHWuSDC1A7KtXAuNjVHkCd12KgUNc66lHGI2QA7BpqfBSjpJXSk1rKs
	 Tt1llSiY6eYvw4G1ImqoGwO84+xqa3gm9RGPdUJCwos+t73MUHxEiVKdvcIj9i8WI1
	 tbyUdLX9G3Xpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 262/844] wifi: rtw89: regd: 6 GHz power type marks default when inactive
Date: Sat, 28 Feb 2026 12:22:55 -0500
Message-ID: <20260228173244.1509663-263-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220340-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6262B1C60CB
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit 8c96752d99c0b094af68317a8c701b09bd0862d9 ]

When inactive, 6 GHz power type has been assigned to the default one,
but missed to mark the local control variable, dflt, true. Then, this
might let some 6 GHz power info of disconnected APs keep being taken
into account under certain cases.

So, mark default when inactive.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251229030926.27004-12-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 209d84909f885..c3425ed44732e 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -1142,6 +1142,7 @@ static int rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 		}
 	} else {
 		rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+		dflt = true;
 	}
 
 	rcu_read_unlock();
-- 
2.51.0


