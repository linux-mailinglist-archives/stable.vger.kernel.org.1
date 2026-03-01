Return-Path: <stable+bounces-222278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKiQJECjo2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:24:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 027811CD842
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E183304266
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB72F39BE;
	Sun,  1 Mar 2026 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5ksAQ91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B6190664
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330477; cv=none; b=qMtd7zp5zt8XSQ5cw1aIfDfJ+OODhIkvm/LdaQ+VoNi7YRu5DoOG6TxHeRQd3Zw4YJcpNCQVOxUlttGV8UNHIxEyKa9Yb+JqmJmTGrPtmtaEjhjXFfSrelr50wvow8QlHiEOt60kjIEFvSpdprl1Z5bDiVwDTC4SCSejPC+86XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330477; c=relaxed/simple;
	bh=4K7PwaX/QhOoJofiGqXVSPLZFI+vlHI05veTLsKOHkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0gTCvyazO+Klin2SDVfv9xHvb+e9UEW5V18Gi5whtO+Iwf428vmv6vKadmbu8nr/Wg/+9mJmfyf3Kt+LO6t9vNFNrdnj8Ax4IWw1SJW4Uik0M+F/+YzSuGgWziapfM2XMmYqnZGCa0XAEQedIGqlq6GrAvPIdSHGpclNK6mBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5ksAQ91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AF6C19421;
	Sun,  1 Mar 2026 02:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330477;
	bh=4K7PwaX/QhOoJofiGqXVSPLZFI+vlHI05veTLsKOHkw=;
	h=From:To:Cc:Subject:Date:From;
	b=P5ksAQ91wOHO/5DwHtC5dvU6rBUZK1fw55Dyz8lK6jKPUeGmioCofwM1pp4+eJD4V
	 7bRiZdNJ+58LduAC+fouIe1O5130Dy/AL0Sb0Mu+7pP1sICgc8o+h3VSRux6E9wbbY
	 pKeH+bVN2pMZnrOdB11CkipcyMQeGn73+jvH/HGweY/bw00JGWOwaKqsovHElzkL2j
	 W243BU9LUc+ZwSkGeWLDiYIwR83H41gn526sjx3Q+DtjU6aKtnQyqhtK+XZGdLNfcL
	 n59fswrZ4EhMWWTwFQ/4DmNqQVpgdxC68h1xWmPV7B+GWcfn9Pj3j170EjSF9MIpGz
	 nC5mf2568/UsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mchehab+huawei@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Subject: FAILED: Patch "docs: kdoc: avoid error_count overflows" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:01:15 -0500
Message-ID: <20260301020116.1728465-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-222278-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,huawei];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 027811CD842
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 802774d8539fa73487190ec45438777a3c38d424 Mon Sep 17 00:00:00 2001
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 19 Jan 2026 13:04:57 +0100
Subject: [PATCH] docs: kdoc: avoid error_count overflows

The glibc library limits the return code to 8 bits. We need to
stick to this limit when using sys.exit(error_count).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Message-ID: <233d1674db99ed8feb405a2f781de350f0fba0ac.1768823489.git.mchehab+huawei@kernel.org>
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





