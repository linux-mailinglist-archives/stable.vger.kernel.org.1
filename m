Return-Path: <stable+bounces-267230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ymNKCzFXNGpmVQYAu9opvQ
	(envelope-from <stable+bounces-267230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:38:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA736A2986
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:38:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=CWOH9UPI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267230-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267230-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E603E301DACB
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B755630E82C;
	Thu, 18 Jun 2026 20:35:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9D302163
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:35:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814906; cv=none; b=T56VK8k9P4JEYFNl3YQmUKbiana0C6yLKPDLreQ3r+SpB8M0tFRRryekYqKYoMha93ssuezlppRuC4QbKaU9ab02AR0Sf2u0i3/KN4vnkdvsT2NgkV6aoV1M+9OfP7rF6nPBgsB3a3GVdSY+PswrIAriccHZlOhgUBppbycdeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814906; c=relaxed/simple;
	bh=7slqrmU0JKmIN4TG3bK1//riMPfA2K0Wm+4SvzoW2Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcPMnB3Xnix5PsBBiWtNG2CmIB8oOtNGTeaoOGBumJUGfq+LUjZG9IEGHhDl6sXLC15yZtgmwtPSN/ub8uPX1F+GUIF6Rmenss5kbD+OZZC2rsetPXhMQDsaaLpsPuHgMcGruhh+2Jo4vGdihzXGn3DW3hHQXf8lateSzHu2X1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CWOH9UPI; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso8993515e9.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781814902; x=1782419702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd4DJFVLYj9995eIiNZox5y5QI2fYgZzhjzLtOnh2KM=;
        b=CWOH9UPIouVmh1L3dgQpJN9jKLeOOxaRhJ0kO1nzCBHVcYF3PS5fLYooP2umfiDK/l
         ShO7FdGxhLLUX+5T14i10T4lJtEMWe6DM1qicr3FvTo1LFN4LWS4mQblz1qyqXN2679f
         sMfIrdnSTERI80ng3Z9aKZJNN39T3NH8mZRAcaF9T1p19R8ZFTsw4KXohQytqICYxtBF
         wm1KbOrSm3fiAMaypipISejgzVK1r6Hx0Ix07935hp1sh72oShKpyY0XTraooE677Kvn
         61r5C6Ke4rnfCWlea6QU+m+AKwiiRxZ1zRpyO0TfzeywtoZNLOyAEDBnV2WNJHsbhbdc
         eGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814902; x=1782419702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fd4DJFVLYj9995eIiNZox5y5QI2fYgZzhjzLtOnh2KM=;
        b=B2GxKmPF7ExT81d2Aot8hrYiOred0X3aCMkBgYCExcATHQ+ZU0qq/E3Ukadl62Bak6
         cv6DhdYzVMwc0xXgh8rstxsvUYGRa6s7OqEZM++YQyycRvMA2SvngbOealwM1tc/zkpB
         VDOEga61B/zN/8pJG9N9uwUIPVowW4dRITuixpj7cMUhiiQShdRbA8baravOU7YWPDk5
         OLmOFJMh8BR9vCqe72GkJdrXTRNrFaMzDSOBttWiRXlkNPfHjBnI1MzEoBpY1hui4VeP
         5QxFS/KztAS0j2kdIcCReqRuUHhmXv6jfITYTRudVcft49hRmiC0hoiYuv3wtTsb6qK0
         iyZg==
X-Forwarded-Encrypted: i=1; AFNElJ81B9xT9utQMj43Us9zVqI3ip5t3K7exnU16CkU4Xm1mckxDBU4V8EqVTq7xBDop7SW2kiYbNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OJPFnrNHvLjrn/HH35vKRfNPWOvWmpmPG5CoV4hWmyKVIZYp
	G1WQijL3xSI2VXSbOyEQd2Nh17n+0uTMEhTgH+BrulmbXTAyita89p7QI6Pc3T6fwrk=
X-Gm-Gg: AfdE7cnipUkSjnJGv4kmRj/KlD05Rl+U9EutN2VROnrvp8BjDmJfjye6omJvz4/UCB5
	q/A4Tc6ioe73n2g6VzcCyBzOR7BfefvmsqwWn3upvDNrmdAG+MXHELorkjAk0qAjzDcbRlqKlNN
	PgKHH6qmuuGBjPHhluRISe5FSRVe0YBzb4bsUL5QUq7csbvjdqXT9Qy2X794/IM+Q7koo8W1Fmh
	sw0GavgIIG3nXlTGViFiBUAc8w7zo2a1rocLjzi/giN3RE8DiXKu1i6cAEQmCHcZ3LpSnrjiHFs
	uhkW9gxIMZyWSo67kmDbrR+Bq8aFimJ6L8A84OikEQQraDI6BNNopiWePr0JmXManUakJtyuym3
	IRbgz55mX3lWmCTMqdPxPStJqVoH3XqWLK/dPYGRv8QLs2DF1izLdlTy/CzEZlZuBNbcQGBCHXi
	SwhDxQgMs5YJh9X8wuO6AI
X-Received: by 2002:a05:600c:524e:b0:492:3e44:214b with SMTP id 5b1f17b1804b1-4923f1530bamr18792335e9.13.1781814902171;
        Thu, 18 Jun 2026 13:35:02 -0700 (PDT)
Received: from precision ([2804:7f0:6401:b508:d1d9:f1f3:d91c:79af])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966fc32849fsm439109241.5.2026.06.18.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:35:01 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	ematsumiya@suse.de,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/6] smb: client: fix double-free in SMB2_ioctl() replay
Date: Thu, 18 Jun 2026 17:34:34 -0300
Message-ID: <20260618203438.667881-2-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618203438.667881-1-henrique.carvalho@suse.com>
References: <20260618203438.667881-1-henrique.carvalho@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:ematsumiya@suse.de,m:linux-cifs@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267230-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFA736A2986

A response-bearing attempt can return a replayable error and free its
response buffer. If SMB2_ioctl_init() fails before the next send, cleanup
retains the previous buffer type and frees that response again.

Reset response bookkeeping before each attempt to prevent the stale free.

Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay flag set")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4d6a989748f9..121ae914c3cf 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3532,6 +3532,8 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	server = cifs_pick_channel(ses);
 
-- 
2.54.0


