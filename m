Return-Path: <stable+bounces-241863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PKKKZ/j8WlZlAEAu9opvQ
	(envelope-from <stable+bounces-241863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:55:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA204933CE
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76EEE307B4E4
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119053EF0BA;
	Wed, 29 Apr 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSQ2X7HY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885722689C
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459800; cv=none; b=jBNOJnu4ajBi7xbxKLqt0ETXilEK2h64pG3QH7kvtVqNEOvqTd/HEpx/UWsrGyptC0hQeEwSBq60E2+i/HrZQVr7Kww81NcrqWs3wjVUr51B0kxQPUi5ATbUSCQ6AFRh1hhPrzRCuPnV5e/aMlyNcaY5TjXSwFn/Gn2tsXQU2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459800; c=relaxed/simple;
	bh=N/5fqb+aB65lsYDsWjoyUnZ02f4BDSqEloFWitAhkp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/Ww09S/OF6pPU3BZ+UyKZ4znBbM05XRCzFWSHLMNm7xpt4Yh63ToXBXww/U7fQYyqOjEa2ioDjq2W5Y7LhxQJNb0nfNFiNmD0MiOJ+rIA+i8j0BykMxAmznwkF/H7rJ2NX2Fu6D4hyUQQYkDIzEDwgPmpsxErrYPetWU/gz8XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSQ2X7HY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so106785745e9.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777459798; x=1778064598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2FyOVAEfkWXswNoEp5C3P/ITYDExEy6ZhNuNWoNGPE=;
        b=QSQ2X7HY8kMb4+n9kTdtd6/TJiA+1SF0Cr7Pha/johrXZKZObVcBr3W6pKiSZKTzR7
         5u9y56BrKRnt3mKV4GjLZ4kcPsckZYXWM/f0Ughigm3fbil3X0758goRgLZk9n3t3mj9
         eoeZuVrNiU4GcXZ/j6+2KDfjcVjfPaH9V0L2iRoOvwAD8RTPEAjM5qzJXeQmF5KwWur5
         gyd+JS3qYkooRIX/0UQkC1BXCnmebyUPPO4pEEEcnZMjFARyuDqFmhq13gIvJGWWnQEA
         lRz5KhEKDZ0Bg6y4tmlX3j1Wkgo6mYuFgpbSk5iEQ+I1zT2OsEDAdEybb76Z6BfSmd68
         5Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777459798; x=1778064598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2FyOVAEfkWXswNoEp5C3P/ITYDExEy6ZhNuNWoNGPE=;
        b=QFbRm2oI2UG6j6E9e/M2c0RPQm25uuHuH3nVfuIgVxpKJnKLTEqE2XNGi/S6Xvb1bf
         PTei6/Ck+37+aRit/rm3ZqWYrO7BnORDahjxTGVr2DKtoI3E5VXJ4mCTalYc/b+czh5Z
         rPJLI2PgV9n9Png0X/bU1kgJsLeRx7XkWGk4U9Nay5dvGSxWU132gm1v/DE9J2gzOPfo
         DEYEWncH5OaTjadNMEzimMCJsb84MM/z+YYP4QhHN5FA22MFrxG+0G0RrvVf/2imsSXF
         Qukf82dA79KZS4GxXcslxvwISts6wPDUkiA3harSQAI3J7caZbDoNcaEHKUNRvBS9hqH
         ugJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vzWJJtiaDW7N/GJr6C3Yp2oyg/vIihxPwOfzx0WCmbE2QKjH+DR6VbRmeYVnmCJ48sIrEfl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRciKBQ/VVWK73V6HTARVjiyTZQTsPe7CJ0MJt9zYXJL3yJy/
	qG/uO1YuChylzqwbrPLMmoEuND1AUjjhy15vHeRve3MaVf9v/VZfomKf
X-Gm-Gg: AeBDievyzy9FUEamQWlY98rHhxeAzeMNZ2nCZo3gtZjISJbrovBdtQY80rm1EVcyYAC
	GjXN8NvhebZjePmPcBhZ1GFrvLGhUae967dbEJWpzRQNMDOKY8ZDiwp0TDeGWrGax9hHnA8BYFi
	tNjhX4VzNBwxDfgicLSB4B1QONrCsABd2wDy7OZ38/fgbP3Ji9efWFY0UkwlKBF1iA9Sn3O9tzy
	TUCA/Tw5at9BktneFwkAt4MTCKNd4x+AlCiv7JLaUZhwOnCLiNo2wtKHuiR1C1XSfccaIak/Qa5
	TzzvrlRgMdllHV9DofXhdGPIYCF79tI+vQFYWt6nM6+V7/KHEmQsgm79rHIkFRdrJX4sKv/2NDu
	gGXOAVF/oeILQHWaEPmJAkdXUXb4xOA0r5e1ohjyLNxl2exTx9ThXMIk5DqWvKHX07y1ALcj+pI
	YgYzrxmHKZDfsDp9vOFTyibjrK3s4vyzo/qCZDAFrjbCqfI9vymgoVNzNAI6EJ1P4YQxyFQYAkT
	RT/IyJt
X-Received: by 2002:a05:600c:859a:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48a7b5125f3mr40682595e9.5.1777459797446;
        Wed, 29 Apr 2026 03:49:57 -0700 (PDT)
Received: from igorovo6 (185-203-47-240.static.vlasimnet.net. [185.203.47.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b8c2dd7sm37481365e9.0.2026.04.29.03.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:49:57 -0700 (PDT)
From: Igor Raits <igor.raits@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	=?UTF-8?q?Jan=20=C4=8C=C3=ADpa?= <jan.cipa@gooddata.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] NFSv4: clear exception state on successful mkdir retry
Date: Wed, 29 Apr 2026 12:49:38 +0200
Message-ID: <20260429104938.1776671-1-igor.raits@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <177745671692.1474915.5018486129724109553@noble.neil.brown.name>
References: <177745671692.1474915.5018486129724109553@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CA204933CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-241863-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igorraits@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gooddata.com:email]

After a server returns NFS4ERR_DELAY for an NFSv4 CREATE issued by
mkdir(2), the client correctly waits and retries.  When the retry
succeeds, however, mkdir(2) can still surface -EEXIST to userspace
even though the directory was just created on the server.

Reproducer (random 16-hex names so collisions are not the cause)
against an in-kernel Linux nfsd; reproduces under both NFSv4.0 and
NFSv4.2:

  N=2000000; base=/var/gdc/export
  for ((i=1; i<=N; i++)); do
      d=$base/$(openssl rand -hex 8)
      mkdir "$d" 2>/dev/null || echo "$(date +%T) failed loop=$i $d"
      rmdir "$d" 2>/dev/null
  done

Failures cluster at the cadence at which the server-side auth/export
cache refresh path causes nfsd to return NFS4ERR_DELAY for CREATE.

A wire trace of one failure (the three CREATE RPCs all come from a
single mkdir(2), generated by the do-while in nfs4_proc_mkdir()):

  client -> server  CREATE name=...  -> NFS4ERR_DELAY
  ~100 ms later
  client -> server  CREATE name=...  -> NFS4_OK         (dir created)
  ~80 us later
  client -> server  CREATE name=...  -> NFS4ERR_EXIST   (correct)

Since commit dd862da61e91 ("nfs: fix incorrect handling of large-number
NFS errors in nfs4_do_mkdir()"), nfs4_handle_exception() is called only
when _nfs4_proc_mkdir() returned an error.  That gate breaks retry-state
hygiene: nfs4_do_handle_exception() resets exception.{delay,recovering,
retry} to 0 on entry, so calling it on success is what previously
cleared the retry flag set by the preceding NFS4ERR_DELAY iteration.
With the gate in place, exception.retry stays at 1 after the successful
retry, the loop runs once more, and the resulting CREATE for an
already-created name yields NFS4ERR_EXIST -> -EEXIST to userspace.

Drop the conditional and call nfs4_handle_exception() unconditionally,
matching every other do-while in fs/nfs/nfs4proc.c (nfs4_proc_symlink(),
nfs4_proc_link(), etc.).  The dentry/status separation introduced by
that commit is preserved.

Fixes: dd862da61e91 ("nfs: fix incorrect handling of large-number NFS errors in nfs4_do_mkdir()")
Reported-and-tested-by: Jan Čípa <jan.cipa@gooddata.com>
Closes: https://lore.kernel.org/linux-nfs/CA+9S74hSp_tJu2Ffe2BPNC2T25gfkhgjjDkdgSsF5c2rnJq_wA@mail.gmail.com/
Reviewed-by: NeilBrown <neil@brown.name>
Cc: stable@vger.kernel.org
Signed-off-by: Igor Raits <igor.raits@gmail.com>
---
 fs/nfs/nfs4proc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a0885ae55abc..ffd14141ea1d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5393,10 +5393,9 @@ static struct dentry *nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
 	do {
 		alias = _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
 		trace_nfs4_mkdir(dir, &dentry->d_name, err);
+		err = nfs4_handle_exception(NFS_SERVER(dir), err, &exception);
 		if (err)
-			alias = ERR_PTR(nfs4_handle_exception(NFS_SERVER(dir),
-							      err,
-							      &exception));
+			alias = ERR_PTR(err);
 	} while (exception.retry);
 	nfs4_label_release_security(label);
 
-- 
2.53.0


