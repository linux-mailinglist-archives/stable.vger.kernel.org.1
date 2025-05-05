Return-Path: <stable+bounces-140292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D066AAA753
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D9D3A5B7A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD79B2BF969;
	Mon,  5 May 2025 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB5Zkl/b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350033385E;
	Mon,  5 May 2025 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484575; cv=none; b=OPRV58pMJheaR9779gpjHKdQhpz8iPgrxqNB1qCxmEkOBUqSiGUpzg94AbJD7T7WLCGrCabXTqW2LlTCbIsio2H2dy6srsWMI5DcrPU+sHWVb/0PgJSjLnGJePY95GcoJb10OTTfwxndEBMAm1PRnVfEMVOFrr1HOWckpXP4QTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484575; c=relaxed/simple;
	bh=RzaQguqKcwjrCFvamXZHJhw/G0TTCr/JHjf89ltAHxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rnm1Y6cveahT4SogYr02KnmMeB1PEFnWi/jJHSIj0eycwyHCiiEnZmULxd703B3uJyrdKqwOQw31R1N0/73LcoccEnSouSNDB2QGy0dEoMfEu4CT7DN3f4xKCTRWaqAC/WJi7s/gLBVlVEYH4XohHliMCdRJAkl/h0Wu/waXzZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB5Zkl/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A49EC4CEE4;
	Mon,  5 May 2025 22:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484575;
	bh=RzaQguqKcwjrCFvamXZHJhw/G0TTCr/JHjf89ltAHxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dB5Zkl/bKi8zdOi3+OnQ2kWeh3QmRCNg/opszjiXPihnX8P2yIXgFeXdezLLucDvE
	 fKoyOBg4H9gPL49Mngz4W2h5ZfFLl/54eNz04DpMHecoAdlj4b8Vax+yYpezphHHl8
	 ajgz0kIBbjen/yCQk6ld6Utw1odK83BzX1R55+Fb89+BzKlGPWRfvvK6xZz3xkI6Yt
	 JLFCUprD602mNE8xUNsIG94Xv9/qVu7FXpi6nPDORxy4owska5konIz2i/Da8yW6b4
	 LEDmLkuzqzyuC4qObOmvfLfNt0NbIjmlQpjhPjy9ASDgILUDzBuh7d0JRAbbHWo+EI
	 XFV/Mj9k5tK4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	johannes.berg@intel.com,
	jstancek@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 544/642] tools: ynl-gen: don't output external constants
Date: Mon,  5 May 2025 18:12:40 -0400
Message-Id: <20250505221419.2672473-544-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 7e8b24e24ac46038e48c9a042e7d9b31855cbca5 ]

A definition with a "header" property is an "external" definition
for C code, as in it is defined already in another C header file.
Other languages will need the exact value but C codegen should
not recreate it. So don't output those definitions in the uAPI
header.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20250203215510.1288728-1-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index c2eabc90dce8c..aa08b8b1463d0 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2549,6 +2549,9 @@ def render_uapi(family, cw):
 
     defines = []
     for const in family['definitions']:
+        if const.get('header'):
+            continue
+
         if const['type'] != 'const':
             cw.writes_defines(defines)
             defines = []
-- 
2.39.5


