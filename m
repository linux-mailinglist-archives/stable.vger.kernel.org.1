Return-Path: <stable+bounces-208357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C69CAD1EEC8
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 13:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EB573009D7F
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48A8399037;
	Wed, 14 Jan 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpcEJOZP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718ED304BCB;
	Wed, 14 Jan 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768395456; cv=none; b=kUZdLEg7mIO7jYaGfShSDFTNM03EtSbFZWIfXRjCeJzSHWHKwMviqRawhH+pgRYIXY8o2hKZ/UJOcjJud7VvpGtGNebJFmljEB8IBsdB9UWnFrwvCcRs1pPz6XqbifnGY9+XzOY01UhNkjs9KIOlbccmdsj7w2nA0cGjQpZYOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768395456; c=relaxed/simple;
	bh=fwg6VCw4cZEc2+a2J27nnrxYwH8tWyGbO90iEbAtz24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0KlLMSnlbHLQAX9mtnW+ljdqXeb73D1ejRYlPEWe98Q1Q2o7F2OCqmSZxW2j+RnkzfJUNBY6W1ElDLuE20M/xv5DNn7zNaH24Hsm1UyeAPpzS6bwDg0VuHicF2D7Mea01dLE1wqc7RcHtgnyaDbJorxPFZSj0NMM0ye3iqL5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpcEJOZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7C8C19425;
	Wed, 14 Jan 2026 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768395456;
	bh=fwg6VCw4cZEc2+a2J27nnrxYwH8tWyGbO90iEbAtz24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpcEJOZPF+n7xrAMkfWVFUNja2Atp1U4exnXOGDkG7TkD9xDFlUZCk1AmeScN+dNN
	 OXFoI4c8wIkd9ZybpXR8WT0v2dhpD3+0Blx3PbYxGovg4zwJNOOMGy9uu1Xjig3Rqn
	 eiVMPS8DN6pAmgbBJ1wckumCAspKLQzvBsLkH3pK/OYLFYf4qznVmHqcgPVM/Gl7/R
	 Gb2Vxea8vs8Ohlzl3JKIW/wNjOUuQSe0wsw3IUd1tdnPsWEdAr/3+vYa9jN0YKvUP9
	 60uG06F1+3vHCC+d01z3erP67KHFftcYkezsbXjjKIaUwpCYc7mrZLGFqIpVx7AM/p
	 5zQ/LJb+FPvQA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vg0RK-00000002ly4-1Dme;
	Wed, 14 Jan 2026 13:57:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/4] scripts/kernel-doc: avoid error_count overflows
Date: Wed, 14 Jan 2026 13:57:23 +0100
Message-ID: <68ec6027db89b15394b8ed81b3259d1dc21ab37f.1768395332.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768395332.git.mchehab+huawei@kernel.org>
References: <cover.1768395332.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The glibc library limits the return code to 8 bits. We need to
stick to this limit when using sys.exit(error_count).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: stable@vger.kernel.org
---
 scripts/kernel-doc.py | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 7a1eaf986bcd..3992ca49d593 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -116,6 +116,8 @@ SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
+WERROR_RETURN_CODE = 3
+
 DESC = """
 Read C language source or header FILEs, extract embedded documentation comments,
 and print formatted documentation to standard output.
@@ -176,7 +178,20 @@ class MsgFormatter(logging.Formatter):
         return logging.Formatter.format(self, record)
 
 def main():
-    """Main program"""
+    """
+    Main program
+    By default, the return value is:
+
+    - 0: success or Python version is not compatible with                                                                kernel-doc.  If -Werror is not used, it will also
+       return 0 if there are issues at kernel-doc markups;
+
+    - 1: an abnormal condition happened;
+
+    - 2: argparse issued an error;
+
+    - 3: -Werror is used, and one or more unfiltered parse warnings
+         happened.
+    """
 
     parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
                                      description=DESC)
@@ -323,16 +338,12 @@ def main():
 
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
2.52.0


