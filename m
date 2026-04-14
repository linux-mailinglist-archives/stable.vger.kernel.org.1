Return-Path: <stable+bounces-237886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGslO+hI3mkzqAkAu9opvQ
	(envelope-from <stable+bounces-237886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:02:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 522AE3FAD53
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16224300CBC3
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760933E5EF8;
	Tue, 14 Apr 2026 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2HG51rP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F038B7A5
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175171; cv=none; b=aT64z278GtuOYTNoes2haHAwQ/oJh4G7B2AkwvwhqlniGX0Ue+6C+xVsnWEuVwF5a24E+9C+Ya+IZwWru3vub6tVJTWg+u6f1POenCYaQgeSDHDaBftaE2Zpa/OGKZ88omqp+PCTnMCCTm9aL/QHmGEwT8F2aZ++oZCyY3l9qoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175171; c=relaxed/simple;
	bh=i7moRks1Em5xSeDJRGmHijtRZlYJUx95CBNBVmpOReA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zch4mH9LJA82DFVCceUaCtJeWe495BRo0/IN8GfHWMHRMGQpyQkyIbfyV9PoqgGRkER58CNoWvLAlbw+9KK6bidU44XEoXZytul5KWrC5r/RK9UAr2tw760oMuKyxTp43/5iG68qg+lPoO5cYT758P3peKXLDa26v1RVeKZpOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2HG51rP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aae4816912so37223255ad.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175169; x=1776779969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AoTQHgaXiOjxnBKbofO+VMkVOBU/6hoNuKav6Pyb85M=;
        b=M2HG51rPy/tDYN43P64USexx+GaoGqzvjrq4ZoT9lXF+0jUiLsWtvEBXC5yeV1XDnk
         0WfwFbAfvcbDEzboxANxSyK25U1yH6REzpL6QfKW95mSPeKCtKeC5KvCbQTOfxcpm46E
         uGbdVHbXEHN3+w2gghNT90hgZ6zO5PqAO7n40fqSGpHxJmtxfcFyNCFGl3HiKw7d642o
         Z1/8vjHWWvaq+Hk/YzPd7AUNYhOTkpPApAbKIwrYV1SvU+gAIxKDk7T0xPN2ZCtebfA7
         ruHMzrw9Z6wn5UqFGBIfqblt7UUMFy2qQpwHO8uBtvrCdYXqrprsl09kX63vhmZ5MIY0
         qH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175169; x=1776779969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoTQHgaXiOjxnBKbofO+VMkVOBU/6hoNuKav6Pyb85M=;
        b=S/KFPRUQ51bL2bozZld2KORUwUmAX9F4ESqEXCLlUojcRRzBLftJ0JMGPHV8uCjpJi
         4dCgOlElYSlgs9GA2T81hWzdjnUvKaiGcu+dQVnkDxcECZhgMwuy9466AQMwXJYCZBw1
         pEPwjo1DtDdyacJOcLl4z2B1FtqaNNBLlTePc0xrO+H96uHHbb+haQNsKfzWokUUwjR3
         wFqLi8GtA5tskpdwiS/lxencsyN/iT3SHuxGz/I3gyvcSgsiqOcqvCooSHtISWd20Dq3
         aJgbEIfn664VWhhXU+NY68FTZpS7oGXyX27iDjEtDnwhLmiGJeL1qVu2gwoz06wXj8sI
         Peyg==
X-Forwarded-Encrypted: i=1; AFNElJ91iPGd24FO7XvDid/lwWQuLd37d1YjnorC5DWpx/IRF2j370pY1eClnElSAVfRxt4LAyhwx4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxecqTx4triIGhQUBHxNHtGAkMlZLCRfsXr3xMzIgzgj8E1otcV
	aNsjXM9cG7nKLrKY3tV/TJ2qhU3HSJyLN+FpkT6jS+3H8OKttPLA0sM2
X-Gm-Gg: AeBDieu0srcDbCKnHV0miQ0lmkJF+bciAtzuaJyUj8QDewoK8AvCczpy3E0+pYqGroj
	nM82Y0Pko+eakUXpy9hPWQUrjWF530/SEHpCUuq6ghJ2RgKcDcy3m7uzlIqcpkFqFketaqANNRw
	rHoywPZyAT3EL6n7xrPJxyowvyxNah+FyRfjfQ0GUWzEOV91CRzM4n26b35qdp/3vaT2QDnWCUy
	k+FxjNZrIrKvgpGYADuxTafTnfCa9XVhS2vg7yXLGOfAaYpMmk2e/bNT88spqPtpdG5LPsTLGcX
	p+yHjpV9in05+PSGG7q0pXhAsFAfd0umBI4vR3LZU8QnK4scFAyZEAKLkqqDLnpSt2k4owTaCRB
	XZeyBGDwheByG8eIsFrdwXf0eyePOr1CgmkSx2GAG1IyNNABoyqQLytDxKwWmz6vI9bVK6KdB3y
	wDlhUftyYSz7xRd0d0/zAA7btFu7b5VmHZfA6X8IUU6G6yAICHH9A+vCj0JFCdFtE=
X-Received: by 2002:a17:903:3c30:b0:2b4:5f69:715d with SMTP id d9443c01a7336-2b45f697b4bmr82943705ad.25.1776175169402;
        Tue, 14 Apr 2026 06:59:29 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4612e60dasm59779895ad.38.2026.04.14.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:59:28 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.com,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	henrique.carvalho@suse.com,
	ematsumiya@suse.de
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] cifs: change_conf needs to be called for session setup
Date: Tue, 14 Apr 2026 19:29:12 +0530
Message-ID: <20260414135918.279802-1-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237886-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.com,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 522AE3FAD53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shyam Prasad N <sprasad@microsoft.com>

Today we skip calling change_conf for negotiates and session setup
requests. This can be a problem for mchan as the immediate next call
after session setup could be due to an I/O that is made on the
mount point. For single channel, this is not a problem as
there will be several calls after setting up session.

This change enforces calling change_conf for the last session setup
response, so that echoes and oplocks are not disabled before the
first request to the server. So if that first request is an open,
it does not need to disable requesting leases.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/smb2ops.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 509fcea28a429..3625030d1912f 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -111,10 +111,19 @@ smb2_add_credits(struct TCP_Server_Info *server,
 				      cifs_trace_rw_credits_zero_in_flight);
 	}
 	server->in_flight--;
+
+	/*
+	 * Rebalance credits when an op drains in_flight. For session setup,
+	 * do this only when the server actually granted positive credits (>2) so a
+	 * newly established secondary channel can reserve echo/oplock credits.
+	 */
 	if (server->in_flight == 0 &&
 	   ((optype & CIFS_OP_MASK) != CIFS_NEG_OP) &&
 	   ((optype & CIFS_OP_MASK) != CIFS_SESS_OP))
 		rc = change_conf(server);
+	else if (server->in_flight == 0 &&
+		 ((optype & CIFS_OP_MASK) == CIFS_SESS_OP) && add > 2)
+		rc = change_conf(server);
 	/*
 	 * Sometimes server returns 0 credits on oplock break ack - we need to
 	 * rebalance credits in this case.
-- 
2.43.0


