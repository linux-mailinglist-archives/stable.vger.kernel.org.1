Return-Path: <stable+bounces-98692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C189E4A08
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7957F167E05
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8720D50C;
	Wed,  4 Dec 2024 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2Js8OKJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DBB20D51A;
	Wed,  4 Dec 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355353; cv=none; b=KMxkGStxXefEShQnQiBXg7pn3xBzMS1xo6JXgDaIRSBw9eTW7UJMWVuzX8iu5TY4K7nwOGQmOd+S+bLtJTiKC/ibvIw2vArJ+eEvyFQFzYHdqtDueRfFDzBQuYZZjg6GynT8sb/7QemG4wou3eW8NfPfYmYG5BbrX70hZ+zn7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355353; c=relaxed/simple;
	bh=7hYQI5j+nVjcxPZ2S4iXMwVOXCdAO8jM1GWwwnFjz/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMUAJbLO08jh3/7wPNMLAZW/oGwd0hNk6sgPJUgSOed3k2EXVQA7Ti1cSfh5HutImF59OCdXv3K+Eg0H9/OKk6Ki+tK+38mZJYX0pw+VqLxQ2a3K3wc+3PGrz1mp3OmxmGzTUTjDuwEsZN7xbNEWZQfllsgNSujqQhAOuCCxJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2Js8OKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA39C4CED2;
	Wed,  4 Dec 2024 23:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355352;
	bh=7hYQI5j+nVjcxPZ2S4iXMwVOXCdAO8jM1GWwwnFjz/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2Js8OKJYOOIqTwqSCgvt9HuRrw5oN9cGu62GE8Y0HzNkzeZAM/m0NKFHATMIBdjc
	 R/QWEQ4vMSlSzEaFNT8NFBtFR5mm3oIL436ijPkJlRBZe4oqD5+4O6cTJCJZpvRIe2
	 WCpNVWL9vxzAH0S8nzRtSVhYnnE1mquCg5Hx82FaaVGp1bVXAtfPiiA1TVVDI8efiF
	 Jxq7ZxtoxDRlAPrzHoEzexv/rfgNd+Zpw52Cw6zG1MXI5M4RDEnlmt0qMmg7CCbMaM
	 IG7El9NusdH5yj74gyTk15YkgIp6If4NQUQn5ZIKUM2eglsPCogZwgTfPmc2Lv823G
	 dB6hy92P1p2sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sean Christopherson <seanjc@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 5/6] setlocalversion: work around "git describe" performance
Date: Wed,  4 Dec 2024 17:24:14 -0500
Message-ID: <20241204222425.2250046-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204222425.2250046-1-sashal@kernel.org>
References: <20241204222425.2250046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

[ Upstream commit 523f3dbc187a9618d4fd80c2b438e4d490705dcd ]

Contrary to expectations, passing a single candidate tag to "git
describe" is slower than not passing any --match options.

  $ time git describe --debug
  ...
  traversed 10619 commits
  ...
  v6.12-rc5-63-g0fc810ae3ae1

  real    0m0.169s

  $ time git describe --match=v6.12-rc5 --debug
  ...
  traversed 1310024 commits
  v6.12-rc5-63-g0fc810ae3ae1

  real    0m1.281s

In fact, the --debug output shows that git traverses all or most of
history. For some repositories and/or git versions, those 1.3s are
actually 10-15 seconds.

This has been acknowledged as a performance bug in git [1], and a fix
is on its way [2]. However, no solution is yet in git.git, and even
when one lands, it will take quite a while before it finds its way to
a release and for $random_kernel_developer to pick that up.

So rewrite the logic to use plumbing commands. For each of the
candidate values of $tag, we ask: (1) is $tag even an annotated
tag? (2) Is it eligible to describe HEAD, i.e. an ancestor of
HEAD? (3) If so, how many commits are in $tag..HEAD?

I have tested that this produces the same output as the current script
for ~700 random commits between v6.9..v6.10. For those 700 commits,
and in my git repo, the 'make -s kernelrelease' command is on average
~4 times faster with this patch applied (geometric mean of ratios).

For the commit mentioned in Josh's original report [3], the
time-consuming part of setlocalversion goes from

$ time git describe --match=v6.12-rc5 c1e939a21eb1
v6.12-rc5-44-gc1e939a21eb1

real    0m1.210s

to

$ time git rev-list --count --left-right v6.12-rc5..c1e939a21eb1
0       44

real    0m0.037s

[1] https://lore.kernel.org/git/20241101113910.GA2301440@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/20241106192236.GC880133@coredump.intra.peff.net/
[3] https://lore.kernel.org/lkml/309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org/

Reported-by: Sean Christopherson <seanjc@google.com>
Closes: https://lore.kernel.org/lkml/ZPtlxmdIJXOe0sEy@google.com/
Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Closes: https://lore.kernel.org/lkml/309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org/
Tested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/setlocalversion | 54 +++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 38b96c6797f40..5818465abba98 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -30,6 +30,27 @@ if test $# -gt 0 -o ! -d "$srctree"; then
 	usage
 fi
 
+try_tag() {
+	tag="$1"
+
+	# Is $tag an annotated tag?
+	[ "$(git cat-file -t "$tag" 2> /dev/null)" = tag ] || return 1
+
+	# Is it an ancestor of HEAD, and if so, how many commits are in $tag..HEAD?
+	# shellcheck disable=SC2046 # word splitting is the point here
+	set -- $(git rev-list --count --left-right "$tag"...HEAD 2> /dev/null)
+
+	# $1 is 0 if and only if $tag is an ancestor of HEAD. Use
+	# string comparison, because $1 is empty if the 'git rev-list'
+	# command somehow failed.
+	[ "$1" = 0 ] || return 1
+
+	# $2 is the number of commits in the range $tag..HEAD, possibly 0.
+	count="$2"
+
+	return 0
+}
+
 scm_version()
 {
 	local short=false
@@ -61,33 +82,33 @@ scm_version()
 	# stable kernel:    6.1.7      ->  v6.1.7
 	version_tag=v$(echo "${KERNELVERSION}" | sed -E 's/^([0-9]+\.[0-9]+)\.0(.*)$/\1\2/')
 
+	# try_tag initializes count if the tag is usable.
+	count=
+
 	# If a localversion* file exists, and the corresponding
 	# annotated tag exists and is an ancestor of HEAD, use
 	# it. This is the case in linux-next.
-	tag=${file_localversion#-}
-	desc=
-	if [ -n "${tag}" ]; then
-		desc=$(git describe --match=$tag 2>/dev/null)
+	if [ -n "${file_localversion#-}" ] ; then
+		try_tag "${file_localversion#-}"
 	fi
 
 	# Otherwise, if a localversion* file exists, and the tag
 	# obtained by appending it to the tag derived from
 	# KERNELVERSION exists and is an ancestor of HEAD, use
 	# it. This is e.g. the case in linux-rt.
-	if [ -z "${desc}" ] && [ -n "${file_localversion}" ]; then
-		tag="${version_tag}${file_localversion}"
-		desc=$(git describe --match=$tag 2>/dev/null)
+	if [ -z "${count}" ] && [ -n "${file_localversion}" ]; then
+		try_tag "${version_tag}${file_localversion}"
 	fi
 
 	# Otherwise, default to the annotated tag derived from KERNELVERSION.
-	if [ -z "${desc}" ]; then
-		tag="${version_tag}"
-		desc=$(git describe --match=$tag 2>/dev/null)
+	if [ -z "${count}" ]; then
+		try_tag "${version_tag}"
 	fi
 
-	# If we are at the tagged commit, we ignore it because the version is
-	# well-defined.
-	if [ "${tag}" != "${desc}" ]; then
+	# If we are at the tagged commit, we ignore it because the
+	# version is well-defined. If none of the attempted tags exist
+	# or were usable, $count is still empty.
+	if [ -z "${count}" ] || [ "${count}" -gt 0 ]; then
 
 		# If only the short version is requested, don't bother
 		# running further git commands
@@ -95,14 +116,15 @@ scm_version()
 			echo "+"
 			return
 		fi
+
 		# If we are past the tagged commit, we pretty print it.
 		# (like 6.1.0-14595-g292a089d78d3)
-		if [ -n "${desc}" ]; then
-			echo "${desc}" | awk -F- '{printf("-%05d", $(NF-1))}'
+		if [ -n "${count}" ]; then
+			printf "%s%05d" "-" "${count}"
 		fi
 
 		# Add -g and exactly 12 hex chars.
-		printf '%s%s' -g "$(echo $head | cut -c1-12)"
+		printf '%s%.12s' -g "$head"
 	fi
 
 	if ${no_dirty}; then
-- 
2.43.0


