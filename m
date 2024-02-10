Return-Path: <stable+bounces-19416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52879850639
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 21:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CD6B2262D
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 20:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC875F562;
	Sat, 10 Feb 2024 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JstUeIgI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408D364BA
	for <stable@vger.kernel.org>; Sat, 10 Feb 2024 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707596099; cv=none; b=sR89/mr78eHOW9kCaC5u8lMXuyAmSmbLiB293b1IYORSqkMRJTnydyXtzw88pt0HA6psCbFmlPaN5KYutgcP136NVqQ3E+m7pCqZ2K/S114d2tar4gFu6NeqyuEa6uPfIkuGakTmbPQ4fDXaCK16JmEAV5tOctoHcqQpqiFK+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707596099; c=relaxed/simple;
	bh=kBA6hyy7xHlwZDCzELFsa0D8jSXd/n5X4psvG5tD+HA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S3dDfUia7rVhKN31MzCAh2HQOABBFO8AaIcTVK4jNPipLLslMjhGBYjr59dczYRF232OmEN7kv6nqRqxeED2rL48CSSGcrHFCFtI2g+ENj2Yh5EYB/jSS0DHMM/GjyNr3JtNflzESrkq/SZ8IEjKtJe42oArmCUFmMN67uAlzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JstUeIgI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d95d67ff45so15805925ad.2
        for <stable@vger.kernel.org>; Sat, 10 Feb 2024 12:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707596097; x=1708200897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zP9YjeZyrBkNPDmKqOYr0oTDbJIAsQq5kHgvf1ypTcY=;
        b=JstUeIgII5yN0oV4uUdcIHfNUautAXq6LB8Tj8Jghy5sDEEySP8FQoTrqRVcMhmEAo
         G+z26ll3bE7Tm69FO4YE97ZtwRQqWtkJGPhq6rgamavaPzdilpheOjykJK6XzY/JkipD
         CYDZ5utY6QCPhJcxhxI8VSP05MprbphWymt0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707596097; x=1708200897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zP9YjeZyrBkNPDmKqOYr0oTDbJIAsQq5kHgvf1ypTcY=;
        b=gSmPIZn5nPztLRt8FiIfYJYRZ5fbSV06qeH0WaZbgxl3AVjjMCnHO7eeUayvLeyGNk
         WwNG+JrfdDRd1b0+8MAgrqHECRW4Zn2NKsFSMtSbqsfxadKsGd9+Jj/Fu3wRTg0tYUqM
         UTezlJO0JYmO86FHK594EceUbUDGHb4H0CCl5EAILtWwQH03tfYgKKv15knuekhwQrWg
         mkP2DwPXX55TodCuuoOXiUnjA3vEO7F3LqnLCGUiI60FnxAwlUwda9Rh+ghyAQ9X+9cT
         Qp23eqcl4g+w8CnCKb+fE8D7Fj0OpdFVdhpeKKABxZ2SXpitDr9kcu2759XpWB6kbeCt
         Mlvg==
X-Gm-Message-State: AOJu0Yz3qicYatTTwHSgrKx/U2b8FZDH1cXeBJa7M/ZVo+QS4r7DxeYi
	bhgCCj7dh+nTanJY3UzrJ6TnmTT5LIppOEuhas+3b2JGEtfScS56cXZuQp21U8JerJ0B02Otbrr
	k16wya/X1Clq7wWwLjRIKyeqKhHWH1gr1rQcU697P99dvc3r484RBl1OAPnNTrnBcLcM5h3SF8B
	Zcmkp0nxZSuIGHY1tJrdReieP722AejDtcDCBzq/oE6s64UO1Ifl3Y+H8=
X-Google-Smtp-Source: AGHT+IFbVq8BHrLfUqGivF5JVFN05xW36f+5A0thj8eW37MQDnnJLheIZlie8ljtYrJzFWzONXLWTw==
X-Received: by 2002:a17:903:1c4:b0:1d8:d599:c014 with SMTP id e4-20020a17090301c400b001d8d599c014mr2918063plh.50.1707596097182;
        Sat, 10 Feb 2024 12:14:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPe7YrFRX2iI0gIVDniYfxOpzuehF6tuIqg8zcC+lubXXSlpWSspsVVGE7jzq9yXX2xma+nXgtLz00I8x60PmcpLtT9A3FvpD3MabSmpi6qr8q8/n5H71kWNvWntPWH0RSkB/J0xI9UmhL1L0LdoCbo3lY5dhyCWSYUfv/WqH1IXtORoR4rqb1SJayuiB2qxUn+PYHcSCx34fb8tlciP8FE3PqF2eROJUDFYa1EaHtePfqsihVieyMyOi785cAoTkyD9Y=
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id kd5-20020a17090313c500b001d944e8f0fdsm3424767plb.32.2024.02.10.12.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:14:56 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com,
	Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.10.y 1/3] smb: client: fix OOB in receive_encrypted_standard()
Date: Sun, 11 Feb 2024 01:44:42 +0530
Message-Id: <20240210201445.3089482-1-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
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
index 26edaeb4245d..5ba7056c78c7 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4892,6 +4892,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	struct smb2_sync_hdr *shdr;
 	unsigned int pdu_length = server->pdu_size;
 	unsigned int buf_size;
+	unsigned int next_cmd;
 	struct mid_q_entry *mid_entry;
 	int next_is_large;
 	char *next_buffer = NULL;
@@ -4920,14 +4921,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
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
@@ -4951,8 +4953,8 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
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


