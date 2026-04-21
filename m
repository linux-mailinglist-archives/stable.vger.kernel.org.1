Return-Path: <stable+bounces-240045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE9hKNIb52k14AEAu9opvQ
	(envelope-from <stable+bounces-240045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:40:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AAF437083
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9726B3007B9C
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 06:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CEC386424;
	Tue, 21 Apr 2026 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9d6zTN2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE83603D3
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753614; cv=none; b=pKYu/wMdcPEkR9wIvwnzmVXClc+grqMfgGef8CDsi0qApRWKthPZPK8b+LNsDD8G2OXRNcnUZMJlNeuD7o9PNPJqUa+0yoyZW+QIEzYaWRtwVv9KXqZm73z/wwrEYsirtkoobPyNjEjNgKhTzL9gcIM4ehr3zrAIXFifWbLAUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753614; c=relaxed/simple;
	bh=0HL5ZEFnxyEbq7XV4UUOrpynXy9ORh0SIFW4oCxfPLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr2C7NL/yaLy/VmaJC1yp33ZsK6fIhhE7TxjN2hvEEHGzqHbSR1n3hSMmkICriHJ3rsskUatYj0bGtVpM2rZi7tSzyKvhxwIqy1cE++QK7bkU8E5yfAqCTbJa1v1le9cPjgO/RM0JPHt3uHrdx+qhRfS5RVF1fPtgeZ0p3og8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9d6zTN2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so1529999a12.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776753612; x=1777358412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPwOpTfrLZUEPYuYw9st6aLdCBfwnzGfzeTwyPnHP84=;
        b=p9d6zTN2cmZ61B+dHkJ+SU7TtXA+TY2rqhJcaZgWSkHg86fsOi+t/epsGobe8Xgx+a
         2gSvsDU9PxBeqt0C20NK9k+8T074HGvCnK56vNtTtpUGVaKbtE20t9NHZN9HvS4wiH/v
         dIodymf1eEJQrVCJQTcFtSk+F6GRQHe6BrlJBHuld+eaOuMY3ILE2NgsOaQbhkhQfEXz
         XxvJdIMa/glauZQsScMCg2kQQki410FqjXENY0+dfwrr6iYJT1q4smyC469AqpFeMupb
         BBAUU85ndJOA1evliRLzdJ8CKbIJplVdK6UIXaX8QN29GjxbbAZWOJMY5LpW2JmB/YDA
         f8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776753612; x=1777358412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPwOpTfrLZUEPYuYw9st6aLdCBfwnzGfzeTwyPnHP84=;
        b=Qf8bnMmKa3TwoQR9TC+SVxMZKnKiwbrt7TsiBLaulQj5DCwC+o+08Vd5/5Xvg6KHKO
         pXzxgGmTJp7FFk++p9gDrx9ZIlGBEHOVlfhocpjty9H1ve1Eekwln7dv0zt258N9t89F
         Gal1wRR0/Kb68smmjz6eWGYUx+/+afB+F6xtDf3GWw0D4leWv97llLn2XGOSRf/0wH6U
         EELdytukgbel/t2VZobIbdu0sSaqs1kF8qlKxEWuSKvPK/71jn/N1NliltOyP89DaqPx
         Fmll3DSLRIgiNujNcrt2NwENaHJY4ASa3FYVDNzvMh00aLrRx/khuotcQszDaGOQ6/ZH
         MgXw==
X-Forwarded-Encrypted: i=1; AFNElJ8zY0pYnnMZmr9oueuMhLSf8smDKV02MozvzdZ+FJxKkglm5AbU4MQMt1ZGgzwMGDXOUs6Ei3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xocKcy9BEovKsRwtBiuHimb9KE4dOnWCVh2lPqUEp+CUAE+U
	8pIUsjysR4ZnZrsmsd0J2Frcd0ipGWZh5t83BLoBoPF6Vy5CqP7CpN9l
X-Gm-Gg: AeBDietlxX0ZfbBW3+vFHqsxMunDeneHxc/uimxmGuzPQwgL/Rt3RD6MLlxURwUqeJE
	WDnYRflou+qgAz1lEfxsiUvl7R3T1FFjCf+7di2IYG1ODyNggJDKxt3LdPi4rC3Ef9RcyVBR+ng
	YN7nNwn2COb7lk3N9vQp1HC+dGMGd8xs0AeTV/fh6a+4X37DRDIbCgWS8m6yuyJlLP4JkNEJJXm
	MT7QORfEkRZi/j/zAY+v8Da8AKEzRJj4ccEs7xLoy2kDRr2b1bJDlhzfssKRT3/HPjpV8PZv0uM
	Jx38fEXyf+2+YbmkaqEv8ydk0Gbp81l/5xJIeORc9mwsct2Sw6xX1XsVUb8clBpLxAAAJZQQx/G
	7TmEoSvmSjfE4KHgAmM1+aae918By2cGlX9RyQL3FSXLfaEFTa4VwRbKqe4GOKydPa20MW5HSBc
	Zk8pjNb+7sJoLHjf21pez+CpRVDJeOdNtvpbDwqQWvKJcExJr49rodtZup/mHyC4qyVkz+p5JOz
	vA=
X-Received: by 2002:a05:6a21:9995:b0:39f:24a5:3065 with SMTP id adf61e73a8af0-3a08d68e9eamr19103464637.7.1776753612396;
        Mon, 20 Apr 2026 23:40:12 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.184])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7977031729sm10032811a12.25.2026.04.20.23.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:40:11 -0700 (PDT)
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
Subject: [PATCH v2 2/7] cifs: abort open_cached_dir if we don't request leases
Date: Tue, 21 Apr 2026 12:09:50 +0530
Message-ID: <20260421063955.99164-2-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421063955.99164-1-sprasad@microsoft.com>
References: <20260421063955.99164-1-sprasad@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240045-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 46AAF437083
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shyam Prasad N <sprasad@microsoft.com>

It is possible that SMB2_open_init may not set lease context based
on the requested oplock level. This can happen when leases have been
temporarily or permanently disabled. When this happens, we will have
open_cached_dir making an open without lease context and the response
will anyway be rejected by open_cached_dir (thereby forcing a close to
discard this open). That's unnecessary two round-trips to the server.

This change adds a check before making the open request to the server
to make sure that SMB2_open_init did add the expected lease context
to the open in open_cached_dir.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/cached_dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 04bb95091f498..e9917e5204b00 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -286,6 +286,13 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 			    &rqst[0], &oplock, &oparms, utf16_path);
 	if (rc)
 		goto oshr_free;
+
+	if (oplock != SMB2_OPLOCK_LEVEL_II) {
+		rc = -EINVAL;
+		cifs_dbg(FYI, "unexpected oplock level %d for cached directory\n", oplock);
+		goto oshr_free;
+	}
+
 	smb2_set_next_command(tcon, &rqst[0]);
 
 	memset(&qi_iov, 0, sizeof(qi_iov));
-- 
2.43.0


