Return-Path: <stable+bounces-238337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJlUGukV4WnoogAAu9opvQ
	(envelope-from <stable+bounces-238337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:01:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BF64123E9
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E53D304EBBE
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F6E31D39A;
	Thu, 16 Apr 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Nktlp8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03A30B535
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776358790; cv=none; b=XYEneWxTAH3e/xeY/wlrokJUKeGRkJsRK+V+tSiTlMrNqcW9gcVasXRtvn0+YmpnFiYfWlImL7Lo9y+T/lx/nvw6tmDJBmxg6LEesV0wdXYJ3EhdApaPYRJp9otLL8KoAUgFoaYJnqH3AUo7RygJByrpPtCuXUB8qKMXysB5DZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776358790; c=relaxed/simple;
	bh=1LP+9Y9TG4oK4f0ZkbP0a0/ld5plxckV7HRW4ZFOBCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REsj/+cwFue2AEgQ9GvasN+hC0vV8E8qkmO+yz716IGPqBJaEJ9/Vpf0s9duulyYvgwDCWbDCnZA1oRhJYMPuHyVXkujjw+6qQz42pegD659p7jR3RTe4ttZ5eJO+jEVh3hc2UIc8DZozO8DiBKS2tflspOaXJAB2Ex3ZlyuIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8Nktlp8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b24fdac394so75018805ad.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776358788; x=1776963588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VksxkcPuGa1fBZOzll7HizxJVJENQAeYC1HuFM93zwo=;
        b=j8Nktlp8PDB+71AU24VxK0+bQ7JFQw1NN2DJ77fCnHzUsS7MD1/qHkPdISdIxOTC/F
         06HaMbyI5T2LxgB1pyCMVUKwozkahynsMRFxTp/1V9JjMgAgMkOK2/kr1yHud8vDERc3
         HXFkiKxHOsKVzsDGpKBLJzm2Hp7x8XROIjGVaxxrhs731GavfEsG/tgtYEw9yU4GX5U+
         hZF/hBxt1WugNXw1A8aAjOZncAlPpuTs9pB4iwDsrS4dhESIEFA6bl5eyfcmbDEGsdfL
         sHqDOB1nlcvJWE/wwPa1+jtKqRPwRllS6FQcNAg+6sqaDq8cDQGTVqKekKvsqbieT7qv
         oHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776358788; x=1776963588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VksxkcPuGa1fBZOzll7HizxJVJENQAeYC1HuFM93zwo=;
        b=tRKjhqpDIxBoFNVJUtAATUCRlhsC2/l8XhKJRBCXdKANEsv6ABXyJdJrevw9G4RU1e
         fP3JazDy+E8PvfJoiAnfXZFdfkJPJMV1PRwkgYm1qvackh9CPQTOSRcXocIz9I6qQeC1
         nxzN+ylNcUyBS3v+O808ZN2ZUumOjvKRJbwJ+AawPWsSY/t77d8LJ3tR8VXncvt++6uC
         0108gKS71pMbgXyVwKTPivpZLhbA9sBLYP3mHG04MdJVFzlXhEqOZzCJtE/TRCqx7M9/
         wG6vcHASfSNkKtbs3e3kePTzwbfQRWbaaRBEfPh49UXO/TMB0aBBWrF0b4yMewYWNB4I
         eIjw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ie5LsA8pXgHLOCOUWhmc7VitBN0v5qD84vtQP8ynecdBoEf3BLM800euYDFkyYKpwyeqfqeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJix1uElPA7chHMhJZB5KfuXiRVM1APxYo3fK7z3KWQiTbUir
	rgrs0aNNBjKjzoMyeFYEixBX/JYjRope9sQHFS8wRK4eD+gRkY+CVH16
X-Gm-Gg: AeBDieutiU3GJ9x92B6m7r0fLPt5bkY+XmBPtDj/Wd8vJdwgharYgAyhuSWjzlUmP50
	3m1ou3LEwMtHcQvFckgvmNfl2COmc/IDDI8s0ldp0fh169HVp0vaqfV96WEb5FjkiMgixLiXKRO
	AMyhQxFL8uYppGUkfIA7JyUWEnPZ3O45KstR2gdEQjQATJPKbOpR05hjqvgAV3W7agroIfYoa1p
	qAb4vVZlX25jip9tuL/GDjNCsmjTNowwlAgYNoZqF8h//JBQAwgggAwPBtzW4oxMvInmAxlGhAq
	+oYGTcb6yPmlXNqdE+Xqgn8KxR0iOrmgaCcOVVs7RBPDDbEH2Ye/1WSVwbnDJspNQdCYe4eL4X+
	MnoVnZTJD5eTSR8ctzHzc4tzvhnlTCpMoOFy3Ledgp6jp8HJ7aAjnF66HgeFjVYZMc7WxBzdOEt
	d6xBMJIKh/dwZjU7S43p/pLn82nZK+BdvaYJnFvTrG7A==
X-Received: by 2002:a17:902:b588:b0:2b2:4c92:c389 with SMTP id d9443c01a7336-2b2d5a6e445mr206661275ad.34.1776358788087;
        Thu, 16 Apr 2026 09:59:48 -0700 (PDT)
Received: from lgs.. ([223.80.110.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780f0428sm59683665ad.9.2026.04.16.09.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:59:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] [SCSI] advansys: fix host resource leak in EISA probe error path
Date: Fri, 17 Apr 2026 00:59:35 +0800
Message-ID: <20260416165935.3958686-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238337-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7BF64123E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A manual code audit found that advansys_eisa_probe() frees saved
Scsi_Host objects directly in its error path.

Those hosts have already been successfully initialized by
advansys_board_found(), so freeing them directly bypasses the normal
teardown path and leaks host resources such as IRQs, DMA or MMIO
resources, and the Scsi_Host release path.

Fix this by releasing the saved hosts with advansys_release() and
dropping their corresponding I/O regions before freeing the probe data.

Fixes: d361db483241 ("[SCSI] advansys: Sort out irq number mess")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/advansys.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index fcf059bf41e8..022a8190ae31 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -11373,9 +11373,17 @@ static int advansys_eisa_probe(struct device *dev)
 	return 0;
 
  free_data:
-	kfree(data->host[0]);
-	kfree(data->host[1]);
-	kfree(data);
+	for (i = 0; i < 2; i++) {
+		struct Scsi_Host *shost = data->host[i];
+		int ioport;
+
+		if (!shost)
+			continue;
+
+		ioport = shost->io_port;
+		advansys_release(shost);
+		release_region(ioport, ASC_IOADR_GAP);
+	}
  fail:
 	return err;
 }
-- 
2.43.0


