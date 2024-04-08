Return-Path: <stable+bounces-36414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2607E89BFC0
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60F2285C68
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E947D074;
	Mon,  8 Apr 2024 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tov0pTgd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC77CF3A;
	Mon,  8 Apr 2024 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581216; cv=none; b=Wh9lLTo6v9NFrKTTts6GrKPKD43t29yydiySCXnYjEcejVgQMKN605tocAkTMpiNqBeRbgXpjVNut+7SJKlOQFr1S0VC9scZJ+PqXmGVOJWUYKAkq9267KVthhFjAJHa3Cby3udWnMMQG8NooZCz0GS2+XqkBak3WJv6rAO4xco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581216; c=relaxed/simple;
	bh=cOnsSsxyeB8GsxXhbyoXb9VYv73QgA9uIIIQS+P1q54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkOOcjhikcOMuck7vaQCdpxlnO4FDMEBJ0aTt1SNcNK4GVgoijT86Mnpu1ehssy6fO4ULL5UHnobw5TCetFxN2rm9kxKGWcMtVaVA64PqsySmVBENv2xN/1jQKZYQUMadXmcB7zDo46pZdY0Hq2HA7i6SsEVPmd3+b3glTBVirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tov0pTgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6826CC433C7;
	Mon,  8 Apr 2024 13:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581215;
	bh=cOnsSsxyeB8GsxXhbyoXb9VYv73QgA9uIIIQS+P1q54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tov0pTgdPplf+SwMgzrC2WtZsLxMSBJkiPJcElkHt1NijqxYnCfITischMlmBHYI+
	 IQ33ocf/AgwxsKCGtEiytPzj7UwamcAui6pNjroS7a8mXeTQUniU63vGnebi3/iOKt
	 btBdWyNqKmt4GaFU2EliTYRcwv+G8LXSSRnqeFCU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lin Yujun <linyujun809@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5.15 001/690] Documentation/hw-vuln: Update spectre doc
Date: Mon,  8 Apr 2024 14:47:47 +0200
Message-ID: <20240408125359.583837532@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Yujun <linyujun809@huawei.com>

commit 06cb31cc761823ef444ba4e1df11347342a6e745 upstream.

commit 7c693f54c873691 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")

adds the "ibrs " option  in
Documentation/admin-guide/kernel-parameters.txt but omits it to
Documentation/admin-guide/hw-vuln/spectre.rst, add it.

Signed-off-by: Lin Yujun <linyujun809@huawei.com>
Link: https://lore.kernel.org/r/20220830123614.23007-1-linyujun809@huawei.com
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/hw-vuln/spectre.rst |    1 +
 1 file changed, 1 insertion(+)

--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -625,6 +625,7 @@ kernel command line.
                 eibrs                   enhanced IBRS
                 eibrs,retpoline         enhanced IBRS + Retpolines
                 eibrs,lfence            enhanced IBRS + LFENCE
+                ibrs                    use IBRS to protect kernel
 
 		Not specifying this option is equivalent to
 		spectre_v2=auto.



