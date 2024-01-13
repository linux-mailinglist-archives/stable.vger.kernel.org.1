Return-Path: <stable+bounces-10604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D820082C7E7
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 00:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CE41F236B5
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 23:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BC519464;
	Fri, 12 Jan 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UBcHpn0T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838218EA9;
	Fri, 12 Jan 2024 23:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5454CC433F1;
	Fri, 12 Jan 2024 23:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705101694;
	bh=cYkbbRPNxqkT+TbMIg0EHzIdvmK/YAdVe2ESpDB/4d0=;
	h=Date:To:From:Subject:From;
	b=UBcHpn0TtTdAi7nC0qKzoR7LFsN7csD/plgLZ4UrAav2KoLwwosQRBua0IuoBZs05
	 PUT+BCUMAZ1R5ziF+qKVnLlbZHkrjuxkLsow+XChpGy98Drll1eb6on+PsL1hBMyRR
	 0DeK4ge+qXjXKUm6zvxV9Y6884v5URkcjm4h4akE=
Date: Fri, 12 Jan 2024 15:21:33 -0800
To: mm-commits@vger.kernel.org,will@kernel.org,trix@redhat.com,stable@vger.kernel.org,quic_eberman@quicinc.com,ndesaulniers@google.com,nathan@kernel.org,masahiroy@kernel.org,justinstitt@google.com,jstultz@google.com,cmllamas@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] scripts-decode_stacktracesh-optionally-use-llvm-utilities.patch removed from -mm tree
Message-Id: <20240112232134.5454CC433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: scripts/decode_stacktrace.sh: optionally use LLVM utilities
has been removed from the -mm tree.  Its filename was
     scripts-decode_stacktracesh-optionally-use-llvm-utilities.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Carlos Llamas <cmllamas@google.com>
Subject: scripts/decode_stacktrace.sh: optionally use LLVM utilities
Date: Fri, 29 Sep 2023 03:48:17 +0000

GNU's addr2line can have problems parsing a vmlinux built with LLVM,
particularly when LTO was used.  In order to decode the traces correctly
this patch adds the ability to switch to LLVM's utilities readelf and
addr2line.  The same approach is followed by Will in [1].

Before:
  $ scripts/decode_stacktrace.sh vmlinux < kernel.log
  [17716.240635] Call trace:
  [17716.240646] skb_cow_data (??:?)
  [17716.240654] esp6_input (ld-temp.o:?)
  [17716.240666] xfrm_input (ld-temp.o:?)
  [17716.240674] xfrm6_rcv (??:?)
  [...]

After:
  $ LLVM=1 scripts/decode_stacktrace.sh vmlinux < kernel.log
  [17716.240635] Call trace:
  [17716.240646] skb_cow_data (include/linux/skbuff.h:2172 net/core/skbuff.c:4503)
  [17716.240654] esp6_input (net/ipv6/esp6.c:977)
  [17716.240666] xfrm_input (net/xfrm/xfrm_input.c:659)
  [17716.240674] xfrm6_rcv (net/ipv6/xfrm6_input.c:172)
  [...]

Note that one could set CROSS_COMPILE=llvm- instead to hack around this
issue.  However, doing so can break the decodecode routine as it will
force the selection of other LLVM utilities down the line e.g.  llvm-as.

[1] https://lore.kernel.org/all/20230914131225.13415-3-will@kernel.org/

Link: https://lkml.kernel.org/r/20230929034836.403735-1-cmllamas@google.com
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
Tested-by: Justin Stitt <justinstitt@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/decode_stacktrace.sh |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/scripts/decode_stacktrace.sh~scripts-decode_stacktracesh-optionally-use-llvm-utilities
+++ a/scripts/decode_stacktrace.sh
@@ -16,6 +16,21 @@ elif type c++filt >/dev/null 2>&1 ; then
 	cppfilt_opts=-i
 fi
 
+UTIL_SUFFIX=
+if [[ -z ${LLVM:-} ]]; then
+	UTIL_PREFIX=${CROSS_COMPILE:-}
+else
+	UTIL_PREFIX=llvm-
+	if [[ ${LLVM} == */ ]]; then
+		UTIL_PREFIX=${LLVM}${UTIL_PREFIX}
+	elif [[ ${LLVM} == -* ]]; then
+		UTIL_SUFFIX=${LLVM}
+	fi
+fi
+
+READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
+ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
+
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
@@ -75,7 +90,7 @@ find_module() {
 
 	if [[ "$modpath" != "" ]] ; then
 		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
-			if readelf -WS "$fn" | grep -qwF .debug_line ; then
+			if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
 				echo $fn
 				return
 			fi
@@ -169,7 +184,7 @@ parse_symbol() {
 	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
+		local code=$(${ADDR2LINE} -i -e "$objfile" "$address" 2>/dev/null)
 		if [[ $aarray_support == true ]]; then
 			cache[$module,$address]=$code
 		fi
_

Patches currently in -mm which might be from cmllamas@google.com are



