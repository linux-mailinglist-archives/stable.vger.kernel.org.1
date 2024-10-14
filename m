Return-Path: <stable+bounces-84522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA61099D098
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4746DB269BA
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67281AB538;
	Mon, 14 Oct 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VVFdThsq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A5481B7;
	Mon, 14 Oct 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918298; cv=none; b=FZJSZI/vaEuK48YoKQ++HQe+q6Gc+oEnS1zo9SIdf5ETf6DhmKrG7negh0OU5qLOgjWd9UEftzBvHlxg5kOWu10/arB3qmXLrd8vu6MTy53qz65zTXRX25bwLpn5oO3O5Vum67eLQiQjfn/Q8HVi314nibmQEha2S9/8DDlTVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918298; c=relaxed/simple;
	bh=3ySgtHnFlVfCPnNbxSIp64N2MLw+hwBPmJLYK2Fj9OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlEd+/THWYP/9Iou4sf5OaQHW7UbbWQXVUHCSNZBwUc5gS1J0gej57pWSXIZY8dzL0DxQ7WpzcbPXSFjQEheWErACOPpRx82R0Zp5J17CeASS3OQbJ6Ws4eXzFtNkzft7qpqVjOBKFmVOVWht7wcN80SQnlA7XCg2CMEGqKj/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VVFdThsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952D4C4CEC3;
	Mon, 14 Oct 2024 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918298;
	bh=3ySgtHnFlVfCPnNbxSIp64N2MLw+hwBPmJLYK2Fj9OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VVFdThsqJ9mYA9K6rjpnWnkJCtHWYhEMF4U9E8bOpl7/fMkVWcaHs6YoON513UmVe
	 ZjKXEaGmbUJN0V4nhSQTKJ8UZkkvTXxO3NvbUKTh7j4DaLVRZrbnwazX3F0kxbTnTm
	 lzPcVqJo0QDt4wGdxz2TnpVcGYq3ZiDeEg6O28xg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.1 281/798] Remove *.orig pattern from .gitignore
Date: Mon, 14 Oct 2024 16:13:55 +0200
Message-ID: <20241014141228.984762947@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -133,7 +133,6 @@ GTAGS
 # id-utils files
 ID
 
-*.orig
 *~
 \#*#
 



