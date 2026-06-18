Return-Path: <stable+bounces-267229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OZj1FilXNGpiVQYAu9opvQ
	(envelope-from <stable+bounces-267229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:38:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F606A297C
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:38:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=bQrbijP1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267229-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267229-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB32C3007F57
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 20:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77EF33A9F5;
	Thu, 18 Jun 2026 20:34:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E732327C18
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:34:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814896; cv=none; b=awLgXDjB//R6WfNIk5M9O8lzmVvqZ4YnEtomjWvSRbINe9qh96b+cARJciaotSK8rbFgWYoLTsqK87ZHUozW0wQFFiitvtBTWqKSu16wM6m+o7Lqv6v1ttqoCExe9k4j6Wsovi+Iir/oRr9X+XLwg8aMz3YXB2/Y6qMY55xPWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814896; c=relaxed/simple;
	bh=lp0Us1M4kfUY89WpS6zIQZNR1h351XJEk3N/5b1jBJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+wS4CDK1RoSpPUBhs27lXwbuQ1NuPDIcNS6UlNfp3NVMXlCwlTT2BpSbpda/JnA0GNER/wAtoau+rWD54HXREaONC0v3j83yGb1+zXCNqEW1M7zI55DcvCjtrhxUB3O2WxvflqWJ5vxDTetUgWvQBqkuYLuWGbDpq9h631zojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bQrbijP1; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4923139e940so8135225e9.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781814894; x=1782419694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XkStSBlBvo2GC/9K4djgXIKKOBITsjSwew1t+Sc2AE=;
        b=bQrbijP1AfC4w7jZ6GTEUXFI0bsgSWhgAbqt6vIQZQn2Mug92/iq/iC64bY9IYKAN/
         ut/WbQiqaK4Y8gcI2ykYGKrcukNM9TtRSK9BGSe6mfpyD9ve2TqPr+ux/Txnqm2mMiQj
         7YzP0mI3dk5bHyjiIjueefIJ5Tw5aM1e/d0zxEIBOv5VsAyUwfPmC+G55Z3JUISTFWl+
         GRmo5781kGIDSDNPbIYWL8evumC+8ItvNjtUwt9YsXN4I5e2ekzLXCqNSxmUQkHL7kKu
         2kyPOmlQghkyAJdy3lID/j1AjxXCf2wv5dYFilQeIaDrdZNIAcFY+mmFdtgKKT2FHFMA
         w6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814894; x=1782419694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XkStSBlBvo2GC/9K4djgXIKKOBITsjSwew1t+Sc2AE=;
        b=agtN7pnIGJRaj6oFhZZcxInBBiVo8RKpjJh5p/9VRKDvgDPwEupSJwh2wXJ5JZa+ao
         IJMs1Lt2HBZFt3lin4b5buRNtV8O8CO1yz2qx3QG/mGly199BL5jzVAvoqL3A7wU0DXc
         InYQ1jaR1AceCYPBI+2hxi8FfHJikgt8eEgKlg5SdVCRSDqnt1myBrQXsubZ5gHglwg0
         TtVhwNaiUDdm7WN7UtBgqQho6p8U47w2IOjltnT39IDCzLGQ2GfJMu90O58wCXlj1X0s
         JaD40YvJbya7gosvWVbuCgJMFvAfFu1LZD4f8C6Ws/NXi5wSd3HxUcri86dob0/Qlfi9
         KiVw==
X-Forwarded-Encrypted: i=1; AFNElJ/0sxSAQSyk2b8cKNGmNSROGAm9PJvfKw0Vwl9w7T/dHvZXDJZVmSGEiqB1ESYdubs23G6zvDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz88CjYS0kUWRVPIZ75P8JqgL4zles8BlIYefbQMmG5cS8VXDpY
	E4aiertmOFFdtVwxlrqshMub3sWC4eibzV0YfXE6d9cF91mr7TmV5FzOQdP9c5MiuiM=
X-Gm-Gg: AfdE7clldVTjBEylZsocP3wlAgq3vRfrpOcAZV9ImTn0pL6oPUL1OCYJ7v7QAuzRdvs
	fxTdYFa6lhsX3oAySkRpveNqt5ssPb7FdHlJDABzGkjg0HGGrFMKMKl//Y4b/Jla65c2OYVOZ1y
	ucUxewKyDFlhqoZXcr2jr6tbJToRgM8dnzs2oob/eDqjOU7c7Camy5HoW1Xn/Zf1To8MmFMeX2d
	ggF0EmyxfwoeWBOWph9T+xdrtRQx9ufs1/iprH07X3dko4TnM2Zeljby4kNZwVFnDx+U8aRw5ci
	Oi9lvRKoBN+gFADxgKjFsCu+XrMrkGZN8IRtIwctfSsC6IzX/hgH0+LzI7sYiN12nqGqiond1Vj
	AyNo2vVI8TSf2ugcIzCN43cA84Jl2ExeISjdpQd6B1FJc7jXFKSHZSoRlEt+YE1zQfLOYxlevPT
	qYPhvxw6/WYP3cJaIRMuEI
X-Received: by 2002:a05:600c:4743:b0:492:3fa1:40e2 with SMTP id 5b1f17b1804b1-4923fa14123mr20898795e9.7.1781814893484;
        Thu, 18 Jun 2026 13:34:53 -0700 (PDT)
Received: from precision ([2804:7f0:6401:b508:d1d9:f1f3:d91c:79af])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966fc32849fsm439109241.5.2026.06.18.13.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:34:52 -0700 (PDT)
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
Subject: [PATCH 1/6] smb: client: fix double-free in SMB2_open() replay
Date: Thu, 18 Jun 2026 17:34:33 -0300
Message-ID: <20260618203438.667881-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
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
	TAGGED_FROM(0.00)[bounces-267229-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7F606A297C

A response-bearing attempt can return a replayable error and free its
response buffer. If SMB2_open_init() fails before the next send, cleanup
retains the previous buffer type and frees that response again.

Reset response bookkeeping before each attempt to prevent the stale free.

Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay flag set")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 318559cd00db..4d6a989748f9 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3305,6 +3305,8 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	server = cifs_pick_channel(ses);
 	oparms->replay = !!(retries);
-- 
2.54.0


