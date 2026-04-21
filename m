Return-Path: <stable+bounces-240044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNdBM9Qb52k14AEAu9opvQ
	(envelope-from <stable+bounces-240044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:40:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A4D437097
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B716E3001CE1
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE613815F2;
	Tue, 21 Apr 2026 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUiY2fy9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043E175A87
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753613; cv=none; b=l/kSxNsUDzcVh7wom73s7C29CGkkeI6QJKmYvyAGWKbjkoTEcp3dezXaAg8W4JFc5Qc76AwAetWb4YJJ/PkwmR3jA/69SO4b9S27y5JEnLuRH6YeRxxOKVU9bxtRkV13B6MGxi5zZN2cPwGsG4Hcqx8yLWTUCYqdn5Kfz1bToao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753613; c=relaxed/simple;
	bh=i7moRks1Em5xSeDJRGmHijtRZlYJUx95CBNBVmpOReA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAQD2qPTuvH282CHxOGHIw1uu9TMScs1+CmXkkFVV+g/n47hpZxwGX+yvT5KWyH1ixgZ/LJjm08s73tGY2j+gpfQlwDnZG3LrHlqMlX6ck8gM+BtkmuhXq19G36y3+ztFfdXDfV5I8mhy/h/1JP8MaUnWAeHe1b4ML+yAoUdrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUiY2fy9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c7971d0d97dso2371254a12.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 23:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776753611; x=1777358411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AoTQHgaXiOjxnBKbofO+VMkVOBU/6hoNuKav6Pyb85M=;
        b=BUiY2fy9uTBBU5LqkCQV1ct5ht+GKS6JFM80TjK+tkEYYj/FHS6TJ2fN4oPf/NsL8v
         ybjt2ZErZ8JA1evLFGkIXHQxYEMzmw0UG7t1ZoQdD1vzKfyqlBUNMGOUbmmWHYtLdrKi
         ZoCQrOoMuYEAecNDkuzuAn5VcrS7hLl27fQ6oRnS/9MmZt+KoG5EBGVYs97gdEp8oQPq
         YuaEEyYnx/AZc9A3XzjohK4MixEgEwgdD422XqFE6ZdK0lWjPRtyysqVi/Ev7aleOXln
         3DjUqhiD9MzUC6zfQ9me4SpYy/07z7Sd/4Wf++JE3pd1cTWEUla9tQTk0D39AGRbtmN1
         /sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776753611; x=1777358411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoTQHgaXiOjxnBKbofO+VMkVOBU/6hoNuKav6Pyb85M=;
        b=k2PcQJHjWvni5T08C103SO03n7EUhVvmNxnZmzC0pSf5MgW1ZHNUq/YfiIfwp56hI6
         mxunDXge+5fFxx1NkkLRxl3A3Lo0Z+De7UOY71xOrRdr2MLlLAZ/KX6zAMEMe1EQzdxn
         PF1/wMqG6fayFSTZ9jAytz8GqlzOkANHu1RelRWDIbvNxybQ6E2gBveFGX0tEV4+qhYe
         JfODBCJt0WHXJW90/wRG1GBSd6/49XpXGM3KBCvs7UyQYWq+5f4LnQQrpWdEn1llWJOt
         TCM22JtrGSY1x/QhMFZqMF3ye4yUiR+x9nPH+wxwSkq89qj1JAJRU3SyZ9qrOS/IxUMR
         uWdw==
X-Forwarded-Encrypted: i=1; AFNElJ+uYgGNOzMaVJHSyStPeat4DwovIiVAn6T59t1O9vlkooo90McJYwpSEy7tKuILbBhMiGqWmnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFAh31hUiYCnxsuVKfop1KyzsZ0gku6SaJDE36kwgAWHVeBp/
	U+fFa0cU5bKJ5p/nMAsAa+ZeEeAtuEu5dKG2ZSISJeV4rpaZ6w2BH/Pv
X-Gm-Gg: AeBDiesh/vz553wqkX27ycuDxyorzdBeH0/fI24Kne/BGLwP/2VaVQT9gxsHUywdVNH
	O+7NUp+CCjE7HNRwBHQnYNFDx0Uzz8n3wwQfpRUNEX2jShHhQcJSMCazAcvoqRlcqrn8ldZr6MU
	oZft5drE/zmjefq1UKDmccHbToNLWvIbebiiMR7pSiz/J/ijMnJviRFcA1Vd4IZyBzLo+RYbkn+
	BoJbK64wjXwRFLxmkB/fknWGG2Kjkv2fLTU00p9QXW/Dl7APCyHAB84yCYvL5lZd3Vj7pqaaZcp
	elidI67sM8W7D803MPXm4g+Huw1hfXgxzKPtns+8shIFnxUp56e/WiqTtXARZpTwwkhsmewubON
	cprXvXG50BCrqSKOeJEDd07SC9JPna1Sbu73htO8gmkzE8OAXbJtD55NNYSfagGvvmtilFpXZ+B
	b7SaZyQvAGkgRgXj9xWXebHFlR2ARaH/H8zlF/fUtqnvyJeBR1ueU9vtT5W4CrUc6q6SVLwaLYW
	xc=
X-Received: by 2002:a05:6a21:e082:b0:39f:2dd0:65bf with SMTP id adf61e73a8af0-3a08d8d9a7amr17966685637.28.1776753611314;
        Mon, 20 Apr 2026 23:40:11 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.184])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7977031729sm10032811a12.25.2026.04.20.23.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:40:10 -0700 (PDT)
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
Subject: [PATCH v2 1/7] cifs: change_conf needs to be called for session setup
Date: Tue, 21 Apr 2026 12:09:49 +0530
Message-ID: <20260421063955.99164-1-sprasad@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240044-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4A4D437097
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


