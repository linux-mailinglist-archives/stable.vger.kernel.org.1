Return-Path: <stable+bounces-220883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDXnAuZHo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E021C7812
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E935C30A45BA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA15042286B;
	Sat, 28 Feb 2026 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EALGbI8u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7541422862;
	Sat, 28 Feb 2026 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300773; cv=none; b=A+N4/1wHwJvJAIm/QZfRQrSvvNXqswIHGlSFP8gn2Yfihd9Z+ZOCK+kXLhduBbbYRwY/Qy6UGSmDlc/X6l/35kmcYbKA75MoPGPv6/C5WDrRo3scvIWa7NDnacjaeMx3NksoVh+lioS78SJYzzju+TWR8BsQ1RhB1DgVSRrprYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300773; c=relaxed/simple;
	bh=jrIlJDL/pjOdfkX9pYY0T+697pkl1IIOum/4Eo93nzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vq8n+gwuIVKJUw+yB6KHXoGso4huh/XuyAYR4Q+M5whUTly5Di5OhobmnHuJceZ5d936khZajXRFtFEg7GmbXeTxJXnen9JsDVLj2kHPCBqMlcFcCc6ICoqbr7LTQBFc/2qKvMA1SR6SFatKTjhTYgT5pDlwZvt91iFq8jeQ4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EALGbI8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE971C19425;
	Sat, 28 Feb 2026 17:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300773;
	bh=jrIlJDL/pjOdfkX9pYY0T+697pkl1IIOum/4Eo93nzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EALGbI8uyaX7+AX7HnmYe1YpC9mFq8Zay34DwIbi9+iE4C7aSKC4zabNIERr+YrI+
	 PDakI+XFxs0825GyhwTtmzTiyk1ssj4kR4rAEI/p9IXcVukb/mMdFcUeYtjSljZHKZ
	 VQVoXXYYvsqcI6FkEhFmtFRcaeS1leeYpG1uKoTxpR9UG2vf3xOZmUcaZOHlNkObyV
	 iVVqK/W7ESx9RGulYVhjEGSyZmJjGhOQ0T6QQzscKSCxQplJqOSKIRMP70jypaFpN7
	 dwOIV/YriSTryN5fL6c8rm87EEosAKI9OaN6eiA/1nbdr86Lbt0Fo266uuwX8jRVF9
	 MFP7ddC8B6lQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Lukas Herbolt <lukas@herbolt.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 804/844] kbuild: rpm-pkg: Fix manual debuginfo generation when using .src.rpm
Date: Sat, 28 Feb 2026 12:31:57 -0500
Message-ID: <20260228173244.1509663-805-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220883-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,p:email]
X-Rspamd-Queue-Id: A1E021C7812
X-Rspamd-Action: no action

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit afdfb71c018e9a0aa2e51fb8186d3fb1acdd3f0e ]

Commit 62089b804895 ("kbuild: rpm-pkg: Generate debuginfo package
manually") added uses of OBJCOPY and READELF, variables from Kbuild.
These variables are defined and work properly when using the binrpm-pkg
target because rpmbuild is run within Kbuild. However, these variables
are not defined when building from a source RPM package generated with
the srcrpm-pkg target, breaking the build when generating the debug info
subpackage.

Define a default value for these variables so that these commands
respect the value from Kbuild but continue to work when built from a
source RPM package.

Cc: stable@vger.kernel.org
Fixes: 62089b804895 ("kbuild: rpm-pkg: Generate debuginfo package manually")
Reported-by: Lukas Herbolt <lukas@herbolt.com>
Closes: https://lore.kernel.org/20260212135855.147906-2-lukas@herbolt.com/
Tested-by: Lukas Herbolt <lukas@herbolt.com>
Link: https://patch.msgid.link/20260213-fix-debuginfo-srcrpm-pkg-v1-1-45cd0c0501b9@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/kernel.spec | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index af682a7054779..bccf58bdd45fd 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -148,11 +148,11 @@ echo /usr/lib/debug/lib/modules/%{KERNELRELEASE}/vmlinux > %{buildroot}/debuginf
 while read -r mod; do
 	mod="${mod%.o}.ko"
 	dbg="%{buildroot}/usr/lib/debug/lib/modules/%{KERNELRELEASE}/kernel/${mod}"
-	buildid=$("${READELF}" -n "${mod}" | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p')
+	buildid=$("${READELF:-readelf}" -n "${mod}" | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p')
 	link="%{buildroot}/usr/lib/debug/.build-id/${buildid}.debug"
 
 	mkdir -p "${dbg%/*}" "${link%/*}"
-	"${OBJCOPY}" --only-keep-debug "${mod}" "${dbg}"
+	"${OBJCOPY:-objcopy}" --only-keep-debug "${mod}" "${dbg}"
 	ln -sf --relative "${dbg}" "${link}"
 
 	echo "${dbg#%{buildroot}}" >> %{buildroot}/debuginfo.list
-- 
2.51.0


