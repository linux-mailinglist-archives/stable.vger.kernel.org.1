Return-Path: <stable+bounces-235927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO/dFIqR3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E06EB3E7E84
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 206C530120F9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A23644D0;
	Mon, 13 Apr 2026 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="LpQUIAls"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C435DA49
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062850; cv=none; b=Jge0u9qDlS7wfaRwHesJdcNZ3t5ytJnlLJMNlYNA9mUiuFok9NeYzK79LSiQp96SzDI40/ID6pc+LDIi24Cz3cT7qlDanc7S6hH2eWgpWr9NbzQGNadQUVs710Rvam4PFBHgSlv9EvG528Y+E9mpzRNCNUDzNyLbRvx2DsyJYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062850; c=relaxed/simple;
	bh=p6UosFiRqD6sFEDs6jCahznpbFna00P+/rlL6Z3ShR4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1lM9j0UMamLvTy7VpnqiAAjupWTkHRiWZ73waysVQ2fncoNyamKhDb6a9zlwyHPjUZ1KX9fffwW15vK9qbTPA8WrZxKT7WF/nhJTqWNkuBgf1VcltrL0ifQ+CSdgHhFErQNjHM7NxwLjuu3ASokh7bghlpoFrCD6QFcpO1m6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=LpQUIAls; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A56843F213
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062847;
	bh=icFo0tU0N3Ryw9hKkjO+hJT8J48lQkdcz2rTPktTYYg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=LpQUIAlspGjAOcS30SbkarT3rvXaKgMMiFyiJZN8B3NAjV5SLdNob8iAmsFKQVN0q
	 AnsJ/mIemZh6ewIzfO6YrdbmEWZTSpMS/tU9ICXayfF0oKh/lFWexiE20J9Gh6nIx6
	 M0WH1teMzvmiWyMPLW++6s5v+LKFoq+eqnvk5dIFw+El21ELsQpMZSwmOmIaLieQJt
	 qR7LqJb1HKwC4Nb4WRXv9fuf3Xn0HSRaUBn6+FGtIoHSjZsjirtz1H4beNJvfdPHG7
	 K9TMWYGzRuJxuynW2Evj6SCXy8oFVydd97zGIeGgMDACqm0NtZneaFZGxIrsSP+ZlV
	 gOAJ0+d8HX7FKIMnwuXXXCnCGbyRpCIFnqDl8+tMZ5K8Al32gseZ6z6iP0P8bpFvG4
	 0ZoSlB3H21pLUY/gsqql8MKk/PspVVt2UA4TN/sKG/YG/fti8n4BfKnWhWVaHLAvPN
	 4T2Req5jPPMVOQoRup1ZbddoWeUPevPtTWCbtNLJny0rRBtNEnkXnwWyGhb4Y0cYZG
	 V14eWCrM5pOg+0Jx5Z0rqV9PlY+QTo7OGwgOOrntHk8HxLQJcIZpEqAS1kdQL0Ty1P
	 hiuDEgFVT3ajmh3NWXveAPfYME6H/qbKQ8AO/BLDZKz/gIEBnGmZ4pDXA15271QPLI
	 sdqdKqjnsgDZzJAymOb+QRek=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24e9b4d82so32298665ad.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062846; x=1776667646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=icFo0tU0N3Ryw9hKkjO+hJT8J48lQkdcz2rTPktTYYg=;
        b=gN9WT1f7fWIOMO+ng5UExAzNCZWO8roLAQRJyRh9usvEmLgUTG5MA99Q2px0FNI2uK
         9OOnbN/ynZ9yKB1fKTsKlAsvV4Ek0APRHlmYAvSwysog1sADgXh6Ohnc8y8mXzyWyXKc
         HPqpMIlOMZrEucRRMCAFDJ9HFUA+cqzTm7h10f2OyEX/VkX1hFcR0oWBPij4Hj8YPM1A
         cm5yhV2URZSnWPDhQ9YI8ZyFbOfLPsaEFUosa2g6jo4oU+MN4AUW952gQHhzanL495WH
         +qcjJwrvyBHTdo4/rn0osIo2c0vXxVSDAkhjC5RSvKH2r+XlYVoakQbMRBUR1zvhDOfD
         K/mw==
X-Gm-Message-State: AOJu0YxKkuDyxkqkNtG37jKieimZSXrU+VdHvkukVaQ3twMccJOWmTtW
	g0yfXRz0tz4wmf7lJuNpw43J3264NkiMmHeU0qtwSm5butNbC3HStJCeGNzkyZHvoeSSEgp5LP7
	KHv0Z6E5boAOYQgLa80xSB92uVNLYKAx0KlkN7WeJep5Qbb0n7gCnpqE5KGDRs0VE3JBpSD9v4r
	h3XbXpLA==
X-Gm-Gg: AeBDievlB0bdvZuRPqzWCxPfrFNTfcPkRrcZJ1k/henDAODGcZ15csiJuQVaEmmkW4X
	ZH6RsI/dZFqPSnYRuRZKE5mDbGqMnjYir/lax9zDlzrNuxMQjlGInb0euxPRn9ML8HHAPJq1VNi
	70U9hcItVu5mLb9ugeXiqOwgp+Azp+717GEzCXYqEfKmMltaz1qwLagZ5vlJbL+D7bAHoQqpuGU
	PQDHnwB2e+941bIonBfd2nSfE4KiP75jn/0cPNifDjqEI4VGNRAp2N/2/AcjvtlhSjSgS4xx+xL
	hLGw/SZ7VtxotDyjuzOL5GZ0auMmkqei2vBMLDklf59ZJGgPLKiZ1I24tJ+SCXvuUTFgcw8Hb8V
	HNOepa9bRGpSmDoR+MOLSMW3mMrA=
X-Received: by 2002:a17:903:38c4:b0:2b2:4f43:b49a with SMTP id d9443c01a7336-2b2d5d8ab1bmr112534135ad.22.1776062846378;
        Sun, 12 Apr 2026 23:47:26 -0700 (PDT)
X-Received: by 2002:a17:903:38c4:b0:2b2:4f43:b49a with SMTP id d9443c01a7336-2b2d5d8ab1bmr112534005ad.22.1776062846050;
        Sun, 12 Apr 2026 23:47:26 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d9443c01a7336-2b315c0b5d9sm40384685ad.11.2026.04.12.23.47.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:25 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 07/11] apparmor: Fix double free of ns_name in aa_replace_profiles()
Date: Sun, 12 Apr 2026 23:46:32 -0700
Message-ID: <20260413064712.1581137-8-john.johansen@canonical.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235927-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E06EB3E7E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 5df0c44e8f5f619d3beb871207aded7c78414502 upstream.

if ns_name is NULL after
1071         error = aa_unpack(udata, &lh, &ns_name);

and if ent->ns_name contains an ns_name in
1089                 } else if (ent->ns_name) {

then ns_name is assigned the ent->ns_name
1095                         ns_name = ent->ns_name;

however ent->ns_name is freed at
1262                 aa_load_ent_free(ent);

and then again when freeing ns_name at
1270         kfree(ns_name);

Fix this by NULLing out ent->ns_name after it is transferred to ns_name

Fixes: 145a0ef21c8e9 ("apparmor: fix blob compression when ns is forced on a policy load
")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 6130811edb94..40a2fc50eea1 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -917,6 +917,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 				goto fail;
 			}
 			ns_name = ent->ns_name;
+			ent->ns_name = NULL;
 		} else
 			count++;
 	}
-- 
2.51.0


