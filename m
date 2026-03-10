Return-Path: <stable+bounces-224235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LaFIJABsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:33:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E318C24AFA4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5FF8309231B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D22D3876D3;
	Tue, 10 Mar 2026 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSjL6LKf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45793876AA;
	Tue, 10 Mar 2026 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141932; cv=none; b=ScU/gdArlefmqdsNbVuEkcE1Wxw3XT1ofdGDa/6y2yfAEGYyKzXzBkjKdTy37XXEM7wu/oK3ZjAauCsC7GnDkf06i8j4gLfTe1Au9upyNabx1aZBrt2diVRMHy9b3UJJfoAQcijpN11qbFiiwUuYrdXXiaqROEEtdbk/hlXkXsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141932; c=relaxed/simple;
	bh=fYQYazVTg2EREslTEu39Q3F5Whf/QjC9eoeQS4aZJdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqt40kAL0MP+bJQNP09x+kxFugPruy+BkI7HrscgBoydjF+L1uhSX9+VFwtb1JWY9wBAPGl9gDuKQEWPkxE1pNtmSYyf/mKyotoYJ/JvTS0K98ZXB0tx4f69hLiRPs5mHimb2n8vaTAeCXyyQnR7ofDpDGlApmqE7CJT0tE4iyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSjL6LKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083C4C2BC86;
	Tue, 10 Mar 2026 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141932;
	bh=fYQYazVTg2EREslTEu39Q3F5Whf/QjC9eoeQS4aZJdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSjL6LKfX1+UBOSbPmhiOWLKEAi5jkTwRdvoDHPWghKsZsPK08OfbvMChe+TWv3ca
	 EMSD8a7DmmTigUa9GS4C6I5IwKgoh0bsmtK12ArA6WXnRN4/tCMUddFDxFr5q+IGu9
	 JLzIz9cRarn/ek1A+uJ32YwlOoTmKZfEAl6hybVLDPp1IkXJNl6oIhIQT2F+HE9Fr+
	 UZmkTIrbop48NG2z7fKcFQJrO9Ii460YTaSw8b6hFb52UU8q72lxyI+9VVzMj/ZdT0
	 jEvpUgF/GVl2CBQqfbPnlYeELE00iZtUmcMLV9cECIBZf6NtOy1LVBOa3FCGbbB2v/
	 NTUaljsB3sjxw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 056/314] btrfs: fix objectid value in error message in check_extent_data_ref()
Date: Tue, 10 Mar 2026 07:15:15 -0400
Message-ID: <ee4e875f76d399d57b729e42ca20eef8d606d9d9.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E318C24AFA4
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
	TAGGED_FROM(0.00)[bounces-224235-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Mark Harmstone <mark@harmstone.com>

[ Upstream commit a10172780526c2002e062102ad4f2aabac495889 ]

Fix a copy-paste error in check_extent_data_ref(): we're printing root
as in the message above, we should be printing objectid.

Fixes: f333a3c7e832 ("btrfs: tree-checker: validate dref root and objectid")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 7bc758ec64a11..420c0f0e17c85 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1713,7 +1713,7 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 			     objectid > BTRFS_LAST_FREE_OBJECTID)) {
 			extent_err(leaf, slot,
 				   "invalid extent data backref objectid value %llu",
-				   root);
+				   objectid);
 			return -EUCLEAN;
 		}
 		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {
-- 
2.51.0


