Return-Path: <stable+bounces-205722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A831CFAA25
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39113307C0A
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152B35CBA9;
	Tue,  6 Jan 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+vWBwTx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824C35CBA5;
	Tue,  6 Jan 2026 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721641; cv=none; b=sQQsJJhYEZ80wc+2HeDpUEf9xYcArh8fn7D6P1bpnvu7KDcs+GTOkR19T85FQmII/Djx816zNFNMbOrSF4hA+MKj8ERB9VTzFijH8cBnlxJmiJGWk1jGbrTarS2xPiYDTZxcwUlGl5rdxS4YZsMmzSQ8Lpj/MhB3WANc4FWdasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721641; c=relaxed/simple;
	bh=H5zCa7lZZ2Vq+L3biwRnIlCygK+Hwr/lucznge3WBfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYOS2ZDKQxumY3t3t5AtU7nzyUar7gVCDL0FBSQPV6NhEfV2CW6X8AeDfdIsTMrHD1xYz0+lsmru0kqOqQl46kB5xjCpRSURX72qlIjXnXrGDz/Xyg/inQxtSARHblXY9m+RSkqFlY4yjeduwbdL+bwxc7VriemR7zVKDhbWNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+vWBwTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81CFC116C6;
	Tue,  6 Jan 2026 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721641;
	bh=H5zCa7lZZ2Vq+L3biwRnIlCygK+Hwr/lucznge3WBfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+vWBwTxL+fRwtpBG8q1LHKgtUpqhuFsf42giyFthD0SMNN99xCAbs62Mwx8AvvlC
	 B9BnS+LWCu4OoScu0Re8msM1zoIcN5q+jtYR0I83BK62DxuH2XOr6JZ7EBmfdtfgSv
	 9d2NeV5j9WEB8iAX5ruQ8wQyA9KbVuN/+3aIII+4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	"Naveen N Rao (AMD)" <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 029/312] powerpc/tools: drop `-o pipefail` in gcc check scripts
Date: Tue,  6 Jan 2026 18:01:43 +0100
Message-ID: <20260106170548.911574554@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Stancek <jstancek@redhat.com>

[ Upstream commit f1164534ad62f0cc247d99650b07bd59ad2a49fd ]

Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-function-entry")
Fixes: b71c9ffb1405 ("powerpc: Add arch/powerpc/tools directory")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Fixes: 8c50b72a3b4f ("powerpc/ftrace: Add Kconfig & Make glue for mprofile-kernel")
Fixes: abba759796f9 ("powerpc/kbuild: move -mprofile-kernel check to Kconfig")
Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh | 1 -
 arch/powerpc/tools/gcc-check-mprofile-kernel.sh           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
index 06706903503b..baed467a016b 100755
--- a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
+++ b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-set -o pipefail
 
 # To debug, uncomment the following line
 # set -x
diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
index 73e331e7660e..6193b0ed0c77 100755
--- a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
+++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-set -o pipefail
 
 # To debug, uncomment the following line
 # set -x
-- 
2.51.0




