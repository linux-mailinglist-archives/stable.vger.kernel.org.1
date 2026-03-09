Return-Path: <stable+bounces-223658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDYzFpzRrmlhJAIAu9opvQ
	(envelope-from <stable+bounces-223658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:56:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854D23A280
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B4F31CF5F5
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4F3D3CEB;
	Mon,  9 Mar 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY+d6+Y1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68B375F86
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064198; cv=none; b=l9yhTgnP+KbuKNv3bjN24OXbKm4iQ+wfEwBPJVd3GZY1DnqXt6NIaV06b8NNMvPfODsGE5VTaxfBlDNTb4ClGp/NkkV7W0FJz+4aQ+o7uoZmN+3oS8VkTG2yp874/YVkAD5hykapM9gHrV7kQjdmP7r6LYTac9LelVbkkEhgbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064198; c=relaxed/simple;
	bh=fZ3SKtmditV/PbKefN3cDClMYc1CCbgahel7LHsR288=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kos3UsyTeSk7e/Fqbb5OvW9JYDMtrla3BNk8sQ9J5roc/yePHCo9xEV+giNha4CrYKC8f6fFNsmoeDHRDJh4+ZslVLGiDc2Ehn0HpTtyHT9zEhcvAkaky8SKCqLFULjbXfb5iPtJss9KdJQR6X+DPIMqxykzSmb4BNBy1/+2PUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY+d6+Y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E348C2BCB1;
	Mon,  9 Mar 2026 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773064197;
	bh=fZ3SKtmditV/PbKefN3cDClMYc1CCbgahel7LHsR288=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fY+d6+Y1+LqFTRr22VCA31kgCw1RfeOYre05vgcvsIMkP43VIyRKyQFRGpKIS96kJ
	 vb1cpls6eR97WqTwbk8/3ymkalBbaFaL91n/WhvZPYYBOURZO+kEHARYdgcQKaUGax
	 yuRkCn7d2b8w9fjJbgLne5dZYM8X96lXIw4YvygiSB8kcFTG8DSSnL/tf65XEh5Jo3
	 vAN3UQFDMww9WWXobY5oy1wQqafNUBeQbi+5idA0Jmn5+3WbL226gTcp+Fe/iDn0l8
	 eTv7TTaiwhxU75fslIpG3u2XhgfpQwyOBYY4CJ0vXbgSA2jQONlNZJaytgsstMJrI8
	 VnLdibMqN9M5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ethan Tidmore <ethantidmore06@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: Fix error pointer dereference
Date: Mon,  9 Mar 2026 09:49:55 -0400
Message-ID: <20260309134955.1022573-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030917-lagged-volumes-b38a@gregkh>
References: <2026030917-lagged-volumes-b38a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7854D23A280
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223658-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ethan Tidmore <ethantidmore06@gmail.com>

[ Upstream commit cddfa648f1ab99e30e91455be19cd5ade26338c2 ]

The function try_lookup_noperm() can return an error pointer and is not
checked for one.

Add checks for error pointer in xrep_adoption_check_dcache() and
xrep_adoption_zap_dcache().

Detected by Smatch:
fs/xfs/scrub/orphanage.c:449 xrep_adoption_check_dcache() error:
'd_child' dereferencing possible ERR_PTR()

fs/xfs/scrub/orphanage.c:485 xrep_adoption_zap_dcache() error:
'd_child' dereferencing possible ERR_PTR()

Fixes: 73597e3e42b4 ("xfs: ensure dentry consistency when the orphanage adopts a file")
Cc: stable@vger.kernel.org # v6.16
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ adapted try_lookup_noperm() calls to d_hash_and_lookup() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/orphanage.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 7148d8362db83..46171f61eda43 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -443,6 +443,11 @@ xrep_adoption_check_dcache(
 		return 0;
 
 	d_child = d_hash_and_lookup(d_orphanage, &qname);
+	if (IS_ERR(d_child)) {
+		dput(d_orphanage);
+		return PTR_ERR(d_child);
+	}
+
 	if (d_child) {
 		trace_xrep_adoption_check_child(sc->mp, d_child);
 
@@ -480,7 +485,7 @@ xrep_adoption_zap_dcache(
 		return;
 
 	d_child = d_hash_and_lookup(d_orphanage, &qname);
-	while (d_child != NULL) {
+	while (!IS_ERR_OR_NULL(d_child)) {
 		trace_xrep_adoption_invalidate_child(sc->mp, d_child);
 
 		ASSERT(d_is_negative(d_child));
-- 
2.51.0


