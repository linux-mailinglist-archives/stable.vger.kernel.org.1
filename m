Return-Path: <stable+bounces-158958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 906CAAEDFB6
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 15:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861461897945
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045621DFF7;
	Mon, 30 Jun 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="neGccCte"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990C28B7E1;
	Mon, 30 Jun 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291745; cv=none; b=QNJwdk0cQW76p12k1OxULpPs8q7S3eD8fUdarlU3rveoUlkSwzFMHrXIrFb6le+G/5ZtfiCaGgGYMSf6YRj22qDHbHBB/4QuEeYA9zmavkVl0hVIbhX/hnSGScQVyaZx4VcSERQ+9TXTSYkD7RDeuTBg3EgEy8ZYoLrC22Uerqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291745; c=relaxed/simple;
	bh=JJ8PBaEx8VkpdEcJqUYzdyXQ7P0j1oS0qswdf6c5b/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tPFDHiNstPwwgnCS35UdOM5taJD1VBc/aRiqCyTNQIozorr59TrhwXvZvB0WkvX6xZ9QtagPnGMSaX/aTAE85XyhDbv48tKmDbPSKbwcgvrMt8X0+elLOHpJ4PbnCb6Es8q9P7jub10MFEBhP3uUO4RpFG9y23J7N33pAyxVpoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=neGccCte; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1751291724;
	bh=uxX69CClkx06ND/PR5r3D+upO+i0Fhzs+Jhqo7bEHhI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=neGccCteqlUxaOnAYGN7PGXAE2lwSBwKp/CVydQbMYDsC+Zf3PvxBGqNEut3CaFlM
	 FEaCRR6oC1HjQKhB0dAN9rqtVG7irZ5RinlmM050QLvByq3cCP2TkWejmpvGkGFW56
	 EdB7jx0Ho4fwEmwLZJRXV+Of4bgsO+2yISy5vsbY=
X-QQ-mid: esmtpsz18t1751291719t009b4508
X-QQ-Originating-IP: DDIvZO/ev5DI1MHibfbUQUUZtpcFSOhV078HaTlfmA4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 30 Jun 2025 21:54:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 123160193670918497
EX-QQ-RecipientCnt: 3
From: Chengyi Zhao <zhaochengyi@uniontech.com>
To: linux-bluetooth@vger.kernel.org
Cc: stable@vger.kernel.org,
	Chengyi Zhao <zhaochengyi@uniontech.com>
Subject: [PATCH] obexd: reject to accept file when replying any error message
Date: Mon, 30 Jun 2025 21:54:21 +0800
Message-Id: <20250630135421.740-1-zhaochengyi@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NAtipnnbTPeayqLm/G3PpVvgBAYkiB0g1o89nigkD6xY2rZFJhXkdpP2
	P3gBrS6RA33W7OKNpTJou3SmlcACnvTQcwkysFNALBZRg8Cz8+irdAOk6xEoS1zIRKBeFfO
	9zwIrwNFUhkwHkX410gqCibaISpS/+5NtAth3YWeeQTH4jhEbdEig96tZa9LWtaKYwHbfco
	y9toxYvIRjegiDAiqpBjFY3gIufDpY4m7W2hMVEFCKitFFWtEzaovGf2QBVrDgnldCQn8Xo
	Uk/xbULT5zHnO3NFePyoGhdCSHRVaAPmZLf125ly+RYA11Jo90X7MuxB29gIMmR3QMMJSoV
	NIRwROTCzfFsQDP6XhS/if1Q5dUWk4cd6DYpNrFtbqpwNLlwOWBplbtNehNEX5iKPBjGOiV
	95M0gol/mwbDifn0SXdsbpTC/6jckMnOKSICp62iNyZV4rcRMe3LJaVJuYC3u865+Lh9jUQ
	B7Kp+C1MVQQqZpWFfNr93USgs2AMEbmGYj8eI4uds6eopNPhdiZd0rwUMzcXJtlcytPgk8G
	SdLXIMF81F2JgrkFFxHXxZnX4gBKpCWbzcqF+25ZX6UHIanaHZGh7HzgE+BzPzoulygxec7
	YkxlnibkDS3IXNxgkHXR5OIjX8fTxnJ/5UTx6NK0+aD1HqpHWMNSry98DPdytU2+kQH966C
	6QtC9a965ShKZqKP3uRLTP6cpKDIJfHd3UOaDkV5dewb7EU1i62XxhowYMpI8pynFMK12md
	eSQurSWDgMW9o4vu1m1ERhks/WlwS5GRqAn93Y8GxSGhUG86eXy+O8E3btQEC99LmQDqoXL
	uZJxV5/ATxJrxyH8+fvP8Hz1uCZSr8fTSs6moGJraSyUNfjWPzbhc78qoTfl6ErU6g/l1d7
	9gUp1Jv2pHIg8JClB8Bla2VbahltFcuUrgdCPKyzf2cL8jjHLt55bZSK+NoDgFbMCGuB6V8
	MIkdm9TeYSFXnpzce+74IDDNHQwXtlVn0ED3QrAmsH5m4By8IbK8NHehnK6JAQcsFPU5ZC/
	DiR/I7l5jGSlBUh+Rt
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

For security reasons, it will reject the file when the obex
agent replies with any error message, and accept the file
when the obex agent replies with the new file name.
---
 obexd/src/manager.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 5a6fd9b4b..cecf9f90a 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -658,6 +658,8 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
 				agent->new_name = g_strdup(slash + 1);
 			agent->new_folder = g_strndup(name, slash - name);
 		}
+
+		agent->auth_reject = FALSE;
 	}
 
 	dbus_message_unref(reply);
@@ -703,7 +705,7 @@ int manager_request_authorization(struct obex_transfer *transfer,
 	dbus_message_unref(msg);
 
 	agent->auth_pending = TRUE;
-	agent->auth_reject  = FALSE;
+	agent->auth_reject  = TRUE;
 	got_reply = FALSE;
 
 	/* Catches errors before authorization response comes */
-- 
2.20.1


