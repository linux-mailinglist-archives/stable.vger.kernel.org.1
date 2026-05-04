Return-Path: <stable+bounces-243445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOItG2ap+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B064BED05
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7957A301E7FD
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8073CF664;
	Mon,  4 May 2026 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BPfxkMcj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD435A3AD;
	Mon,  4 May 2026 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903902; cv=none; b=GFNs9OSI/zelhMcvyvuZmfnX7Zvoy10akyh5vW3EdBRWUIG0tUST8OwfgIjk7xmOpxCK7OFhgXVNSS0/ZKpWLXRgibCslkb2de+uKGWiq73zZv3jOCmuZ4uiWTRNp+zEx85LWj5aIq/ssPdlJwF0wgQ1VFeqauuC1Ers6HWixFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903902; c=relaxed/simple;
	bh=Bftd/IfLujV6WFyFwU2DtMPmwYFBWZA/uBlX/qJBjDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucd103PGHxXD5gK+uEXTh/cl75qb7tHXre1jh4NQhait4Zji2unJNkULZfe7XWpvoj9ZDgRAjXpdGMPehN8X3Ec3oYJQXYw9epC93mYQBz27I5OOwnHOEeyzVwgSSeGd6G/ZtMMXScWzC1K1pEY6t7TCmE2E3vPKO0UXSHzwF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BPfxkMcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ADFC2BCC4;
	Mon,  4 May 2026 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903902;
	bh=Bftd/IfLujV6WFyFwU2DtMPmwYFBWZA/uBlX/qJBjDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPfxkMcjIOniqnlnZSegyv3aSYGUEVCRz2FH3WQOD9h1hMQvj9tS1s6yjLGrqvEGc
	 8eNNXaieqfZrNJGU+BlcDFcCR/OwThJ/OsvGbdSFKrXfq+zzAchgxAgGNi+VZmzilL
	 F+SX8iPQopPEqGMMrI6z70+amx2+dcUln1CvBiOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	kernel test robot <lkp@intel.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH 6.18 089/275] selftests/landlock: Fix format warning for __u64 in net_test
Date: Mon,  4 May 2026 15:50:29 +0200
Message-ID: <20260504135146.228305006@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E3B064BED05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,intel.com,gmail.com,digikod.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243445-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mickaël Salaün <mic@digikod.net>

commit a060ac0b8c3345639f5f4a01e2c435d34adf7e3d upstream.

On architectures where __u64 is unsigned long (e.g. powerpc64), using
%llx to format a __u64 triggers a -Wformat warning because %llx expects
unsigned long long.  Cast the argument to unsigned long long.

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: a549d055a22e ("selftests/landlock: Add network tests")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202604020206.62zgOTeP-lkp@intel.com/
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/r/20260402192608.1458252-6-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/landlock/net_test.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1344,7 +1344,7 @@ TEST_F(mini, network_access_rights)
 					    &net_port, 0))
 		{
 			TH_LOG("Failed to add rule with access 0x%llx: %s",
-			       access, strerror(errno));
+			       (unsigned long long)access, strerror(errno));
 		}
 	}
 	EXPECT_EQ(0, close(ruleset_fd));



