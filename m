Return-Path: <stable+bounces-238665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJZ0OY5H5WnPgQEAu9opvQ
	(envelope-from <stable+bounces-238665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:22:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2EE425898
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6257300B546
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D4730EF84;
	Sun, 19 Apr 2026 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvKoPMlO"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D32F39C2
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776633738; cv=none; b=Pez8ZYqS4NYl+o563kYvo3Nkf9nwjZYUexSTXMYnPZAVnnzyt6QQxxCoFwPgfdSVxcCCHFRX2IDgoelZo0tXDYQqH5F0m/sDGTCAw/k7Gd75HXxkq4jQzdAdKVR/7Msu08jUZYguk5KwoiuhHEp/5i1eQn5fefV8yrBLMOe5oKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776633738; c=relaxed/simple;
	bh=8bXWAUwuXeHpNnD3ARKgWX+5UoBQj6FtEd1TUTI+88U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhy+29XBWE5hyKFrloiuncZcs8fNkC6lG3vBBjvazY91xMgZsTMGcJW4nSZziELxqiFVg45wBY72XJXUabfUDSoeL2uu7haPgCJysGDg6ibW6krONz7iPhe0zr63gOguPJtPwL5Ozpny8Xlo4F5YjsQ3CIV4SHOgJl7DoPR2/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvKoPMlO; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d424af6282so257475185a.0
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776633736; x=1777238536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgjr9000CxEsC1rRZgD66eWlAXXvm6i1E9C0yOGBCjc=;
        b=kvKoPMlOq0FxaF4Qz+PxUC41kJKOfrGEYO+vtH9oVeyo3fRqfJbEVjmnwGYZQ92WyW
         GHF8XHkC3LOGCx0vdeuYwWj9WTkIDnEg4SEPeWX1JCtXtICEAxJ9Qslnvmz949PdmrVl
         lVu179JZyZtWLnM/RMQFZbHMSaMJBhxmXnK01+KSxLaeEA9nogOwc6EsDcmSCbzyxvH8
         SwlajIGxieouBbmC3Oocj/n/u+3zcdIwHUBDLjC1RMy/GzK8dFXrGYOx6+Mwl28nsJ51
         UZ4AdNsbWaUoMfnpiDJzI9CJHMmrztXHYwDq5oT9LnEQILBkiMEZTyEeU8AgL9It9bWJ
         Q5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776633736; x=1777238536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lgjr9000CxEsC1rRZgD66eWlAXXvm6i1E9C0yOGBCjc=;
        b=WX1VuTirKsiS5F0D9SFWJ1pmXGaLG/6N7YfA/eK2OAyv/t2UhPaoUgpxCXVdOI7Xt3
         JDvFbFcIZdupOjNjxjBSGb/VrII9RK+Dpn/FfIqc91xLeLborFqiao6QZ5QxkmCIcN9q
         +IYYfFc7Opi9cCGkeNdnHduMADKHZ/ckHZ4fOB21ppxkkFYNyYOTKC6Ely/bkehWWED3
         RvpFRh8HoeCfWv/ufzBk7So5st1QwM+EbSNebjgJhNietHUcA1H1742HtcvogYBoqCbi
         33u3OmWghuobFwNNQObMr29GkTbSP7AKepBaS736gFXoqz7LkaBtdKlGIX3p7ECIIqur
         6uEg==
X-Forwarded-Encrypted: i=1; AFNElJ8BoaOwCKn1oQ6l0JLy+F7spZeJvnY2bQWKVSrnXdBHPMyZ7T2Io7AGkiJZMicWiQRfvKNPtMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGZDAdwkzBDO/lZM+oteSGYHhTuV6Djv1jfkKycyvjSoB/AOC
	IEXvlIj4qsandAgvwtpOXoZ9bFJZz3XYn7C6hcw4EHeUp00brK1XHN4R
X-Gm-Gg: AeBDietMsA41KUZQ93h6NE/BiTtLVpjnA2VTS6yMGnoDvvI6XwxofWyMiGPCfSFJGqB
	6e/sQpt0LaOvAOeACgpnzqRGyDIQT924IxplXwR1wcKfwbiBNyn7UMAwjkZqHvgxqh1vPQc/2Il
	WRSTIBcPzq/v26UdCrwC4w+wg0Rj5MWjDidGZKBobdd5Uq6VwxrRPgFVAvRFGMKdMY69obMu/IA
	pX7XlJyaWSNWCkHVwJTUrI/NINT/jeiA+z4+2qqhCPOJ3t7blyBfUpQy53jDxTQst9gqLsBpiPx
	1zZ99qPYMF2eIYHPqBVUjzCtZrUPtKNaMZokQmHHOYHij8YO6RwGiQVOmXPkPqYKI88eBufzaaK
	hZqy14YQlkNgM3cxLk7z2IUce7h7jVucB1FqdCyUgaSX/ttKNJBbNxTMdKt7UO+rg+nk5empk5P
	7hTY52Zq+fwEJEomi3BoFHOL2RsZbz4lIVxDrcVhMgmsFpPLwTmNUmHLJhwlzHZPlZiJzJUGh7m
	H7aT8nqbszfn+jlx6G+MeP0fu6Zjhwt0M6D7AdVrg==
X-Received: by 2002:a05:620a:4489:b0:8dc:5094:ea79 with SMTP id af79cd13be357-8e79189e3c1mr1524677385a.39.1776633735681;
        Sun, 19 Apr 2026 14:22:15 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d65c1321sm654849185a.15.2026.04.19.14.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:22:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Edward Adam Davis <eadavis@qq.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] isofs: validate Rock Ridge CE continuation extent against volume size
Date: Sun, 19 Apr 2026 17:21:54 -0400
Message-ID: <20260419212155.2169382-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419212155.2169382-1-michael.bommarito@gmail.com>
References: <20260419212155.2169382-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238665-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[qq.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F2EE425898
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rock_continue() reads rs->cont_extent verbatim from the Rock Ridge CE
record and passes it to sb_bread() without checking that the block
number is within the mounted ISO 9660 volume.  commit e595447e177b
("[PATCH] rock.c: handle corrupted directories") added cont_offset
and cont_size rejection for the CE continuation but did not validate
the extent block number itself.  commit f54e18f1b831 ("isofs: Fix
infinite looping over CE entries") later capped the CE chain length
at RR_MAX_CE_ENTRIES = 32 but again left the block number unchecked.

With a crafted ISO mounted via udisks2 (desktop optical auto-mount)
or via CAP_SYS_ADMIN mount, rs->cont_extent can therefore point at
an out-of-range block or at blocks belonging to an adjacent
filesystem on the same block device.  sb_bread() on an out-of-range
block returns NULL cleanly via the block layer EIO path, so there
is no memory-safety violation.  For in-range reads of adjacent-
filesystem data, the CE buffer is parsed as Rock Ridge records and
only the text of SL sub-records reaches userspace through
readlink(), which makes the info-leak channel narrow and difficult
to exploit; still, rejecting the malformed CE outright matches the
rejection shape already present in the same function for
cont_offset and cont_size.

Add an ISOFS_SB(sb)->s_nzones bounds check to rock_continue() next
to the existing offset/size rejection, printing the same
corrupted-directory-entry notice.

Fixes: f54e18f1b831 ("isofs: Fix infinite looping over CE entries")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/isofs/rock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 6fe6dbd0c740..1232fab59a4e 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -101,6 +101,15 @@ static int rock_continue(struct rock_state *rs)
 		goto out;
 	}
 
+	if ((unsigned)rs->cont_extent >= ISOFS_SB(rs->inode->i_sb)->s_nzones) {
+		printk(KERN_NOTICE "rock: corrupted directory entry. "
+			"extent=%u out of volume (nzones=%lu)\n",
+			(unsigned)rs->cont_extent,
+			ISOFS_SB(rs->inode->i_sb)->s_nzones);
+		ret = -EIO;
+		goto out;
+	}
+
 	if (rs->cont_extent) {
 		struct buffer_head *bh;
 
-- 
2.53.0


