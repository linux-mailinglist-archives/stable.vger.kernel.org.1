Return-Path: <stable+bounces-235923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMNKIoSR3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 811803E7E58
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F8C930069AB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDFB375ADF;
	Mon, 13 Apr 2026 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="kSHuZJsW"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95F36492D
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062843; cv=none; b=hnyf7acq7oKWDxq1qFfdl0M4Lr43rVAzsja3KtIZN8j410QNAxIIf8Ej7VlIWpdYpzK+555aHZVZr2j7gB81bRucI+okeJo/FR89ddYoAhNaCZc+vK0LvhXJ++IXYaCqc0Y2hzWgzskZgspVQir6chJ50Dxf1WVs9kT7UYG1oIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062843; c=relaxed/simple;
	bh=hbMoCz+s2zqB9peWYmgvyaOIJ1bPh8wlTST8DJNF1ew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYlcf4/Cz220S/IYhw7E0vzZSr8NasEdl3NIqhjkGlXl04ssDcTsgfvT3gyAtnu+rBETfRViQiKWDHRKI07aowpEUknkucN/4bcUmscv0T6jS+R2e+dYOuUHRD/23xngsOJlfaUWpWI26+J62Ho/G1SEWCoo5alHzcFKy/chvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=kSHuZJsW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 33D4B3F213
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062841;
	bh=gQMo3s2CR2kdkyyrh5Nynw2Wn7klzfW2y3f3x+NnXyc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=kSHuZJsW3z+YCtcUoA/p6R83d4XwV/J6i3/4F24CBlrzUYeYXSwnGNd/xzUnBmsU2
	 QiIoYycSXLFF2FaiUy1zo7U1+NEiXqd+Y4+L+x3PnmMq8dbO5L/QKJM64JuePQbY0w
	 kW8SIy5gOzpxfyNc//ZQgqwO5qbD5SrLAYlu+2khq1POCYReTsglQO5PJHpOPR14Fc
	 e72tb7CstWsmXxd4gnCqjHjVSRqIV+URRZmUB2Ppf19YJ3+kWkSGfNu73WbyM6c9EQ
	 daBVS+tmBbuTSE5CvqMv+/uVZy1+t6EJ+0zdpyD/APQEdpId4ziqcgBv8fta05Cq4r
	 sDGFZkuWRFssYmMP+DfG3ZAkg+NtiQVvScP8Xc3menS9/TyAsa9NNys/ZM9zSg+fWv
	 hI30f2BSDHQWIt8EmD/N10zrIGOiFEG8MzVSmfm5c+aBId/VUbXjkMEgOuVytQ6hGl
	 HbGQ0Iav05pQOONT+/jk28NgVu7noIzjHzmgWZ+Z7lyImQJRq+Ox2Yrt5fYBRHLYLg
	 4zYeK8Wnu3Y7eIBEHHvylVQaUDVciYK7hBsPZ3NwEmY2PRu/HozD2Jmyl9fucuVwRg
	 fVnueV2OWAmYepqKP4rvUk07gLPA8JrMwkFBHVn9HIrdvp/TwrM+1QgT8lVSEdg1gF
	 CfNX6pvm5d88kvrxTJaYpdKo=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso7270650a91.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062840; x=1776667640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQMo3s2CR2kdkyyrh5Nynw2Wn7klzfW2y3f3x+NnXyc=;
        b=KeuSE5UyNNQtO7bQat5VQtJdfQiUbU97fK8gNhT/iFF4i8ev3fhjDpKZnD9caCJPwo
         DCqdkcwSAB5OokwEZcUVZG3apa9+VWDG72wVWhEParTF6cNRtnETRUFoU7mwhklv3OK6
         j+d3knb65dgnJnnSjMJsDks/WVwr81v0XXLsnAwOtxE11XWxpWol7hlBUnLEOp0+JyXq
         gyDqTLbfHcsVGviobMADH24QaiVlgYYpzqcDDEuZ7PkvkGkZNHyarggOkkozlvZ8JeIG
         hkivLtZ/9BlMmx3I0rvydj+GRcCuyTQHcScVF3o/8qLxZj7HUpA0gJ2YgYW54ceO9XTI
         PtnQ==
X-Gm-Message-State: AOJu0YzwiqZfbt80nqX6kJIOEyYBK5vgowEdaAN1DVts7Qrr076HdFeW
	7nHqqtTzoNI8ym9/tQNVGcmej7619CwSYcrZzWuFkloISUn88vYEN85FE5XCspouqf2/EnUlpcn
	GRLA8iR7x80mEcWuhAiZMAycUjZkARZamjV8GmBuzVDczCJRLKg25FAyLECCVl7n6httZ3D9CLz
	H+3bbj5A==
X-Gm-Gg: AeBDieu54ZB0YfvOY4oVibBdBdeW8RS/1Bwzw+uYgN6tGLOhPSMjT6yrHUJBgcFCjYm
	Q2wMQ4cAK2tpVdt9EOKmvACBkTIBPV50pPxOxs2jZyWf5PcweTFffHxBcXUnqjFrvQLGZ8a/9wY
	RkDhvAmOBGvkKDREqC3gJdITJHRxhUXetKTBNB/MEs9oj0x3wEl376CMkzTr6wzTlLROFKczal0
	/wYa//2X9JJ/RbrNT7fF4s/ySHn+Zb7HlH0Z2BCEK40Ha33+VLPehUEvSSX/OxqtFpnvozvdrpX
	BfIjMWbBiv7Fb2Ik8qbjJZoyQ2nCCOPOh6L9Ks3RtVTJMRTN575I0fIQq9VNOjmUz128ACcIEyD
	QYsI9xsxaW9Nd0h6OwUAufDONZpQ=
X-Received: by 2002:a17:90b:3ccd:b0:35b:9ab6:1d4b with SMTP id 98e67ed59e1d1-35e42846246mr12652479a91.20.1776062839878;
        Sun, 12 Apr 2026 23:47:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3ccd:b0:35b:9ab6:1d4b with SMTP id 98e67ed59e1d1-35e42846246mr12652467a91.20.1776062839506;
        Sun, 12 Apr 2026 23:47:19 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id 98e67ed59e1d1-35fb595e1fasm1156044a91.3.2026.04.12.23.47.18
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:18 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 02/11] apparmor: fix memory leak in verify_header
Date: Sun, 12 Apr 2026 23:46:27 -0700
Message-ID: <20260413064712.1581137-3-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064712.1581137-1-john.johansen@canonical.com>
References: <20260413064712.1581137-1-john.johansen@canonical.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235923-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:email,canonical.com:mid]
X-Rspamd-Queue-Id: 811803E7E58
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
index 737f23bc7d61..e142fc825ec6 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -976,7 +976,6 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
 {
 	int error = -EPROTONOSUPPORT;
 	const char *name = NULL;
-	*ns = NULL;
 
 	/* get the interface version */
 	if (!unpack_u32(e, &e->version, "version")) {
-- 
2.51.0


