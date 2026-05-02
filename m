Return-Path: <stable+bounces-242611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI80Hkcc9mndSQIAu9opvQ
	(envelope-from <stable+bounces-242611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 17:46:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA04B2B02
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 17:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4A3C300F9D4
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5853822A8;
	Sat,  2 May 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/pOUegs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E038228E
	for <stable@vger.kernel.org>; Sat,  2 May 2026 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777736607; cv=none; b=q+qyGDw6JgMv5A+F0ighU+gsbwITL0QXcgB2TixOw2W3BY4Nt99/Vaiuuz/PRby5F15kc5BPXC3FpAL0OXnERrjFoTdxZTrVsVPkHhObidUrtvBadeoocyUPcErjAgmLxGgG64b7VvNdGQJ+4vkuwBicf8COmNgltPBpB2uJBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777736607; c=relaxed/simple;
	bh=Qcqo8Bkv1OmcFLp2M409Xk+TJ506bXJtcrDPRa0OEk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpH4EkzIqBgyj5kpx/E9mk1tQWVLFr7ESL1y6FR/86Nn6MY3+V3JV4VgxA0RG03IfwwDlaAX5VgZHYSc6fHGneImRKuW0b1imUOnZsOJ62ZCnQY4M26I4A80P+deWSjYo46vZTquMCYAsampwwBCI1UHn1m3BU+ggjAWCaTuNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/pOUegs; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35fb262f92cso665799a91.2
        for <stable@vger.kernel.org>; Sat, 02 May 2026 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777736606; x=1778341406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPLhh/sYehPY6xGFGWFMg/n/yf/ziOgLoWmXDVIRRZ4=;
        b=Y/pOUegsqE3BfsxqGiYVDMQl/OkgrXGS7GwbdOvefwrVA9LlPUs+SDxcl1S992Lwo/
         yjGwIII2G1JCRzaXCpENO1YgAd+agBRgoko+NjtrBlWdtfMuFXa5e7pB+y/z+dlEhhYx
         wauy8uxzRyoI2pFSnW21PUc3cDiSl3ZCwmzLkXjF9/Ys96V5uXHOkxjaYaJDhkVWf6w/
         YtlW9SBiottGcA1mnXGYs0go8GHBb/dMu+EQp0E+mQW5EUqxgJqYB13nDlt/ewHHQJYA
         2hCvBDekCs8NN8MZrYOzY5ZiJIJWFamDI9+kgLhEoVfrzPYgR+wj+jETYBcmM6Me8BlX
         4cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777736606; x=1778341406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPLhh/sYehPY6xGFGWFMg/n/yf/ziOgLoWmXDVIRRZ4=;
        b=BL+HgZqa1b1ygHksFJ60SXw7AwVAqarH31PTH/IazaB335bmwa/V2K0/RiUpg/06ni
         D1iyN12LvXALeMLUkZCUBymZJc/4nQpBM2QqcATxNvjz3K3O7BVCdE7aShcmNrQObrDM
         P4+NITB5v4/kT6rexE7f5P8O5H+6omffo9tO2M4uEDyi84fUvJMjUqWtlVbA9JhFeDUs
         M8+muSlSLPNgg7J44w38tVt2PBUzzZjseqdYfoh7YYmpfuqgsQIXeu4QQaPC9ODodTZR
         pLbOgBTCqDWFRfGyxKFlwZ0wPU30ykLVqjHOGx9hilQWXiEnbPK56JsbrAeEBF9FslIl
         xxtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mqQ7woIxs9CK9xx7XYn4HFL+cVoPfqhctd1wKg2qtzPv68l6JoYGU0S7/VFAgexmp+lb+3lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmVjGQpY8kv5pQRMaChEamFxgOE00pplaiczeoETkssvJtDSL7
	+cK50WDMia1fi3dqOY4J02NVh+XJqSkF+UfL1oLGBbro3by9loVzY8kW
X-Gm-Gg: AeBDiesW3T4qyXCehumituo40SjmGPaVGfqaoqW/I1FykWYmjOo3sKoFf7Zw/Yt+O9O
	IsSBbehbe4paslYAFpX97ZJN/hH3E+rMqAgIjI9pK6d2X/8jmLzutp7DeXj78Jh5yK63QbXavui
	z6+pMXzx7ZtTZvVhg1QaYli5kLGUmNRQXDerDFp/mVTotrGaHM7cBETFXbE2+yavkUqCBGGHoMh
	TMW45zVUQIndunXk1pOd8hYvzEgB6lUgRFKA3/0pr2okNZhsdTOPrGTfO9HjifAnrrLt3ygzOhO
	vOMtvo1cNQ8vPR9Kb+e4grMdTFe95tbOYNuoM3KbcrP9rx1evaFbMhf5NHZqTUVmzq0y+bvvRV5
	ghsp5Vx2Mb2KH5wkEVKVxzdLL/jz0o+/oPScBqtUN64ZeE1VaRCZbiWMg4saWilRdWTEb5cHBML
	siz7jlsSejSjdDXc/dLObM88xIsI7U
X-Received: by 2002:a17:90a:d407:b0:362:be3b:c8d4 with SMTP id 98e67ed59e1d1-3650ce10197mr1847644a91.3.1777736605937;
        Sat, 02 May 2026 08:43:25 -0700 (PDT)
Received: from kali ([103.195.202.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaae29dsm52915385ad.19.2026.05.02.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 08:43:25 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] fs/ntfs3: validate lcns_follow in log_replay conversion
Date: Sat,  2 May 2026 11:42:51 -0400
Message-ID: <20260502154252.164586-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D4EA04B2B02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-242611-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

log_replay() converts DIR_PAGE_ENTRY_32 records into DIR_PAGE_ENTRY
records when replaying version 0 restart tables.

During this conversion, the memmove() length is derived directly from
the on-disk lcns_follow field:

	memmove(&dp->vcn, &dp0->vcn_low,
		2 * sizeof(u64) +
				le32_to_cpu(dp->lcns_follow) * sizeof(u64));

check_rstbl() validates restart table structure, but does not constrain
per-entry lcns_follow values relative to the entry size. A malformed
filesystem image can provide an oversized lcns_follow value, causing
the conversion memmove() to access memory beyond the bounds of the
allocated restart table buffer.

The same field is later used to bound iteration over page_lcns[],
so validating lcns_follow during conversion also prevents downstream
out-of-bounds access from the same malformed metadata.

Compute the maximum valid lcns_follow from the already-validated
restart table entry size and reject entries that exceed this bound.
Reuse the existing t16/t32 scratch variables already declared in
log_replay() to avoid introducing new declarations.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 fs/ntfs3/fslog.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index c0237f7d0..91dc2d503 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -4215,13 +4215,22 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	if (rst->major_ver)
 		goto end_conv_1; /* reduce tab pressure. */
 
+	t16 = le16_to_cpu(dptbl->size);
+	if (t16 < sizeof(struct DIR_PAGE_ENTRY))
+		goto dirty_vol;
+
+	t32 = (t16 - sizeof(struct DIR_PAGE_ENTRY)) / sizeof(u64);
+
 	dp = NULL;
 	while ((dp = enum_rstbl(dptbl, dp))) {
 		struct DIR_PAGE_ENTRY_32 *dp0 = (struct DIR_PAGE_ENTRY_32 *)dp;
-		// NOTE: Danger. Check for of boundary.
+		u32 lcns = le32_to_cpu(dp->lcns_follow);
+
+		if (lcns > t32)
+			goto dirty_vol;
+
 		memmove(&dp->vcn, &dp0->vcn_low,
-			2 * sizeof(u64) +
-				le32_to_cpu(dp->lcns_follow) * sizeof(u64));
+			2 * sizeof(u64) + lcns * sizeof(u64));
 	}
 
 end_conv_1:
-- 
2.53.0


