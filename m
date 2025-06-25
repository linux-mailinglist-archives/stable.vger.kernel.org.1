Return-Path: <stable+bounces-158505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66761AE7AC6
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5943ABC64
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C1228643A;
	Wed, 25 Jun 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1LP6xwl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6114028643E
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841291; cv=none; b=HCIUkUTEzU0+HGGfxComKXcVeq6GiSPNPhWnMhlULXRYQA45sVgapxc0KTIR5kZx7xEtuljLuAtfFPqofvoGt7euS8bOVnQWFNy5LfpuKnsAN6Rfm3txU3B+wstrmDP8EIvYUIIlVZ+KjgB8HsjgYO+P+/2JOjGWgfrd9ndCE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841291; c=relaxed/simple;
	bh=Llfux1su6RBWemkt650U8JuOyobsWBEphsdUzvBEfe8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hOTH7gBT4vO5CN1GWskdOed+EPDXfQs3Reo5zOJRRI+UtnjXlg8E/GtVnSyTwsZOXA0LY4cxBj1FPI43Q/JGTEolLr5s7q74TPGVq0xuJaRfr7RLfAkvbT9riyJ5iLWBm2ASb0UJ0OQKJULKohgxj+ESImwVY4Dmg91qJdy8s0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1LP6xwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB74FC4CEEA;
	Wed, 25 Jun 2025 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750841290;
	bh=Llfux1su6RBWemkt650U8JuOyobsWBEphsdUzvBEfe8=;
	h=Subject:To:Cc:From:Date:From;
	b=x1LP6xwlv7mPEh1kGF6daiD3+M5Dk/vq4dXRgaeAln9IULyKfA5Rz4ynktaQO8t1p
	 oAib8wmGbcEWtCWHqSTt0mxkaQSr0y2rreQCeOz4mDTTvQjfQneVUTFzLOgM5Kw5V4
	 yuZ3vxyOYQPzs66e0CvJxvcg/Y0QyIAkLC1uAjvI=
Subject: FAILED: patch "[PATCH] kbuild: Update assembler calls to use proper flags and" failed to apply to 5.4-stable tree
To: ndesaulniers@google.com,anders.roxell@linaro.org,lkft@linaro.org,masahiroy@kernel.org,nathan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Jun 2025 09:48:07 +0100
Message-ID: <2025062507-surgical-strive-b54b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062507-surgical-strive-b54b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0 Mon Sep 17 00:00:00 2001
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 11 Jan 2023 20:05:01 -0700
Subject: [PATCH] kbuild: Update assembler calls to use proper flags and
 language target

as-instr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS. This can
cause as-option to fail unexpectedly when CONFIG_WERROR is set, because
clang will emit -Werror,-Wunused-command-line-argument for various -m
and -f flags in KBUILD_CFLAGS for assembler sources.

Callers of as-option and as-instr should be adding flags to
KBUILD_AFLAGS / aflags-y, not KBUILD_CFLAGS / cflags-y. Use
KBUILD_AFLAGS in all macros to clear up the initial problem.

Unfortunately, -Wunused-command-line-argument can still be triggered
with clang by the presence of warning flags or macro definitions because
'-x assembler' is used, instead of '-x assembler-with-cpp', which will
consume these flags. Switch to '-x assembler-with-cpp' in places where
'-x assembler' is used, as the compiler is always used as the driver for
out of line assembler sources in the kernel.

Finally, add -Werror to these macros so that they behave consistently
whether or not CONFIG_WERROR is set.

[nathan: Reworded and expanded on problems in commit message
         Use '-x assembler-with-cpp' in a couple more places]

Link: https://github.com/ClangBuiltLinux/linux/issues/1699
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 274125307ebd..5a84b6443875 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -33,7 +33,7 @@ ld-option = $(success,$(LD) -v $(1))
 
 # $(as-instr,<instr>)
 # Return y if the assembler supports <instr>, n otherwise
-as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler -o /dev/null -)
+as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler-with-cpp -o /dev/null -)
 
 # check if $(CC) and $(LD) exist
 $(error-if,$(failure,command -v $(CC)),C compiler '$(CC)' not found)
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 3d8adfd34af1..7aa1fbc4aafe 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -29,16 +29,16 @@ try-run = $(shell set -e;		\
 	fi)
 
 # as-option
-# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
+# Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
-# Usage: cflags-y += $(call as-instr,instr,option1,option2)
+# Usage: aflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
+	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
 
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
diff --git a/scripts/as-version.sh b/scripts/as-version.sh
index 1a21495e9ff0..af717476152d 100755
--- a/scripts/as-version.sh
+++ b/scripts/as-version.sh
@@ -45,7 +45,7 @@ orig_args="$@"
 # Get the first line of the --version output.
 IFS='
 '
-set -- $(LC_ALL=C "$@" -Wa,--version -c -x assembler /dev/null -o /dev/null 2>/dev/null)
+set -- $(LC_ALL=C "$@" -Wa,--version -c -x assembler-with-cpp /dev/null -o /dev/null 2>/dev/null)
 
 # Split the line on spaces.
 IFS=' '


