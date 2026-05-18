Return-Path: <stable+bounces-249338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C4ZMdg/C2phFAUAu9opvQ
	(envelope-from <stable+bounces-249338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:35:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA61570FDD
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFF143020A9E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBCB48AE12;
	Mon, 18 May 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="seXqiink"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBD481FC3
	for <stable@vger.kernel.org>; Mon, 18 May 2026 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122130; cv=none; b=DN0AEW4U2E4gzo+N6Mu6IQc89ZM64FNLYF5uNdjNehSBemdffNwboTGQcizKPlFZOpNGslB97ABcEqXRtGgKsb4XCpZou3aTal92Adc4Zrk8uleUYqIJSbyfFzzCdZvse1+1Vs6d6YmHXmeCBqJepT6A6LmtuJ8ATikB+SOeuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122130; c=relaxed/simple;
	bh=lADZGL1l+uV+dRUhIFGvk44P/1X//TbM0Q/BhApFkWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RUqyxh5fTRZjUpBiH/f2irWqP1tV03fwdhLhyBd26FImvKwGxGBnUpg7YsOaNJ2GMJwtL4Y0NRKH09QobqJiYkFcwy+ViU0tUyU6bBoNV+Dii1b9jIRcsv6oKNxr6E1VcGec0JaRF0U8xLjgdvDkrVGa6d+pnkwy2EoeQ9naLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=seXqiink; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so1655e9.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779122126; x=1779726926; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6RI1o8QPT8hiZuDRhk2bWs7AEZtLDRZKqnNbFswNzg=;
        b=seXqiinkpUmksbB7slzxfwbJTHfuUtmJSJ+WK8sSje+0Y53vgfVPO4ny5z11hEHabh
         HOGX/piPC074psVJNXl18wAlXSEFk2+AYZ51Lh02aaHZ6latauUCG9SoLEYRiTWaTJZ9
         uj+N5tOC4vc7qXP4ABS3RD4NkuN3HxJjVfS45hU5pqfSihPsAH4qBUrSWZla924z+QNN
         g4FUM+oScM6YGHlI7to/Eli9f6K1HkdKCuEojME2NUI02duaGS1iTPt975jotYzeDi5s
         QxcPFSW+WVb3T+BCS+v1sOh2VzHw809FwNJnbWTSm5OKLHkJIRMUq1vtiqxQafqli/dz
         +xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122126; x=1779726926;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6RI1o8QPT8hiZuDRhk2bWs7AEZtLDRZKqnNbFswNzg=;
        b=Jeyce/xjvL/EMclhnA9XQlvN1T5UbGkouvAnXUB5vgrZB7msLu84PrNc+zuGqKTRWa
         crF1sOxX6RWPCu2smqHKvCkjjQKId9mXeGMBbAaC2GdUNASmOfWIpcVQ9BsWFhudBHGf
         +Q+OGvzmRJSiqCZ/Ejw/woepXbjM3kCz7JybJZKccmHwaTy3h1rLVIYRgoQWVy3LT3ls
         drLnGqCk1HmfgwG4mYuGJz9QUVDIRRPfjTz1WZtopPHmiKoF6LKaGLTaJk0/cfL3SZY7
         L5e0jzXLJHoCloOCHS9J7fM4suyqQ/gv22Zx5ruTnoNQQUftJjf79VGXZl1WUCHqcLij
         0/7w==
X-Forwarded-Encrypted: i=1; AFNElJ8WtGeB9aaevG0dJ8P4L3mzanEUgZepu78EZfHwF06Jlo4auYwjVqgfj0V8DW/sr/ZzoSEu/ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqM4/cinZ+hjplednW3cEmVF3RqO35h/kXg2Kk+7JFNiFFu5k
	+TxAjNBo1aRjVAzn85WQjO9dIyxRewHH8hIiD4XsN9kCZBYgcqbBclrYBBZM6U+zCTZTnL9lNSl
	L+VrEdiwS
X-Gm-Gg: Acq92OGj3G3Wwr3lpMvVAT++IeAEK7wMwz99ZAuQxVsl2ZAOCc2enxdZDQmwm6nsWl6
	hKREtjfliuAllldHA/arGjtBSTz3HjXEDpijoZy6HqOjE2Ra4z9wmQivvmM3y/IWY1Sk3KYNBpc
	haT+Z4pIcuGmJnSgtRcCsPVW3ueBY1WIk6Bi75aFrzIPyJrcJbHiXZZPz2uRaLgWL0WuS8jLwHB
	rpO7/wrxY/GTa8muOJ//wM87n1fBC8dHJQxZqYH84DBuZALgH4DJejjudCTjQFMc2/y7ghsQKSd
	BrAjnoO4TnuHqzmtMd9LVtrAttZmbytcIVV/QrwU5psASilwtXaw1FXrPBVMf1A6wkLNM4v9RlM
	GxSdmjKTp/S585ho0qf+byoKRHI4rcuau0TXPPMSJEu7Z59+riWIgktec39PGL5QVrALI+9QXSv
	apFz5g/ajmphzVTkymPPNuxeb6jPXBgC/aJiiTBSMqeu7uBpf8AbIFqaHB30Jz
X-Received: by 2002:a05:600c:22d6:b0:48a:5618:b4d4 with SMTP id 5b1f17b1804b1-48ffd828d6emr1692195e9.1.1779122125101;
        Mon, 18 May 2026 09:35:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:866a:e549:273b:bc0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm288997405e9.7.2026.05.18.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:35:24 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/2] proc: protect ptrace_may_access() with
 exec_update_lock
Date: Mon, 18 May 2026 18:35:14 +0200
Message-Id: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMI/C2oC/x2MQQrDIBAAvxL23AUVDE2+Unow65ouCVHWEgLBv
 1d6HIaZGyqrcIV5uEH5lCr56GAfA9AnHCujxM7gjBuNt08smilV3DNtSS4sQb8WfaTg4uQXsg5
 6WpS7/G9f79Z+wvvYyWYAAAA=
X-Change-ID: 20260518-procfs-lockfix-part1-5dca2d95bc12
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Arjan van de Ven <arjan@linux.intel.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779122120; l=1555;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=lADZGL1l+uV+dRUhIFGvk44P/1X//TbM0Q/BhApFkWk=;
 b=IwpfuQofLx1OaD/Oq+E+Ekv+BwOYk72drXWLQP391fiPqwH7SfjOaqsx9Fjg87efduRYWBxLd
 Ine6lmQsfUvC2OWy+okwbW5YXqypA2GqF7rISgDZkLkJKNNyTHDU5Np
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249338-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6FA61570FDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

My understanding is that procfs is effectively maintained by the VFS
maintainers (though scripts/get_maintainer.pl claims that there are
no maintainers for procfs because the VFS entry only claims files
directly in fs/, and the procfs entry has no maintainers listed on
it).

In procfs, most uses of ptrace_may_access() should use
exec_update_lock to avoid TOCTOU issues with concurrent privileged
execve() (like setuid binary execution).

This series doesn't fix all the remaining issues in procfs, but it fixes
the easy cases for now; I will probably follow up with fixes for the
gnarlier cases later unless someone else wants to do that.

I have checked that procfs files still work with these changes and that
CONFIG_PROVE_LOCKING=y doesn't generate any warnings.

(checkpatch complains about missing argument names in
proc_op::proc_get_link, but that was already the case before my patch.)

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (2):
      proc: protect ptrace_may_access() with exec_update_lock (part 1)
      proc: protect ptrace_may_access() with exec_update_lock (FD links)

 fs/proc/array.c      |   6 ++
 fs/proc/base.c       | 159 ++++++++++++++++++++++-----------------------------
 fs/proc/fd.c         |  27 ++++-----
 fs/proc/internal.h   |   2 +-
 fs/proc/namespaces.c |  12 ++++
 5 files changed, 97 insertions(+), 109 deletions(-)
---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260518-procfs-lockfix-part1-5dca2d95bc12

--  
Jann Horn <jannh@google.com>


