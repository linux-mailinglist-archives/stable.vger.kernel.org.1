Return-Path: <stable+bounces-238369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNM5FPxW4Wl5rwAAu9opvQ
	(envelope-from <stable+bounces-238369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 23:39:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B432F41501D
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 23:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C865830BF420
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117B36E465;
	Thu, 16 Apr 2026 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ3WhE1F"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1D340281
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776375454; cv=none; b=IwzwXOCynd0By3m6sdx2/tnHV2rNrJLZyzUutCJQ0c1b3oR4LRqbqAwN+oCKu2alj/ykeax7hZDDvjQjnEneLoZGlTXn6gzC0bBEjFna6cMpLBF0rXoNgVe6AFhkXsMx+7kjb1SAXSyzxoZxez044OZX/W5AI4L1zokqJpqMSuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776375454; c=relaxed/simple;
	bh=SnJvrHty8riZtWpxkx6xz7jX8W81q+Yde+8ssBb8Yyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfXFg+fd1yafz6DruXcAVtU8cvRdWEKvSJsUzyuO/ZIFLlsIjBdHExzILxoa+Uunwk3sa18b47K2zRDEfL7hWUyeJLa0pozGjr2JL2/EcKCJF33NdylGX8sHTUUBvnBT/Zg9h4XITYkJbJZ/9iAzQY8kzhYSwG/8DCctVYr230k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQ3WhE1F; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a032383008so92907046d6.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776375452; x=1776980252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=huo/l1LVhl1kS5YAYBF6Ffd0gihdNIPyirAcpm8PYyY=;
        b=DQ3WhE1FW8oCZhNMiUEXPKyHXJC+mjC0AEBe8XBcCSi95GVWb/qzZHyiDArldp7uhZ
         wELm4JJ7ZCOzzdXoRPlHB0a/HfyCxngleZtDS51R9nnOz3H5TM/nd+rvLsVvO9e4sG52
         voXAgo33dMr1DfnorR3OV5350WJbWoz8qlGhL7LyU8MlVW6eKeN3o5WWdmjtCpLruJi4
         no6EOfSGqu5rzh7j6NVA3GS8iFay5i3EskCJP7Fw5nJAgJoLpAqgnY2MRYvV1aSzNURU
         5WyVKS5uoZpRk+eeD3VaTA4xOvRuzEVU7DAwijH9c8vxuhPJVZ88mJtBBJRKBtWBz5G+
         78ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776375453; x=1776980253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huo/l1LVhl1kS5YAYBF6Ffd0gihdNIPyirAcpm8PYyY=;
        b=RnS6eW3hGDzBFymXd5oF5ZfbkfKFVyssB6qF4NYhx8chl4xvCjF277ueDC+TvMlBC9
         Kk2hPxQLETwV2ziPUDgGy2VI6Gk0M7NP5ffmAnUcJe8Uoj8/6vJJTuq6hpeYawsGwbsF
         zcDJ1rjq2NmJF8pNg+yOMCXFwJFNWsRDlk2R/+bfEPRwLCJ6AV3w8rJF/T68t7ffxKTR
         X+Gf2B/G8UWZKKa12kQ+yhP5NSlsJgm/pdSxi+yujXbFGeqiAjJnyaYqIY6TtP7lwyX8
         eQtsNRSzTCCgy5qvNjWZ7DU4CumFVCzL7HIxyZLN7RR/KN4Ri/FOTP0lCnZP/HAX1NTP
         L76A==
X-Forwarded-Encrypted: i=1; AFNElJ8gIT2skxCdsD0Iung+UKB4MyT07VKgV8cQB/07qG0A+gAsbo7ec+W+ojbx/xRARWR/rGl+xsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypst1aIA7arQwPu+iEuZl5I7VqEeowdD0D8rHjR0710Ai89O/f
	hQ+9Akpu1fVkft3IgHZyYeP1auLAMzvuTyIW6gGv/02WJiQxTsmPK3V2
X-Gm-Gg: AeBDieu9+jrPOXnb4Qf3lQacb6E0Ls+xsdO7wAQhbu2EXsFElVQFGqidqHlksGUnKc0
	2DIQ3/bU4v3EDDxWPvQJ5GLFE2ohAZUrt37kL72gwIfkUQTkYerJvMYkdGpHk/Df00QSf6gBcZV
	oHH5TD3+aIPXT/wr/9tMEgaC8Uj+qGXt4v5lEWmtcKtG5r5xQYiVr7r1QW1WsmDFvZFLzOHRAEC
	M5WN+Xn2Wx/KOlHGpMsDCzDFvEGhfiEPxVQp1s0bSWK/rLiK9VN1nUxQIQoTQ+AxKLdgS5jplD3
	3yXo+WZVnszhzUUQXmpPV8SARVd5jPcaMMXRSNTo3veH1nQYj4MrAt5hFE0YdYTPVzwycXNYDMq
	lXNfMwu65tYj7PBWPl++Lag4e9mkFmamXU10d2qsIYvF1nvEvkz3As0Z2co6KySInHx2va5Jab1
	owYu0jhdgJVxa17ZgTyygyWE12TcFJL6Z/ntuBK1gHP1tZKVjcnbZR+gQHv683qB7cdBoY6deas
	+LnsgwBjTpW0EjTSiIHoqoZdjVOnfZqMhoGY3Q7/FYcE7MEr96Z/A==
X-Received: by 2002:ad4:5d42:0:b0:8ac:a4f9:da7a with SMTP id 6a1803df08f44-8b0280f7e88mr4451406d6.32.1776375452536;
        Thu, 16 Apr 2026 14:37:32 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cb9eb87sm44823896d6.32.2026.04.16.14.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 14:37:31 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path
Date: Thu, 16 Apr 2026 17:37:16 -0400
Message-ID: <20260416213716.3118443-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238369-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B432F41501D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Another client side from my clanker. smb2_ioctl_query_info() has two
response-copy branches: PASSTHRU_FSCTL and the default QUERY_INFO path.
The FSCTL branch validates that the server-reported output length fits
within the response iov:

    if (qi.input_buffer_length > 0 &&
        le32_to_cpu(io_rsp->OutputOffset) + qi.input_buffer_length
        > rsp_iov[1].iov_len)

The QUERY_INFO branch has no equivalent check:

    qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
    if (le32_to_cpu(qi_rsp->OutputBufferLength) < qi.input_buffer_length)
        qi.input_buffer_length = le32_to_cpu(qi_rsp->OutputBufferLength);
    ...
    copy_to_user(pqi + 1, qi_rsp->Buffer, qi.input_buffer_length)

A malicious server can set OutputBufferLength larger than the actual
response, causing copy_to_user to read past the slab allocation into
adjacent kernel heap.

Reproduced under UML + KASAN by constructing a 73-byte response
(sizeof(struct smb2_query_info_rsp) + 1) with OutputBufferLength=2,
forcing a read 1 byte past the allocation:

  BUG: KASAN: slab-out-of-bounds in _nfs4_do_fsinfo
  Read of size 1 at addr ... by task mount.nfs4/219

Confirmed rejection without splat after patch applied.

Add the same bounds check used by the FSCTL branch.

Fixes: 5242fcb706cb ("cifs: fix bi-directional fsctl passthrough calls")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/smb/client/smb2ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 509fcea28a42..de10077320e1 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1783,6 +1783,12 @@ smb2_ioctl_query_info(const unsigned int xid,
 		qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
 		if (le32_to_cpu(qi_rsp->OutputBufferLength) < qi.input_buffer_length)
 			qi.input_buffer_length = le32_to_cpu(qi_rsp->OutputBufferLength);
+		if (qi.input_buffer_length > 0 &&
+		    sizeof(struct smb2_query_info_rsp) + qi.input_buffer_length
+		    > rsp_iov[1].iov_len) {
+			rc = -EFAULT;
+			goto out;
+		}
 		if (copy_to_user(&pqi->input_buffer_length,
 				 &qi.input_buffer_length,
 				 sizeof(qi.input_buffer_length))) {
-- 
2.53.0


