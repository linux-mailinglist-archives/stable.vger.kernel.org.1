Return-Path: <stable+bounces-244964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJaQNDdR/2nn4gAAu9opvQ
	(envelope-from <stable+bounces-244964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 17:22:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA050043C
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 17:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6393530041F9
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CA2281525;
	Sat,  9 May 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcyAzgWq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E6185B48
	for <stable@vger.kernel.org>; Sat,  9 May 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778340146; cv=none; b=XXtUEjjVb8nE7vHOdfrVPqVZdLPAQpkjOM/DTNteoa+wVXxNDYCC8rP7aeegNKTJ59J+dMOHsA6SLm+0YWZQEE6o4qgJVCM1P56kisiOjsvBW6hossagJUjs+OR3Ik01BVBSHM1HyV8VrNG5jnI7TE4/U/hmsm4gYIR4Ac2ZFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778340146; c=relaxed/simple;
	bh=UiDPC8dIgV+OA6WZijB9odMoOn8UmI3/gkcwkkQJQAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHt+l0sfAwdaEcoAMeoImNPgN0B4FvAXNII52XYOORXmdOSZglrneMQ+zfhY/LzSm4P3IvuM0jy3tuD0RSKvK/RDTGBGQ9IGm6k8TowHl/fwsOXVuKdIsXRgRAmolwcSUyQFJASic6sxzHT8dcJKZlXHIFYX03owubM/Boe7dfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcyAzgWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336EDC2BCF4;
	Sat,  9 May 2026 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778340146;
	bh=UiDPC8dIgV+OA6WZijB9odMoOn8UmI3/gkcwkkQJQAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcyAzgWqse4o7c8rqh9hH6lZcTDpKhKHuaSza4N+6BmgYkn8VDB/8wjuXL8FXkz0f
	 iEjvdu8Ht8yx8MlXBjv1XemEkb3SxX6cfj0Gum+lcoR8We5aSQNcaOJyDdtdXefpG6
	 4W249tjn1KRgNM3XBlOXdD7AUc/vyPHDRqwOljJ8FMN1SFW8ogdG1AvsoUoQxXypb9
	 MOSy2k9YPDj9sx0q7esfATYydJnAhB5FO9NaON1KaSEKcN83ZsabfkNLmfI1UvBiik
	 sXsH4hiqAks/0GBoKKzHmULNs9XR9BlD/ZAsMecu7jszea3L8fHdA4ptqA4LP156N5
	 hg3DrsvbCiq8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] ktest: Fix the month in the name of the failure directory
Date: Sat,  9 May 2026 11:22:22 -0400
Message-ID: <20260509152222.3511536-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509152222.3511536-1-sashal@kernel.org>
References: <2026050401-payphone-celestial-4a77@gregkh>
 <20260509152222.3511536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 70CA050043C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244964-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Action: no action

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 768059ede35f197575a38b10797b52402d9d4d2f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 1188de4bf89de..91dfe870b4a3c 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1719,7 +1719,7 @@ sub save_logs {
     my ($result, $basedir) = @_;
     my @t = localtime;
     my $date = sprintf "%04d%02d%02d%02d%02d%02d",
-	1900+$t[5],$t[4],$t[3],$t[2],$t[1],$t[0];
+	1900+$t[5],$t[4]+1,$t[3],$t[2],$t[1],$t[0];
 
     my $type = $build_type;
     if ($type =~ /useconfig/) {
-- 
2.53.0


