Return-Path: <stable+bounces-217403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sL1LD+zRlmlnogIAu9opvQ
	(envelope-from <stable+bounces-217403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:03:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD7615D32B
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06EC73006224
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86974336EE3;
	Thu, 19 Feb 2026 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="nbIuT/vJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D5333733
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771491814; cv=none; b=RluVeignT5aKSAbb1tbIL4wRSrAn3WoExX4xMvQNX/c4r3DiBmUdDM4opp+2dwL/mUGyardKZyWCkz/F6PIldYeT4NzRxDVrOrv22bEdqXjCtY6pPEPWfM5kBb31cnuu4gJrs5Rmdapd9DhyjrKrQiAl4K40wFOtoRgPPVULd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771491814; c=relaxed/simple;
	bh=928OAOahZdG4Xfvx2DerQUpFBhMcEhz7CAZj5Aci8zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SaUl4qKonLBUOvc6EEQ/17WO3Hd36TZBI6/u8XaWuQN+tY1O9OqozfwpDoOoYYiyzYJorVJjcmUTOGKLoPFN+6GPzbn6ymAlBhLYB+JdfmWJR25nnZfSDm4LMveduZY6RKsg4kWNUGqizVPy2znSq7tucbKxCUQ1uoTZW4vhQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=nbIuT/vJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823075fed75so346730b3a.1
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 01:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1771491810; x=1772096610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=woTan9VVYvyV1yh7C/L083Hx/xNDYsj+r3LiM0PqHJ0=;
        b=nbIuT/vJLyA/crDZWYVFRKLI3FTPEXAHc8Mf2hbGWljvGArPteYGEoZ93nrZ7pC5VT
         xYl4QaTr0HdNuFfEOrwYQ/zpnCOQ/ek7K2LkkQvHLdcz85HtbQxuJFNs1DQxOwkSycRe
         7TmBOfCMu9fThGRPrLZoSeanu0F0DaOdov2mPFIwj7Vlero/NgscxD998oBVOXncyAbX
         RvAyH16SKdsPbD6BdJfckVjXnwzoHOtj8krJDVV65vWnvsCEdcq/KPA5GsbAVAxWzaTG
         Kewb1qboIpzT1vubRfa+xihM8o5ax/Mc6uLL+/S5RV2fv9oiL1joMpQvANPVJ/g4HnDt
         K6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771491810; x=1772096610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woTan9VVYvyV1yh7C/L083Hx/xNDYsj+r3LiM0PqHJ0=;
        b=stfkPyC/65xK/UlFtmIZK5Af38+KwyOvcCC3HEbCb6l7YjIx0gOkxDJ80ocPWHKQ+J
         cQNlBIKIe3Z0/QnGYf3TXrq89tsyB6NGB8FViIPEkb0IIoI5l7B0QlbWZpJ+F7GvDNwX
         mJQXml1MAvh1dNmf4Tz4SnrdL6dADmIEkCq7fldmDV6hYg98H4KMawZ5cGdFvVykXEc9
         CUyC+N8P/OUqwmaWB6oSAX+ilv+Rz8bK/uenh+laTtpoJOQUWGe8M+cMoALxo/5CCEMH
         mGAFuZH2OSO7yk3Ho0wMAxMkk3gKvDCktnlWkfo1BZ5QXDqZjfoXw1i1POkjP2yaqksm
         lgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2m7OQZeh9ltHJ+XIGeFTLAB52DVmQFXynkagb8DxrKYA2JZK1aO/PcFdBy1RlViUxT1rIxwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAtFpvCpRvuDZh9/QetX4pvf9yHO+gs+QI5wnX5+i9h3VoWHP
	f5R7F/7h0fc06xIF081sD77OlY37l7oiHypChTq+/sP3s+0YQRUQoo44uRi3Xm9BW6o=
X-Gm-Gg: AZuq6aJ1XtkFsUscffQw2o3dTt+47G9kqWtQJwsqeunoDCqpS3b75RRjk+VLQnJIpAJ
	GHKPsc6rQvfcZbrgEJZHhbbkCeGXBxl0njJXmmXEsIhohwXvbBqrUzVP1t+aL3aQ2ce9JGv2ypd
	aQZJpRhU5Opv9IWfYztEMILmLstxYNM2PziD9U35NX8umkNAN7numxSvD66VCj/L6iWJra6FcyH
	+1k4KcMF8CPK9OgioW75oQC9rXAWom5NBzgRDirF4/PrCgQrYwGRCvoxXLst4vSYwzc57lEo+xZ
	Ve/ZUouVbDHrYmTe81mXNXrRG9H5GB8ltXisLV8zbsMb5kpafWwTG6E4DTbzYt0JkyMiqSV+FA8
	FnB4lkE2lphqCY77zaxLA9SxUyakTkSY+Tp4k1JaxkdOtT8OOE6Bg76/ipU6lFLDZFozm2LWFg3
	lx7CoIgGQ8El5rUzQdB0TJJz0Uvn03AIU18AKhRD+Gstm/ZdK+s0fBbGE9cmDeo5rEc228/BrBF
	WmBuRgJbkd3ADfmuRsvPOWyverxQhjOKcuYslfXlrEiJlsS33i3AnK17w==
X-Received: by 2002:a05:6a00:1d83:b0:81e:b93a:ab09 with SMTP id d2e1a72fcca58-826bab56b60mr1002475b3a.1.1771491810251;
        Thu, 19 Feb 2026 01:03:30 -0800 (PST)
Received: from localhost.localdomain ([103.158.43.38])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-824c6bb3549sm19985248b3a.59.2026.02.19.01.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 01:03:29 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: ram.vegesna@broadcom.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jsmart2021@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] scsi: efct: Fix potential memory leak in efct_io_pool_free()
Date: Thu, 19 Feb 2026 14:31:31 +0530
Message-ID: <20260219090136.108938-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cse.iitm.ac.in,HansenPartnership.com,oracle.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217403-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CD7615D32B
X-Rspamd-Action: no action

The memory allocated for struct efct_io in efct_io_pool_create(), is
not freed by it's corresponding free function efct_io_pool_free().
Fix that by adding a kfree().

Fixes: e2cf422ba833 ("scsi: elx: efct: Hardware queues processing")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Found using static analysis.

 drivers/scsi/elx/efct/efct_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
index c612f0a48839..bdafecca7573 100644
--- a/drivers/scsi/elx/efct/efct_io.c
+++ b/drivers/scsi/elx/efct/efct_io.c
@@ -92,6 +92,7 @@ efct_io_pool_free(struct efct_io_pool *io_pool)
 					  io->rspbuf.size, io->rspbuf.virt,
 					  io->rspbuf.phys);
 			memset(&io->rspbuf, 0, sizeof(struct efc_dma));
+			kfree(io);
 		}
 
 		kfree(io_pool);
-- 
2.43.0


