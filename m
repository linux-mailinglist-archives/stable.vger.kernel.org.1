Return-Path: <stable+bounces-208285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF0FD1A95E
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 18:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F4A7303524E
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728D8350A2A;
	Tue, 13 Jan 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBWdEQoh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC82FE042;
	Tue, 13 Jan 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324802; cv=none; b=lJJ+b0zzU6LTxQEBNRiZSN9qSCVJFWnLtk5Oz5ZbvIPZaMyO62AfzccIL847yW1XRBZjryzV9pO+eHXWjSFIDlmmXufZONtvedt1TMRl331LJeipHaPWv+FELQEOM5OvIu3CYTAgD9Wi1w9uMkrXD3CwUfGFTeEiJGEbn5YM9YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324802; c=relaxed/simple;
	bh=UUmc3EfAY48oflOixuCJfyhKnkDnBsRLnIZJCLJ1PX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oa1EwVTUc4NINiH2oTcieHQy0iLDzvjJJSUTqKZHxJjFC7auT3JpCzmpaKY88aUAym3hPkVxdD9GBaYCEZEXbrVxxy9g3rSkAvVykSox5uTMIgC9KRhhD5iXct8Q6Xzfj/zD5Q6tJkO3Nq5bc2gKBXPSkPne6eTsf8c1NJ9CWVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBWdEQoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1628C116C6;
	Tue, 13 Jan 2026 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768324801;
	bh=UUmc3EfAY48oflOixuCJfyhKnkDnBsRLnIZJCLJ1PX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBWdEQoheTARg8Y8d+o2uLj+NFHpoJWUSv0XaLTHT9esNRmDBGK/9YeTd+uSllvW6
	 fhOPzRqGkrfhqqHEUXPCoslASKKXm3RelZpVyqiFbNn+io82BKG4wLf/U80gS2RubY
	 +2JyBEehausuQCHEIozWl9OOJjlqSwA0bZf9M0hEoAnM9pUP1oG+2KueyeyPYrbLDf
	 mvhH5zdk4DqggUKi0S5pUEFvslDhSmc/bu7GvTP2N4m9yhMwbsvUvhTjLXLvI/snvy
	 KQxSxxLi874+kRKa27fW0zKk+Ls3V3kSwqUQ/PEqmwTRFXVsJUfdQ2mOdDabGvNivB
	 oA7uo5tQuxlqQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vfi3j-00000000zeC-3PZb;
	Tue, 13 Jan 2026 18:19:59 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/4] scripts/kernel-doc: avoid error_count overflows
Date: Tue, 13 Jan 2026 18:19:54 +0100
Message-ID: <80bd110988b8c1bd1118250c2acc05e9d2241709.1768324572.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768324572.git.mchehab+huawei@kernel.org>
References: <cover.1768324572.git.mchehab+huawei@kernel.org>
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
 scripts/kernel-doc.py | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 7a1eaf986bcd..5d2f29e90ebe 100755
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
+    Main program
+    By default, the return value is:
+
+    - 0: parsing warnings or Python version is not compatible with
+      kernel-doc. The rationale for the latter is to not break Linux
+      compilation on such cases;
+
+    - 1: an abnormal condition happened;
+
+    - 2: arparse issued an error;
+
+    - 3: -Werror is used, and one or more unfiltered parse warnings
+         happened.
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
2.52.0


