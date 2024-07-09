Return-Path: <stable+bounces-58414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D9D92B6DD
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F9C1F241A7
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E695A15749F;
	Tue,  9 Jul 2024 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W66OToJu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F1153812;
	Tue,  9 Jul 2024 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523865; cv=none; b=UqOA3HXK29vZdfCnHEM5HPlrcL9w6PurrSM7dM3H2VM/Axh4c0/KMu0O8hHK/h542cRMNmqj4TpMCm6+rdiRGyTwbA2Zp0bcoxnSPkaGq66GmNjomx2KyWk11VwIyb2ADA3+JBTL3ITYR4jrJMSNfrBuIo3tM3zW+Dal05Ud22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523865; c=relaxed/simple;
	bh=LFfYnP0oBsZQ7lVfOwdhtpHV8zFIub77f9BrIdcEUcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9OwmDUadU9UFUVNMTfQEnrHHWestRN0pYAmEgRf3CNx+VSOxxSzeelXcxhTsC9E7q4ZsqSHkDCTuXKoZFnqPWzKo+zqiP1F9lARA09exoTkf815zEeOCAJAhE5/k0taGX5BDSP5RzVuvqieRefdUUGs+2pwtfS0HWAtseF0iJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W66OToJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A592C3277B;
	Tue,  9 Jul 2024 11:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523865;
	bh=LFfYnP0oBsZQ7lVfOwdhtpHV8zFIub77f9BrIdcEUcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W66OToJumF4aNhXJPymeaUP84Pu09TgqOUocI0d713q3NMT2dsLUBGSY6cQmkTV91
	 ohGGJWFF8c1QSQZ8qNs9Xmj0HnAS8KILXjQ7ZDXXAb7OHBjKYQMGaeGQ6fPyo+vvX7
	 F8xNASZUntD+rPp3BcZNkVmQ9bRUb/jUFaOzA7iU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 133/139] kbuild: fix short log for AS in link-vmlinux.sh
Date: Tue,  9 Jul 2024 13:10:33 +0200
Message-ID: <20240709110703.307201670@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
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

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 3430f65d6130ccbc86f0ff45642eeb9e2032a600 ]

In convention, short logs print the output file, not the input file.

Let's change the suffix for 'AS' since it assembles *.S into *.o.

[Before]

  LD      .tmp_vmlinux.kallsyms1
  NM      .tmp_vmlinux.kallsyms1.syms
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  NM      .tmp_vmlinux.kallsyms2.syms
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux

[After]

  LD      .tmp_vmlinux.kallsyms1
  NM      .tmp_vmlinux.kallsyms1.syms
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.o
  LD      .tmp_vmlinux.kallsyms2
  NM      .tmp_vmlinux.kallsyms2.syms
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.o
  LD      vmlinux

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/link-vmlinux.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 7862a81017477..a9434a72cac4f 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -182,7 +182,7 @@ kallsyms_step()
 	mksysmap ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms ${kallsymso_prev}
 	kallsyms ${kallsyms_vmlinux}.syms ${kallsyms_S}
 
-	info AS ${kallsyms_S}
+	info AS ${kallsymso}
 	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
 	      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} \
 	      -c -o ${kallsymso} ${kallsyms_S}
-- 
2.43.0




