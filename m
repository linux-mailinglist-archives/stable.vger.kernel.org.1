Return-Path: <stable+bounces-210139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47357D38D57
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 10:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61ABE301E6C7
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550C322DFB8;
	Sat, 17 Jan 2026 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytg0q7Sd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B8332EB4;
	Sat, 17 Jan 2026 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768642173; cv=none; b=OwyxacYervPF5ddJwI29lg4J2fBH4EJtesORxTJZNrglD1NUsYeUbtczGsQL4htMqk3Yvff+jsCYZQwsahMIho4P9dXd/MrrPGtyuDFK+TtKtXR1gpjwh/3NZ//5AtUqtTSp4DemcwRDR6l/btTjlreqpoLvic00uLQGvkKzNyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768642173; c=relaxed/simple;
	bh=gswQgvIkCvCKkiNyrJA/gedBlbjViDDQyImQR0Lwtf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ao5yoP8Gb9NtSNVMfUUmfC/FTjumgbqYql+SshXlWIjO6i6Px32XvVi8dAEy/pOBDm8Zfsf6aYFf2c64qbys1CgRXdtxjrEhBUpEMQBlTOcG7Dqy86taKMVwz1Xjw65A3uzJPFtMJ3KqHwxgvL8uy9ONVtAudabC5uE/Cy+nWgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytg0q7Sd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7DFC4AF0C;
	Sat, 17 Jan 2026 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768642172;
	bh=gswQgvIkCvCKkiNyrJA/gedBlbjViDDQyImQR0Lwtf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ytg0q7Sda8Jtsy2t6IOq0BjFLwvPDF54IHLZ9fCwaHf8qcu+VB1SinYReE8s8cJi+
	 Bui5o/NsgKTA4NJ7pzpT3NsDDN4YnNkfaAvJ5L2ybgxLZ+t6j2m0Kp8wuO9jPyUxod
	 QqqZASSVpoh5yBGTC8rbE1Z9/doqBfw2Wsb3kHcFIsAXe4sSx9i2Ireu/UXakua0ty
	 GoAv/HJMA9GistLkQSau04Iw0PfFTFj/H43WwGx+kPViEvWEv2YWYP9IqtlbO1e5e+
	 +7Mi+KsXD/0wF+55gJyFwCiWCZkdBr7FYEiStR42BSd96kuXddZOIV3oJJNXbMgg60
	 wJQOKnX9m4f9w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vh2cc-00000000fo2-0OzK;
	Sat, 17 Jan 2026 10:29:30 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/4] scripts/kernel-doc: avoid error_count overflows
Date: Sat, 17 Jan 2026 10:29:24 +0100
Message-ID: <23206b5bc44601d0a0bce30adb77cc0f58b49234.1768642102.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768642102.git.mchehab+huawei@kernel.org>
References: <cover.1768642102.git.mchehab+huawei@kernel.org>
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
index 7a1eaf986bcd..1ebb16b9bb08 100755
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
2.52.0


