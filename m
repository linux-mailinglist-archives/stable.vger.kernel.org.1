Return-Path: <stable+bounces-238664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIx6FpJH5WnPgQEAu9opvQ
	(envelope-from <stable+bounces-238664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:22:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB094258A7
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67DA3019501
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 21:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF82FD69E;
	Sun, 19 Apr 2026 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiRyQgcj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645726E706
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776633736; cv=none; b=hDgkDTu+z4RhbfVHD7KbVdhLYMQvVgkczp/lSi4MEjsfIlZwbz6+F+zjRf5Jr35iEZlZOQZDUUXZGOMzO1+18vgHWxQtKJFun/oaP2hhFOtwWndxE8UOEzitszBCJTEowVdwZgQLO7kAqp1Rg1BDbIBPuRHH4vJZkJlQuiHJjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776633736; c=relaxed/simple;
	bh=4mgFnDuqjDazkpWQSACMpuF+9o6jWUlghenOuJwyDNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pVf4XhxXtYTnCuU9GnVFN3mlVAxsYzZXu74VQHh9ifABLNr48QKjIl3+r24LVOpyVy8F29UZx9+q5Bj8UhLavrYmmtiontp0xDgG+9DfoMncZxpw5RcJua8KhthlM+aB+S3PzW6fOB02Yekk+3DnKKVVxaE/HK6y7jrzjc77Gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiRyQgcj; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d428da4300so267916785a.3
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776633734; x=1777238534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qliX1CpRzcqySHVjBmsdzyegBGfy3s8Af3FF3IEJPas=;
        b=BiRyQgcjrt6Ok4yqnPJexgS4v0aK7KbO+dTi757V1yJOXJA90KPzeOZXMSlBnoW5TR
         /a4+iJNmDxH2lXVjM1abh408IMR/HywLKYJMDfcoIZYe87kGyT4IOOsRt9W5QLrgmGcN
         4YcOLN77KgNLHVSzbEHe1wrM9L/hqn9Edi1ex1IG7/G7EGKSP3yxQKfnTUCLPh29ZDaI
         uctsBFnIliKDbEfRLa1XtuRlViEUT83pEGGvD0O1ia04+xOqjKL84XP5XhW4pwKO2HD/
         Ml7jzqNk0qPCDJ21srpMVzF1kUMrjdShB+sdOcZL1IS0dHp4sCCoDxIJhliIgBUX93ve
         7mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776633734; x=1777238534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qliX1CpRzcqySHVjBmsdzyegBGfy3s8Af3FF3IEJPas=;
        b=hslqfSz/3r3m9wjHfXzUSubkPsXdkcHAes+sZWPImiI+RRtR3dqAcvcP+S6mir7NwW
         3awCGVPQBGd8MEZ2fbPRaLuLO/ob+/DF4LiDYGvHjtuluWx1QgIuK1LuGnQC+CQY3jJU
         PcZmZm9VM2JAvExolObQdtGXCKMPt2Mloyz4JJ2EZBPESNpUJe0X6pPVlE//QcW1aiJA
         2htiBhFI8CMeUJT+SJHLWlyY0aOvT00X8B3ykPDmzvXwlikLTOH2XuHC2XQ0yBQQlK9+
         BHamDKaRqZTAKN1FPf8TV6+nhvvAK7ub58sUofrT+sVqX0MadOwLfU2jU5KPIIGOIweT
         e0Hw==
X-Forwarded-Encrypted: i=1; AFNElJ9qwEsLIXxWlm9Lg7GtF46FDFRcIucHalIjlz9WR69ylmUm3w3F6sIPs7Cnn8hdNI0ODGOV9a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVceBpMIyJNyBDRkjHiMv/WHglrZ+R0oiuIHy2ktq1Q194zmUu
	6fka9Ej8P/4sEloqs6RLWDfzxvtDVJCiyINivWSyh4wnoUM7BRryvugzCL1vUqaO
X-Gm-Gg: AeBDieuq0DVjUy3GhlyWEZ/o4HRxkSb8Pc3fXaq1ShwN+E7C0wtCKSztEKeL6Z1rMha
	q7Brfiyv9Z66tcki9nzdCpry1RRk4W7hpQhBDS0OUR/hnNhO8Ed3gHMkWmGnFgJk4fF+EIoYkIK
	Mo6i2YDmhtyObjTFE5hZ6lwR06BFiLYXQNaq7kjjMPEkKO6NqSmBloeRtEHXvZ5YvL/Fh2R8Eok
	/h1KjS5Qb5H08Ge0mfZGDbhghnYtk/RZZKQoackqystpMXfyo5Opobm/tbFV7a9c6Lu88wRNSPt
	HqBOIkRZsVQiqLjeBjY3FfHhJPkTTvasJXFIflDqOhslYcNc9mRwsgruK63icg0ET5tgcmeB0EJ
	Epe9I6hNsLXMVaHQnS/iz/7EMrcfPBOdD7G1FTwWn4EUUhmvGPIZXKyYHSlNG8gJvVPqI4dhnbK
	eAkSsIA8TvpTfHr3OK340y39hxxxHd4MWC/WQhiBGXE+nC2F8m1GTVC3RnhjCJtngBVfZWC/Pa8
	9Y6UEkC3ah+vBv1etfwHy59vHHfzQ0=
X-Received: by 2002:a05:620a:241c:10b0:8ea:b828:350d with SMTP id af79cd13be357-8eab828370fmr236380585a.11.1776633734532;
        Sun, 19 Apr 2026 14:22:14 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d65c1321sm654849185a.15.2026.04.19.14.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:22:13 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Edward Adam Davis <eadavis@qq.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] isofs: hardening for crafted CE and NFS-handle paths
Date: Sun, 19 Apr 2026 17:21:53 -0400
Message-ID: <20260419212155.2169382-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238664-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDB094258A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two small defensive bounds checks for the ISO 9660 filesystem, one
in Rock Ridge CE continuation handling and one in the NFS export
path.  Both surfaced while looking for missing bounds checks
adjacent to recently-landed isofs fixes (0405d4b63d08,
f54e18f1b831).  Neither is a memory-safety bug on its own; the
existing sb_bread() / isofs_iget() paths handle out-of-range
blocks cleanly.  These patches reject the malformed input at the
earliest point it is known to be out of range.

1/2: rock_continue() reads rs->cont_extent from the Rock Ridge CE
record and calls sb_bread() on it without validating the block number
against ISOFS_SB(sb)->s_nzones.  commit e595447e177b (2005) added the
cont_offset and cont_size rejection but left the extent number
unchecked; commit f54e18f1b831 ("isofs: Fix infinite looping over CE
entries") later capped the CE chain at RR_MAX_CE_ENTRIES = 32 but
again did not address the block number.  The reachable attacker model
is a crafted ISO auto-mounted via udisks2 / polkit on a desktop
session; sb_bread() on an out-of-range block returns NULL cleanly, so
there is no memory-safety issue, and the CE buffer is parsed as Rock
Ridge records rather than returned verbatim via readlink().

2/2: isofs_fh_to_dentry() and isofs_fh_to_parent() pass
attacker-controlled block numbers from the NFS file handle to
isofs_export_iget(), which rejects block == 0 but not out-of-range
block numbers.  commit 0405d4b63d08 ("isofs: Prevent the use of too
small fid", CVE-2025-37780) added fh_len checks but left the block
number itself unchecked.  An authenticated NFS peer with a crafted
fid can drive reads of adjacent-partition data on the same block
device into iso_inode_info fields reaching the client as dentry
metadata.  Deployment surface is narrow (isofs-over-NFS); impact is
primarily EIO / ESTALE with a weak info-leak channel.

Both patches are one-line (or close to it) additions; the existing
out-of-range-block check in isofs_iget() / sb_bread() handles the
read-side cleanly, so these are strictly belt-and-suspenders
rejection at the earliest point we know the input is out of range.

Build-tested W=1 against 7.0-rc7 with CONFIG_ISO9660_FS=y,
CONFIG_JOLIET=y, CONFIG_ZISOFS=y.

Michael Bommarito (2):
  isofs: validate Rock Ridge CE continuation extent against volume size
  isofs: validate block number from NFS file handle in isofs_export_iget

 fs/isofs/export.c | 2 +-
 fs/isofs/rock.c   | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.53.0


