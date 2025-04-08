Return-Path: <stable+bounces-131839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7476A814E9
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CEA3B2F7E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD28204F79;
	Tue,  8 Apr 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RerGrZ9A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84D23A0
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137923; cv=none; b=fYCwLanUcLJOYwAYju5AQg95cEkv7Mqu6CiexfMa3Nf6vb/ljhehSlAYJHwaZpht6wN21mxkZZS92+ESmMpfWByQKuaBN2IcaBYDR22RHXi8MMRl9E09MS5t1we4qxBiVt4YnlL2Ua4E7MiyG63Iv7P6rDDsCwrDT5+Zx1gmXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137923; c=relaxed/simple;
	bh=OS+5MrM5St3m2FWaSjKKYWydpMCMlPYsspCzzA3pZow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKEpVjjg10dboPAqebTmGY3NLBNIZXz2Pe4ZW5djgp22QCAZ+FHOfEtx4u1r0N6tYdjN+84mwv+k4ysBRoi/1cNC4aN/3tnAn7n9Lic2MV0xuhIDlkBySe9LLVq6gcx3xsC0kVFoJpyXoZe7q30B65izcwmLYXo+rVEDc0op4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RerGrZ9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB0EC4CEE5;
	Tue,  8 Apr 2025 18:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744137922;
	bh=OS+5MrM5St3m2FWaSjKKYWydpMCMlPYsspCzzA3pZow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RerGrZ9AIJwLdJwB4NeYZcGBatxDbgZ5L8JjGDK6grmRDE9yQu56fJYdRPyPYG8+W
	 r89RXKwJtt4jTCVI/i35Mw9Ld3ZL1Wk6/Qfo7GPobQixQP31FplpQ8rLwsLw/ZTs2p
	 7EgWO5E4bWqBMrOiR4f0V8ChoS39fmpVAHp+ufeavnUXNkdqddkZ6N45uSUw69UB5O
	 hYGKVwspb/Z78OoHzW/Wvl8gXIWzOyl8IK83HlFD7LGTDs8EW0TYM7oFTMNZLN8rSp
	 kTwZ4uW4mPQHzOSeDsZBO1/uB+wLeBeNriUhwTIwbVvVLx0aoLRO8mCAVWHoWk0Gp9
	 ZRnZVdjqlEhfg==
Date: Tue, 8 Apr 2025 11:45:18 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: lkml@johnrowley.me, mpearson-lenovo@squebb.ca,
	rafael.j.wysocki@intel.com, samitolvanen@google.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ACPI: platform-profile: Fix CFI violation
 when accessing" failed to apply to 6.13-stable tree
Message-ID: <20250408184518.GA2217235@ax162>
References: <2025040803-womb-decorated-10be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uzFJSWkS2KTdaKUP"
Content-Disposition: inline
In-Reply-To: <2025040803-womb-decorated-10be@gregkh>


--uzFJSWkS2KTdaKUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2025 at 11:14:03AM +0200, gregkh@linuxfoundation.org wrote:
...
> From dd4f730b557ce701a2cd4f604bf1e57667bd8b6e Mon Sep 17 00:00:00 2001
> From: Nathan Chancellor <nathan@kernel.org>
> Date: Mon, 10 Feb 2025 21:28:25 -0500
> Subject: [PATCH] ACPI: platform-profile: Fix CFI violation when accessing
>  sysfs files

Attached is a backport that should apply cleanly to 6.13 through 5.15.

Cheers,
Nathan

--uzFJSWkS2KTdaKUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-ACPI-platform-profile-Fix-CFI-violation-when-accessi.patch

From 52492863472c7f8eb750dcda14f574e96bebe471 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 10 Feb 2025 21:28:25 -0500
Subject: [PATCH 6.13 and earlier] ACPI: platform-profile: Fix CFI violation
 when accessing sysfs files

commit dd4f730b557ce701a2cd4f604bf1e57667bd8b6e upstream.

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
[nathan: Fix conflicts in older stable branches]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/acpi/platform_profile.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2f7fd7743a1..11278f785526 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -22,8 +22,8 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
-static ssize_t platform_profile_choices_show(struct device *dev,
-					struct device_attribute *attr,
+static ssize_t platform_profile_choices_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
 					char *buf)
 {
 	int len = 0;
@@ -49,8 +49,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	return len;
 }
 
-static ssize_t platform_profile_show(struct device *dev,
-					struct device_attribute *attr,
+static ssize_t platform_profile_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
 					char *buf)
 {
 	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
@@ -77,8 +77,8 @@ static ssize_t platform_profile_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
 
-static ssize_t platform_profile_store(struct device *dev,
-			    struct device_attribute *attr,
+static ssize_t platform_profile_store(struct kobject *kobj,
+			    struct kobj_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int err, i;
@@ -115,12 +115,12 @@ static ssize_t platform_profile_store(struct device *dev,
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
 

base-commit: 1edf71b4b7d9f599843d2c5280537d10be495ebc
-- 
2.49.0


--uzFJSWkS2KTdaKUP--

