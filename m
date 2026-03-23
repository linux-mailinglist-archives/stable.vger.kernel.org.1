Return-Path: <stable+bounces-228704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLVuNtBUwWlTSQQAu9opvQ
	(envelope-from <stable+bounces-228704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:57:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 189F12F5820
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37FCB301BD6D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1112C3B0ACC;
	Mon, 23 Mar 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHYxTx2y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88003AF66A;
	Mon, 23 Mar 2026 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276898; cv=none; b=R8pdKlwkpAJ704UABFFSfWaXJ/jJb6wPsQ/YOqNHGMCtCaaY3sOxEAHLzOF/seFybtGEZ1fwiSjHnSwxc3Huu3EVqHeByeKdcdxByr+AmF/sakLdSWAyjlckQFOtiNgw7vwZ1yQU2/aHU3sOcYSHlmE74pZD9PMUpOj2Rsrycoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276898; c=relaxed/simple;
	bh=iySqGAV1ae9CH7yzf1rOgdbiGVOe/uWFDBZPLeXEZb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dwbi4YhXgdfS+TGIqASYmOMqdKbPrl9mKFbqI+TsQFdGKSaooNInb8ad/pPyCJzIzo6aNaWiSGB6Q6Zu7hl1mhCDDPOK6lOOjmNfeLeYfw73yPsvqw2kXgOD0fOrw7Ug2UO42TajX9pizgFkacfTYzNyWNyJ2JxPM/pE3rrA8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bHYxTx2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B066C4CEF7;
	Mon, 23 Mar 2026 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276898;
	bh=iySqGAV1ae9CH7yzf1rOgdbiGVOe/uWFDBZPLeXEZb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHYxTx2yq7YZZNGMjQPyRnJU77VPYxWtLYFAs03jJG1K47TAfqzuo+Ix5xTyIogA7
	 /kOmDGbPMwFT5x4gyyUUslKxJopQ4WbgIC1PTDQ2YY2aernGOmXMAuYj2M4EDr59kW
	 wzDZTgZA3uLFKsQ7ioF5fCmdjm1GmuR7gY61xRLc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 239/460] xfs: Fix error pointer dereference
Date: Mon, 23 Mar 2026 14:43:55 +0100
Message-ID: <20260323134532.377540977@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228704-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 189F12F5820
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/scrub/orphanage.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

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



