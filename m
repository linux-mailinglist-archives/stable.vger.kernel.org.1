Return-Path: <stable+bounces-186800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C34BE9A84
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2F6835D639
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5906335063;
	Fri, 17 Oct 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zOo0j3ST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC832C93B;
	Fri, 17 Oct 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714273; cv=none; b=GE+0r9yISN4jBYA018W69rDR017/JcRfYqrG+fN6KnNjFebvlmBZfAzkVW9omKExPxyWJFXAu5dSRGvkn3PSAENkRr1pbNk0a/IMT1XJPE0q8cS0EbHygs4llkaknw4y7B/lLSiPdKmGPhmpUBRCvi36nMw09uWcJ6PEmWi7xdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714273; c=relaxed/simple;
	bh=IBfMeR00MoQhgjpN1fogb9sVNDJp8f0qmqdpxQjw4ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3qF1KmHwsJ4mXV10MJdNzZe8YKJ1xh3qvrL5PP82wAQWnY+p2zoMD0EZfPZGxJMHHajAPrp79LOnggfku5aQGqu2EJMBkrtFUtel2tzt68JpN1UJ/Xcv3WEtT0d/oQiJs2ia6nLsoTKCtCS6d16ZKnPE72u1sl8e2/vk4dGyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zOo0j3ST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA279C4CEE7;
	Fri, 17 Oct 2025 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714273;
	bh=IBfMeR00MoQhgjpN1fogb9sVNDJp8f0qmqdpxQjw4ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zOo0j3STNU79IWYwHDaLOrxTyizI9ick2ZXJrZqsZ2Z+vvCOWy0LGG6Nhlgh59mWF
	 j2TD84b4MgeBrhGxBKAye2jUK1n3x+fIUTzcgIyxgEJ4CdyYU38r7He6HexGGWdIbq
	 LLmScN8OF3eDJ5VrX3MqKPWYqc7qhJGnix9QVnOE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.12 087/277] ACPI: debug: fix signedness issues in read/write helpers
Date: Fri, 17 Oct 2025 16:51:34 +0200
Message-ID: <20251017145150.311300762@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>

commit 496f9372eae14775e0524e83e952814691fe850a upstream.

In the ACPI debugger interface, the helper functions for read and write
operations use "int" as the length parameter data type. When a large
"size_t count" is passed from the file operations, this cast to "int"
results in truncation and a negative value due to signed integer
representation.

Logically, this negative number propagates to the min() calculation,
where it is selected over the positive buffer space value, leading to
unexpected behavior. Subsequently, when this negative value is used in
copy_to_user() or copy_from_user(), it is interpreted as a large positive
value due to the unsigned nature of the size parameter in these functions,
causing the copy operations to attempt handling sizes far beyond the
intended buffer limits.

Address the issue by:
 - Changing the length parameters in acpi_aml_read_user() and
   acpi_aml_write_user() from "int" to "size_t", aligning with the
   expected unsigned size semantics.
 - Updating return types and local variables in acpi_aml_read() and
   acpi_aml_write() to "ssize_t" for consistency with kernel file
   operation conventions.
 - Using "size_t" for the "n" variable to ensure calculations remain
   unsigned.
 - Using min_t() for circ_count_to_end() and circ_space_to_end() to
   ensure type-safe comparisons and prevent integer overflow.

Signed-off-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Link: https://patch.msgid.link/20250923013113.20615-1-a.jahangirzad@gmail.com
[ rjw: Changelog tweaks, local variable definitions ordering adjustments ]
Fixes: 8cfb0cdf07e2 ("ACPI / debugger: Add IO interface to access debugger functionalities")
Cc: 4.5+ <stable@vger.kernel.org> # 4.5+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_dbg.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -569,11 +569,11 @@ static int acpi_aml_release(struct inode
 	return 0;
 }
 
-static int acpi_aml_read_user(char __user *buf, int len)
+static ssize_t acpi_aml_read_user(char __user *buf, size_t len)
 {
-	int ret;
 	struct circ_buf *crc = &acpi_aml_io.out_crc;
-	int n;
+	ssize_t ret;
+	size_t n;
 	char *p;
 
 	ret = acpi_aml_lock_read(crc, ACPI_AML_OUT_USER);
@@ -582,7 +582,7 @@ static int acpi_aml_read_user(char __use
 	/* sync head before removing logs */
 	smp_rmb();
 	p = &crc->buf[crc->tail];
-	n = min(len, circ_count_to_end(crc));
+	n = min_t(size_t, len, circ_count_to_end(crc));
 	if (copy_to_user(buf, p, n)) {
 		ret = -EFAULT;
 		goto out;
@@ -599,8 +599,8 @@ out:
 static ssize_t acpi_aml_read(struct file *file, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	int ret = 0;
-	int size = 0;
+	ssize_t ret = 0;
+	ssize_t size = 0;
 
 	if (!count)
 		return 0;
@@ -639,11 +639,11 @@ again:
 	return size > 0 ? size : ret;
 }
 
-static int acpi_aml_write_user(const char __user *buf, int len)
+static ssize_t acpi_aml_write_user(const char __user *buf, size_t len)
 {
-	int ret;
 	struct circ_buf *crc = &acpi_aml_io.in_crc;
-	int n;
+	ssize_t ret;
+	size_t n;
 	char *p;
 
 	ret = acpi_aml_lock_write(crc, ACPI_AML_IN_USER);
@@ -652,7 +652,7 @@ static int acpi_aml_write_user(const cha
 	/* sync tail before inserting cmds */
 	smp_mb();
 	p = &crc->buf[crc->head];
-	n = min(len, circ_space_to_end(crc));
+	n = min_t(size_t, len, circ_space_to_end(crc));
 	if (copy_from_user(p, buf, n)) {
 		ret = -EFAULT;
 		goto out;
@@ -663,14 +663,14 @@ static int acpi_aml_write_user(const cha
 	ret = n;
 out:
 	acpi_aml_unlock_fifo(ACPI_AML_IN_USER, ret >= 0);
-	return n;
+	return ret;
 }
 
 static ssize_t acpi_aml_write(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	int ret = 0;
-	int size = 0;
+	ssize_t ret = 0;
+	ssize_t size = 0;
 
 	if (!count)
 		return 0;



