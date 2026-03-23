Return-Path: <stable+bounces-229116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDN4GpFXwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-229116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:09:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3FF2F5DC4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81E2A304845F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7026ED37;
	Mon, 23 Mar 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t0rfy2Dk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9EE26E718;
	Mon, 23 Mar 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278110; cv=none; b=egTZ1ku0ORZDoURm8KBGXlq1uAGiVooXABl7+Kc3WqlHZD7I5d0w1DLzumVUA+QnPEiBzO3TT51gCiyBnf7lPcg+Nl6xAxaHowqCTV4sq+3pmCn9QKObewSjIRjRZiABAwXyplfFO1n1QmYCvQHs9PMWK1XEQe/iwPmBAm/ZYKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278110; c=relaxed/simple;
	bh=8cUGIUtz0pmMAuuI5c9QjVd33qz1fs+1IJ3MkwLKQk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuI+iZQ3VJFNOKNtPAujQl9mdClLso7YIvQ00mPCSoQh/Jh5WA/nhAiOwpT11PoQ0OL6S7gVHIKQORYVYOTErELSwwlKitdP7a3xJOaA0GXi0m+jtAKjLpoWKVfOEjZjX6Zv0KFAQ2isobiodX33z/8bENGJnMsvBGS8hsahqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t0rfy2Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D82C2BCB1;
	Mon, 23 Mar 2026 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278109;
	bh=8cUGIUtz0pmMAuuI5c9QjVd33qz1fs+1IJ3MkwLKQk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0rfy2Dk4Uh4k9iyx3VapPFAmbZ1n00lvhUWxQZ5JZSGLWzo2uSRtQx8Ov9WyWyc7
	 E7+KOSnvpOeV6xagMiM6lBecmC/2CXbLKuuO1c10Pfj6Z5U4xrKyHiM03zDwXkS+8M
	 vTULp9WPUHrqo8rEdhQ1uHKrJHeyMaOu+O56t9Nc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Jeffery <djeffery@redhat.com>,
	Tomas Henzl <thenzl@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 204/567] scsi: ses: Fix devices attaching to different hosts
Date: Mon, 23 Mar 2026 14:42:04 +0100
Message-ID: <20260323134538.891414969@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229116-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2C3FF2F5DC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Henzl <thenzl@redhat.com>

[ Upstream commit 70ca8caa96ce473647054f5c7b9dab5423902402 ]

On a multipath SAS system some devices don't end up with correct symlinks
from the SCSI device to its enclosure. Some devices even have enclosure
links pointing to enclosures attached to different SCSI hosts.

ses_match_to_enclosure() calls enclosure_for_each_device() which iterates
over all enclosures on the system, not just enclosures attached to the
current SCSI host.

Replace the iteration with a direct call to ses_enclosure_find_by_addr().

Reviewed-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Link: https://patch.msgid.link/20260210191850.36784-1-thenzl@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ses.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index d7d0c35c58b80..05e462f328e75 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -503,9 +503,8 @@ struct efd {
 };
 
 static int ses_enclosure_find_by_addr(struct enclosure_device *edev,
-				      void *data)
+				      struct efd *efd)
 {
-	struct efd *efd = data;
 	int i;
 	struct ses_component *scomp;
 
@@ -658,7 +657,7 @@ static void ses_match_to_enclosure(struct enclosure_device *edev,
 	if (efd.addr) {
 		efd.dev = &sdev->sdev_gendev;
 
-		enclosure_for_each_device(ses_enclosure_find_by_addr, &efd);
+		ses_enclosure_find_by_addr(edev, &efd);
 	}
 }
 
-- 
2.51.0




