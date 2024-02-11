Return-Path: <stable+bounces-19446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F95850B94
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 21:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AB3B21E45
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 20:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E55D8E4;
	Sun, 11 Feb 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dLModVln"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD405381E
	for <stable@vger.kernel.org>; Sun, 11 Feb 2024 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684854; cv=none; b=gl/7WJ38J46p9Y6EGyHh71CC6mTFuFc0jNnn3TwqiAwVGEUXQaSu22Ekgjx3fhNBpfWWd+llJell7nmSfwDkrPqBVo609IDMAS4Javbjhd8p40uEHNsROj95fLg1m75ZFxvtyey0l011SsMtHeqVpa8Ekvjy3PKuAEp/XTphrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684854; c=relaxed/simple;
	bh=1STC1V9YMx8sKQ6UuBw95l3TuyTGTcksaTaO2vuD/4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAAnCF0oUyVvCJSlHIHoPzTsDpAtjTvHEu3oVgsFwhKRHLZh25tCQeEypA45e9Ge2skCWV9gWsI12z125dswtZeusecTN4IboxEkAE5JSA8uUaBIxhd78e/hplbtjk0ItocC2/0+ay4ZFzIExxkV9ostDF6MlU2i8FsZr4A8CQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dLModVln; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c403dbf3adso151663739f.1
        for <stable@vger.kernel.org>; Sun, 11 Feb 2024 12:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707684850; x=1708289650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG7TDb71syCopJ2EmqI/veNex007IgIKbGD42LrMjA8=;
        b=dLModVln2nc71Twv8KATOld536Iae3UjVprNyjfaaWPs1Ug4xqUjGNuUkBiWTLk/Vg
         NV35Y4BmOxFYncoZoS911Ps1LRPtqkxvDLxPysn6Zsyl1mLV1j4BqW8QsaVvzvNOLz8W
         yoXz5mFxqeUDGTlHtCpaDalBrRhFXQNmyfmFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707684850; x=1708289650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG7TDb71syCopJ2EmqI/veNex007IgIKbGD42LrMjA8=;
        b=QG4mfnW/lmOAGfzxu5GCLuHSlVuU4u5UXGfrWqaVLMloffDfaCFUTYNUbDButtWL17
         qmo9iY/J4juxyseuKZWIq/zAe1VQ+8lzIm8ltgZuZ5XP6rg6g6mdbpSSdij5GLWg0w9X
         lWCi87Lzpm6LpZYKjkuoEW3mmF9w+ovVLDYM7lN/8oEWNujPCnKpWHLXPr9YreIyp9Kj
         9GjNoMId/fYJTqvCKGNMR2ru245TMQ+zQ/QpcK0+aPK7525cCybXUhyxN9m7slT1jkkw
         ipHo9Agrnjsxi8Rdf17ISatr+CeZy1xxlmUinMg0uI0kjSEGpwfMVYzzK91ELBzTSAND
         Z9Jg==
X-Gm-Message-State: AOJu0YxOi0+r/yHMHsYf6go4Bhwt6V+3fXqyDL+RUtrD4a2Cso4zdKqN
	yxwrQfyzvQWlECV8KMWc8G/FHCORcltDBEogI+X22Zq+2EGzjsfYVgLubXxIR6bIR914LUvtTKu
	KwakpbcijNgTjDZUfqYJcxQ/BH4i1igwCbo5H3DT0nZ16K/wQsRqzsmrfvXZQ9EFN727l2gFs/N
	8wTkyHHUNrEST997+gt9FekOV6fZYDFiqM7BVpFptnXrA4rHPPiRtnLvs=
X-Google-Smtp-Source: AGHT+IEzt7yvZSHKaZVNJyFaLIOWLq1hmJ4VvtHb2S9M1aDSfUtckzDCWK17ihfr1RDAoMmgxhWxng==
X-Received: by 2002:a05:6e02:1086:b0:363:bc81:47f8 with SMTP id r6-20020a056e02108600b00363bc8147f8mr6127686ilj.21.1707684850157;
        Sun, 11 Feb 2024 12:54:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZBnShyJWYl524AbQ9c/57bpygG8jEeVQR0OgFXx6W9MfbbbwQZsVlJ8VAWIr7S+ap4X2sL6XzDH2k4Qel/bKJoILtbNV4UxnnXty/YVNgiYM0iBHzRQ2PXnlRQJvHTsiYGbkh3qNkUgurJCTwGnihe0ihRld8wZmYaj8xVleUtDDBs5xEuivSS63a82d+5np79ZGNva8BJNpAS817rwhHvVeguBL7LawHjLHVaJYI85zxJM4b8FvI3aN/nF7MpGaPgXY=
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id cv16-20020a17090afd1000b0028ce81d9f32sm5423735pjb.16.2024.02.11.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:54:09 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com,
	Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 5.15.y 1/3] smb: client: fix OOB in receive_encrypted_standard()
Date: Mon, 12 Feb 2024 02:23:11 +0530
Message-Id: <20240211205313.3097033-2-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240211205313.3097033-1-guruswamy.basavaiah@broadcom.com>
References: <20240211205313.3097033-1-guruswamy.basavaiah@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit eec04ea119691e65227a97ce53c0da6b9b74b0b7 ]

Fix potential OOB in receive_encrypted_standard() if server returned a
large shdr->NextCommand that would end up writing off the end of
@next_buffer.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[Guru: receive_encrypted_standard() is present in file smb2ops.c,
smb2ops.c file location is changed, modified patch accordingly.]
Signed-off-by: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
---
 fs/cifs/smb2ops.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index f31da2647d04..867b32b1393f 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -5153,6 +5153,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	struct smb2_sync_hdr *shdr;
 	unsigned int pdu_length = server->pdu_size;
 	unsigned int buf_size;
+	unsigned int next_cmd;
 	struct mid_q_entry *mid_entry;
 	int next_is_large;
 	char *next_buffer = NULL;
@@ -5181,14 +5182,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	next_is_large = server->large_buf;
 one_more:
 	shdr = (struct smb2_sync_hdr *)buf;
-	if (shdr->NextCommand) {
+	next_cmd = le32_to_cpu(shdr->NextCommand);
+	if (next_cmd) {
+		if (WARN_ON_ONCE(next_cmd > pdu_length))
+			return -1;
 		if (next_is_large)
 			next_buffer = (char *)cifs_buf_get();
 		else
 			next_buffer = (char *)cifs_small_buf_get();
-		memcpy(next_buffer,
-		       buf + le32_to_cpu(shdr->NextCommand),
-		       pdu_length - le32_to_cpu(shdr->NextCommand));
+		memcpy(next_buffer, buf + next_cmd, pdu_length - next_cmd);
 	}
 
 	mid_entry = smb2_find_mid(server, buf);
@@ -5212,8 +5214,8 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	else
 		ret = cifs_handle_standard(server, mid_entry);
 
-	if (ret == 0 && shdr->NextCommand) {
-		pdu_length -= le32_to_cpu(shdr->NextCommand);
+	if (ret == 0 && next_cmd) {
+		pdu_length -= next_cmd;
 		server->large_buf = next_is_large;
 		if (next_is_large)
 			server->bigbuf = buf = next_buffer;
-- 
2.25.1


