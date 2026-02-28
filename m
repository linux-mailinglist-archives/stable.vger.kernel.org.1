Return-Path: <stable+bounces-220483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMDkOt44o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF91C64E9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F6BC30AB605
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C8E3C5C9B;
	Sat, 28 Feb 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSPH+mO1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC63C5C92;
	Sat, 28 Feb 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300370; cv=none; b=UtPaOfCBWh7+ltWMyYXZsUJ1PYUl1z82axDnTUZU4cixcVouEqhpAnFeg4dc5t6+Y+3TMo57GCJ0FYYnDf9IrRposRQyGsCL2IVdcXt1r987YPewg6iOGT2hZ41oQyfzRf0hkIbrij99lsl7UeR2KsYU2jva5d59YjGHMuvh/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300370; c=relaxed/simple;
	bh=eJufBIgFYLmO1ZT837sOCaDD3kXiBVg1PvAFNT10wXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9GkjQFnWAWbfOjoZlld3GzIgwPvm5VKA4EEkccofDurvhOeoOTRSHqnDLH2ffd9Q2zSDhqU1SKvnFRLdqRgpbtTrIMGOoPZFlPhM4jDBHulIBpSwSlEEcUzZRq+WLyV0iBwEk2ZYocEzlK5xl9lecHBhCLrHfbSCpOMEaLWNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSPH+mO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0084C116D0;
	Sat, 28 Feb 2026 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300369;
	bh=eJufBIgFYLmO1ZT837sOCaDD3kXiBVg1PvAFNT10wXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSPH+mO1b3Ed3iW1zYjTNJzHi49RbMMyegYRsEdmtbmekLrT8Bofn3VZNlE7fxmVV
	 VI9PdstPb95lcI5Yecf3P8vjqYQ4FFCLWNAGV5LqF0ptlBzJivxwIAseWIW8qh1VPM
	 wVxGn3a8iCTLRa+73dwO5S2KrBeXBoUkDw6oWSAVjkwlM6KbF9qye3pmDK9ZyT/hNH
	 xv2RzN05+QESJDR3hbP2eTyMfAZ8tpePxYhTZSv+02AmeYtS4JT5mZO5+e87V+vKes
	 MvESw3J9ArD6SbMTIse/7eSxKoSFG79MFbgvyxTAQ3ZTU84JvWudbg4pZz0ZTKR0Hq
	 JOaVSTIzWO9xQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaehun Gou <p22gone@gmail.com>,
	Seunghun Han <kkamagui@gmail.com>,
	Jihoon Kwon <kjh010315@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 404/844] fs: ntfs3: fix infinite loop in attr_load_runs_range on inconsistent metadata
Date: Sat, 28 Feb 2026 12:25:17 -0500
Message-ID: <20260228173244.1509663-405-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,paragon-software.com:server fail];
	FREEMAIL_CC(0.00)[gmail.com,paragon-software.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220483-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A7CF91C64E9
X-Rspamd-Action: no action

From: Jaehun Gou <p22gone@gmail.com>

[ Upstream commit 4b90f16e4bb5607fb35e7802eb67874038da4640 ]

We found an infinite loop bug in the ntfs3 file system that can lead to a
Denial-of-Service (DoS) condition.

A malformed NTFS image can cause an infinite loop when an attribute header
indicates an empty run list, while directory entries reference it as
containing actual data. In NTFS, setting evcn=-1 with svcn=0 is a valid way
to represent an empty run list, and run_unpack() correctly handles this by
checking if evcn + 1 equals svcn and returning early without parsing any run
data. However, this creates a problem when there is metadata inconsistency,
where the attribute header claims to be empty (evcn=-1) but the caller
expects to read actual data. When run_unpack() immediately returns success
upon seeing this condition, it leaves the runs_tree uninitialized with
run->runs as a NULL. The calling function attr_load_runs_range() assumes
that a successful return means that the runs were loaded and sets clen to 0,
expecting the next run_lookup_entry() call to succeed. Because runs_tree
remains uninitialized, run_lookup_entry() continues to fail, and the loop
increments vcn by zero (vcn += 0), leading to an infinite loop.

This patch adds a retry counter to detect when run_lookup_entry() fails
consecutively after attr_load_runs_vcn(). If the run is still not found on
the second attempt, it indicates corrupted metadata and returns -EINVAL,
preventing the Denial-of-Service (DoS) vulnerability.

Co-developed-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Co-developed-by: Jihoon Kwon <kjh010315@gmail.com>
Signed-off-by: Jihoon Kwon <kjh010315@gmail.com>
Signed-off-by: Jaehun Gou <p22gone@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 980ae9157248d..c45880ab23912 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1354,19 +1354,28 @@ int attr_load_runs_range(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	CLST vcn;
 	CLST vcn_last = (to - 1) >> cluster_bits;
 	CLST lcn, clen;
-	int err;
+	int err = 0;
+	int retry = 0;
 
 	for (vcn = from >> cluster_bits; vcn <= vcn_last; vcn += clen) {
 		if (!run_lookup_entry(run, vcn, &lcn, &clen, NULL)) {
+			if (retry != 0) { /* Next run_lookup_entry(vcn) also failed. */
+				err = -EINVAL;
+				break;
+			}
 			err = attr_load_runs_vcn(ni, type, name, name_len, run,
 						 vcn);
 			if (err)
-				return err;
+				break;
+
 			clen = 0; /* Next run_lookup_entry(vcn) must be success. */
+			retry++;
 		}
+		else
+			retry = 0;
 	}
 
-	return 0;
+	return err;
 }
 
 #ifdef CONFIG_NTFS3_LZX_XPRESS
-- 
2.51.0


