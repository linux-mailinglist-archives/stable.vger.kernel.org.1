Return-Path: <stable+bounces-262407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u5LoJcvKKGqEJgMAu9opvQ
	(envelope-from <stable+bounces-262407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 04:24:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE756656F2
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 04:24:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=gVCNmbXa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262407-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262407-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 719A730AEC8A
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 02:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DBA28030E;
	Wed, 10 Jun 2026 02:21:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B52874F8;
	Wed, 10 Jun 2026 02:21:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058118; cv=none; b=Wtmrqa5NwMak4AvgRdM9Kq7ejQAQQEQTjQWcxTRkreJyvZWjr6XzfVrhhBsg0tZvXUJraZdKol8tL9+zeh9rkfeRHlo03a/OziYlo8ft+CgtBfmk9VjiJ8TWpByuP2VDDpNW96SoECVURrVS3Y4HDaDTs4IhKzeshEBNkF5l7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058118; c=relaxed/simple;
	bh=3AN/GDMda1OVSuSxQuTeGXL8MNo4HYwZLsEsL/ouXZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oPetYYxNhwnzN5QHVpiIh+CJwGN54E+kKbUwNZLyBOyGly6Il3Ac4r3v+g6HofLbAt0ng8u3u6Gi7orNu4yF1Bp67imaMmgLdd+D7+Pbm8MhffyGI85y69Se7xrEPv0c4Ba0XyAEzUKiaqWnsDOQsP7yBORJmqtTRf9/Bqd9NR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gVCNmbXa; arc=none smtp.client-ip=18.132.163.193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781058107;
	bh=QCe4298oC+5SC0xDh01+u5CQw3nFK1Tz14usyVQ3ZgQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gVCNmbXaETQWdxJ9HXfuYuLOWS3zdWcs9OkTTxxdCe5GiIKxZeVC2hlhp18e47d+J
	 EbWPVPRfUPBnwx9eD55zA46Xh0itwp40PhMZckMrtJmKk4hi8bobLX7DVVGJrZj5+K
	 6GERqs7EufgEBEhjiXHjcnETKBUDYoNG93dXXgWo=
X-QQ-mid: zesmtpgz1t1781058091tc2e4e984
X-QQ-Originating-IP: Qlix9jfpBpFqgpMZibKtqLAsWN0iiYk29pM6y8edgQk=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Jun 2026 10:21:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13360541327879733750
EX-QQ-RecipientCnt: 6
From: Yingjie Gao <gaoyingjie@uniontech.com>
To: linux-xfs@vger.kernel.org
Cc: cem@kernel.org,
	djwong@kernel.org,
	linux-kernel@vger.kernel.org,
	Yingjie Gao <gaoyingjie@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] xfs: fix inode ref leak in attr intent recovery
Date: Wed, 10 Jun 2026 10:20:27 +0800
Message-Id: <20260610022028.79846-2-gaoyingjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260610022028.79846-1-gaoyingjie@uniontech.com>
References: <20260609111619.1866748-1-gaoyingjie@uniontech.com>
 <20260610022028.79846-1-gaoyingjie@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Of2cEohDBRJB3pJN/dS5O8teCeXc68+ZbmOSm4bYbEUvKtZlsLed2rn2
	GT6/Bj1oqwPn0esHJvb6i7nSOfmXeIYEsTYn5UezFz25T9KJe3UhANlMFPj3I5YzSeUylDS
	zI1F2x9HcEDEtV2NfhBygqC1lLAOIETvHoyZ0+ilpmJGL7kjgfDz1wKMN+d26Q6yH+BN2Go
	mHPKR6Y3IfG162DX4I6h4Tlp0odNDQTjrFYqsJamQgGtQ1GjXlkN055vNLfZbJ+CSUNbPzU
	qgTF3jgbCuVHkYAnxk84+VLTfDT/c9BsfAhbzAKN7z9mrrcJtBZ6cFBUh9r/jDVpzM8s8Cm
	dx/1sNn7IlS+wXHzoQ5EEqI+1syL1HOKyQyBLU1Nv8BFgMXIk7MWVfKvctRsPj62eJ+blzm
	qXz86l6hmKkJqSokdIolv8a92vA9hjybkptaTcQM9tXBnpEg6O0xpCz/98mAEtRxXAFc17K
	8l6+287RoPmD+8b+71eMf8+Q5dB+Ka6TWbRQvAiAHP7mW0nTntBhxLNRVINqeFC2vnaTPO2
	3DyJSetHk1UKT9JBrFNUathImfXJJvC2PqT8DVvoQIbCeUKA42XlmtqBkteD053jPPpKnTI
	xSCJc0C2dsqmm25uMS8V8occzySbcA3g9yxEXWT5JjBOpnnKIPi7hTV/rdyporiGsVlPYVa
	1O5HAENpZlRArkenOcKr8yxRx4efqk+TIWUVVDsZX8Z4wF/6fWTDlgxNSPQ1y/zm/RCPQ4O
	Ib4pYTVCKWzjAK1Wul/OUM2XSe4+22KHa7zSAOWEtjRZWxLrHDmfKu3+hFIDHb6jPvK5EE5
	32Sqdee3yoMtYVpnYtWy/1+224QPI6pbnmwYfxyWeW5Wk9+62/Hwo2J28gX9vHHwvQRagkF
	Hw+EhUC0NBSdL3tLtv8Agm4sU1XHCepttZaUFrtjjeeSljA2AsB5imN7uRsKDa5AOcKmBpt
	k1P3oCT9qjDF8KnrEHpJHRF7qLMcaYYL/SrQCfSiBn6E+uaQCBUux0id6xJEm1SdGASkrzv
	IjKsGBrlQJeHGqXxxXY/f0OWtelqydO4JPJJI+oQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-xfs@vger.kernel.org,m:cem@kernel.org,m:djwong@kernel.org,m:linux-kernel@vger.kernel.org,m:gaoyingjie@uniontech.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[gaoyingjie@uniontech.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262407-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaoyingjie@uniontech.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDE756656F2

xfs_attri_recover_work() grabs the target inode, attaches it to the
reconstructed attr work item, and adds that work item to the defer
pending list.

If xfs_attr_recover_work() fails to allocate the recovery transaction,
it returns immediately without dropping the inode reference.  The later
cancel path only frees the attr work item state, so the inode reference
leaks.

Send the failure through the existing cleanup path so the inode
reference is dropped before the function returns the error.

Fixes: e70fb328d527 ("xfs: recreate work items when recovering intent items")
Cc: <stable@vger.kernel.org> # v6.8
Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>
---
 fs/xfs/xfs_attr_item.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index deab14f31b38..841838bc1d0f 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -774,7 +774,7 @@ xfs_attr_recover_work(
 	resv = xlog_recover_resv(&resv);
 	error = xfs_trans_alloc(mp, &resv, total, 0, XFS_TRANS_RESERVE, &tp);
 	if (error)
-		return error;
+		goto out_rele;
 	args->trans = tp;
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
@@ -791,6 +791,7 @@ xfs_attr_recover_work(
 	error = xfs_defer_ops_capture_and_commit(tp, capture_list);
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+out_rele:
 	xfs_irele(ip);
 	return error;
 out_cancel:
-- 
2.20.1


