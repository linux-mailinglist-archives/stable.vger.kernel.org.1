Return-Path: <stable+bounces-128849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EC3A7F923
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EC8169069
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200CB221573;
	Tue,  8 Apr 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RI+l4v/C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1C10E5
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103747; cv=none; b=iUIy0snj2iEMO1sZD2ijDmjtaIjjxtZ5ujQQGNvZvUOITZHk4amPGJ06vlluugzh9j3isYQm0zZJwZ6KeqjTLm/xGqpoBWcMPVLxk7xuYSu9fqOqreyIlW3E6OQFOumXfWq9CZGAe2gLsvc48nVv3sZXIZB5f3MCxd57i6/u+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103747; c=relaxed/simple;
	bh=zWyAenS+13sBCmvHR+XOqnWP+G9HhN5uVKom1eHB0F4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Guy3nnS/LYYFoM1KsvLR+H06sFK6gaHHWqIGdWhepucrNBV7P+JEuFEVouh5KvS38pZXon7rbjq1b9Pz/Z06VM0PB2cU23Jl27imJ2V4h0CvLV7QNEiMlv4kJWi63mZqCp9sl0mMz4yoqK1sYY5wfcvYJLnrs9eOsv6ox2MPOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RI+l4v/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658F0C4CEE5;
	Tue,  8 Apr 2025 09:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744103747;
	bh=zWyAenS+13sBCmvHR+XOqnWP+G9HhN5uVKom1eHB0F4=;
	h=Subject:To:Cc:From:Date:From;
	b=RI+l4v/CU1oVLxQhGbtH+TDU6v78qEBl6GeN4mOm1szmU2v9XB5EOuluCs/4H7Ah2
	 dyUsk6gliKnltPGLxQkfZ6AzdQZFc9Trmx6iAAW4Owb+Pi0Fjd8uAqPiwxu3VWYkCd
	 Ws9sg97jmh2l6jjzdZJJASi+9EhwCYwX+XIRdvHc=
Subject: FAILED: patch "[PATCH] ACPI: platform-profile: Fix CFI violation when accessing" failed to apply to 6.12-stable tree
To: nathan@kernel.org,gregkh@linuxfoundation.org,lkml@johnrowley.me,mpearson-lenovo@squebb.ca,rafael.j.wysocki@intel.com,samitolvanen@google.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 11:14:04 +0200
Message-ID: <2025040804-submitter-spur-cf1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x dd4f730b557ce701a2cd4f604bf1e57667bd8b6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040804-submitter-spur-cf1a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dd4f730b557ce701a2cd4f604bf1e57667bd8b6e Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 10 Feb 2025 21:28:25 -0500
Subject: [PATCH] ACPI: platform-profile: Fix CFI violation when accessing
 sysfs files

When an attribute group is created with sysfs_create_group(), the
->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
and ->store() callbacks to kobj_attr_show() and kobj_attr_store()
respectively. These functions use container_of() to get the respective
callback from the passed attribute, meaning that these callbacks need to
be of the same type as the callbacks in 'struct kobj_attribute'.

However, ->show() and ->store() in the platform_profile driver are
defined for struct device_attribute with the help of DEVICE_ATTR_RO()
and DEVICE_ATTR_RW(), which results in a CFI violation when accessing
platform_profile or platform_profile_choices under /sys/firmware/acpi
because the types do not match:

  CFI failure at kobj_attr_show+0x19/0x30 (target: platform_profile_choices_show+0x0/0x140; expected type: 0x7a69590c)

There is no functional issue from the type mismatch because the layout
of 'struct kobj_attribute' and 'struct device_attribute' are the same,
so the container_of() cast does not break anything aside from CFI.

Change the type of platform_profile_choices_show() and
platform_profile_{show,store}() to match the callbacks in
'struct kobj_attribute' and update the attribute variables to
match, which resolves the CFI violation.

Cc: All applicable <stable@vger.kernel.org>
Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
Reported-by: John Rowley <lkml@johnrowley.me>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2047
Tested-by: John Rowley <lkml@johnrowley.me>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://patch.msgid.link/20250210-acpi-platform_profile-fix-cfi-violation-v3-1-ed9e9901c33a@kernel.org
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index fc92e43d0fe9..1b6317f759f9 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -260,14 +260,14 @@ static int _aggregate_choices(struct device *dev, void *data)
 
 /**
  * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
- * @dev: The device
+ * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
  *
  * Return: The number of bytes written
  */
-static ssize_t platform_profile_choices_show(struct device *dev,
-					     struct device_attribute *attr,
+static ssize_t platform_profile_choices_show(struct kobject *kobj,
+					     struct kobj_attribute *attr,
 					     char *buf)
 {
 	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
@@ -333,14 +333,14 @@ static int _store_and_notify(struct device *dev, void *data)
 
 /**
  * platform_profile_show - Show the current profile for legacy sysfs interface
- * @dev: The device
+ * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
  *
  * Return: The number of bytes written
  */
-static ssize_t platform_profile_show(struct device *dev,
-				     struct device_attribute *attr,
+static ssize_t platform_profile_show(struct kobject *kobj,
+				     struct kobj_attribute *attr,
 				     char *buf)
 {
 	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
@@ -362,15 +362,15 @@ static ssize_t platform_profile_show(struct device *dev,
 
 /**
  * platform_profile_store - Set the profile for legacy sysfs interface
- * @dev: The device
+ * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to read from
  * @count: The number of bytes to read
  *
  * Return: The number of bytes read
  */
-static ssize_t platform_profile_store(struct device *dev,
-				      struct device_attribute *attr,
+static ssize_t platform_profile_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
 				      const char *buf, size_t count)
 {
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
@@ -401,12 +401,12 @@ static ssize_t platform_profile_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR_RO(platform_profile_choices);
-static DEVICE_ATTR_RW(platform_profile);
+static struct kobj_attribute attr_platform_profile_choices = __ATTR_RO(platform_profile_choices);
+static struct kobj_attribute attr_platform_profile = __ATTR_RW(platform_profile);
 
 static struct attribute *platform_profile_attrs[] = {
-	&dev_attr_platform_profile_choices.attr,
-	&dev_attr_platform_profile.attr,
+	&attr_platform_profile_choices.attr,
+	&attr_platform_profile.attr,
 	NULL
 };
 


