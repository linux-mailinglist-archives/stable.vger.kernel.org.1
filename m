Return-Path: <stable+bounces-220724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LRmDh1Bo2lC+wQAu9opvQ
	(envelope-from <stable+bounces-220724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EC41C6F6A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8199D318880C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DC03FE85A;
	Sat, 28 Feb 2026 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6Xr+YRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883753FE852;
	Sat, 28 Feb 2026 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300604; cv=none; b=czbxtZTYZoHeVNlpn2yaWeSTCHUrFcFY0JRCPFl29hAYYHIZ+Xdtc10CqzzeHjqwYF4cBw0trEeXlu3GLFO6R4kZc314RWAY+84ilYF/vCnLhrQnKA3qdvWb8h6CwPkiUltVJxZZQbfXIB9KW4+kB/47Cc4SB0+gQy/42AKQ4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300604; c=relaxed/simple;
	bh=CIq1sMcaAIbQlDLPPLl+hO1rP2rtKXpxE8bLIcDJV2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0INEaqTdaD7IDjNDHr2XEcpTNC9EppBvPO5sJS4uZGX0dDDombV4V6TeTeRudPnTJPhQWevGmw7ujg1c6cSEEnDB9E7WJdfIeX54ItsRbOw3t8DvCp4Ecgc7H0VEMSm4b3Grr6vxU44Q0C+0szIeJhXWoUyiJQYG8SS3a5lN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6Xr+YRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B157AC19423;
	Sat, 28 Feb 2026 17:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300604;
	bh=CIq1sMcaAIbQlDLPPLl+hO1rP2rtKXpxE8bLIcDJV2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6Xr+YRWc1K7UMA7dcL7axVqxSgtFTu+b50NBx7RnQODKwP3NKnz6t+r67ai10lRu
	 IHVxuvfp/3IXIXiRyP7xb6M0ua2VWpN79e00Hf7uuMgYS9qeMuW2TVZtr0OB5SJqhr
	 iz16v1VEOTLoZ1nGAi/CKvKzNd7mlKDzur243Zxe8BIaKbaRHPVnMPkdFxaGN27Sxj
	 UN+R4X+hKDpVVe9EnxRGE3SbxGlbwmb9mN2BxbXsa3G5eOklP3OSt+WcCZjisUrREe
	 WPt9dv6H8vwb8MxpPVLFVa2qmSDQSxC6n8CMiLBoXLveVnjD0lRmYsBh7/yyn7n7iY
	 aZzsdfu3UUhLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 645/844] docs: kdoc: avoid error_count overflows
Date: Sat, 28 Feb 2026 12:29:18 -0500
Message-ID: <20260228173244.1509663-646-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220724-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,huawei];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lwn.net:email]
X-Rspamd-Queue-Id: 19EC41C6F6A
X-Rspamd-Action: no action

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 802774d8539fa73487190ec45438777a3c38d424 ]

The glibc library limits the return code to 8 bits. We need to
stick to this limit when using sys.exit(error_count).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Message-ID: <233d1674db99ed8feb405a2f781de350f0fba0ac.1768823489.git.mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kernel-doc.py | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 7a1eaf986bcd4..1ebb16b9bb087 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -116,6 +116,8 @@ SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
+WERROR_RETURN_CODE = 3
+
 DESC = """
 Read C language source or header FILEs, extract embedded documentation comments,
 and print formatted documentation to standard output.
@@ -176,7 +178,21 @@ class MsgFormatter(logging.Formatter):
         return logging.Formatter.format(self, record)
 
 def main():
-    """Main program"""
+    """
+    Main program.
+
+    By default, the return value is:
+
+    - 0: success or Python version is not compatible with
+      kernel-doc.  If -Werror is not used, it will also
+      return 0 if there are issues at kernel-doc markups;
+
+    - 1: an abnormal condition happened;
+
+    - 2: argparse issued an error;
+
+    - 3: -Werror is used, and one or more unfiltered parse warnings happened.
+    """
 
     parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
                                      description=DESC)
@@ -323,16 +339,12 @@ def main():
 
     if args.werror:
         print("%s warnings as errors" % error_count)    # pylint: disable=C0209
-        sys.exit(error_count)
+        sys.exit(WERROR_RETURN_CODE)
 
     if args.verbose:
         print("%s errors" % error_count)                # pylint: disable=C0209
 
-    if args.none:
-        sys.exit(0)
-
-    sys.exit(error_count)
-
+    sys.exit(0)
 
 # Call main method
 if __name__ == "__main__":
-- 
2.51.0


