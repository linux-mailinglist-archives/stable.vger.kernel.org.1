Return-Path: <stable+bounces-262806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pcZgBTgoK2ph3QMAu9opvQ
	(envelope-from <stable+bounces-262806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 23:27:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8421B6756FD
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 23:27:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openai.com header.s=google header.b=A8Fl0Gc2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262806-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262806-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=openai.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B2D930BEBF8
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7337F726;
	Thu, 11 Jun 2026 21:27:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458919CD1D
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 21:27:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213237; cv=none; b=aTdAMpMAH5kj2X72i9ghu6Kspu0yMP/pf0haEAe/kRlL+J0EEpOgseeyaUncJktYOUKB18eJJtwpaG2KLpn7MaFpoZaA8OMKzK58CH7xoWcPmsd4Wav8J2b5+U6ihwTkYmDlgGvBecTkVFA9j+aQ4pKegHBkVbhHI4x6U1IpNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213237; c=relaxed/simple;
	bh=C6j3x5WYRRV6ciwLPPZ8nA7aPINWU6dJHmIiSTjVJHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joT1uUNIjvQUZqs5WKJTMLjrfdKS4caD3gGRlOfK1Ow63VJVpMgeNjUOzRL7+cYaVlb8SZAgOqjVTlHypyUN9/JTxM491rNqIoQUgzgVo5o3dNSyg7bPLvXaAcVDlZBRg0v7msWkK9tf1ScorvqV2e2vU08FI1LvOUUEkbnsAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=A8Fl0Gc2; arc=none smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176465a4a4so2723691cf.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781213235; x=1781818035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2uVyCKJxMa4TJzaUAXJP9RjvhqBIOc1qSJCsvifbc2k=;
        b=A8Fl0Gc2rkMygUOSVpZyDvRwtdDAD4T8fIsjjP5oMeZxHy+W6BfmQ+xKorHOsOLdKJ
         T8dGTYUyItRQGLnMAPcXVTepU5KpsZlusYV9Y1CfCg6XdjM+fyTn8uh8cMXtZyhTikYK
         MAnSxUKifk/uq/r7ea1ic+9p6y9RBci3WQFQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213235; x=1781818035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uVyCKJxMa4TJzaUAXJP9RjvhqBIOc1qSJCsvifbc2k=;
        b=eGJEp9BXKJcDDxe2rt8NU99l496DeOCDU2VM5W/T6tSeI1oUvCI/h5+kARQuKX+3mG
         hMe1IE+pgm7PPt92AtEj7tq1rVlEOw3zLAqlTH9rSaLwyXN1hdDtRVakoNerJGtV8CJI
         PU+IlffKak1Lhb6I6zXjKAvdE898XSmLNK4zxfok+2cu4cNIbG1eqC/33TnDRmf5Xwo4
         Mrh5lnDk7om8cRYp3Izi2nmqsJb1vCo3JlkGq7rbi0BnnXn/4PglTVgvvgzJ5ysSQedi
         GkQfKQA+cafHxSthvP30zCOZ2No3hAX5O1RSGkUkGP2uWWWaJEINNjt31liENFUaIPey
         T47g==
X-Forwarded-Encrypted: i=1; AFNElJ+Xv2ZF4jYonBXmI1wwnDBM6kRps4p3QjeaDBR4eBRgxwbuBbHstaL7SuVv6QpU69di0sAvM5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfS4xp86M1K/E/tHenQ3nz5I23IW3svD+TyQgocAFKCojRKdem
	+3yb3WbnsXFHMXGLFeEp0Wyu9/R5BfmcTjSc2Q6w9Ca9tN3ZZfUqUstRLzvAsMEYDiE=
X-Gm-Gg: Acq92OEkF/OLZAr+X6LH1ZPVy4Jc6m+GR6MX5jltsdOGzXn9IBTjVwvwCe3xOoSe19+
	P+DzA8STPjXEwdav+s6bytKog732cdpo9Dm6lEzYGBLSeOBqbJJHszs1Ou6Es+PgLA4EKwcULMB
	WOvhbArDFazd0BvpG65RO+U1jtC+55vnQneC+hgxm0/QQ23XckdxwWGE9q/zcQWGv5ff2uKpDxl
	nw9FoSZVTuGsOo6bfmaJqZskcN6WMQ/RvrVKxiS8V0GX2LqzCQZpSf6h89DKVSDQ8OU5OE1krr+
	gS/5pRyP74JfutKoB0+sgzkfl1jPwDLgkmIYPDNnYs5fhtIQuTq6QbIrfL9szMwCf+S3IJbWMsO
	XBZlH+JcQ0SD1KiP0jimh1gqZD6glQquOWAsTCUG9ER+r5G4jRbZJDk4wCENekGAwqfQaohyu+D
	6zOa/2UbP3f8mw+sWfsW5P5t2xbaigOuSbCMOhZSD6AmZWrvAFjGTdjpNBhQ6JyKhCob/thUwr4
	4AEbuiGFJgoX+OT5OdOI0DyK3KpaQ2LL1QjmXppW9lfxQ==
X-Received: by 2002:a05:622a:4a0a:b0:50d:6b06:a453 with SMTP id d75a77b69052e-517ede809c0mr72346601cf.18.1781213235116;
        Thu, 11 Jun 2026 14:27:15 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7ec47asm3717861cf.24.2026.06.11.14.27.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:27:14 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] hfsplus: terminate xattr names before listing them
Date: Thu, 11 Jun 2026 14:27:10 -0700
Message-ID: <20260611212710.5134-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[openai.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-fsdevel@vger.kernel.org,m:frank.li@vivo.com,m:slava@dubeyko.com,m:glaubitz@physik.fu-berlin.de,m:outbounddisclosures@openai.com,m:kylebot@openai.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[kylebot@openai.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262806-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[kylebot@openai.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[openai.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:dkim,openai.com:email,openai.com:mid,openai.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8421B6756FD

hfsplus_uni2asc_xattr_str() returns the converted byte count but does not
append a trailing NUL. hfsplus_listxattr() then passes the reusable
conversion buffer to string helpers such as can_list(), name_len(), and
copy_name().

If a shorter converted xattr name follows a longer one, stale bytes after
the new byte count can make strscpy() fail with -E2BIG. The caller adds
copy_name()'s return value to the running output offset, so a negative
return can move the next write before the listxattr buffer.

Explicitly terminate the converted name at the returned byte count before
treating it as a C string.

Fixes: 127e5f5ae51ef ("hfsplus: rework functionality of getting, setting and deleting of extended attributes")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/hfsplus/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 452a1f9becb2..35fcbc397b62 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -870,6 +870,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			res = -EIO;
 			goto end_listxattr;
 		}
+		strbuf[xattr_name_len] = '\0';
 
 		if (!buffer || !size) {
 			if (can_list(strbuf))
-- 
2.54.0


