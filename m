Return-Path: <stable+bounces-220881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E2qCR5Lo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:07:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096F1C7ED2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C87FE3364B21
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA283421255;
	Sat, 28 Feb 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjvaEbBp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40A42124D;
	Sat, 28 Feb 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300771; cv=none; b=fUOFoWdfmhnbYE2KgW52RRP/UNanaj4IHVwkIvagLYdfy+8ng1lGzzNnsfQ16zZkpcwSNkXUjEWiCkTMq91aB5J8zyE+LJFx2larCC6DVZ48QoO3Tv/33axVrZAnRbGJpNn9wLNUumDKgKf/wBygW9pt04p27MRjJ9i9XqMsp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300771; c=relaxed/simple;
	bh=9c42ecIz9hQ9+pcNEMXWiBZo4N95fyeynxQzrsL/Tg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0tmyBgP7aNaBSZrVAfpiga1A84H6r29mhvQOvlhmJw2mdSs6D8HflX8Xd9VTR+iSvE3uhb7hpCvh9xc6b9ZDrZuLAXd/xmb5lkG/vmqtFBvqDjVJPpLmjDmR3mM7ET8PfD13TQ3dpVIlgkDnOEEW7EFtLhjymY8mrVv+5ywzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjvaEbBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8341EC2BC9E;
	Sat, 28 Feb 2026 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300771;
	bh=9c42ecIz9hQ9+pcNEMXWiBZo4N95fyeynxQzrsL/Tg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjvaEbBpq73vAaTB79HsJBPHugSpR4kai/NHpbkfpnlhUTm8oVNBsBcKeGDp4uqFz
	 lSTKXX4XIdtLUN77l+CwQ6Qtcy9RLd0l7TKBTAVULHgdLtBFSFKw0HU6eVYJJiPGRu
	 s/Z4sgb6xGplgU7hOg+7+6cff3v+lRX4XJxhIN+WXXl5hHxV5pv06JDgRw15rUTJgS
	 2fzQt3jscqIZFm2/iXkskq8pheGKiQVeS2dWLAQoHlSaxr7dda6itP6dGScyU95cb8
	 idSJiF/C+Txh7r1NcLrCHdUu3QJ8nqM9oGe/FXF6lrh4JUOZecV4NrABrGIhUKAQW9
	 G7UrJR/k9C1dA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Steve French <stfrench@microsoft.com>,
	Juergen Gross <jgross@suse.com>,
	Nicolas Schier <nsc@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 802/844] kbuild: rpm-pkg: Restrict manual debug package creation
Date: Sat, 28 Feb 2026 12:31:55 -0500
Message-ID: <20260228173244.1509663-803-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,microsoft.com,suse.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220881-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,find-debuginfo.sh:url,system.map:url]
X-Rspamd-Queue-Id: 9096F1C7ED2
X-Rspamd-Action: no action

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 6d6b8b0e28c468263d7fcb071e5cb284ae343df2 ]

Commit 62089b804895 ("kbuild: rpm-pkg: Generate debuginfo package
manually") moved away from the built-in RPM machinery for generating
-debuginfo packages to a more manual way to be compatible with module
signing, as the built-in machinery strips the modules after the
installation process, breaking the signatures.

Unfortunately, prior to rpm 4.20.0, there is a bug where a custom %files
directive is ignored for a -debuginfo subpackage [1], meaning builds
using older versions of RPM (such as on RHEL9 or RHEL10) fail with:

  Checking for unpackaged file(s): /usr/lib/rpm/check-files .../rpmbuild/BUILDROOT/kernel-6.19.0_dirty-1.x86_64
  error: Installed (but unpackaged) file(s) found:
     /debuginfo.list
     /usr/lib/debug/.build-id/09/748c214974bfba1522d434a7e0a02e2fd7f29b.debug
     /usr/lib/debug/.build-id/0b/b96dd9c7d3689d82e56d2e73b46f53103cc6c7.debug
     /usr/lib/debug/.build-id/0e/979a2f34967c7437fd30aabb41de1f0c8b6a66.debug
    ...

To workaround this, restrict the manual debug info package creation
process to when it is necessary (CONFIG_MODULE_SIG=y) and possible (when
using RPM >= 4.20.0). A follow up change will restore the RPM debuginfo
creation process using a separate internal flag to allow the package to
be built in more situations, as RPM 4.20.0 is a fairly recent version
and the built-in -debuginfo generation works fine when module signing is
disabled.

Cc: stable@vger.kernel.org
Fixes: 62089b804895 ("kbuild: rpm-pkg: Generate debuginfo package manually")
Link: https://github.com/rpm-software-management/rpm/commit/49f906998f3cf1f4152162ca61ac0869251c380f [1]
Reported-by: Steve French <smfrench@gmail.com>
Closes: https://lore.kernel.org/CAH2r5mugbrHTwnaQwQiYEUVwbtqmvFYf0WZiLrrJWpgT8iwftw@mail.gmail.com/
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Steve French <stfrench@microsoft.com>
Tested-by: Juergen Gross <jgross@suse.com>
Acked-by: Nicolas Schier <nsc@kernel.org>
Link: https://patch.msgid.link/20260210-kbuild-fix-debuginfo-rpm-v1-1-0730b92b14bc@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/kernel.spec |  9 +++++----
 scripts/package/mkspec      | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 0f1c8de1bd95f..b7deb159f404d 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -47,12 +47,13 @@ This package provides kernel headers and makefiles sufficient to build modules
 against the %{version} kernel package.
 %endif
 
-%if %{with_debuginfo}
+%if %{with_debuginfo_manual}
 %package debuginfo
 Summary: Debug information package for the Linux kernel
 %description debuginfo
 This package provides debug information for the kernel image and modules from the
 %{version} package.
+%define install_mod_strip 1
 %endif
 
 %prep
@@ -67,7 +68,7 @@ patch -p1 < %{SOURCE2}
 mkdir -p %{buildroot}/lib/modules/%{KERNELRELEASE}
 cp $(%{make} %{makeflags} -s image_name) %{buildroot}/lib/modules/%{KERNELRELEASE}/vmlinuz
 # DEPMOD=true makes depmod no-op. We do not package depmod-generated files.
-%{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} INSTALL_MOD_STRIP=1 DEPMOD=true modules_install
+%{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} %{?install_mod_strip:INSTALL_MOD_STRIP=1} DEPMOD=true modules_install
 %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 cp System.map %{buildroot}/lib/modules/%{KERNELRELEASE}
 cp .config %{buildroot}/lib/modules/%{KERNELRELEASE}/config
@@ -98,7 +99,7 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
 	echo "%exclude /lib/modules/%{KERNELRELEASE}/build"
 } > %{buildroot}/kernel.list
 
-%if %{with_debuginfo}
+%if %{with_debuginfo_manual}
 # copying vmlinux directly to the debug directory means it will not get
 # stripped (but its source paths will still be collected + fixed up)
 mkdir -p %{buildroot}/usr/lib/debug/lib/modules/%{KERNELRELEASE}
@@ -162,7 +163,7 @@ fi
 /lib/modules/%{KERNELRELEASE}/build
 %endif
 
-%if %{with_debuginfo}
+%if %{with_debuginfo_manual}
 %files -f %{buildroot}/debuginfo.list debuginfo
 %defattr (-, root, root)
 %exclude /debuginfo.list
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index c7375bfc25a9a..1080395ca0e16 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -23,15 +23,42 @@ else
 echo '%define with_devel 0'
 fi
 
+# manually generate -debuginfo package
+with_debuginfo_manual=0
 # debuginfo package generation uses find-debuginfo.sh under the hood,
 # which only works on uncompressed modules that contain debuginfo
 if grep -q CONFIG_DEBUG_INFO=y include/config/auto.conf &&
    (! grep -q CONFIG_MODULE_COMPRESS=y include/config/auto.conf) &&
    (! grep -q CONFIG_DEBUG_INFO_SPLIT=y include/config/auto.conf); then
-echo '%define with_debuginfo %{?_without_debuginfo: 0} %{?!_without_debuginfo: 1}'
-else
-echo '%define with_debuginfo 0'
+	# If module signing is enabled (which may be required to boot with
+	# lockdown enabled), the find-debuginfo.sh machinery cannot be used
+	# because the signatures will be stripped off the modules. However, due
+	# to an rpm bug in versions prior to 4.20.0
+	#
+	#     https://github.com/rpm-software-management/rpm/issues/3057
+	#     https://github.com/rpm-software-management/rpm/commit/49f906998f3cf1f4152162ca61ac0869251c380f
+	#
+	# We cannot provide our own debuginfo package because it does not listen
+	# to our custom files list, failing the build due to unpackaged files.
+	# Manually generate the debug info package if using rpm 4.20.0. If not
+	# using rpm 4.20.0, avoid generating a -debuginfo package altogether,
+	# as it is not safe.
+	if grep -q CONFIG_MODULE_SIG=y include/config/auto.conf; then
+		rpm_ver_str=$(rpm --version 2>/dev/null)
+		# Split the version on spaces
+		IFS=' '
+		set -- $rpm_ver_str
+		if [ "${1:-}" = RPM -a "${2:-}" = version ]; then
+			IFS=.
+			set -- $3
+			rpm_ver=$(( 1000000 * $1 + 10000 * $2 + 100 * $3 + ${4:-0} ))
+			if [ "$rpm_ver" -ge 4200000 ]; then
+				with_debuginfo_manual='%{?_without_debuginfo:0}%{?!_without_debuginfo:1}'
+			fi
+		fi
+	fi
 fi
+echo "%define with_debuginfo_manual $with_debuginfo_manual"
 
 cat<<EOF
 %define ARCH ${ARCH}
-- 
2.51.0


