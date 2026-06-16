Return-Path: <stable+bounces-263913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xuEmGLtpMWr7igUAu9opvQ
	(envelope-from <stable+bounces-263913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67381690EEC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="dRw9Cv/0";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263913-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-263913-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 798CF30172DB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1A643E4A8;
	Tue, 16 Jun 2026 15:18:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531843C05C;
	Tue, 16 Jun 2026 15:18:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623138; cv=none; b=RojsRBOqvu3G8FT5jbwW4pGQVp/Ve2Tqn80uCtxPso77jTzv5+mPiKgpTvInxjVXy7N27R0qmXc4PsrRq3OBLkDYAXuZftO/b9Ej0Mye89QWqwGv+MSlv96Vdq4azVLg/CFhqs/5aAxwgn0fwtTlX1MHHXimu3qEGSGbcLRwTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623138; c=relaxed/simple;
	bh=RnM8x/r/esLzHy7XJ8ZnggB/NkQ5IDYT/zYkdwet6W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVzjLyto24AS7kFIwyjaiXHQO9C3fBZvplTkv6t4tg0+UazTekya001aS10ns23FuTKiaY7pUmFd0RPIJnpsO7h2zy/DHPlKSv4gk3p/LcX3f39Fu5igoDEQ/YL4YzlJM1O6xVwXIgAD8Hsk/jnyJtdbFZFcQ9Epo2j5NMsq7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dRw9Cv/0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4194A1F000E9;
	Tue, 16 Jun 2026 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623137;
	bh=RGcmIxo8zh5jI+dESpb2B0u//7RA8I7/4136Y6cyE1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dRw9Cv/0FO8ps2H7aMg448tLp0nWQA7sUrxzLN1LnapZQn+eC06Mu94hl0+GCnFwk
	 Cma4Unv4mbAXpJfvhH3g+4rm+SdNs8EdoOX1xJCuXgDTqSpa9+/vB8bB7OkGysL0zz
	 Ruj0sffIj1SZdMdbZRaAGELaYa4LobNJsbHDJ7GM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 094/378] verification/rvgen: Fix options shared among commands
Date: Tue, 16 Jun 2026 20:25:25 +0530
Message-ID: <20260616145115.237573127@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263913-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:namcao@linutronix.de,m:gmonaco@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linutronix.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67381690EEC

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit 5f845ad706c0b394ae274e9a930044f78bef782e ]

After rvgen was refactored to use subparsers, the common options (-a and
-D) were left in the main parser. This meant that they needed to be
called /before/ the subcommand and using them without subcommand was
allowed. This is not the original intent.

  rvgen -D "some description" container -n name

Define the options as parent in the subparsers to allow them to be used
from both subcommands together with other options.

  rvgen container -n name -D "some description"

Fixes: 5270a0e3041c ("verification/dot2k: Replace is_container() hack with subparsers")
Reviewed-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/20260514152055.229162-7-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/verification/rvgen/__main__.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index fa6fc1f4de2f7e..5198bccccd107b 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -17,14 +17,16 @@ if __name__ == '__main__':
     import sys
 
     parser = argparse.ArgumentParser(description='Generate kernel rv monitor')
-    parser.add_argument("-D", "--description", dest="description", required=False)
-    parser.add_argument("-a", "--auto_patch", dest="auto_patch",
+
+    parent_parser = argparse.ArgumentParser(add_help=False)
+    parent_parser.add_argument("-D", "--description", dest="description", required=False)
+    parent_parser.add_argument("-a", "--auto_patch", dest="auto_patch",
                         action="store_true", required=False,
                         help="Patch the kernel in place")
 
     subparsers = parser.add_subparsers(dest="subcmd", required=True)
 
-    monitor_parser = subparsers.add_parser("monitor")
+    monitor_parser = subparsers.add_parser("monitor", parents=[parent_parser])
     monitor_parser.add_argument('-n', "--model_name", dest="model_name")
     monitor_parser.add_argument("-p", "--parent", dest="parent",
                                 required=False, help="Create a monitor nested to parent")
@@ -34,7 +36,7 @@ if __name__ == '__main__':
     monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type",
                                 help=f"Available options: {', '.join(Monitor.monitor_types.keys())}")
 
-    container_parser = subparsers.add_parser("container")
+    container_parser = subparsers.add_parser("container", parents=[parent_parser])
     container_parser.add_argument('-n', "--model_name", dest="model_name", required=True)
 
     params = parser.parse_args()
-- 
2.53.0




