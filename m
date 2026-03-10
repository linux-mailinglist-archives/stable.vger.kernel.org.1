Return-Path: <stable+bounces-224020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOtnAij+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:19:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 979BC24A5E3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24AD314BDAC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788A3859EA;
	Tue, 10 Mar 2026 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH/mvrSW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00102BF3E2;
	Tue, 10 Mar 2026 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141153; cv=none; b=r1esAtxQTSCfYG+9Qgg9UOWlAMUdlgid269cEb/Cvby1XSzkhhPks7CwP0OAlPbxNoP+9ebbR7jSt6rdXK/OyRxKc4FWHhgzZ7tQQVIa5TsmfHtkfu2ImYM7NzG8LTzm9RgxGt863ToyrnV9YUma6oXhlAwdQC3KgceIdd4cgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141153; c=relaxed/simple;
	bh=Vk7JE1uWPox+OGZhpTj5AcGrsE8f40x+S8GAD3oyvI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnWw6HFEdzZU2gHUvy1VPpsYv2T9MeZImKUDRdr3bT0unJIe2x4yKPlsL7bsM5zqx0rkTIsEpp8iHBsKwvy0csaLkTDrO8C26mtDViMpGPWRVHGxggPVlGaC8dP1JPQ7jjPPVCchxVebYuisfdSnfQuG7bpENzLeUQoLD8djQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH/mvrSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13857C2BCB0;
	Tue, 10 Mar 2026 11:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141152;
	bh=Vk7JE1uWPox+OGZhpTj5AcGrsE8f40x+S8GAD3oyvI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SH/mvrSWXRlvZ3nDlC7ZXFFxfcyqxWPuc/J5zANsffp/5uZDiH9XqiWGyWPdIdrO0
	 ZSnoW1zykdn9KkulBhyYUsV9aG0Ib3rPWmbfE4RFDVOhTwZFvtiioah8b+w249ZBLh
	 m7KdARAzBhw5xQj1IQOa4DlX1bPSsxHeZQXOAoAyNv35pSVXjZ6NF/U16vVEhohz1f
	 AkeWvhVaVvWiR0fWEpveQDsXhs3vNqKIG5XYvHhRdnPi/sHw8s3rT9mYlFN5heOwL0
	 fStsYx5HEmAgt7aWLF8eqT6UK+8ovr8LxCJhpMqJybuxZw+cFguk+Nn3ZCrqruCmHP
	 o1fJv4zI7RQRA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ethan Tidmore <ethantidmore06@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	Carlos Maiolino <cem@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 155/311] xfs: Fix error pointer dereference
Date: Tue, 10 Mar 2026 07:03:22 -0400
Message-ID: <f24c01697b4989b03b4e586615b647cbf9798cb5.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 979BC24A5E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224020-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ethan Tidmore <ethantidmore06@gmail.com>

commit cddfa648f1ab99e30e91455be19cd5ade26338c2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/scrub/orphanage.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 4e550a1d5353b..3fa78bfe5f663 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -442,6 +442,11 @@ xrep_adoption_check_dcache(
 		return 0;
 
 	d_child = try_lookup_noperm(&qname, d_orphanage);
+	if (IS_ERR(d_child)) {
+		dput(d_orphanage);
+		return PTR_ERR(d_child);
+	}
+
 	if (d_child) {
 		trace_xrep_adoption_check_child(sc->mp, d_child);
 
@@ -479,7 +484,7 @@ xrep_adoption_zap_dcache(
 		return;
 
 	d_child = try_lookup_noperm(&qname, d_orphanage);
-	while (d_child != NULL) {
+	while (!IS_ERR_OR_NULL(d_child)) {
 		trace_xrep_adoption_invalidate_child(sc->mp, d_child);
 
 		ASSERT(d_is_negative(d_child));
-- 
2.51.0


