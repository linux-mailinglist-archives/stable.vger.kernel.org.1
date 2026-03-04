Return-Path: <stable+bounces-222977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAeQDm2lp2n6iwAAu9opvQ
	(envelope-from <stable+bounces-222977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 04:22:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D21FA4C5
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 04:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26E19305ED37
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 03:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC0034D922;
	Wed,  4 Mar 2026 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="IIGKKoF8"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208323385B6
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594347; cv=none; b=Ti+7XMIFrQ8EatXu4t9D59CA0KjdHB8SlKZIR67MgDhEmiUaQ0iid7Fdnd+9io6e8DNW+VOkuutoTKViB6/ZK4zoh3BN4CSwCuYcxEOFyILmyfn9VcALx79ETW7b52OoalC5BO+rkAyrB01X7QCitvO0DbC8HzXk2pFPwnikq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594347; c=relaxed/simple;
	bh=Zia7W5YpxuaPTUS7zFZUaxlJfaJxhGOFcTmliImou3I=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=skZIvsz8RZSwCktS/jz1yoyHRf9hnsv5kwKsHYipYj055f6GHPczRb0P7J6LNFcWwNOw2JH8iUq9y0C7ZTsqyLGpf3/yIyY52tY/+lIozj4nf9tnsqnJPMKjnIL7p+WkXAmsejKYLClPckWbnc+E8j8dchHPmnnYYJPnahD9Szo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=IIGKKoF8; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772594334;
	bh=W++rZyPRWMQ98vhaBnme2YVFWjNEop/x7bXdsJkhJo4=;
	h=From:To:Cc:Subject:Date;
	b=IIGKKoF8b5Zqx2sCYvjCqOCl56m5UuLoZPurQlnarAEBRKG0vsknEFaRCzOO5qYUv
	 6ncDA8BfDxOPKUNRLbRwP+uG6h/SoL84HA/6Z2ao99SbZUZ7657IbEFWKtWb/xPsNw
	 54yXWSIB+eSl9JJSPqZuMvU1lhIWcz04oGzd0smc=
Received: from China-team ([60.247.85.88])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 4B400C74; Wed, 04 Mar 2026 11:18:52 +0800
X-QQ-mid: xmsmtpt1772594332tq3exns81
Message-ID: <tencent_ACDA359D1F489269D63C389E30B90D5AB408@qq.com>
X-QQ-XMAILINFO: Nm9fJvgf/HqHyr9uy2IFjMMhICiu1m28r8h7kWLhxRy9G7YKOf75iN1s9soM+u
	 oXVXduW4RoCIk1zGnd52pjOdVM1vNvSv7ZRvA+m7GmZbmydwhsHp0Yb7aBkHkFoNdz+DjxZsy5/Y
	 cNI+36wMQZPybUInS6LiGgywYN9/0myYwYJuxDuueLtI34kvhfd0JYl8bSw9pUWYvQHoF1WGw+Kb
	 25n6W95KXPfOb71L2Fqs+iEqUuiNn39uURkGeUxgHiyvlANTi5ailc/ZIoUcNaRqPzqvvl7DCHB9
	 tun62MtHVby9vJ8uRsGJfDI+wGzSnzsBrZ8tsv0FR39t530JxBuzgOS0d5vlriRR4LnJvGbXXa7I
	 8+DGAulXOAQCTkZWerPCMp2waKZ5CFg38NNKH5j8cB5Hn7iA1QZynq3DqaKIIsBZUcTLKqEvUTNE
	 TOp26Ud2EiYMmPb7n13gXC2XLEATcHiEunUsYgCXJxqo7M8arBpbNBvOVdGAEv6s9tJN8IjChZ9g
	 eEUWXVq1/kcATe9jNi31jfWYWdEn98qQysw88n6VJBL6A23DPbzUHDZkbwwjbT3sX6sRbYHqARSg
	 gUiZdsV7552BlHQdRqRB+ImmPUnRkDMp9ibMRgFIKTYEWLuFgDgffziDKfc3dA/HFaU2TfugROq1
	 FpHWCyaf3DT54ql/CsvN4czcKzGraUnRuA4ExvY3pFpMNVGK//M7hMGecjla4ScBmiSUsdiSU/mW
	 ZofKGpM7a91/EMLvZhVF8wDUWTxR209jlhzCkRhjX2/eb9MUNXkRYXnXEaumzFdt0pkgXlst2tOw
	 XAGvi3Gxp/8Z3nzf65wk+FtmcP8suE/bIoAr8YOQJQtzoyhgT6HHhatNgBj74vIXCSgRQGlo1L9d
	 wXHUYQwVes+JhS7svISciur1o+dMRios3zc7UPj93iRDV9Bw78/jmA3Sjr06gr+WR+PU8mk5szL/
	 jzbPcLSySdFGcIMbQ1+P0l9Y57WXY13rkuEsGSDK2ADkXulCMt9wW4q+IphX5OFxszAsSn0HzR/k
	 puGPA1rpXGgF2DmrvzSBL+PvBC5lcKRkJv+YHDuLtfcnMpAOUuauPEGZO9lxU=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] drm/amdgpu: Add basic validation for RAS header
Date: Wed,  4 Mar 2026 11:18:37 +0800
X-OQ-MSGID: <20260304031837.2239853-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 655D21FA4C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222977-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:mid,foxmail.com:dkim,foxmail.com:email]
X-Rspamd-Action: no action

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 5df0d6addb7e9b6f71f7162d1253762a5be9138e ]

If RAS header read from EEPROM is corrupted, it could result in trying
to allocate huge memory for reading the records. Add some validation to
header fields.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ RAS_TABLE_VER_V3 is not supported in v6.6.y. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9d82701d365b..4cfe26fb9b22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1338,15 +1338,31 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 
 	__decode_table_header_from_buf(hdr, buf);
 
-	if (hdr->version == RAS_TABLE_VER_V2_1) {
+	switch (hdr->version) {
+	case RAS_TABLE_VER_V2_1:
 		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
 		control->ras_record_offset = RAS_RECORD_START_V2_1;
 		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
-	} else {
+		break;
+	case RAS_TABLE_VER_V1:
 		control->ras_num_recs = RAS_NUM_RECS(hdr);
 		control->ras_record_offset = RAS_RECORD_START;
 		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
+		break;
+	default:
+		dev_err(adev->dev,
+			"RAS header invalid, unsupported version: %u",
+			hdr->version);
+		return -EINVAL;
 	}
+
+	if (control->ras_num_recs > control->ras_max_record_count) {
+		dev_err(adev->dev,
+			"RAS header invalid, records in header: %u max allowed :%u",
+			control->ras_num_recs, control->ras_max_record_count);
+		return -EINVAL;
+	}
+
 	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
-- 
2.43.0


