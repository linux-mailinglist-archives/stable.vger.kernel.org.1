Return-Path: <stable+bounces-239989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HQaCg9/5mklxQEAu9opvQ
	(envelope-from <stable+bounces-239989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:31:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2443351B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388C03024111
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3E63C5539;
	Mon, 20 Apr 2026 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+E2JdQd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29823C4561;
	Mon, 20 Apr 2026 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713448; cv=none; b=nrjOw9Cp1ZbOK/f/zlFbDUVnIaz46y8qpwpahzlLwajcauba18/dGqCAUSDfWVKhMzAWKIFInXX6lIYY0tDj7WdWrICFE4/miYDtkbVQFcyo2Y1Grt18BtFSP2D35/9kx1HZh+ZZtZb3V+1v/AfXmMw7if3irWd8CH9HuMeo1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713448; c=relaxed/simple;
	bh=EzkrBWV7mo4RuGZ2Otih5js1m7BD0KaWPQdKFp2cNwo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VclhOXGM7GsLul1h091bZUQkKxj3XQcnCFurVGmzno3PFkD31oBWtg0seNKJZkInzCFh1EWSEo4HK4Af7X6rvN+xpqMrYTwxxqnujizdAbvQqGwTFfkYj2YVUjTiyX8gIyIu12GOUur010Te6eKfcK7cYCU+4QMSs4fBFkZ6vrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+E2JdQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFDFC2BCB4;
	Mon, 20 Apr 2026 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776713448;
	bh=EzkrBWV7mo4RuGZ2Otih5js1m7BD0KaWPQdKFp2cNwo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=h+E2JdQdLjtcTlNMgRluHKjQoBg2IhjctsS5VqxOmCQxRNfLBh+Rn6AQa35bPycAk
	 GxqmPeA3wkvbBrv4OgOxCW5ozShzWvt8OyVANYqWlXu/EFMWdH7d3M5mQ7aUWOkV0a
	 7lncNtIm5aSijzH8FzX/xsNYS6f8EDSGgX/dy/xTsnFE9MX8qwMeulJ+CFtkaf4/a2
	 xAV9qv7cqiwApmcvAUVfRBaTIyezeg3po0/q4hRHDRXB7t/ONb9l6WuCHh9UtMNe0t
	 25cJbl/OPGXGXnWWuVUNZaUjF+EeOi2Ocw2/vyJrd1wOSwhF5h+4RNWDt/TwG8B7hW
	 xICjaPQ10Orwg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1wEuMD-00000006vwl-0Vw2;
	Mon, 20 Apr 2026 15:32:33 -0400
Message-ID: <20260420193232.981751367@kernel.org>
User-Agent: quilt/0.69
Date: Mon, 20 Apr 2026 15:32:04 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 1/2] ktest: Fix the month in the name of the failure directory
References: <20260420193203.993782513@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239989-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78F2443351B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Steven Rostedt <rostedt@goodmis.org>

The Perl localtime() function returns the month starting at 0 not 1. This
caused the date produced to create the directory for saving files of a
failed run to have the month off by one.

  machine-test-useconfig-fail-20260314073628

The above happened in April, not March. The correct name should have been:

  machine-test-useconfig-fail-20260414073628

This was somewhat confusing.

Cc: stable@vger.kernel.org
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>
Link: https://patch.msgid.link/20260420142426.33ad0293@fedora
Fixes: 7faafbd69639b ("ktest: Add open and close console and start stop monitor")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 112f9ca2444b..dd55eea15070 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1855,7 +1855,7 @@ sub save_logs {
     my ($result, $basedir) = @_;
     my @t = localtime;
     my $date = sprintf "%04d%02d%02d%02d%02d%02d",
-	1900+$t[5],$t[4],$t[3],$t[2],$t[1],$t[0];
+	1900+$t[5],$t[4]+1,$t[3],$t[2],$t[1],$t[0];
 
     my $type = $build_type;
     if ($type =~ /useconfig/) {
-- 
2.51.0



