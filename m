Return-Path: <stable+bounces-220882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGDLNcpHo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:53:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4E1C77EE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5AFB3374F99
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4821F4209B6;
	Sat, 28 Feb 2026 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRx016mf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C741F54A;
	Sat, 28 Feb 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300773; cv=none; b=k++2DxRqcY+qoLfbrjwcU1A2GTZ1psHvLBsRa9ok/sXU/soMuRtvafAeS2psTJwCKWuszAhw0hej7FZz2wQcOTFdKegGV2xG2nK0f/cdm/gwk76r2BWc2GZf/8mbkWZL824JGjtoC/iY9L0wTBIFBT8ZsBgMw93cN39orw8imUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300773; c=relaxed/simple;
	bh=YB007UTpIrmYR82LZcTIZxezIlKmCVaQ/ScAfFNf/lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhSHDJJK6dJCQHCF9D6C3LNF+4SvQV2SAjjGqcv1DIHsytCcz462wan0amI6wCseCmfscQ5SJt5kmxTjbLkx+JKaQ7czQckUxN11XvxeoIiRNRYyYu2TCdN4D+X7kji0xe9HReBoiTtMoQftC5uFAo4LLjJ6Bx8CZdFWds8+Yd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRx016mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40B5C116D0;
	Sat, 28 Feb 2026 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300772;
	bh=YB007UTpIrmYR82LZcTIZxezIlKmCVaQ/ScAfFNf/lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRx016mfGNaEYppPS/18HJbOPzFACO+TMIPj+apy2BblC+nXPn4x35jvGH4S9JlOo
	 sja3FC+LjPQhnE9Z0uumUspegTIuxqYSo/iZUgkCOlSdACL3kNlRPjXJkVBpNFIu6O
	 yu1QdzRv0bAGilyZG9gNEjtalpcfE0nkm3187vTR/tXU1NvYkk7/ZO4E0IgW+FDrjs
	 UNwDYR+zQpOET8OAwNCH9EbCs13iz7DdRZn/zJSSkU52f9zgLC/4qRuCUJzTsYL7kR
	 c04aZWvZN1YDaDayPqZheocx56tv/SXL+VFzYf7KOWnjEK6O2zL/gfEfFz/EIwVB2p
	 18REGvoJws/eA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Steve French <stfrench@microsoft.com>,
	Juergen Gross <jgross@suse.com>,
	Nicolas Schier <nsc@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 803/844] kernel: rpm-pkg: Restore find-debuginfo.sh approach to -debuginfo package
Date: Sat, 28 Feb 2026 12:31:56 -0500
Message-ID: <20260228173244.1509663-804-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220882-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,find-debuginfo.sh:url]
X-Rspamd-Queue-Id: 13D4E1C77EE
X-Rspamd-Action: no action

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit ffe9ac1ad56df8f915896b97bd7645f522c47ce9 ]

Commit 62089b804895 ("kbuild: rpm-pkg: Generate debuginfo package
manually") effectively reverted commit a7c699d090a1 ("kbuild: rpm-pkg:
build a debuginfo RPM") but the approach it took is not safe for older
RPM releases. Restore commit a7c699d090a1 ("kbuild: rpm-pkg: build a
debuginfo RPM") for the !CONFIG_MODULE_SIG case to allow more
environments and configurations to take advantage of the separate debug
information package process.

Cc: stable@vger.kernel.org
Fixes: 62089b804895 ("kbuild: rpm-pkg: Generate debuginfo package manually")
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Steve French <stfrench@microsoft.com>
Tested-by: Juergen Gross <jgross@suse.com>
Acked-by: Nicolas Schier <nsc@kernel.org>
Link: https://patch.msgid.link/20260210-kbuild-fix-debuginfo-rpm-v1-2-0730b92b14bc@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/kernel.spec | 50 ++++++++++++++++++++++++++++++++++---
 scripts/package/mkspec      |  5 ++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index b7deb159f404d..af682a7054779 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -2,8 +2,6 @@
 %{!?_arch: %define _arch dummy}
 %{!?make: %define make make}
 %define makeflags %{?_smp_mflags} ARCH=%{ARCH}
-%define __spec_install_post /usr/lib/rpm/brp-compress || :
-%define debug_package %{nil}
 
 Name: kernel
 Summary: The Linux Kernel
@@ -56,6 +54,38 @@ This package provides debug information for the kernel image and modules from th
 %define install_mod_strip 1
 %endif
 
+%if %{with_debuginfo_rpm}
+# list of debuginfo-related options taken from distribution kernel.spec
+# files
+%undefine _include_minidebuginfo
+%undefine _find_debuginfo_dwz_opts
+%undefine _unique_build_ids
+%undefine _unique_debug_names
+%undefine _unique_debug_srcs
+%undefine _debugsource_packages
+%undefine _debuginfo_subpackages
+%global _find_debuginfo_opts -r
+%global _missing_build_ids_terminate_build 1
+%global _no_recompute_build_ids 1
+%{debug_package}
+
+# later, we make all modules executable so that find-debuginfo.sh strips
+# them up. but they don't actually need to be executable, so remove the
+# executable bit, taking care to do it _after_ find-debuginfo.sh has run
+%define __spec_install_post \
+	%{?__debug_package:%{__debug_install_post}} \
+	%{__arch_install_post} \
+	%{__os_install_post} \
+	find %{buildroot}/lib/modules/%{KERNELRELEASE} -name "*.ko" -type f \\\
+		| xargs --no-run-if-empty chmod u-x
+%else
+%define __spec_install_post /usr/lib/rpm/brp-compress || :
+%endif
+# some (but not all) versions of rpmbuild emit %%debug_package with
+# %%install. since we've already emitted it manually, that would cause
+# a package redefinition error. ensure that doesn't happen
+%define debug_package %{nil}
+
 %prep
 %setup -q -n linux
 cp %{SOURCE1} .config
@@ -99,14 +129,22 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
 	echo "%exclude /lib/modules/%{KERNELRELEASE}/build"
 } > %{buildroot}/kernel.list
 
-%if %{with_debuginfo_manual}
+%if 0%{with_debuginfo_manual}%{with_debuginfo_rpm} > 0
 # copying vmlinux directly to the debug directory means it will not get
 # stripped (but its source paths will still be collected + fixed up)
 mkdir -p %{buildroot}/usr/lib/debug/lib/modules/%{KERNELRELEASE}
 cp vmlinux %{buildroot}/usr/lib/debug/lib/modules/%{KERNELRELEASE}
+%endif
 
-echo /usr/lib/debug/lib/modules/%{KERNELRELEASE}/vmlinux > %{buildroot}/debuginfo.list
+%if %{with_debuginfo_rpm}
+# make modules executable so that find-debuginfo.sh strips them. this
+# will be undone later in %%__spec_install_post
+find %{buildroot}/lib/modules/%{KERNELRELEASE} -name "*.ko" -type f \
+	| xargs --no-run-if-empty chmod u+x
+%endif
 
+%if %{with_debuginfo_manual}
+echo /usr/lib/debug/lib/modules/%{KERNELRELEASE}/vmlinux > %{buildroot}/debuginfo.list
 while read -r mod; do
 	mod="${mod%.o}.ko"
 	dbg="%{buildroot}/usr/lib/debug/lib/modules/%{KERNELRELEASE}/kernel/${mod}"
@@ -124,6 +162,10 @@ done < modules.order
 
 %clean
 rm -rf %{buildroot}
+%if %{with_debuginfo_rpm}
+rm -f debugfiles.list debuglinks.list debugsourcefiles.list debugsources.list \
+	elfbins.list
+%endif
 
 %post
 if [ -x /usr/bin/kernel-install ]; then
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 1080395ca0e16..c604f8c174e2c 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -23,6 +23,8 @@ else
 echo '%define with_devel 0'
 fi
 
+# use %{debug_package} machinery to generate -debuginfo
+with_debuginfo_rpm=0
 # manually generate -debuginfo package
 with_debuginfo_manual=0
 # debuginfo package generation uses find-debuginfo.sh under the hood,
@@ -56,9 +58,12 @@ if grep -q CONFIG_DEBUG_INFO=y include/config/auto.conf &&
 				with_debuginfo_manual='%{?_without_debuginfo:0}%{?!_without_debuginfo:1}'
 			fi
 		fi
+	else
+		with_debuginfo_rpm='%{?_without_debuginfo:0}%{?!_without_debuginfo:1}'
 	fi
 fi
 echo "%define with_debuginfo_manual $with_debuginfo_manual"
+echo "%define with_debuginfo_rpm $with_debuginfo_rpm"
 
 cat<<EOF
 %define ARCH ${ARCH}
-- 
2.51.0


