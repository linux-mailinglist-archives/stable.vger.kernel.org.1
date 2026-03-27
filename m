Return-Path: <stable+bounces-230555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ6LAIHLxWmZBwUAu9opvQ
	(envelope-from <stable+bounces-230555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 01:12:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31B33D608
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 01:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F4BC303B7F0
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00622199920;
	Fri, 27 Mar 2026 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mL0VJlty"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE600149C6F;
	Fri, 27 Mar 2026 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774570362; cv=none; b=gADsZIvoO0j6PQAd0MTOYqqQEuPJtQY8ZBNaGm0X7+ThwXgg/S2Uz1y/ln27VXMO+wME5j2ZX6p28yiC9Jp6CDXC4wu0hJhBekILi+xnTyzCMKsIrU6Yi/CdC/h6hX95ZDQEAoDMuuT3HQgDo3+BaUPN9ToW5S25FbT/s+tge0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774570362; c=relaxed/simple;
	bh=j4WT0tTagW1CWnW4KdeSu6pwouXwlHPu5mc86e+IKTM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=U0lYBk49Z8yygZ88CnAIRG/9S21UdtNKqP11gKe2aBsKlL26sFAhftjXkxwtthx+wu8JgEmwgPflCcQPtn3sS/M7WzOljAg7Bq/A3vdqYmoZJXDL8Sl2mMPZu8mKj/v5JG2xClvgnPT9SN85WuXXZHUG5Kz1eOXMkBW+RGTQsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mL0VJlty; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774570351; bh=jF3VGWtFl5+5o0uq4BkVs4561ebEJfqMmvq/lQMWgIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mL0VJltyFIuTAuDiXbq0SFZZtwXZHycgE0zQd8Pdni5gtRYlgRrFs9iSWsjYNIDLU
	 ZahxIJ3swxFCe87FTCNeYIsqADKSVTn6R0wWFabTzgvXmuuIbclLK8pWh1Fj/ub4vr
	 F8P0rOdwNduvAkO37xvewIeztKUaL2YOLszylhWM=
Received: from June.localdomain ([123.121.145.35])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 31B3D40A; Fri, 27 Mar 2026 08:12:27 +0800
X-QQ-mid: xmsmtpt1774570347t0b1u0f4c
Message-ID: <tencent_FED49CF5331CC0C7910618883332A08E2606@qq.com>
X-QQ-XMAILINFO: NOcEdvLhLw8TC3ZRP/Ms0StBJXSMyXt0mU2UswUKCWUlYxFjktxm4PCFaA1xS/
	 EyzMCbbnf0yAdffRpg0L3tinYG7P33cxMV7HET/P46r2gumZSJli6l+weTKjXu4Xz05bnuUZjiq0
	 pmeNp96t6ySl+iel6n/kLFUQ4jB/oHXJUdtkfa/4GsK1oSi3mE9NcU0/7Sm8GouX218nqxeCKNAe
	 LwiiNRm1iCtCBsLAz/96ynLKP6QvZ52ne2DDmdgcYgi9GkisNL5EWjuxwkA4c5TsawyE1bNa3DO7
	 BF7XbJPNNVsa06JylxRz4kLskpVXqmPs09Vwxn6iaK3eANR3IN5vmGDXzw2dA/9nx4UVIfov0F9+
	 3FD3ZLQom/kbFJOxCJfcD4ehTLaPG8nbmWOf982IWvOn24PKa5+3owmU1y4w3Pp5eVulVOIKMu+6
	 zVwphqDXppwIFAD9JKisnxWxKJ4+5Uq23hUJ2U3ZkSX05uxIxwqgEf87bC+SEHkaomIac4p9/3Lg
	 Jdd6Z5lXAueJyRSQIdrsOYeGy8aTMf61MnSrNMD1y8QJKlKOblGFejXIGN8oaRqLMgvCqOFYr2F6
	 bGmGgmB6z92I/MWqt+cdi5K0oJl00zBWs2XD1kucFkDnSUD6P2iwgpjMd2Wym5mMlLu1yXkHXK1t
	 AjaDRV3xkdT+duBWUk6CYiEZTHnHqh4Rox1fC6OWWh7gxV5vGXGKfK+ygKFdaGL7bQHhpo8OsNrh
	 ILo4L/k6l6CuNO/Un5shA//IrgSSL9zzT+RnjY+ZSWgfEnKoae1MaeBHmgzDi/x9BfGneqNimrwb
	 OhMBwcNZZ0TX5XskB89pFRAXzg0hm643TXzLnfu02X7O/reQluAWrKdhpBh6A+Nadf0L9IbxRBSi
	 WZDXm7B5wMHfT0pyXkm8jnvYn4f/aCcEkXwplDrHpumfbOjAd0WoOsHzgZqu6YwwTJpSIRSHlZ+y
	 bn/YtDozYt7Ua0ncRNxltyxIGiWiRxbsBIdkxiv/qeGhyD8dTE6x+RpXiFCF1H85SAkSvMx6+pkh
	 MbR+YM2tq39v/Tkg0aQM7b1OV2cDEx3JJo5eTeKpOo2liS2EZfZt4Db4lsRjzANEK2TNxpbQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Wang Jun <1742789905@qq.com>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Wang Jun <1742789905@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] soc: fsl: qe: panic on ioremap() failure in qe_reset()
Date: Fri, 27 Mar 2026 08:12:25 +0800
X-OQ-MSGID: <20260327001225.23192-1-1742789905@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <780c1ba3-6639-478e-896f-e35ec059b58c@kernel.org>
References: <780c1ba3-6639-478e-896f-e35ec059b58c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bjtu.edu.cn,qq.com];
	TAGGED_FROM(0.00)[bounces-230555-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1742789905@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B31B33D608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ioremap() fails in qe_reset(), the global pointer qe_immr remains
NULL, leading to a subsequent NULL pointer dereference when the pointer
is accessed. Since this happens early in the boot process, a failure to
map a few bytes of I/O memory indicates a fatal error from which the
system cannot recover.

Follow the same pattern as qe_sdma_init() and panic immediately when
ioremap() fails. This avoids a silent NULL pointer dereference later
and makes the error explicit.

Fixes: 986585385131 ("[POWERPC] Add QUICC Engine (QE) infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Wang Jun <1742789905@qq.com>
---
 drivers/soc/fsl/qe/qe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 70b6eddb867b..9f6223043ee3 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -86,8 +86,12 @@ static phys_addr_t get_qe_base(void)
 
 void qe_reset(void)
 {
-	if (qe_immr == NULL)
+	if (qe_immr == NULL) {
 		qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);
+		if (qe_immr == NULL) {
+			panic("QE:ioremap failed!");
+		}
+	}
 
 	qe_snums_init();
 
-- 
2.43.0


