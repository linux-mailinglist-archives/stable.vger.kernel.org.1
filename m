Return-Path: <stable+bounces-220273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDktOIwuo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 916F21C568B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9727B3046137
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C323824EE;
	Sat, 28 Feb 2026 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3+S10jR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3553824E7;
	Sat, 28 Feb 2026 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300176; cv=none; b=BWlNtmN9NWh63LbuNFbqdQFl5A8XBFVgO2Armqbbt0FSENM/uQRrYr8fJIxB1uvTRM4swaooj9m6ORo0A3CKEHU2/E2SCFeM0LQ4/56DPwPTMAh0RHFIVwb86dsxpkEp6TyYtBaHAHLAJJsAIYZHwnGeipj+s4FNEkrHUtRIjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300176; c=relaxed/simple;
	bh=qQVS1+SNYkHb2oV7rUK6aHfhX6IPuk23megtrKNAwwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRx6ttpXGOsfBmMvQW8IjImvQxxPTCbXkcHHt0NDDM/QpOjz3sNAhht8vQjXEApa3TnoaAMNVDtrVPaRVHb8rInyoYqOR6bKM/xqal2BfH1SlDI7rbC6U5kqjS/9JTwe/XtHvbUen6gg3f0ja7YG881IOmlnFLUvPTgikddJL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3+S10jR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A445AC2BC87;
	Sat, 28 Feb 2026 17:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300176;
	bh=qQVS1+SNYkHb2oV7rUK6aHfhX6IPuk23megtrKNAwwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3+S10jRLKEZZHm07vLOWPaa9VJYct4SEv+57+Nj2EdhGxguPDobZd+J1rJkJ09ir
	 rc94Wszo5XlGkypMFJm9edRkKrGQS7rwV3ukwmU59vh1GIAbULebPo6UbyVSlrKI7y
	 p6UX4bAgfvEt6irkE7sNarJj37FSVQa7zJPVuJlqK1wNizu/yHiuqwR5nG8WsmOWmp
	 F2B2qlWT7n3FxDfLr2XYudj4k5kDvYu2XHULk0mxQc3BYFo8VwqZRZ1k4q+XeBLBdI
	 yoZcyGk/wG0TJI5q45UJ2mkb77K5IjcZMfbW1m8kqiamBXiVtzy48+LvIlyNd7Ym5q
	 l+uEQjA41UfEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Wei Liu (Microsoft)" <wei.liu@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 195/844] hyper-v: Mark inner union in hv_kvp_exchg_msg_value as packed
Date: Sat, 28 Feb 2026 12:21:48 -0500
Message-ID: <20260228173244.1509663-196-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220273-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,arndb.de:email,linutronix.de:email,intel.com:email,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 916F21C568B
X-Rspamd-Action: no action

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit 1e5271393d777f6159d896943b4c44c4f3ecff52 ]

The unpacked union within a packed struct generates alignment warnings
on clang for 32-bit ARM:

./usr/include/linux/hyperv.h:361:2: error: field  within 'struct hv_kvp_exchg_msg_value'
  is less aligned than 'union hv_kvp_exchg_msg_value::(anonymous at ./usr/include/linux/hyperv.h:361:2)'
  and is usually due to 'struct hv_kvp_exchg_msg_value' being packed,
  which can lead to unaligned accesses [-Werror,-Wunaligned-access]
     361 |         union {
         |         ^

With the recent changes to compile-test the UAPI headers in more cases,
this warning in combination with CONFIG_WERROR breaks the build.

Fix the warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512140314.DzDxpIVn-lkp@intel.com/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/linux-kbuild/20260110-uapi-test-disable-headers-arm-clang-unaligned-access-v1-1-b7b0fa541daa@kernel.org/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-kbuild/29b2e736-d462-45b7-a0a9-85f8d8a3de56@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Wei Liu (Microsoft) <wei.liu@kernel.org>
Tested-by: Nicolas Schier <nsc@kernel.org>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20260115-kbuild-alignment-vbox-v1-1-076aed1623ff@linutronix.de
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/hyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
index aaa502a7bff46..1749b35ab2c21 100644
--- a/include/uapi/linux/hyperv.h
+++ b/include/uapi/linux/hyperv.h
@@ -362,7 +362,7 @@ struct hv_kvp_exchg_msg_value {
 		__u8 value[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
 		__u32 value_u32;
 		__u64 value_u64;
-	};
+	} __attribute__((packed));
 } __attribute__((packed));
 
 struct hv_kvp_msg_enumerate {
-- 
2.51.0


