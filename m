Return-Path: <stable+bounces-235936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPi8KEiS3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:50:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A23E7EFC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1F5302AC31
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AF438AC69;
	Mon, 13 Apr 2026 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="OfyBDt5D"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C562D063E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062952; cv=none; b=PYdBd9l/kTHNv23TL28V1k8BPeR1gwLr9F98A+KPW6fJmGmQToUN8lhhM/9gfy90JeMcMYDDF4lKt3RAPsr+ZaTffo70CNYEljBtdkK37x0cD00kzLBXtnF06r/UeyA1J/gkL8LdNchCuAcbfMnGMPkl+hfXp//afad8fxT500c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062952; c=relaxed/simple;
	bh=CXyS5l7S31JHsLhprE+TIGU2SF3b4rx+m/gWIEZswlY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFj9l9lPJHZH4ZBH6TSjNIPdXPqqJPFWpeeGnhe2prjfgJ3wSVaSA+gLzeStxjAkYIDQ2yA7YMC+Js8QgbHyvGMYdqSJ0O2x5alpukFZmX/ReXkhAbkxIbcn0g9fByWu4gxeX6r4nGo1VaT7twhUaMk7GoWZ8/PkMuBuEe79zZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=OfyBDt5D; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2ABE73F1C4
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062584;
	bh=MnJkZXVrde59v/3Te+6R8CQ/x4A02leywcfS/63Aksw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=OfyBDt5D1PfH23RG90IUIYP8QMU/1nPx/PrOVh2qtzTsQAfCJnUf9VV9GzafXwose
	 lhtLN/AuF9axElbEiM4bbTLaw+GGxfcMCvHz+gvsxEnTwHbXZUWKJWPCwksM2jOAHz
	 7xVbtUMNTvu+r/L9gsEX6S3KRQ1acbbpjupf9EHg7rpGjsNl013kEKWdoTDHbB4Sx1
	 NeNFsV4hWAArQ8croFEy0c+LBSuan50m+Ld0uRUDAmmyL18PXHb2XV1GfFxCNjARxW
	 TOnYogdNqJX7rODxG8qTxSnH2lfIabB/4JkVOXp7gOybMdRZDFcQzWz45xG+/DGNCN
	 rpOy/PKmPjwTSztPskGNmpCBoQi/QzDZDmB4Omd7f8jUVt0BS5LHasfc+a+OAGPcmC
	 Nl4sWxLLI52jUIXnj9G/x653y+phNDEGPmgKZuaMurc3f6yWp5T7NbLAZRu48GKe36
	 K7KyjjnNAR8WZ9YaJ8A+0Kzb+rgVzVB7KR8449HEaxlWAJutaCyi7qu9ECQgsUTVoH
	 lYbho/jK3lUSZPnqBNTKJoIns2y0DI1c4Ci99F7O5sA6XEAaSsUG3EW8kAi1dSJdGD
	 rmbTEsUJ5TqKkWO8Mdt6q5ukMPqhUOISwLrzeeQZeacSUsMQMTJM8WQAxUzQGvhvx9
	 a35JUizd2qo/zk39AfxKRnHk=
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b249975139so79244215ad.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062583; x=1776667383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MnJkZXVrde59v/3Te+6R8CQ/x4A02leywcfS/63Aksw=;
        b=d6zVTzP2YNZs+eY+MWbMel4Hn8aQMqjtVK+TRHfIoc71HSUfUJ+dVdXyu7k23kSM0t
         OeCa4Vg0BJTVZwTtZn1iZ6AHCtC5W6SDnfiyI25f6Bwz3hOTbebkZxkUADFtUpIxsKc+
         k7Flr7IMOPDnl90YQSGd6cN2OnUH23x2H6uwyoazypL1KPr6RI9jeDcvH8+lJsZ4OWtg
         nHGpPGMD85s/U145pF3TGjWAZDDsWZXIYP2Tz2GhXO/V4dtnwu5xiKMBJzxTpfIFc6QP
         GRzCbvIqxrc5X//SD+0alUoGaTjMgSVoOREvswXJ3j6V+fpaGsZaClv3ZGoAF3WJ9mxN
         FCHA==
X-Gm-Message-State: AOJu0Yyv+sG3UMM54mmrdeEVFgrE2BuS2UXr3GeF4asQbkHfoy2s9rWi
	BoGoLwg+e+azmVL1NPDTvgI5CEBlPpPtr/6EpmN8vCR6S/yqWP17zfp8avZhmBPC09fM+rFqNfp
	tpilT3mVujtO/f/5QLpHfTLzuxDzP5cwrv4QBNFa3YxCAbUBXrHe5UC2XNrMgIQPORuCttVL8W7
	zYj9/IaQ==
X-Gm-Gg: AeBDietR5P16uKfHjA5kGanATZ0I+2TQbAQr9+lcE3LlirD1SuQdqmVktF8FaEW3Q13
	FrlsTu8l6jh2BLHv8l69VH3CVZ6tIuD+qh/xKNrjfu1VQasxkVi457R4TUrwu5C8QMqdQvmg6XN
	CdG25th3t03UPpxFm7p7BKOvBh97mCt9tUr2wlThHfsv0w+43gcLMu7gL8ks5RgwyXhwXZAn/kw
	lfbgQIYClzBzZe9/OpDL5srh5x+bT468/oaVWHFljZAg7/t6X7ZPLwO4td56rtMnuTetTq4fHxt
	9+I8WJMQwit9UAq6V8z1q4Xf7UWKX6DPruasUoRDg4IfjdBUh80hxJnHyHysRxYxkNJSw889VkC
	Z+Axq5lqAwaiY2tVgqUvkxoMi6jk=
X-Received: by 2002:a17:902:cf0d:b0:2b0:5cb3:e4bc with SMTP id d9443c01a7336-2b2d59ae7cemr120115385ad.16.1776062582823;
        Sun, 12 Apr 2026 23:43:02 -0700 (PDT)
X-Received: by 2002:a17:902:cf0d:b0:2b0:5cb3:e4bc with SMTP id d9443c01a7336-2b2d59ae7cemr120115225ad.16.1776062582413;
        Sun, 12 Apr 2026 23:43:02 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d9443c01a7336-2b2d4e0accbsm100861485ad.33.2026.04.12.23.43.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:43:01 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 02/11] apparmor: fix memory leak in verify_header
Date: Sun, 12 Apr 2026 23:39:11 -0700
Message-ID: <20260413064256.1578919-3-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064256.1578919-1-john.johansen@canonical.com>
References: <20260413064256.1578919-1-john.johansen@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235936-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualys.com:email,canonical.com:dkim,canonical.com:email,canonical.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E0A23E7EFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

commit e38c55d9f834e5b848bfed0f5c586aaf45acb825 upstream.

The function sets `*ns = NULL` on every call, leaking the namespace
string allocated in previous iterations when multiple profiles are
unpacked. This also breaks namespace consistency checking since *ns
is always NULL when the comparison is made.

Remove the incorrect assignment.
The caller (aa_unpack) initializes *ns to NULL once before the loop,
which is sufficient.

Fixes: dd51c8485763 ("apparmor: provide base for multiple profiles to be replaced at once")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/policy_unpack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 1f8628a418da..9e6f3e0d4265 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -959,7 +959,6 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
 {
 	int error = -EPROTONOSUPPORT;
 	const char *name = NULL;
-	*ns = NULL;
 
 	/* get the interface version */
 	if (!aa_unpack_u32(e, &e->version, "version")) {
-- 
2.51.0


