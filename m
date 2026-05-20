Return-Path: <stable+bounces-252467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLGaDmcCDmra5QUAu9opvQ
	(envelope-from <stable+bounces-252467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:50:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 998295974A4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BB72397B804
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC423F86F4;
	Wed, 20 May 2026 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MVhshatu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3D2F363F;
	Wed, 20 May 2026 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300750; cv=none; b=hoLWQ5jLqdUpsrG3+pON7niXNss+3/lqO8yLW+ixjWNI4I6SgMc/c2Y8hGfaFkquzxNiQKxq8TfYPdz1nNdqbmftM4gs8obFbpQXz4X+3P5rF+oKcOr4nI7MLYPF12DGz4dLwDfHz6JYJOadelLdlR04yY/oQxAorAkHm06DlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300750; c=relaxed/simple;
	bh=DDqhgfn7gGkmXZ0A+EGYeJF2vvJfNnuNAFUBaYfTZOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqsUMj6bdO7jY92/KnA0SwcciOoX++I23mzbqeZy0U38xiaMcWpePtKb3kqtZ95PfXnnAYH6atBD2cVAiVOBqXu7zhDGHIETXphRdurbzI2rhzgR2aOsFMW2+V1+jlPuEJTYwlVQtn2SvK5bKFcvTsA5wMi6Lur4KIngMN2jsTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MVhshatu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642F21F000E9;
	Wed, 20 May 2026 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300748;
	bh=iXnkP4VNN66miwBu2nL3i/OF6xdxwQrUflUdkHKYgpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVhshatuT2/G4zeKRdW24P8iYsAEZysXRTJBsMf8foZOPp0foYFwnOy0IHOmS+290
	 krwxhKAgoc5LF7bOrzyaaqvQWOLI5unOhh/cQgYEE1chQ/DckCoORj8zg7gOy1zaeH
	 vAwtaN1HrSeMcKmQyQUP+7HkIbFimDqE+4on4I1o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Hawley <warthog9@eaglescrag.net>,
	Andrea Righi <arighi@nvidia.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Pedro Falcato <pfalcato@suse.de>,
	"=?UTF-8?q?Ricardo=20B . =20Marli=C3=A8re?=" <rbm@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 256/666] ktest: Honor empty per-test option overrides
Date: Wed, 20 May 2026 18:17:47 +0200
Message-ID: <20260520162116.764353928@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252467-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eaglescrag.net:email,goodmis.org:email,suse.com:email,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 998295974A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo B. Marlière <rbm@suse.com>

[ Upstream commit a2de57a3c8192dcd67cccaff6c341b93748d799b ]

A per-test override can clear an inherited default option by assigning an
empty value, but __set_test_option() still used option_defined() to decide
whether a per-test key existed. That turned an empty per-test assignment
back into "fall back to the default", so tests still could not clear
inherited settings.

For example:

  DEFAULTS
  (...)
  LOG_FILE = /tmp/ktest-empty-override.log
  CLEAR_LOG = 1
  ADD_CONFIG = /tmp/.config

  TEST_START
  TEST_TYPE = build
  BUILD_TYPE = nobuild
  ADD_CONFIG =

This would run the test with ADD_CONFIG[1] = /tmp/.config

Fix by checking whether the per-test key exists before falling back. If it
does exist but is empty, treat it as unset for that test and stop the
fallback chain there.

Cc: John Hawley <warthog9@eaglescrag.net>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Pedro Falcato <pfalcato@suse.de>
Link: https://patch.msgid.link/20260307-ktest-fixes-v1-4-565d412f4925@suse.com
Fixes: 22c37a9ac49d ("ktest: Allow tests to undefine default options")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/ktest/ktest.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index b18ea351c8b16..777ab6790d5db 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4127,7 +4127,8 @@ sub __set_test_option {
 
     my $option = "$name\[$i\]";
 
-    if (option_defined($option)) {
+    if (exists($opt{$option})) {
+	return undef if (!option_defined($option));
 	return $opt{$option};
     }
 
@@ -4135,7 +4136,8 @@ sub __set_test_option {
 	if ($i >= $test &&
 	    $i < $test + $repeat_tests{$test}) {
 	    $option = "$name\[$test\]";
-	    if (option_defined($option)) {
+	    if (exists($opt{$option})) {
+		return undef if (!option_defined($option));
 		return $opt{$option};
 	    }
 	}
-- 
2.53.0




