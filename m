Return-Path: <stable+bounces-242325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MjlG9+M9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:22:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE64ABF49
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 914E93006162
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095B39F169;
	Fri,  1 May 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV8e87Cs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76033A5E69
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634433; cv=none; b=by1mKCEg25ZuotC2/i5MRL3Zj7/MAxEWIoT289j8Zh6rZYtaeUWmedDtZkCLVOjfTCfU7xqy/rDbkpT/npayC8PL38q9kcaJV74NNMhqCqlNtSdGgSA+H6XeFVu9/o+lkaAK7/hBpOmP4LUr0z/p+3SfIcs7FVdKM6hgopF8iOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634433; c=relaxed/simple;
	bh=eG9ghrqyHv+FTgYWiTsJuJFnXKn0gQTXBQyL1yWQTYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMLbX4bOddNMMvyn8Irj0kMad4x02W9edVCVQ0R/Lc97wiK9H5zr1ekw5i8Q+o/Yf/x5nzObP1QtGGVMs8jwgxMGlroI44rQFzGgOefy6ks3ROYy3BC2VY/ysfQLkBWfYWNwTaHur0NZ2prQLCx0PSLwXwFsBvzOLf1T589iBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZV8e87Cs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so832815b3a.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777634431; x=1778239231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k085XqsDoPGBdb9RzNl+RVKDoAd53m9lIegek7QU+Yc=;
        b=ZV8e87CsC4UZ+ujPnUqB2ExeeFuHE4clcfW0tjgp6E7xmL7RETu2shaVWEOZNhsrGc
         2LZhBGUgopqMeZhTWchV7iaWSAtlonuuZVLe2/3H8hksgmWtlnjysc6mS1v4ouGk2Qll
         OjFcXwAbq1llOWoPIm3KgLlnbEzqw4UeCBsqIUSNKXqMa4qUvG9tc80v9pxqeXB5W8uU
         62d+YI6brUWjcmEQVQCfk96IjvZjVLZaukheNvwgUyf6kgWeB7mhuVtJHIdrfyd3raB+
         J/v6l+K0CFyF6opmOv6nYim1jkCHgnNQSz5CCfBkUH8gqPmm/WuUAa19jXjREz90qpwZ
         vp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634431; x=1778239231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k085XqsDoPGBdb9RzNl+RVKDoAd53m9lIegek7QU+Yc=;
        b=mQNQc+fctZCqOpE6GPw/moOjSqFlJQup71r7OSu6U9JnbDAmnUfdu5HO2GQWY66lne
         oEvOMjPtT/Lgk7D3WE94mkG1pwKU9zZMhKrQgmbUxQMn5pRn3zm8vrlRiqbqvRSXcSxO
         Il6qGDjcBXQMdD4oZVMAl3mNsQf+u/+v78dxvQS80PcM/qt7Aoa7Qxs8VuUYBt2mDZXX
         ORwmOW6k0bvkDuXT2h/S1tSRGLpdiAS8BvGQDa30jO29SmcIujD6nTQFy8nDJfVTViLo
         mIVPJm94U7ehVG7ajpZfPWf2Ds9NJsvX9xvLLuV/T6nlKP1NPbZPTHWkcdUc9X2jJl3T
         A07Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Lz2CFmQyudOcGS7wOY9eJLvViZDLFeCUlhkpL6UqV+aPTeFmYVPldM+op8Rr9A00HzhEiU+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/4DwcT4/81bPKq3Cy7FvNuhEwAameurVjJBSdZBp40S6TcPnS
	1EmekYNnn5r/T8r77HWFLxdXvU9a6eN3fZIznq0jw4KRqZg7Afsb3XoU
X-Gm-Gg: AeBDietUlTu6PC4JtcKV8Gu/s069Wcc6a36MwjUzkZWhl4V2hYB/JqMzVEligF17MBZ
	O/SU1uG2ZVsxwGLzVlG5ngyn8Jkn5UuadGlgoIk/WgxZRPiNnCMs7hm07gNwxJc26TMzO55UU8X
	tV6qcbWb8SlUFlPYQUqpIP09B+4JnYzYev+JdnQ+ywLcYo6RgaQHn9m+/1CM/vpsBltSkx2p5FQ
	I4nDkLqhgngPF36htH9GnRe5kg7hImRl7SKHt5Lh+ftJOkVbdANyuUqPWDs+IcL4dEQczhSWbLE
	oRFAkTIXtLp5NcnKOTMiSxAc6wG7F7SZQbNX/4cxPq8aKziOF8Hj302ubYMBWWRChLZVUDEdhdN
	FIT9l5MIXIviNRfvRuEtUfAnsJCAIZSPtjCPtsiS8WjKguqTOAajs4vJNJYmWGb/HshbpRorahq
	7e0lhJ/lmkatl8tatMEKNyO+ogN3l/wIwhCTYkCyvExjhm3SeyvF9uz1Q7d6nZEQjkpDIUQHVoZ
	Wk=
X-Received: by 2002:a05:6a00:ad88:b0:827:3914:f130 with SMTP id d2e1a72fcca58-834fe200ef0mr7412087b3a.36.1777634430884;
        Fri, 01 May 2026 04:20:30 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351587db67sm2331922b3a.13.2026.05.01.04.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:20:30 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	henrique.carvalho@suse.com,
	ematsumiya@suse.de
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 01/19] cifs: change_conf needs to be called for session setup
Date: Fri,  1 May 2026 16:50:04 +0530
Message-ID: <20260501112023.338005-1-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 20FE64ABF49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242325-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Shyam Prasad N <sprasad@microsoft.com>

Today we skip calling change_conf for negotiates and session setup
requests. This can be a problem for mchan as the immediate next call
after session setup could be due to an I/O that is made on the
mount point. For single channel, this is not a problem as
there will be several calls after setting up session.

This change enforces calling change_conf when the total credits contain
enough for reservations for echoes and oplocks. We expect this to happen
during the last session setup response. This way, echoes and oplocks are
not disabled before the first request to the server. So if that first
request is an open, it does not need to disable requesting leases.

Cc: <stable@vger.kernel.org>
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/smb2ops.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 509fcea28a429..a9d68e5fcea91 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -111,10 +111,21 @@ smb2_add_credits(struct TCP_Server_Info *server,
 				      cifs_trace_rw_credits_zero_in_flight);
 	}
 	server->in_flight--;
+
+	/*
+	 * Rebalance credits when an op drains in_flight. For session setup,
+	 * do this only when the total accumulated credits are high enough (>2)
+	 * so that a newly established secondary channel can reserve credits for
+	 * echoes and oplocks. We expect this to happen at the end of the final
+	 * session setup response.
+	 */
 	if (server->in_flight == 0 &&
 	   ((optype & CIFS_OP_MASK) != CIFS_NEG_OP) &&
 	   ((optype & CIFS_OP_MASK) != CIFS_SESS_OP))
 		rc = change_conf(server);
+	else if (server->in_flight == 0 &&
+		 ((optype & CIFS_OP_MASK) == CIFS_SESS_OP) && *val > 2)
+		rc = change_conf(server);
 	/*
 	 * Sometimes server returns 0 credits on oplock break ack - we need to
 	 * rebalance credits in this case.
-- 
2.43.0


