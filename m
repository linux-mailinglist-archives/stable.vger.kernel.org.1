Return-Path: <stable+bounces-273121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /AEZB9NZUGrOxAIAu9opvQ
	(envelope-from <stable+bounces-273121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 04:32:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A081C736B3A
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 04:32:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LjCNbVuP;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273121-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273121-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFB2F303451A
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 02:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D352D3A7C;
	Fri, 10 Jul 2026 02:31:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D538DD3
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:31:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650708; cv=none; b=W2HO4lsjqj3wELoXLiop9cEf+Xq0coMvcXF48/59S5Xb4ybbOpxQ3XWwswsTAHsk/kaRX+O+BaBcyl3nggH6rINlErE6he6fT+bVwzXOsiUZJgCVvf0hJjBKW58w3b8ciJcQjtIlc8/DxDESEd6aWcXpSmN+EwRl2wvFhX0Uuq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650708; c=relaxed/simple;
	bh=DLEOYtg6pX0wN99muAS2Kb4y9kiaFJu7o0A8KQC2IM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mb2x3zZcDdavvC71+iTqKyXbX5KAyIErGmPZkusCzWBdYvAX/e3JFFXIP7DC0FzTtuayodDnHaAyE+tKdgW+hYPUWK9RvWU56MokfwFUyy1kFkSj91yxa0ZvDiKsXQsnK7251rU+XsI2StvHlrIV9qSBoW4GKUUmzvUVf6QGBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjCNbVuP; arc=none smtp.client-ip=209.85.219.54
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f29ec73064so3747826d6.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650707; x=1784255507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RkQ/1bstQnfaorhe+sz7JlhppZT7UEc9rxWGwXZ/Tpk=;
        b=LjCNbVuPjiXQke3mtFvy4TMIbYZgebAqzUvCQ0lGh66lLV7NXvdew2XEqsyIHg14zk
         qBPgwMUSOIPH6GHXqMczzaD+RznCRWrt2fsnkDgNrYma8T7pqzta0dYg4Ku7hLX1TeaE
         9dwiVY4ujKeRdHDLndPLL/mBO2pjGM6cAV4BSo2Ffkp5nq4VzTG+c35ueZAFtrBHq3UK
         guTtmgcW7ntPuRc84RyNtjxPY5ilu91cwclTE5pzS04819cjToYt/GZX0ymHJjJEaIBC
         7io/NBd9pImKdHVUooZUqpWU6lZ4DW/wflP9zpka7gRJj90G/qGPQna/fkKXOyC+pZZx
         kCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650707; x=1784255507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RkQ/1bstQnfaorhe+sz7JlhppZT7UEc9rxWGwXZ/Tpk=;
        b=J1rdj8AMThoJLP3e+ICD33paW9OwhmmkK2FzZDGJ+379N2mqdaEakeR5Wl8uNJSOBk
         Q1LNFNbUKLEUXKltFx3eknxBAIZIswClUlsO489/a3b2RIyqEKTX050rI4K2LuLjwiNR
         4Zg+sAlobzH/1vXeV3+YovOPhh7jp2LP3GqlaywXdDJ18DqLvKfurfmvSqdjbJUbye5I
         DyRnc2YcJlE1kS2nfslfq3niBALoB1J5BLL/upiKwjtT1/1LeMKO38tN+HnE+j3owplL
         3fWUOKRXr8Sto9v3qtvES9FJkgckJGD9RsRPBs9xjlcAvgh8OM+HdFVGoGGT1nwweCjc
         gVPg==
X-Gm-Message-State: AOJu0YxM3qf8cof/Cd8KoSM5vCmhk9+bJxaVmq+kpaDAH1H+GumrlXoA
	Vjfvd+ouy4p0DZ7EZucWLby95eARTkXELsOC9d+k3vYnm7rdAU6ITHuDLY3Y8zhlJtc=
X-Gm-Gg: AfdE7cnSxqtBoG9kTmaLc5WOovAfHx11iS2rlJ7eZ7gQ4dFosYImkTK38HOTK0IJRpa
	LF90TSlo5uiPGwcawtKyIx+SR/W6uqwhSYi0AYzWlcoLIi0v3uixGPgK5Xd3rG6LGyHovkQKqIg
	LneFjSXOK1lYC1rzYMG0JiDqMhRP5piQZQK1SCoxqAV9wZL+Jt5XS/hQZQQghFAvgLv/GgcrQop
	G2naCSIjQshJjUpGHmguTqhzNnSHU4aSRumuNLqHjTTDARY/BAdoMuKA2AbuHSCP7y+k1hlDmTt
	dvRlEt771sEZmm7Q24zqj6jJD5+0sKuvncM5MtDBJ6scECLOy8S0rnIpLlqsBjYBY1u0RcMIDuD
	NmS+aRfMTFk/92Lpad4uTxnsVe7EckSIObFiQ44jmPhJAFgUbI9B+4CZQzi2CxC/G/3/C37wU4R
	WU4zt6Fw/bZo0zIRt0YoGGW6pOIy41guCQk4R0UotAe+oN+aNvnO5aqb+DaKyQGgkHv87LEUNOb
	iYg9gPmgJwOuW5dBwJ8kva+oWQsE0T6dS8gBrBpDuc=
X-Received: by 2002:a05:620a:4614:b0:92b:67e6:4b6b with SMTP id af79cd13be357-92ecf6114e1mr1024252085a.66.1783650706639;
        Thu, 09 Jul 2026 19:31:46 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d5fc4dsm89983185a.40.2026.07.09.19.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:31:45 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Please consider 83f99de1b7c0 ("ext2: fix race between setxattr and write back") for 5.10.y, 5.15.y, and 6.1.y
Date: Thu,  9 Jul 2026 22:31:42 -0400
Message-ID: <20260710023142.3748810-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273121-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A081C736B3A

Please consider the following already-mainlined fix for the stable
series listed below.

Upstream commit: 83f99de1b7c0dcfa42b211e5e40334b7ad786b36
Subject: ext2: fix race between setxattr and write back

This is a stable option-2 request for an already-mainlined fix. The
patch fixes a security-relevant bug pattern that remains present in the
listed stable branches in my current review.

Why this belongs in stable:
ext2_xattr_set2 allocates a block via the reservation window
concurrently with writeback (ext2_get_blocks), tripping rsv_window_dump
BUG() in ext2_try_to_allocate_with_rsv (panic/DoS); fix absent in the
checked stable branches and the unguarded reservation path plus
reservation-using xattr allocation are still present there.

Requested stable series:
- 5.10.y
- 5.15.y
- 6.1.y

Fresh stable check (2026-07-08):
- 5.10.y: 738ac465e4e9
  fix shape: absent; upstream diff: needs-adjustment
- 5.15.y: c86c4726e7f0
  fix shape: absent; upstream diff: needs-adjustment
- 6.1.y: 090666d3cc90
  fix shape: absent; upstream diff: needs-adjustment
- 6.6.y and newer checked longterms already have the fixed shape

The source-shape check looked for both the EXT2_ALLOC_NORESERVE xattr
allocation call and the matching reservation guard in fs/ext2/balloc.c.
Those are absent in the requested branches and present in the checked
6.6.y, 6.12.y, and 6.18.y branches.

Backport note:
The mechanical check above reports whether the upstream diff applies to
each listed branch as-is. Branches marked needs-adjustment may need an
equivalent stable backport rather than a straight cherry-pick.
The current upstream diff fails in fs/ext2/xattr.c at the same hunk on
5.10.y, 5.15.y, and 6.1.y, so an adjusted backport is expected for all
three requested series.

Impact: a local user with write access to an already-mounted writable
ext2 filesystem with user xattrs enabled can trigger a kernel BUG/oops
through user.* xattr churn and writeback pressure. I do not have evidence
for privilege escalation, code execution, or confidentiality/integrity
impact; this is an availability issue. My current CVSS 3.1 estimate for
that mounted-ext2 scope is 5.5.

Direct-tracking exposure in my current review includes Debian 11,
Debian 12, Amazon Linux 2023, and Android 13/14/15 GKI. Vendor trees
that do not directly track the above stable branches need separate
per-tree checks.

Primary touched files: fs/ext2/balloc.c, fs/ext2/xattr.c

No reproducer is included in this public stable request. I can provide
additional details privately if needed.

