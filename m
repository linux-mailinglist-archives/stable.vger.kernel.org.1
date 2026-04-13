Return-Path: <stable+bounces-235912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED7sGomQ3GkmTAkAu9opvQ
	(envelope-from <stable+bounces-235912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D840E3E7DBF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D3C93011792
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93AC3921DC;
	Mon, 13 Apr 2026 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="EY3R3Qp9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C3C1CEADB
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062592; cv=none; b=jsfB4E9mYQvga0UIkUEBiG1Eb5CF5pUMmPQyO0NCnOjy2KpX3XqRH5WwxHLlv6sO7WnT4wB6tDaHRB0Nipwa9W1gP7WYCFyBSDanIFSYMxC4mLZ2m5Qk83+PPdK+2JcpmwBvvvh5KXkjJNs7ja0M2Psc79SR5eEdDNXc4AcJbr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062592; c=relaxed/simple;
	bh=4g8N1vkzn8xr3AUxEJAtlRo7h5BUEidnKmGUtWx0Q0I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hIzoOY5K8AHKKey4ikJlfS+siMFOwvB8oRg/bLtnlEQiySIXROQGmXaFld0V01YpqC34oWAp5d9FEnzOOqnK+pvDRaqnFxmf+g3U0igeBAcfM81ZMrlsdjhDfD+d+3wSeOEZ8/FwOgl19lhdlFkYrXRnb4u4c7osY5pybfBsscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=EY3R3Qp9; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D68883F1C0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062581;
	bh=4UJnWe5agX/QTj7pDob3I/bXDBC/+SOkZOEFDFxODQA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EY3R3Qp9CYz/c6EXcAy9XTMVYZqiZvWFEPXuFtXJ1Wd5GNWQ8OiyGuE+4MPXIYk4Y
	 0Ck4gDs/9ZLvCpGk5ygqfY3MzhsV0Nd1ZwRzBc9cvYBqzVd6vutGFJN2GcudABwQ09
	 Ih52GSeuGHTjcyZlxJLm6nhD6robGI5cGufbYqw0ZpMP5p7puSyWZADusgwEEbp/8o
	 sOTR3GMl01zAkY1MfSmTeqn5oMm+TNW3igYJUvtQmq68wizwg6Gv2lrHC0nYsEA05w
	 MH7uWDP9bdW1UiEOAXRl4PmmgM7fVRq3TWMzDWZ6tXX0kDmVtRM+c3l04dRP872x8+
	 SbrhkvY1XlVBsy75ZSEU4xqnEoyynsFE/O7zJJ9x3hUYoR1onSDTozpYSuGlin0OQP
	 MHexbi2K4RO95f82Ky5AKcmyxo29DzFS0dOSAVpG45t+PROoDRFXODd32KZFQ7Us4G
	 ih3g7YLBQkO8GPr/xegyKXZ76xxaJ9AWPytHmCPVgrYr/jFSqV0+zo5Jwk8fSZLODx
	 xjSru7V7Dh2Szx9hOHOMFP/lQhi8TIyU3ypVHeHgPJri+aOAYd2l8Gc5JQj4SmK01F
	 i3VUDNaIJFnru4aGHHknC5/VTyqg8wS0qTL78G6Ia3O0UaolnmTlMSaeENJJd+pPKh
	 YW6i92FZtTxUfVG+E5Ntb2ZA=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fb6cd0879so615620a91.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062580; x=1776667380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UJnWe5agX/QTj7pDob3I/bXDBC/+SOkZOEFDFxODQA=;
        b=rZwJA3Fgv+n5ttkbUePMaQQfEAxwBb1xbJTZcpAVlylA0hPndQffLDF477lYdyyxdT
         CXnOlSwr5PyzJp9VLIvG/jdY+7uqackfNiiUnvtxB2bgkBb850HYg07kTE/osyFqFcZZ
         pwBOb7bR6X6k+eZOBj7quwFtGlkFs/d0JW7Ffm8T+5k6RfPpypPcoeFGTEk6X3ALu9YB
         odApB9TojlufT1HI6rHL9YsautwDVt1v1mZlUQBDGg2QKtaYbXIegUJSozdWWsYvJhpd
         8qZStfd49YigHDx/7ICkithm+MSAGHzwTqonnIXhE3Y3+07jr5i6wOw6g8z/cKOgIAjn
         ZgpA==
X-Gm-Message-State: AOJu0Yy5kU+fp10W9QxHFXzKod2ANPsczXzWL0O1grzpbHilE3ZwQkqL
	BS5CLMvzm4lkkvR5TVGKjVsVCDwAcJl7rgb2ZlRH195siqk7TpIWrBbyHH4qSwwihutvIUJxh32
	fxhehjyisgjv+pp4S84VWsGtv5ahRoQyW8C73CxHD1zzRJGfYhiqBewdCIt4OxuDNWSuODeyq1B
	WXFAZAtw==
X-Gm-Gg: AeBDieujOBfpdGZWUhRdFmt9E7hHTaqpU8OjXMnLCrDthvtZxdckrUmI++7RyDmNPUh
	SbrFUvyPnAAvW06KfV3J5PpqIY4dXoIGjFmTjtzhrcidX8qOCgqYp+D3rWn/TIaiNx6tF2OgXkO
	SvGa8COqYfHi19vu+YD5JJZ5on1GdesDfHlqLvXrNLvaAcaAgvrwNPJsgty/1e+WD/FpAEguyQk
	irZmxbR3t1ICVnsIWTqzeNYO5+6+kco1gFkw90J1vrnJiJQ82Yszl+HWSh/9Z+5rq1Ab7sNQoV/
	/YDRfjS8pxplVuU0GD32n8vQFnXbxRU7WQS/a2AsHFpDIcThf27yONsCUbdbri6DcD6A4CSCfqN
	a+mJeI1VEysgZPO56Lyndlwbc/tE=
X-Received: by 2002:a17:90b:3c48:b0:35d:a8d9:3b4 with SMTP id 98e67ed59e1d1-35e4274e854mr12442246a91.4.1776062580367;
        Sun, 12 Apr 2026 23:43:00 -0700 (PDT)
X-Received: by 2002:a17:90b:3c48:b0:35d:a8d9:3b4 with SMTP id 98e67ed59e1d1-35e4274e854mr12442237a91.4.1776062579877;
        Sun, 12 Apr 2026 23:42:59 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id 98e67ed59e1d1-35e4131cfc4sm12924038a91.11.2026.04.12.23.42.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:42:59 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [Patch 0/11] apparmor: CrackArmor fixes for 6.1
Date: Sun, 12 Apr 2026 23:39:09 -0700
Message-ID: <20260413064256.1578919-1-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
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
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235912-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:mid]
X-Rspamd-Queue-Id: D840E3E7DBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set applies to 6.1

The following is the Backport of the CrackArmor fix patch set to
6.1. There are 3 backported patches in the set as outlined below. The
clean picks are included in the series because there are some ordering
dependencies, they can be cherry-picked instead of using the attached
patches if so desired.

All patches have been annotated with the upstream commit and the
backported patches have an explanation of the conflict and patch that
introduced the conflict.

Severity explanation of each the fixes:

There is an LPE fixed in
  Patch [8/11] apparmor: fix unprivileged local user can do privileged policy management

An unprivileged user exploitable use after free in the apparmor fs
virtual file system is fixed in the two patches
  Patch [10/11] apparmor: fix race on rawdata dereference, and
  Patch [11/11] apparmor: fix race between freeing data and fs accessing it

The remaining patches are unprivileged user exploitable, via the LPE
fixed in patch 8, but also even with patch 8 applied still exploitable
on systems with LXD/Incus installed and setup so that unprivileged
users can launch containers.

patch 1:  Backport of 9063d7e2615f4a7ab321de6b520e23d370e58816
patch 2:   clean pick of upstream e38c55d9f834e5b848bfed0f5c586aaf45acb825
patch 3:   clean pick of upstream ab09264660f9de5d05d1ef4e225aa447c63a8747
patch 4:   clean pick of upstream 306039414932c80f8420695a24d4fe10c84ccfb2
patch 5:   clean pick of upstream 8756b68edae37ff546c02091989a4ceab3f20abd
patch 6:   clean pick of upstream d352873bbefa7eb39995239d0b44ccdf8aaa79a4
patch 7:   clean pick of upstream 5df0c44e8f5f619d3beb871207aded7c78414502
patch 8:  Backport of 6601e13e82841879406bf9f369032656f441a425
patch 9:   clean pick of upstream 39440b137546a3aa383cfdabc605fb73811b6093
patch 10:  clean pick of upstream a0b7091c4de45a7325c8780e6934a894f92ac86b
patch 11: Backport of 8e135b8aee5a06c52a4347a5a6d51223c6f36ba3



