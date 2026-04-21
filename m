Return-Path: <stable+bounces-240156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJbvOVl652mu9QEAu9opvQ
	(envelope-from <stable+bounces-240156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:23:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 948EC43B462
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 740FC3011166
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4D3D16F9;
	Tue, 21 Apr 2026 13:23:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0A1925BC;
	Tue, 21 Apr 2026 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777811; cv=none; b=FBZNEE/1X6iIw3uywMd2sVmtjOXWOAHb7QgVgZH7Arwjimvwa6xluqY++ildJp/DQ+KR6LZnlKCDOta2ppdyBx2FCQNqeufNSeJ0n1pYDgdEl3T7EKDEPOejwWWsx3h0ZbxgQb53SkjzLs4HfXYGgkZZ/uFtT5gD4WaPau0pUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777811; c=relaxed/simple;
	bh=4G7XAXPItr2vWolSOSo+B9qXS9QnWLQ5Q6j8onuBOQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z3MRcO1KXT2omXIJv61+f37wzCDLBOnyb9UABNJiLZG1aLCR1ZPi94CE+Mqdjz4CfrwWZRs6nJvOL5iir+5oNoBAiKNMhFxXN1SSY6+cFQRLrbZPFGStsKJsuyKuFj4QWiZ+cCk6xz3Vsc1i51zMYu+gsN5VNAIUSMWWwjxiIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 0719A2338F;
	Tue, 21 Apr 2026 16:23:27 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	linux-scsi@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y 0/2] scsi: qla2xxx: Fix CVE-2022-49158 and CVE-2022-50493
Date: Tue, 21 Apr 2026 16:23:25 +0300
Message-Id: <20260421132327.38389-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[altlinux.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240156-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[kovalev@altlinux.org,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altlinux.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 948EC43B462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Backport two qla2xxx CVE fixes to 5.10.y. Sent as a series since both
patches touch drivers/scsi/qla2xxx/qla_init.c with overlapping context.

Arun Easi (1):
  scsi: qla2xxx: Fix crash when I/O abort times out

Quinn Tran (1):
  scsi: qla2xxx: Fix warning message due to adisc being flushed

 drivers/scsi/qla2xxx/qla_init.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
2.50.1


