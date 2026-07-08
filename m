Return-Path: <stable+bounces-272623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wr7gIgcnTmrKEAIAu9opvQ
	(envelope-from <stable+bounces-272623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 12:31:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8797245A1
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 12:31:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=CzrwkdFO;
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272623-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272623-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45F0C311A155
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7A420E85;
	Wed,  8 Jul 2026 10:17:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4378D41F7E7
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 10:17:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505839; cv=none; b=VmG1bfsQRmuOLt5ofNN3lczDD2YX34Jo09a8GswqlIoaSRL3Xj/yAC5N7gIfZo1TGyyrsnRWKX5x7ft0U0CooHTvjf0QqaHV0Bdj0AbHenhaQaJu+YdkZk2dhLppYtBPcorVAxkqx4bU2wHqlv/QjbHZjmVYf19L3v3R80JiLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505839; c=relaxed/simple;
	bh=8lB45HmwrISbEaOFvPM6FZq1cdQWoSMIrBEJ5takT+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5lKMrX+iVImD9G2G1gKSlL+LFheaR7UfDxF67UqWP4YvrUcPiBko0IcgA4o6L196tdPJkoEJMSSASQ8+yshfk3yAnSBWLkTvKM3Wnd9mcKWg9TDqiqn4XW65QHYyji5BRUUsIbYvAqu1wMWhhuZX9No24aI7EfHrpKWdjXDwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=CzrwkdFO; arc=none smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f0e5e36912so3635446d6.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1783505835; x=1784110635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Un8tuy4xf7gncW+PfBjoxULc5dW+yU+T+db3ECkNrYc=;
        b=CzrwkdFOZZpyV9Jj3blr+LXuxC3gxWtXa8Adn8exk/C1PjT3kRr4b7muI26mXhYFwZ
         jxFcEYmdkufbsaXCwTyU5hslBad1nLO+PJw/PRc0t0iPGoZqptJQxDYCz0nvuah+EJET
         DCuTXwh4kZz4sAYw4k+Vc82s28cAP8NLlf/Apx/fpouKSBge0YBjZ41/vL+x34G/Si0C
         PKqaoVmUX/o67KamjdAJEUxvPntn6eVw3QAfZcxPBuZG/knr2o327BU6cT5XgSHJWlXd
         DImAdpme8osA46TCrJtJAgYcSquEkteLE5S7PHUNm/O3dFm9KXmMlFUCnaUBv5Nc5r+h
         i9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783505835; x=1784110635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Un8tuy4xf7gncW+PfBjoxULc5dW+yU+T+db3ECkNrYc=;
        b=M4oCAA+0zZIHClb7UqI5FdtgpMmUXzIQBt28Q9lG2pu1IJfklNqDMOk6nSK6W0hLtP
         5kSEIk+W4jgyaxr5D2iUlMP2dhfwtGVC8wVCL9A519SSJ3SCPB8E+fqBBAfwZBUbw3d9
         2zS1QVZfMi3TeLoe5s79Qz/9ZWLcidocD8h5TnR3xZV4Xj2CSvcYw321pZHCglGjA9Co
         a/wOBKBeninJvyWUvQkdg3KAf0QrNFtmDu/ebPspbCjh0PkodG4b9jxVb3cCae+nPEQN
         slPLNzRsEX5nrYQ2urpplQBeHMPLQn2TFoeGnAr10qkun71RB3k1L8cJdamvZr017tHU
         K6Hg==
X-Forwarded-Encrypted: i=1; AHgh+RoRwHYZm2MNRGwWqHEn39CDRuHVGNOlZdYF/ih2i2PYe9lKnD4epd2ql0hHu/e7adY2UJyBahs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTehorYCj3jQH/xYPndFzWw3Y/6BK6PF3VOWXPQLOMnHVO2ZD5
	7a91+EiTfDtvF/T5nE3vb/UDQCetbVLGgde3E4qbupWRWvDpIzOnn71NjWm43gcBvU0=
X-Gm-Gg: AfdE7cnG0TLmWBjki0BdKp4dzF4G4u40q5wFgR9tQaRxwTdQaZvpV+Hjzs0fBROM+0F
	kLFbkRLj6uRquDDv5JtPgXzK+jEGAZKuHS32udepK1W5jzshqwAZQhKapK3G+Mmj6nzJrCbhDlb
	i+XSy1oULKirYYuBeqU2AnTTvjc9sMpszzYq5J7Tk7qKOwsryGMqyfbFMjQ5/IhCHbCH/BHvlZg
	IGkGRcuXc55EtF9RmUfnRbf/ZS+Y6ShT7Y2eOYR4bmuvA6K5NPE/TNcsLRt8N3t6D2hNtCrjj7j
	cG2YjaI5DZotgSxF9TUUpyS1hozUw1qTnhns7P2NHnbtuk5Vq/vh0DspdXWtkzRBanaGLxOyJZ1
	bGpaUNkYYtWWomeZDPBjJLdmFZz54tozzPP/lbcHcevkijYjNRuXkU/4Xtf5oNl5cAnQIC4Htbr
	sr/oOtv52rYlgQ7qBubw==
X-Received: by 2002:a05:6214:1bc9:b0:8e9:f5de:d609 with SMTP id 6a1803df08f44-8fec41e6fd4mr13291576d6.54.1783505835117;
        Wed, 08 Jul 2026 03:17:15 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8f46e27d555sm180651326d6.7.2026.07.08.03.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 03:17:14 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Jan Kara <jack@suse.com>
Cc: David Lee <david.lee@trailofbits.com>,
	linux-kernel@vger.kernel.org,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	stable@vger.kernel.org
Subject: [PATCH] udf: reject VAT indexes equal to the entry count
Date: Wed,  8 Jul 2026 10:17:09 +0000
Message-ID: <20260708101712.1706564-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-272623-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jack@suse.com,m:david.lee@trailofbits.com,m:linux-kernel@vger.kernel.org,m:dominik.czarnota@trailofbits.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[david.lee@trailofbits.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david.lee@trailofbits.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,trailofbits.com:from_mime,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA8797245A1

UDF 1.50 virtual partition mapping uses the VAT as an array of physical
block mappings. s_num_entries stores the number of entries in that array,
not the highest valid index. The valid VAT indexes are therefore below
s_num_entries.

udf_get_pblock_virt15() currently rejects only indexes greater than
s_num_entries. A crafted image can request index s_num_entries, pass the
bounds check, and make the kernel read one entry past the allocated VAT table.

Change the check to reject block >= s_num_entries, so the count is handled as
an exclusive upper bound.

A crafted UDF image reproduced this on origin/master commit
0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53 with a KASAN slab-out-of-bounds
report in udf_get_pblock_virt15().

Trail of Bits has a reproducer that triggers kernel panic demonstrating the bug, and can share it if needed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: David Lee <david.lee@trailofbits.com>
Assisted-by: Codex:gpt-5.5
---
fs/udf/partition.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/partition.c b/fs/udf/partition.c
index 2b85c95..ad8dced 100644
--- a/fs/udf/partition.c
+++ b/fs/udf/partition.c
@@ -55,7 +55,7 @@ uint32_t udf_get_pblock_virt15(struct super_block *sb, uint32_t block,
 	map = &sbi->s_partmaps[partition];
 	vdata = &map->s_type_specific.s_virtual;
 
-	if (block > vdata->s_num_entries) {
+	if (block >= vdata->s_num_entries) {
 		udf_debug("Trying to access block beyond end of VAT (%u max %u)\n",
 			  block, vdata->s_num_entries);
 		return 0xFFFFFFFF;

