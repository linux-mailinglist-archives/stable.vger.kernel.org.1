Return-Path: <stable+bounces-241854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCacMe3U8Wm3kgEAu9opvQ
	(envelope-from <stable+bounces-241854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:52:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D694492562
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 119B53014748
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4F3B6368;
	Wed, 29 Apr 2026 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jaw3jFWW"
X-Original-To: stable@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A7A33B97A;
	Wed, 29 Apr 2026 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456354; cv=none; b=O92LSpp9j+iMs8qGgcZcKsaZKjYrO3oNlgz5FNwpy905xQCc6aqy6oJhwSi81EdcsjDKjxxQyw4GC4diPGffQfnnnbd6TtR6Mn3Yx7ZgloEeOnDhcfBwi8mdSTpLmVjKNN7iyx+SaDiciX23075MfyEP2GqGwANCcFfcmJHw7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456354; c=relaxed/simple;
	bh=Evxh1G6rbB2wj7A/DTt+Tr0gVT1B3scSb7N1VKff2ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVx3gypuMg1gayyA25op6kIJ6yMSaip6adFxByD/Y30Omh3biaJyBeDbvLrGuzAbRo2rfHawHNiKXcpHai/Dc5wtl3qOD21Tdj2Xks238cwwLBvCvQlkuWpOQm4QebW4IhVPNL3xRLe3l4ufNasQRJwMNrEw/1NP3tSlsKXOcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=jaw3jFWW; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:81a0:0:640:13b3:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 72643C006A;
	Wed, 29 Apr 2026 12:52:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp) with ESMTPSA id FqWVCtCS4a60-bv4HI1XE;
	Wed, 29 Apr 2026 12:52:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1777456342; bh=zKAV6Ou4HUehi60/PWBWKPjNewLWnoIgiFqKQFMR/X8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=jaw3jFWWaeLl4yr2ur0OnI/+hNlyhqt0Lcm1MElQ3pWcqjBvErUr3rt/jIh1EPVL9
	 EYKi+N9SHLfqf9nF9P4cbPAPvzatreJhcxB0eyA+gVjC6sU8LA8JKP0vwS2XZ3x6m4
	 i1zWOVbbt5g4YAySfAK6gEqAxtgwBMzixYzFoDFI=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	kartilak@cisco.com,
	nmusini@cisco.com,
	sebaddel@cisco.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] snic/vnic_dev: Remove dead store in vnic_dev_discover_res()
Date: Wed, 29 Apr 2026 12:52:12 +0300
Message-ID: <20260429095212.11251-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D694492562
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[yandex.ru,cisco.com,HansenPartnership.com,oracle.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241854-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex.ru:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The assignment 'len = count' for RES_TYPE_INTR_PBA_LEGACY,
RES_TYPE_DEVCMD, and RES_TYPE_DEVCMD2 cases is never used.

Drop the unused assignments to fix the following static analyzer warning.

No functional change.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/scsi/snic/vnic_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/snic/vnic_dev.c b/drivers/scsi/snic/vnic_dev.c
index ed7771e62854..22303f827583 100644
--- a/drivers/scsi/snic/vnic_dev.c
+++ b/drivers/scsi/snic/vnic_dev.c
@@ -132,7 +132,6 @@ static int vnic_dev_discover_res(struct vnic_dev *vdev,
 		case RES_TYPE_INTR_PBA_LEGACY:
 		case RES_TYPE_DEVCMD:
 		case RES_TYPE_DEVCMD2:
-			len = count;
 			break;
 
 		default:
-- 
2.43.0


