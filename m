Return-Path: <stable+bounces-80393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9D98DD36
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC70284EA4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE71D175F;
	Wed,  2 Oct 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2rEulHC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901251EA80;
	Wed,  2 Oct 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880243; cv=none; b=s9ZdsGJTpp7FGpaR3qE2JCuoWwN2wgrF4Li2vn3mZM+obaeK72mZlqRc6xeIt54Kic+tBZ4L3KYms7zDxdASLl8rXQ0Xs/vQRWy4t4M2ueyw9NpA5t7KV2PyyinSlSqspgWzJrrHMMmFXVkTtbIlQKiOZxstxfSH6Fa6zFNVDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880243; c=relaxed/simple;
	bh=g3ikejaAL49Vv3UrD+y3n4RbEhMUZbZSKw64ylCMhgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyecGh/H4jI8EHnyd+OPUs36Ez8Wj1tm/KIbt5SxYJQs2swXaiWuhiz1uxDiIwHYVbBplu6k5NeGLAl6xrJ+QTMr0s0+L2gWBddltZflJ0d8JcOmnViAWWESftmw1WfPjtNA4ts/5+VbISNJveBpvRdc2NEhixJxqFJ+ejAoF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2rEulHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC48C4CEC2;
	Wed,  2 Oct 2024 14:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880243;
	bh=g3ikejaAL49Vv3UrD+y3n4RbEhMUZbZSKw64ylCMhgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2rEulHCzD8D1phEl+fLopUaI89u8Tz32l6s5pyZlWw0/T9B+el7uAVb1VrBzevpO
	 22d9CPNk7YIKdThmOw7p7xt3xd3Uvvj0IjCp7lmXJuNrTA1iidGskGrBnJtn2rFkxF
	 AqtpzMaGAQeHIeTIEVLPD3elYVQUXCNm8hTeXkc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.6 392/538] Remove *.orig pattern from .gitignore
Date: Wed,  2 Oct 2024 15:00:31 +0200
Message-ID: <20241002125807.906205677@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

commit 76be4f5a784533c71afbbb1b8f2963ef9e2ee258 upstream.

Commit 3f1b0e1f2875 (".gitignore update") added *.orig and *.rej
patterns to .gitignore in v2.6.23. The commit message didn't give a
rationale. Later on, commit 1f5d3a6b6532 ("Remove *.rej pattern from
.gitignore") removed the *.rej pattern in v2.6.26, on the rationale that
*.rej files indicated something went really wrong and should not be
ignored.

The *.rej files are now shown by `git status`, which helps located
conflicts when applying patches and lowers the probability that they
will go unnoticed. It is however still easy to overlook the *.orig files
which slowly polute the source tree. That's not as big of a deal as not
noticing a conflict, but it's still not nice.

Drop the *.orig pattern from .gitignore to avoid this and help keep the
source tree clean.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[masahiroy@kernel.org:
I do not have a strong opinion about this. Perhaps some people may have
a different opinion.

If you are someone who wants to ignore *.orig, it is likely you would
want to do so across all projects. Then, $XDG_CONFIG_HOME/git/ignore
would be more suitable for your needs. gitignore(5) suggests, "Patterns
which a user wants Git to ignore in all situations generally go into a
file specified by core.excludesFile in the user's ~/.gitconfig".

Please note that you cannot do the opposite; if *.orig is ignored by
the project's .gitignore, you cannot override the decision because
$XDG_CONFIG_HOME/git/ignore has a lower priority.

If *.orig is sitting on the fence, I'd leave it to the users. ]
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .gitignore |    1 -
 1 file changed, 1 deletion(-)

--- a/.gitignore
+++ b/.gitignore
@@ -135,7 +135,6 @@ GTAGS
 # id-utils files
 ID
 
-*.orig
 *~
 \#*#
 



