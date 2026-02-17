Return-Path: <stable+bounces-216871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJq/L+6ulGk2GgIAu9opvQ
	(envelope-from <stable+bounces-216871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:09:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D4314EEE4
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051D33047BED
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB57936E497;
	Tue, 17 Feb 2026 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=celes.in header.i=@celes.in header.b="a2UJaXAX"
X-Original-To: stable@vger.kernel.org
Received: from a4i680.smtp2go.com (a4i680.smtp2go.com [158.120.82.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885D32BD031
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.82.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351775; cv=none; b=krKCVQUcdWgqGQ5lVovVs9RTqoo6KGZQl7HLdbL0KMIlnDBqOmYNNZQb/nwXeC99Qd6Pn5LvyMj9tF2FFiaATHc2YgDpMN1ihqMcM3GUdLXD36Cx3pcSBWPDM2HWjmCwKaidOmU91cw+ZDQW4bqXYf41PHNvS6PRpyYPoNdBXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351775; c=relaxed/simple;
	bh=6t8H+384IDLlkN0wdl5nK7NVnDqSQHE5pJne2/V6NZg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ByCQ8zVN/o5QmLHZ34TB3OZSFfe5lWyFM1neEl1p+hVXdh+KDcauRIEH1JS7tq7YyEw/SicpdZJXD//7qddEfdCoY0LcNqbZJSM5adFfNZwe1SYUfSGq+XWR56S0GgWsdutnVhIRuYg3LgqpLDBY2ryLwOT+GtzzFuUZOqOq9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=celes.in; spf=pass smtp.mailfrom=em1059891.celes.in; dkim=pass (2048-bit key) header.d=celes.in header.i=@celes.in header.b=a2UJaXAX; arc=none smtp.client-ip=158.120.82.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=celes.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1059891.celes.in
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celes.in;
 i=@celes.in; q=dns/txt; s=s1059891; t=1771351774; h=from : subject :
 to : message-id : date;
 bh=XyyAuD3bxt9VZzXVxdeWC65dj9gU11l8wx0bNKtL8A0=;
 b=a2UJaXAXY0pmjqQ9zZlfM6Uq+UG//tHEt24txmNuQeuvwHTA0v75QCQtvXSK2dTqWzGd6
 jMSvCp87LRgrxL1MXpVrpm+Xr1nW/uC5sj2/i+fK0SeXbXh93/FGmvEbd/2SwCxUL+k+s8p
 DQl64wpBVPvgiB6lXmvMJr8fbJ1C94ot4uFLhYne8fwUjYXKLeqkgDR3W8T8lU1lEcxVhtL
 A1FrwT4cjCyh559bq9rXcpUylaIn3F7cAvlBJb2zNrp3nSuTBDk8SMR9uql/RVzgg1GimK3
 Hc6YmFMt+gORSvE9RkCssTFJbB570vLe37JGBTYffGOdfYsDGBtk6vbla2Hg==
Received: from [10.143.247.69] (helo=mail-qv1-f54.google.com)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.99.1-S2G)
	(envelope-from <me@celes.in>)
	id 1vsPVr-AIkwcC8xjAs-5l9Z
	for stable@vger.kernel.org;
	Tue, 17 Feb 2026 18:09:31 +0000
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-896fd2c5337so37527546d6.2
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 10:09:31 -0800 (PST)
X-Forwarded-Encrypted:
 i=1; AJvYcCXM0O1TnoaPxBv6fytYDi49ObcIMOURZz5w8tm+AStLpE9U0hTCKe3+hs96WsxCoJ/Q/pzjZ6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvJfQpBr0IcYozEKgaGTKs4s78r/Q74QBNnKuF/J88xfmnBKO5
	8yIpedGYiS6JQpqMIxoderKeJU7efQVrSmKxoNtSIGWQtBN/hkvheTtj652pK9qw6q4vVHkU+Ls
	FoQ3U7VGdDFUmfYOJ0V1LDzphWwT++f0=
X-Received: by 2002:a05:6214:1c86:b0:895:4741:9f0c with SMTP id
 6a1803df08f44-897360f1b35mr188002386d6.3.1771351770129; Tue, 17 Feb 2026
 10:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Matsumoto <me@celes.in>
Date: Tue, 17 Feb 2026 15:09:19 -0300
X-Gmail-Original-Message-ID: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
X-Gm-Features: AaiRm53pqYNtQCklPDpvkElqfxn3-ztbj70v7QngPGRnU5O_PdF0KNFME70v1Cc
Message-ID: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
To: luiz.von.dentz@intel.com, maiquelpaiva@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1059891m:1059891aeXj9Ek:1059891s3kKDNjq08
X-smtpcorp-track: SgZeViaXVdMr.738Zln6n470t.vJw80QF6dLB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[celes.in,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[celes.in:s=s1059891];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216871-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[celes.in:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@celes.in,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[celes.in:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 73D4314EEE4
X-Rspamd-Action: no action

Regarding commit ac0c6f1b6a58 ("Bluetooth: mgmt: Fix heap overflow in
mgmt_mesh_add"):

I reviewed the call path for this patch and the overflow condition
appears to be unreachable in the current tree.
The only caller of mgmt_mesh_add() is mesh_send() in
net/bluetooth/mgmt_util.c. The length parameter is explicitly
sanitized before the call:

if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
   len <= MGMT_MESH_SEND_SIZE ||
   len > (MGMT_MESH_SEND_SIZE + 31))
return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
      MGMT_STATUS_REJECTED);

Given that mgmt_mesh_add() allocates sizeof(*mesh_tx), which includes
the param buffer sized for this maximum length, the bounds check
introduced in the commit is redundant.
While defensive programming is valid, tagging this as a fix for a heap
overflow is misleading for backporters and security scanners, as the
overflow cannot be triggered.

Please consider dropping this from the stable queue to avoid
unnecessary code churn.

